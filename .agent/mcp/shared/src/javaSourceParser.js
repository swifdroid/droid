import { splitSummaryAndBody, stripJavaDocCommentBlock } from "./textUtils.js";

const MODIFIERS_RE =
  /\b(public|protected|private|static|final|abstract|synchronized|native|default|strictfp|sealed|non-sealed)\b/g;

function escapeRegex(value) {
  return value.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

function maskNonCode(source) {
  const chars = Array.from(source);
  let index = 0;
  let inLineComment = false;
  let inBlockComment = false;
  let inString = false;
  let inChar = false;
  let escaping = false;

  while (index < chars.length) {
    const char = chars[index];
    const next = chars[index + 1];

    if (inLineComment) {
      if (char !== "\n") {
        chars[index] = " ";
      } else {
        inLineComment = false;
      }
      index += 1;
      continue;
    }

    if (inBlockComment) {
      if (char === "*" && next === "/") {
        chars[index] = " ";
        chars[index + 1] = " ";
        index += 2;
        inBlockComment = false;
        continue;
      }
      if (char !== "\n") {
        chars[index] = " ";
      }
      index += 1;
      continue;
    }

    if (inString) {
      if (char !== "\n") {
        chars[index] = " ";
      }
      if (!escaping && char === "\"") {
        inString = false;
      }
      escaping = !escaping && char === "\\";
      index += 1;
      continue;
    }

    if (inChar) {
      if (char !== "\n") {
        chars[index] = " ";
      }
      if (!escaping && char === "'") {
        inChar = false;
      }
      escaping = !escaping && char === "\\";
      index += 1;
      continue;
    }

    if (char === "/" && next === "/") {
      chars[index] = " ";
      chars[index + 1] = " ";
      inLineComment = true;
      index += 2;
      continue;
    }

    if (char === "/" && next === "*") {
      chars[index] = " ";
      chars[index + 1] = " ";
      inBlockComment = true;
      index += 2;
      continue;
    }

    if (char === "\"") {
      chars[index] = " ";
      inString = true;
      escaping = false;
      index += 1;
      continue;
    }

    if (char === "'") {
      chars[index] = " ";
      inChar = true;
      escaping = false;
      index += 1;
      continue;
    }

    index += 1;
  }

  return chars.join("");
}

function findClassBody(source, simpleClassName) {
  const maskedSource = maskNonCode(source);
  const classPattern = new RegExp(
    `\\b(class|interface|enum)\\s+${escapeRegex(simpleClassName)}\\b[\\s\\S]*?\\{`,
    "m",
  );
  const classMatch = classPattern.exec(maskedSource);
  if (!classMatch) {
    return null;
  }

  const openingBraceIndex = classMatch.index + classMatch[0].length - 1;
  let depth = 0;
  for (let index = openingBraceIndex; index < maskedSource.length; index += 1) {
    const char = maskedSource[index];
    if (char === "{") {
      depth += 1;
    } else if (char === "}") {
      depth -= 1;
      if (depth === 0) {
        return {
          classStart: classMatch.index,
          bodyStart: openingBraceIndex + 1,
          bodyEnd: index,
        };
      }
    }
  }

  return null;
}

function findNearestJavaDocBefore(sourcePrefix) {
  const regex = /\/\*\*[\s\S]*?\*\//g;
  let last = null;
  let match = regex.exec(sourcePrefix);
  while (match) {
    last = match[0];
    match = regex.exec(sourcePrefix);
  }
  return last;
}

function countChar(text, char) {
  let count = 0;
  for (let index = 0; index < text.length; index += 1) {
    if (text[index] === char) {
      count += 1;
    }
  }
  return count;
}

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

function normalizeType(typeName) {
  return typeName
    .replace(/\s+/g, " ")
    .replace(/\s*<\s*/g, "<")
    .replace(/\s*>\s*/g, ">")
    .replace(/\s*,\s*/g, ",")
    .replace(/\s*\[\s*\]/g, "[]")
    .trim();
}

function normalizeTypeForId(typeName) {
  return normalizeType(typeName)
    .replace(/\bfinal\s+/g, "")
    .replace(/\? extends /g, "")
    .replace(/\? super /g, "")
    .replace(/\s+/g, "");
}

function stripAnnotations(value) {
  return value.replace(/@\w+(?:\([^)]*\))?\s*/g, " ");
}

function parseParameter(rawParameter) {
  const withoutAnnotations = stripAnnotations(rawParameter)
    .replace(/\bfinal\s+/g, " ")
    .trim();
  if (!withoutAnnotations) {
    return null;
  }

  const tokens = withoutAnnotations.split(/\s+/);
  if (tokens.length < 2) {
    return null;
  }

  const name = tokens[tokens.length - 1];
  const type = tokens
    .slice(0, -1)
    .join(" ")
    .replace(/\.\.\./g, "[]")
    .trim();

  return {
    name,
    type: normalizeType(type),
  };
}

