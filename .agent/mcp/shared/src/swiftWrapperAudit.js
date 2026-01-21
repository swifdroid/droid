import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

import { resolveReferenceData } from "./referenceResolver.js";

const MARK_LINE = "// MARK: - Missing API (auto-generated)";
const BEGIN_MARKER = "// BEGIN-AUTO-TODOS(swifdroid-wrapper-audit)";
const END_MARKER = "// END-AUTO-TODOS(swifdroid-wrapper-audit)";
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const OVERRIDES_PATH = path.resolve(
  __dirname,
  "..",
  "..",
  "swifdroid-wrapper-audit",
  "mappings",
  "name-overrides.json",
);

let cachedOverrides = null;

function lowerFirst(value) {
  if (!value) {
    return value;
  }
  return value[0].toLowerCase() + value.slice(1);
}

function stripSwiftComments(text) {
  return text
    .replace(/\/\*[\s\S]*?\*\//g, " ")
    .replace(/\/\/.*$/gm, " ");
}

function extractReferenceUrl(sourceText) {
  const match = sourceText.match(
    /\/\/\/\s*\[Learn more\]\((https:\/\/developer\.android\.com\/reference\/[^)]+)\)/i,
  );
  return match?.[1] ?? null;
}

function extractWrapperTypeName(sourceText) {
  const learnMoreMatch = sourceText.match(
    /\/\/\/\s*\[Learn more\]\(https:\/\/developer\.android\.com\/reference\/[^)]+\)/i,
  );
  if (learnMoreMatch && learnMoreMatch.index !== undefined) {
    const afterLearnMore = sourceText.slice(learnMoreMatch.index);
    const classAfterDoc = afterLearnMore.match(
      /\b(?:open|public|final)?\s*class\s+([A-Za-z_]\w*)\b/,
    );
    if (classAfterDoc?.[1]) {
      return classAfterDoc[1];
    }
  }

  const fallbackMatch = sourceText.match(
    /\b(?:open|public|final)?\s*class\s+([A-Za-z_]\w*)\b/,
  );
  return fallbackMatch?.[1] ?? null;
}

