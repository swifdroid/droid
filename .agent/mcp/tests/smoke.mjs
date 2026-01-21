#!/usr/bin/env node

import fs from "node:fs/promises";
import os from "node:os";
import path from "node:path";

import { resolveReferenceData } from "../shared/src/referenceResolver.js";
import { auditWrapperFile } from "../shared/src/swiftWrapperAudit.js";

const BEGIN_MARKER = "// BEGIN-AUTO-TODOS(swifdroid-wrapper-audit)";
const END_MARKER = "// END-AUTO-TODOS(swifdroid-wrapper-audit)";
const STALE_TODO_ID = "__SWIFDROID_SMOKE_STALE__()";

function assert(condition, message) {
  if (!condition) {
    throw new Error(message);
  }
}

function parseTodoLineId(line) {
  const match = line.match(/^\s*\/\/\s*TODO:\s*implement\s+(.+?)\s*$/);
  return match?.[1]?.trim() ?? null;
}

function findGeneratedBlock(sourceText) {
  const beginIndex = sourceText.indexOf(BEGIN_MARKER);
  const endIndex = sourceText.indexOf(END_MARKER);
  if (beginIndex === -1 || endIndex === -1 || endIndex < beginIndex) {
    return null;
  }
  const endLineBreak = sourceText.indexOf("\n", endIndex);
  const endAfter = endLineBreak === -1 ? sourceText.length : endLineBreak + 1;
  const inner = sourceText.slice(beginIndex + BEGIN_MARKER.length, endIndex);
  const ids = [];
  for (const line of inner.split("\n")) {
    const id = parseTodoLineId(line);
    if (id) {
      ids.push(id);
    }
  }
  return { beginIndex, endAfter, ids };
}

function extractTodoIdsOutsideBlock(sourceText) {
  const block = findGeneratedBlock(sourceText);
  const outside = block
    ? sourceText.slice(0, block.beginIndex) + sourceText.slice(block.endAfter)
    : sourceText;
  const ids = [];
  for (const line of outside.split("\n")) {
    const id = parseTodoLineId(line);
    if (id) {
      ids.push(id);
    }
  }
  return ids;
}

function extractGeneratedTodoIds(sourceText) {
  return findGeneratedBlock(sourceText)?.ids ?? [];
}

function replaceGeneratedBlockIds(sourceText, nextIds) {
  const block = findGeneratedBlock(sourceText);
  assert(block !== null, "Expected a generated TODO block before mutation");
  const nextBlockText = [
    BEGIN_MARKER,
    ...nextIds.map((id) => `// TODO: implement ${id}`),
    END_MARKER,
    "",
  ].join("\n");
  return sourceText.slice(0, block.beginIndex) + nextBlockText + sourceText.slice(block.endAfter);
}

function isLexicallySorted(ids) {
  for (let index = 1; index < ids.length; index += 1) {
    if (ids[index - 1].localeCompare(ids[index]) > 0) {
      return false;
    }
  }
  return true;
}

async function runReferenceSmoke() {
  const classes = [
    "android.app.Dialog",
    "android.view.View",
    "android.widget.TextView",
    "androidx.constraintlayout.widget.ConstraintLayout",
    "com.google.android.material.button.MaterialButton",
  ];

  for (const className of classes) {
    const data = await resolveReferenceData({
      className,
      allowNetwork: false,
      refresh: true,
    });
    assert(data.class.canonicalName === className, `Wrong class for ${className}`);
    assert(
      Array.isArray(data.methods) && data.methods.length > 0,
      `No methods parsed for ${className}`,
    );
  }
}