function parseDeclaration(declaration, simpleClassName, docText) {
  const compact = declaration
    .replace(/\s+/g, " ")
    .replace(/\bthrows\b[\s\S]*$/, "")
    .replace(/\s*\{\s*$/, "")
    .replace(/\s*;\s*$/, "")
    .trim();

  if (!compact.includes("(") || !compact.includes(")")) {
    return null;
  }

  if (!/\b(public|protected)\b/.test(compact)) {
    return null;
  }

  if (/^(if|for|while|switch|catch)\b/.test(compact)) {
    return null;
  }

  const openParen = compact.indexOf("(");
  const closeParen = compact.lastIndexOf(")");
  if (openParen === -1 || closeParen === -1 || closeParen <= openParen) {
    return null;
  }

  let beforeParen = compact.slice(0, openParen).trim();
  const paramsText = compact.slice(openParen + 1, closeParen).trim();

  beforeParen = stripAnnotations(beforeParen)
    .replace(/\b(public|protected)\b/, "")
    .replace(MODIFIERS_RE, " ")
    .replace(/^<[^>]+>\s*/, "")
    .replace(/\s+/g, " ")
    .trim();

  const nameMatch = beforeParen.match(/([A-Za-z_]\w*)$/);
  if (!nameMatch) {
    return null;
  }

  const name = nameMatch[1];
  const returnType = beforeParen
    .slice(0, beforeParen.length - name.length)
    .trim();
  const parameters = splitTopLevelByComma(paramsText)
    .map(parseParameter)
    .filter(Boolean);
  const methodId = `${name}(${parameters
    .map((parameter) => normalizeTypeForId(parameter.type))
    .join(",")})`;
  const docs = splitSummaryAndBody(docText);

  if (name === simpleClassName) {
    return {
      kind: "constructor",
      id: methodId,
      name,
      signature: {
        name,
        parameters,
        returnType: null,
      },
      docSummary: docs.summary,
      docBody: docs.body,
    };
  }

  return {
    kind: "method",
    id: methodId,
    name,
    signature: {
      name,
      parameters,
      returnType: normalizeType(returnType || "void"),
    },
    docSummary: docs.summary,
    docBody: docs.body,
  };
}

function javadocToText(javadocBlock) {
  const stripped = stripJavaDocCommentBlock(javadocBlock);
  return stripped
    .split("\n")
    .filter((line) => !line.trim().startsWith("@"))
    .join("\n")
    .trim();
}

export function parseJavaSourceReference({
  source,
  canonicalClassName,
  referenceUrl,
}) {
  const simpleClassName = canonicalClassName.split(".").pop();
  const classBodyMeta = findClassBody(source, simpleClassName);
  if (!classBodyMeta) {
    return null;
  }

  const classPrefix = source.slice(0, classBodyMeta.classStart);
  const classDocBlock = findNearestJavaDocBefore(classPrefix);
  const classDocText = classDocBlock ? javadocToText(classDocBlock) : "";
  const classDocs = splitSummaryAndBody(classDocText);

  const body = source.slice(classBodyMeta.bodyStart, classBodyMeta.bodyEnd);
  const lines = body.split("\n");

  let depth = 0;
  let inJavaDoc = false;
  let javaDocLines = [];
  let pendingDoc = "";
  let collectingDeclaration = false;
  let declarationLines = [];
  let declarationParenDepth = 0;

  const constructors = [];
  const methods = [];

  for (const line of lines) {
    const trimmed = line.trim();

    if (!collectingDeclaration) {
      if (!inJavaDoc && depth === 0 && trimmed.startsWith("/**")) {
        inJavaDoc = true;
        javaDocLines = [trimmed];
        if (trimmed.includes("*/")) {
          inJavaDoc = false;
          pendingDoc = javadocToText(javaDocLines.join("\n"));
        }
      } else if (inJavaDoc) {
        javaDocLines.push(trimmed);
        if (trimmed.includes("*/")) {
          inJavaDoc = false;
          pendingDoc = javadocToText(javaDocLines.join("\n"));
        }
      }
    }

    if (!inJavaDoc) {
      if (collectingDeclaration) {
        declarationLines.push(trimmed);
        declarationParenDepth += countChar(trimmed, "(");
        declarationParenDepth -= countChar(trimmed, ")");

        const declarationEnded =
          declarationParenDepth <= 0 &&
          (trimmed.endsWith("{") ||
            trimmed.endsWith(";") ||
            trimmed.includes("{"));
        if (declarationEnded) {
          const declarationText = declarationLines.join(" ").trim();
          const parsed = parseDeclaration(
            declarationText,
            simpleClassName,
            pendingDoc,
          );
          if (parsed) {
            if (parsed.kind === "constructor") {
              constructors.push(parsed);
            } else {
              methods.push(parsed);
            }
          }
          collectingDeclaration = false;
          declarationLines = [];
          declarationParenDepth = 0;
          pendingDoc = "";
        }
      } else if (
        depth === 0 &&
        trimmed &&
        !trimmed.startsWith("@") &&
        !trimmed.startsWith("//") &&
        /\b(public|protected)\b/.test(trimmed) &&
        trimmed.includes("(")
      ) {
        collectingDeclaration = true;
        declarationLines = [trimmed];
        declarationParenDepth =
          countChar(trimmed, "(") - countChar(trimmed, ")");
        if (
          declarationParenDepth <= 0 &&
          (trimmed.endsWith("{") ||
            trimmed.endsWith(";") ||
            trimmed.includes("{"))
        ) {
          const declarationText = declarationLines.join(" ").trim();
          const parsed = parseDeclaration(
            declarationText,
            simpleClassName,
            pendingDoc,
          );
          if (parsed) {
            if (parsed.kind === "constructor") {
              constructors.push(parsed);
            } else {
              methods.push(parsed);
            }
          }
          collectingDeclaration = false;
          declarationLines = [];
          declarationParenDepth = 0;
          pendingDoc = "";
        }
      }
    }

    if (!inJavaDoc) {
      depth += countChar(trimmed, "{");
      depth -= countChar(trimmed, "}");
      if (depth < 0) {
        depth = 0;
      }
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
