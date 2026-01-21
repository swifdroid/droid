const TAG_RE = /<[^>]+>/g;

export function decodeHtmlEntities(text) {
  if (!text) {
    return "";
  }
  return text
    .replace(/&nbsp;/g, " ")
    .replace(/&amp;/g, "&")
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&#x2F;/g, "/")
    .replace(/&#x60;/g, "`")
    .replace(/&#x3D;/g, "=")
    .replace(/&#(\d+);/g, (_, code) => String.fromCharCode(Number(code)))
    .replace(/&#x([a-fA-F0-9]+);/g, (_, code) =>
      String.fromCharCode(Number.parseInt(code, 16)),
    );
}

export function htmlToText(html) {
  if (!html) {
    return "";
  }
  return decodeHtmlEntities(
    html
      .replace(/<script[\s\S]*?<\/script>/gi, " ")
      .replace(/<style[\s\S]*?<\/style>/gi, " ")
      .replace(/<\/(p|div|h1|h2|h3|h4|h5|li|tr|section)>/gi, "\n")
      .replace(/<br\s*\/?>/gi, "\n")
      .replace(TAG_RE, " ")
      .replace(/[ \t]+/g, " ")
      .replace(/\n{3,}/g, "\n\n")
      .trim(),
  );
}

export function normalizeWhitespace(text) {
  return text
    .replace(/\r/g, "")
    .replace(/[ \t]+/g, " ")
    .replace(/\n{3,}/g, "\n\n")
    .trim();
}

export function stripJavaDocCommentBlock(block) {
  const body = block
    .replace(/^\/\*\*/, "")
    .replace(/\*\/$/, "")
    .split("\n")
    .map((line) => line.replace(/^\s*\*\s?/, ""))
    .join("\n");
  return normalizeWhitespace(body);
}

export function splitSummaryAndBody(text) {
  const clean = normalizeWhitespace(text);
  if (!clean) {
    return { summary: "", body: "" };
  }

  const paragraphSplit = clean.split(/\n\n+/);
  if (paragraphSplit.length > 1) {
    return {
      summary: paragraphSplit[0].trim(),
      body: paragraphSplit.slice(1).join("\n\n").trim(),
    };
  }

  const sentenceSplit = clean.match(/^(.*?[.!?])(\s+[\s\S]*)?$/);
  if (sentenceSplit) {
    return {
      summary: sentenceSplit[1]?.trim() ?? clean,
      body: sentenceSplit[2]?.trim() ?? "",
    };
  }

  return { summary: clean, body: "" };
}

export function toClassPath(className) {
  return className.replace(/\./g, "/");
}

export function toCanonicalClassName(referenceUrl) {
  const match = referenceUrl.match(/\/reference\/(.+)$/);
  if (!match) {
    return null;
  }
  return match[1].replace(/\//g, ".");
}

export function toReferenceUrl(className) {
  return `https://developer.android.com/reference/${toClassPath(className)}`;
}
