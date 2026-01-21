import {
  htmlToText,
  normalizeWhitespace,
  splitSummaryAndBody,
} from "./textUtils.js";

function splitTopLevelByComma(value) {
  const parts = [];
  let start = 0;
  let genericDepth = 0;
  for (let index = 0; index < value.length; index += 1) {
    const char = value[index];
    if (char === "<") {
      genericDepth += 1;
    } else if (char === ">") {
      genericDepth = Math.max(0, genericDepth - 1);
    } else if (char === "," && genericDepth === 0) {
      parts.push(value.slice(start, index).trim());
      start = index + 1;
    }
  }
  parts.push(value.slice(start).trim());
  return parts.filter(Boolean);
}

function parseSignature(signatureText) {
  const normalized = signatureText
    .replace(/\s+/g, " ")
    .replace(/\s*\(\s*/g, "(")
    .replace(/\s*\)\s*/g, ")")
    .trim();
  const openParen = normalized.indexOf("(");
  const closeParen = normalized.lastIndexOf(")");
  if (openParen === -1 || closeParen === -1 || closeParen <= openParen) {
    return null;
  }

  const name = normalized.slice(0, openParen).trim().split(" ").pop();
  if (!name) {
    return null;
  }

  const paramsRaw = normalized.slice(openParen + 1, closeParen).trim();
  const parameters = splitTopLevelByComma(paramsRaw).map((item, index) => ({
    name: `p${index}`,
    type: item,
  }));

  return {
    id: `${name}(${parameters.map((parameter) => parameter.type).join(",")})`,
    name,
    parameters,
  };
}

function extractClassDocs(html, fallbackSummary = "") {
  const metaDescriptionMatch = html.match(
    /<meta[^>]+name=["']description["'][^>]+content=["']([^"']+)["'][^>]*>/i,
  );
  const description = metaDescriptionMatch?.[1]
    ? normalizeWhitespace(metaDescriptionMatch[1])
    : "";

  const firstParagraphMatch = html.match(/<p[^>]*>([\s\S]*?)<\/p>/i);
  const firstParagraph = firstParagraphMatch
    ? normalizeWhitespace(htmlToText(firstParagraphMatch[1]))
    : "";

  const merged = [description, firstParagraph]
    .filter(Boolean)
    .join("\n\n")
    .trim();
  const docs = splitSummaryAndBody(merged || fallbackSummary);
  return docs;
}

function extractH3Blocks(html) {
  const blocks = [];
  const regex = /<h3[^>]*id=["']([^"']+)["'][^>]*>([\s\S]*?)<\/h3>/gi;
  let match = regex.exec(html);
  while (match) {
    const start = match.index + match[0].length;
    const next = regex.exec(html);
    const end = next ? next.index : html.length;
    regex.lastIndex = next ? next.index : html.length;
    blocks.push({
      id: match[1],
      titleHtml: match[2],
      bodyHtml: html.slice(start, end),
    });
    match = next;
  }
  return blocks;
}

export function parseAndroidReferenceHtml({
  html,
  canonicalClassName,
  referenceUrl,
}) {
  const simpleClassName = canonicalClassName.split(".").pop();
  const classDocs = extractClassDocs(html, simpleClassName);

  const constructors = [];
  const methods = [];
  const seen = new Set();

  const h3Blocks = extractH3Blocks(html);
  for (const block of h3Blocks) {
    const titleText = normalizeWhitespace(htmlToText(block.titleHtml));
    const signature =
      parseSignature(titleText) ||
      parseSignature(block.id.replace(/%3C/g, "<").replace(/%3E/g, ">"));
    if (!signature) {
      continue;
    }

    const docsText = normalizeWhitespace(htmlToText(block.bodyHtml));
    const docs = splitSummaryAndBody(docsText);
    const key = `${signature.id}|${docs.summary}`;
    if (seen.has(key)) {
      continue;
    }
    seen.add(key);

    const entry = {
      id: signature.id,
      name: signature.name,
      signature: {
        name: signature.name,
        parameters: signature.parameters,
        returnType: null,
      },
      docSummary: docs.summary,
      docBody: docs.body,
    };

    if (signature.name === simpleClassName) {
      constructors.push(entry);
    } else {
      methods.push(entry);
    }
  }

  return {
    class: {
      canonicalName: canonicalClassName,
      referenceUrl,
      docSummary: classDocs.summary,
      docBody: classDocs.body,
    },
    constructors,
    methods,
  };
}
