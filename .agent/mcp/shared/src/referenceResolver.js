import fs from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

import { parseAndroidReferenceHtml } from "./androidHtmlParser.js";
import { parseJavaSourceReference } from "./javaSourceParser.js";
import {
  toCanonicalClassName,
  toReferenceUrl,
  normalizeWhitespace,
} from "./textUtils.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const SHARED_ROOT = path.resolve(__dirname, "..");
const MCP_ROOT = path.resolve(SHARED_ROOT, "..");
const FIXTURES_ROOT = path.join(SHARED_ROOT, "fixtures", "reference");

function resolveAndroidRefCacheRoot() {
  const override = process.env.SWIFDROID_ANDROID_REF_CACHE_ROOT;
  if (override && override.trim()) {
    return path.resolve(override.trim());
  }
  return path.join(MCP_ROOT, ".cache", "android-ref-docs");
}

const CACHE_ROOT = resolveAndroidRefCacheRoot();

const CACHE_VERSION = 1;

function toFixtureFilename(canonicalClassName) {
  return `${canonicalClassName}.json`;
}

function toCacheFilename(canonicalClassName) {
  return `${canonicalClassName}.json`;
}

async function safeReadFile(filePath) {
  try {
    return await fs.readFile(filePath, "utf8");
  } catch {
    return null;
  }
}

async function safeReadJson(filePath) {
  const text = await safeReadFile(filePath);
  if (!text) {
    return null;
  }
  try {
    return JSON.parse(text);
  } catch {
    return null;
  }
}

async function ensureDirectory(directoryPath) {
  await fs.mkdir(directoryPath, { recursive: true });
}

function resolveClassAndUrl({ className, referenceUrl }) {
  const canonicalClassName = className ?? toCanonicalClassName(referenceUrl ?? "");
  if (!canonicalClassName) {
    throw new Error(
      "Missing class identifier. Provide either `className` or `referenceUrl`.",
    );
  }
  const resolvedReferenceUrl = referenceUrl ?? toReferenceUrl(canonicalClassName);
  return {
    canonicalClassName,
    referenceUrl: resolvedReferenceUrl,
  };
}

function buildSdkCandidates() {
  const candidates = [
    process.env.ANDROID_SDK_ROOT,
    process.env.ANDROID_HOME,
    path.join(os.homedir(), "Library", "Android", "sdk"),
    path.join(os.homedir(), "Android", "Sdk"),
  ].filter(Boolean);
  const seen = new Set();
  const unique = [];
  for (const candidate of candidates) {
    if (!seen.has(candidate)) {
      seen.add(candidate);
      unique.push(candidate);
    }
  }
  return unique;
}

async function resolveSourceFromSdk(canonicalClassName) {
  const relativeJavaPath = `${canonicalClassName.replace(/\./g, "/")}.java`;
  const relativeKtPath = `${canonicalClassName.replace(/\./g, "/")}.kt`;

  for (const sdkRoot of buildSdkCandidates()) {
    const sourcesRoot = path.join(sdkRoot, "sources");
    let sourceVersions = [];
    try {
      sourceVersions = await fs.readdir(sourcesRoot);
    } catch {
      continue;
    }

    const sortedVersions = sourceVersions
      .filter((entry) => entry.startsWith("android-"))
      .sort((left, right) => {
        const leftVersion = Number.parseInt(left.replace("android-", ""), 10);
        const rightVersion = Number.parseInt(right.replace("android-", ""), 10);
        return rightVersion - leftVersion;
      });

    for (const version of sortedVersions) {
      const javaPath = path.join(sourcesRoot, version, relativeJavaPath);
      const ktPath = path.join(sourcesRoot, version, relativeKtPath);

      const javaText = await safeReadFile(javaPath);
      if (javaText) {
        return {
          sourceText: javaText,
          sourcePath: javaPath,
          sourceKind: "android-sdk-source",
        };
      }

      const kotlinText = await safeReadFile(ktPath);
      if (kotlinText) {
        return {
          sourceText: kotlinText,
          sourcePath: ktPath,
          sourceKind: "android-sdk-source-kotlin",
        };
      }
    }
  }

  return null;
}

async function resolveFromFixture(canonicalClassName) {
  const fixturePath = path.join(FIXTURES_ROOT, toFixtureFilename(canonicalClassName));
  const fixture = await safeReadJson(fixturePath);
  if (!fixture) {
    return null;
  }
  return {
    ...fixture,
    source: "fixture",
  };
}

async function resolveFromHtml({ canonicalClassName, referenceUrl, timeoutMs = 12000 }) {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), timeoutMs);
  try {
    const response = await fetch(referenceUrl, {
      signal: controller.signal,
      headers: {
        "user-agent": "swifdroid-android-ref-docs/1.0",
      },
    });
    if (!response.ok) {
      throw new Error(`Failed to fetch reference URL (${response.status})`);
    }
    const html = await response.text();
    const parsed = parseAndroidReferenceHtml({
      html,
      canonicalClassName,
      referenceUrl,
    });
    return {
      ...parsed,
      source: "developer.android.com-html",
    };
  } finally {
    clearTimeout(timeout);
  }
}