async function runAuditSmoke() {
  const original = path.resolve(
    "Sources/Droid/Packages/android/app/Dialog.swift",
  );
  const tempDirectory = await fs.mkdtemp(
    path.join(os.tmpdir(), "swifdroid-wrapper-audit-"),
  );
  const tempFile = path.join(tempDirectory, "Dialog.swift");

  try {
    await fs.copyFile(original, tempFile);

    const report = await auditWrapperFile({
      wrapperFile: tempFile,
      allowNetwork: false,
      includeConstructors: true,
      applyTodos: true,
    });
    assert(report.wrapperType === "Dialog", "Unexpected wrapper type for Dialog smoke copy");
    assert(report.changed === true, "Expected TODO insertion for Dialog smoke copy");

    const secondPass = await auditWrapperFile({
      wrapperFile: tempFile,
      allowNetwork: false,
      includeConstructors: true,
      applyTodos: true,
    });
    assert(
      secondPass.changed === false,
      "TODO insertion should be idempotent on second pass",
    );

    const firstMissingIds = Array.from(
      new Set(report.missing.map((item) => item.id)),
    ).sort((left, right) => left.localeCompare(right));
    assert(
      firstMissingIds.length >= 3,
      `Expected at least three current missing IDs, found ${firstMissingIds.length}`,
    );

    const removedStillMissingId = firstMissingIds[0];
    const keptStillMissingId = firstMissingIds[1];
    const manualStillMissingId = firstMissingIds[2];

    const afterFirstPass = await fs.readFile(tempFile, "utf8");
    const firstBlockIds = extractGeneratedTodoIds(afterFirstPass);
    assert(
      firstBlockIds.includes(removedStillMissingId),
      `Generated block missing expected still-missing id ${removedStillMissingId}`,
    );
    assert(
      firstBlockIds.includes(keptStillMissingId),
      `Generated block missing expected still-missing id ${keptStillMissingId}`,
    );
    assert(
      firstBlockIds.includes(manualStillMissingId),
      `Generated block missing expected still-missing id ${manualStillMissingId}`,
    );

    const mutatedBlockIds = firstBlockIds.filter(
      (id) => id !== removedStillMissingId && id !== manualStillMissingId,
    );
    mutatedBlockIds.push(STALE_TODO_ID);
    mutatedBlockIds.sort((left, right) => left.localeCompare(right));
    let mutatedText = replaceGeneratedBlockIds(afterFirstPass, mutatedBlockIds);
    mutatedText = `${mutatedText.replace(/\s*$/, "")}\n// TODO: implement ${manualStillMissingId}\n`;
    await fs.writeFile(tempFile, mutatedText);

    const reconciled = await auditWrapperFile({
      wrapperFile: tempFile,
      allowNetwork: false,
      includeConstructors: true,
      applyTodos: true,
    });
    assert(reconciled.changed === true, "Expected reconciliation to change the mutated wrapper");

    const reconciledText = await fs.readFile(tempFile, "utf8");
    const reconciledGeneratedIds = extractGeneratedTodoIds(reconciledText);
    const reconciledManualIds = extractTodoIdsOutsideBlock(reconciledText);
    const reconciledGeneratedSet = new Set(reconciledGeneratedIds);
    const reconciledManualSet = new Set(reconciledManualIds);

    assert(
      reconciledGeneratedIds.includes(removedStillMissingId),
      "Reconciliation should restore the deliberately removed still-missing generated TODO",
    );
    assert(
      reconciledGeneratedIds.includes(keptStillMissingId),
      "Reconciliation should preserve the still-missing generated TODO left in the block",
    );
    assert(
      !reconciledGeneratedIds.includes(STALE_TODO_ID),
      "Reconciliation should remove the fake stale generated TODO",
    );
    assert(
      reconciledManualIds.includes(manualStillMissingId),
      "Reconciliation should preserve the manual/external TODO line",
    );
    assert(
      !reconciledGeneratedSet.has(manualStillMissingId),
      "Reconciliation should not duplicate the manual/external TODO into the generated block",
    );
    assert(
      isLexicallySorted(reconciledGeneratedIds),
      "Generated TODO IDs should be sorted deterministically",
    );
    for (const missingId of firstMissingIds) {
      assert(
        reconciledGeneratedSet.has(missingId) || reconciledManualSet.has(missingId),
        `Missing id ${missingId} must appear in generated block or as external manual TODO`,
      );
    }

    const finalPass = await auditWrapperFile({
      wrapperFile: tempFile,
      allowNetwork: false,
      includeConstructors: true,
      applyTodos: true,
    });
    assert(
      finalPass.changed === false,
      "Reconciled wrapper should be unchanged on the final audit pass",
    );
  } finally {
    await fs.rm(tempDirectory, { recursive: true, force: true });
    const remaining = await fs.stat(tempDirectory).catch(() => null);
    assert(
      remaining === null,
      `Wrapper temp directory was not removed: ${tempDirectory}`,
    );
  }
}

async function main() {
  await runReferenceSmoke();
  await runAuditSmoke();
  process.stdout.write("MCP smoke checks passed.\n");
}

await main();