function collectImplementedMembers(sourceText) {
  const stripped = stripSwiftComments(sourceText);
  const methodNames = new Set();
  const staticMethodNames = new Set();
  let constructorCount = 0;

  const methodRegex =
    /\b((?:public|open|internal|private|fileprivate|final|override|class|static|@discardableResult|\s)*)func\s+(?:`([A-Za-z_]\w*)`|([A-Za-z_]\w*))\s*(?:<[^>]*>)?\s*\(/g;
  let methodMatch = methodRegex.exec(stripped);
  while (methodMatch) {
    const modifiers = methodMatch[1] ?? "";
    const name = methodMatch[2] ?? methodMatch[3];
    if (/\b(static|class)\b/.test(modifiers)) {
      staticMethodNames.add(name);
    } else {
      methodNames.add(name);
    }
    methodMatch = methodRegex.exec(stripped);
  }

  const initRegex = /\b(?:convenience\s+|required\s+|override\s+)*init(?:<[^>]*>)?\s*\(/g;
  let initMatch = initRegex.exec(stripped);
  while (initMatch) {
    constructorCount += 1;
    initMatch = initRegex.exec(stripped);
  }

  return {
    methodNames,
    staticMethodNames,
    constructorCount,
  };
}

function javaMethodNameCandidates(javaName) {
  const candidates = new Set([javaName]);

  if (/^get[A-Z]/.test(javaName)) {
    candidates.add(lowerFirst(javaName.slice(3)));
  }
  if (/^set[A-Z]/.test(javaName)) {
    candidates.add(lowerFirst(javaName.slice(3)));
    candidates.add(javaName);
  }
  if (/^is[A-Z]/.test(javaName)) {
    candidates.add(javaName);
  }
  if (/^has[A-Z]/.test(javaName)) {
    candidates.add(javaName);
  }

  return Array.from(candidates);
}

async function loadOverrideMappings() {
  if (cachedOverrides) {
    return cachedOverrides;
  }
  try {
    const text = await fs.readFile(OVERRIDES_PATH, "utf8");
    cachedOverrides = JSON.parse(text);
  } catch {
    cachedOverrides = {};
  }
  return cachedOverrides;
}

function applyOverrideCandidates(baseCandidates, canonicalClassName, methodName, overrides) {
  const candidates = new Set(baseCandidates);
  const wildcard = overrides["*"]?.[methodName];
  const perClass = overrides[canonicalClassName]?.[methodName];
  for (const entry of [wildcard, perClass]) {
    if (!Array.isArray(entry)) {
      continue;
    }
    for (const candidate of entry) {
      if (typeof candidate === "string" && candidate.trim()) {
        candidates.add(candidate.trim());
      }
    }
  }
  return Array.from(candidates);
}

function buildMissingItems({
  referenceData,
  implemented,
  includeConstructors = true,
  overrides = {},
}) {
  const missingConstructors = [];
  const missingMethods = [];

  if (
    includeConstructors &&
    referenceData.constructors.length > 0 &&
    implemented.constructorCount === 0
  ) {
    for (const constructor of referenceData.constructors) {
      missingConstructors.push({
        kind: "constructor",
        id: constructor.id,
        name: constructor.name,
        signature: constructor.signature,
        docSummary: constructor.docSummary ?? "",
      });
    }
  }

  for (const method of referenceData.methods) {
    const candidates = applyOverrideCandidates(
      javaMethodNameCandidates(method.name),
      referenceData.class.canonicalName,
      method.name,
      overrides,
    );
    const isImplemented =
      candidates.some((name) => implemented.methodNames.has(name)) ||
      (method.isStatic === true &&
        candidates.some((name) => implemented.staticMethodNames.has(name)));

    if (!isImplemented) {
      missingMethods.push({
        kind: "method",
        id: method.id,
        name: method.name,
        signature: method.signature,
        docSummary: method.docSummary ?? "",
      });
    }
  }

  return {
    missingConstructors,
    missingMethods,
    missing: [...missingConstructors, ...missingMethods],
  };
}

function extractTodoIdsFromText(text) {
  const ids = new Set();
  const regex = /^\s*\/\/\s*TODO:\s*implement\s+(.+?)\s*$/gm;
  let match = regex.exec(text);
  while (match) {
    ids.add(match[1].trim());
    match = regex.exec(text);
  }
  return ids;
}

function findValidGeneratedBlock(sourceText) {
  const beginIndex = sourceText.indexOf(BEGIN_MARKER);
  const endIndex = sourceText.indexOf(END_MARKER);
  if (beginIndex === -1 || endIndex === -1 || endIndex <= beginIndex) {
    return null;
  }

  const beginLineStartRaw = sourceText.lastIndexOf("\n", beginIndex);
  const beginLineStart = beginLineStartRaw === -1 ? 0 : beginLineStartRaw + 1;
  const endNewlineIndex = sourceText.indexOf("\n", endIndex);
  const blockEnd = endNewlineIndex === -1 ? sourceText.length : endNewlineIndex;

  let managedStart = beginLineStart;
  let hasMarkLine = false;
  if (beginLineStart > 0) {
    const prevNewline = sourceText.lastIndexOf("\n", beginLineStart - 2);
    const prevLineStart = prevNewline === -1 ? 0 : prevNewline + 1;
    const prevLine = sourceText.slice(prevLineStart, beginLineStart - 1);
    if (prevLine === MARK_LINE) {
      managedStart = prevLineStart;
      hasMarkLine = true;
    }
  }

  return {
    start: managedStart,
    end: blockEnd,
    beginIndex,
    endIndex,
    hasMarkLine,
  };
}

function applyTodoBlock(sourceText, missingItems) {
  const block = findValidGeneratedBlock(sourceText);
  const manualTodoIds = extractTodoIdsFromText(
    block
      ? sourceText.slice(0, block.start) + sourceText.slice(block.end)
      : sourceText,
  );
  const previousGeneratedIds = block
    ? extractTodoIdsFromText(sourceText.slice(block.beginIndex, block.endIndex))
    : new Set();

  const currentMissingIds = new Set(missingItems.map((item) => item.id));
  const desiredGeneratedIds = Array.from(currentMissingIds)
    .filter((id) => !manualTodoIds.has(id))
    .sort((left, right) => left.localeCompare(right));

  const todosAdded = desiredGeneratedIds.filter((id) => !previousGeneratedIds.has(id));

  if (desiredGeneratedIds.length === 0) {
    if (!block) {
      return {
        updatedText: sourceText,
        addedTodoIds: [],
        changed: false,
      };
    }
    const updatedText = sourceText.slice(0, block.start) + sourceText.slice(block.end);
    if (updatedText === sourceText) {
      return {
        updatedText: sourceText,
        addedTodoIds: [],
        changed: false,
      };
    }
    return {
      updatedText,
      addedTodoIds: [],
      changed: true,
    };
  }

  const blockLines = [
    MARK_LINE,
    BEGIN_MARKER,
    ...desiredGeneratedIds.map((id) => `// TODO: implement ${id}`),
    END_MARKER,
  ];
  const blockText = blockLines.join("\n");

  let updatedText;
  if (block) {
    updatedText =
      sourceText.slice(0, block.start) + blockText + sourceText.slice(block.end);
  } else {
    updatedText = `${sourceText.replace(/\s*$/, "")}\n\n${blockText}\n`;
  }

  if (updatedText === sourceText) {
    return {
      updatedText: sourceText,
      addedTodoIds: [],
      changed: false,
    };
  }

  return {
    updatedText,
    addedTodoIds: todosAdded,
    changed: true,
  };
}

export async function auditWrapperFile({
  wrapperFile,
  className,
  referenceUrl,
  includeConstructors = true,
  applyTodos = false,
  allowNetwork = true,
  refresh = false,
}) {
  const resolvedWrapperPath = path.resolve(wrapperFile);
  const sourceText = await fs.readFile(resolvedWrapperPath, "utf8");
  const learnedReferenceUrl = referenceUrl ?? extractReferenceUrl(sourceText) ?? undefined;
  const wrapperType = extractWrapperTypeName(sourceText);

  const referenceData = await resolveReferenceData({
    className,
    referenceUrl: learnedReferenceUrl,
    allowNetwork,
    refresh,
  });
  const implemented = collectImplementedMembers(sourceText);
  const overrides = await loadOverrideMappings();
  const missingData = buildMissingItems({
    referenceData,
    implemented,
    includeConstructors,
    overrides,
  });

  let todoUpdate = {
    updatedText: sourceText,
    addedTodoIds: [],
    changed: false,
  };

  if (applyTodos) {
    todoUpdate = applyTodoBlock(sourceText, missingData.missing);
    if (todoUpdate.changed) {
      await fs.writeFile(resolvedWrapperPath, todoUpdate.updatedText);
    }
  }

  return {
    wrapperFile: resolvedWrapperPath,
    wrapperType,
    reference: referenceData.class,
    source: referenceData.source,
    implemented: {
      methods: Array.from(implemented.methodNames).sort((left, right) =>
        left.localeCompare(right),
      ),
      staticMethods: Array.from(implemented.staticMethodNames).sort((left, right) =>
        left.localeCompare(right),
      ),
      constructorCount: implemented.constructorCount,
    },
    missingConstructors: missingData.missingConstructors,
    missingMethods: missingData.missingMethods,
    missing: missingData.missing,
    missingCount: missingData.missing.length,
    todosApplied: applyTodos,
    todosAdded: todoUpdate.addedTodoIds,
    changed: todoUpdate.changed,
  };
}

async function collectSwiftFilesRecursively(rootDir) {
  const output = [];
  const stack = [rootDir];

  while (stack.length > 0) {
    const current = stack.pop();
    let entries = [];
    try {
      entries = await fs.readdir(current, { withFileTypes: true });
    } catch {
      continue;
    }

    for (const entry of entries) {
      if (entry.name.startsWith(".")) {
        continue;
      }
      const fullPath = path.join(current, entry.name);
      if (entry.isDirectory()) {
        stack.push(fullPath);
      } else if (entry.isFile() && entry.name.endsWith(".swift")) {
        output.push(fullPath);
      }
    }
  }

  return output;
}

export async function auditWorkspace({
  rootDir = "Sources/Droid/Packages",
  filter,
  includeConstructors = true,
  allowNetwork = true,
}) {
  const resolvedRoot = path.resolve(rootDir);
  const files = await collectSwiftFilesRecursively(resolvedRoot);
  const filteredFiles = filter
    ? files.filter((file) => file.includes(filter))
    : files;

  const reports = [];
  for (const file of filteredFiles) {
    try {
      const report = await auditWrapperFile({
        wrapperFile: file,
        includeConstructors,
        applyTodos: false,
        allowNetwork,
      });
      reports.push({
        wrapperFile: report.wrapperFile,
        wrapperType: report.wrapperType,
        missingCount: report.missingCount,
        referenceUrl: report.reference.referenceUrl,
      });
    } catch (error) {
      reports.push({
        wrapperFile: file,
        error: error instanceof Error ? error.message : String(error),
      });
    }
  }

  const sorted = reports
    .filter((report) => typeof report.missingCount === "number")
    .sort((left, right) => right.missingCount - left.missingCount);

  return {
    rootDir: resolvedRoot,
    auditedFiles: filteredFiles.length,
    topMissing: sorted.slice(0, 30),
    failures: reports.filter((report) => report.error),
  };
}