function ensureReferenceShape(data, canonicalClassName, referenceUrl, sourceKind) {
  const classData = data.class ?? {};
  return {
    class: {
      canonicalName: canonicalClassName,
      referenceUrl,
      docSummary: normalizeWhitespace(classData.docSummary ?? ""),
      docBody: normalizeWhitespace(classData.docBody ?? ""),
      sinceApi: classData.sinceApi ?? null,
    },
    constructors: Array.isArray(data.constructors) ? data.constructors : [],
    methods: Array.isArray(data.methods) ? data.methods : [],
    source: sourceKind ?? data.source ?? "unknown",
  };
}

async function writeCache(canonicalClassName, payload) {
  await ensureDirectory(CACHE_ROOT);
  const cachePath = path.join(CACHE_ROOT, toCacheFilename(canonicalClassName));
  await fs.writeFile(
    cachePath,
    JSON.stringify(
      {
        cacheVersion: CACHE_VERSION,
        createdAt: new Date().toISOString(),
        payload,
      },
      null,
      2,
    ),
  );
}

async function readCache(canonicalClassName) {
  const cachePath = path.join(CACHE_ROOT, toCacheFilename(canonicalClassName));
  const cached = await safeReadJson(cachePath);
  if (!cached || cached.cacheVersion !== CACHE_VERSION) {
    return null;
  }
  return cached.payload ?? null;
}

export async function resolveReferenceData({
  className,
  referenceUrl,
  refresh = false,
  allowNetwork = true,
}) {
  const resolved = resolveClassAndUrl({ className, referenceUrl });
  const { canonicalClassName } = resolved;

  if (!refresh) {
    const cached = await readCache(canonicalClassName);
    if (cached) {
      return ensureReferenceShape(
        cached,
        canonicalClassName,
        resolved.referenceUrl,
        cached.source,
      );
    }
  }

  if (allowNetwork) {
    try {
      const htmlData = await resolveFromHtml(resolved);
      const shaped = ensureReferenceShape(
        htmlData,
        canonicalClassName,
        resolved.referenceUrl,
        htmlData.source,
      );
      await writeCache(canonicalClassName, shaped);
      return shaped;
    } catch {
      // Intentionally ignored; local source / fixtures are fallback.
    }
  }

  const sdkSource = await resolveSourceFromSdk(canonicalClassName);
  if (sdkSource?.sourceKind === "android-sdk-source") {
    const parsed = parseJavaSourceReference({
      source: sdkSource.sourceText,
      canonicalClassName,
      referenceUrl: resolved.referenceUrl,
    });
    const hasSurface =
      parsed &&
      ((Array.isArray(parsed.methods) && parsed.methods.length > 0) ||
        (Array.isArray(parsed.constructors) && parsed.constructors.length > 0));
    if (hasSurface) {
      const shaped = ensureReferenceShape(
        parsed,
        canonicalClassName,
        resolved.referenceUrl,
        sdkSource.sourceKind,
      );
      shaped.sourcePath = sdkSource.sourcePath;
      await writeCache(canonicalClassName, shaped);
      return shaped;
    }
  }

  const fixtureData = await resolveFromFixture(canonicalClassName);
  if (fixtureData) {
    const shaped = ensureReferenceShape(
      fixtureData,
      canonicalClassName,
      resolved.referenceUrl,
      fixtureData.source,
    );
    await writeCache(canonicalClassName, shaped);
    return shaped;
  }

  throw new Error(
    `Unable to resolve reference data for ${canonicalClassName}. Network fetch failed or unavailable, and no local SDK/fixture source was found.`,
  );
}

export async function resolveMethodData({
  className,
  referenceUrl,
  methodId,
  refresh = false,
  allowNetwork = true,
}) {
  const referenceData = await resolveReferenceData({
    className,
    referenceUrl,
    refresh,
    allowNetwork,
  });
  const method = referenceData.methods.find((item) => item.id === methodId);
  if (!method) {
    throw new Error(
      `Method not found for ${referenceData.class.canonicalName}: ${methodId}`,
    );
  }
  return {
    class: referenceData.class,
    method,
    source: referenceData.source,
  };
}

export async function searchReferenceClasses({ query, limit = 20 }) {
  const normalizedQuery = (query ?? "").trim();
  if (!normalizedQuery) {
    return { results: [] };
  }

  const candidates = new Map();

  if (normalizedQuery.includes(".") || normalizedQuery.includes("/")) {
    const canonical = normalizedQuery.replace(/\//g, ".");
    candidates.set(canonical, {
      canonicalName: canonical,
      referenceUrl: toReferenceUrl(canonical),
      source: "derived",
    });
  }

  let fixtureFiles = [];
  try {
    fixtureFiles = await fs.readdir(FIXTURES_ROOT);
  } catch {
    fixtureFiles = [];
  }

  for (const fileName of fixtureFiles) {
    if (!fileName.endsWith(".json")) {
      continue;
    }
    const canonicalName = fileName.replace(/\.json$/, "");
    const haystack = canonicalName.toLowerCase();
    if (haystack.includes(normalizedQuery.toLowerCase())) {
      candidates.set(canonicalName, {
        canonicalName,
        referenceUrl: toReferenceUrl(canonicalName),
        source: "fixture",
      });
    }
  }

  const results = Array.from(candidates.values()).slice(0, limit);
  return { results };
}
