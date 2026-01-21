import { inspect } from "node:util";

const DEFAULT_PROTOCOL_VERSION = "2024-11-05";

function stringifyError(error) {
  if (error instanceof Error) {
    return `${error.name}: ${error.message}`;
  }
  return inspect(error);
}

export class StdioMcpServer {
  constructor({ name, version, tools }) {
    this.name = name;
    this.version = version;
    this.tools = tools;
    this._buffer = Buffer.alloc(0);
    this._stopped = false;
  }

  start() {
    process.stdin.on("data", (chunk) => {
      this._buffer = Buffer.concat([this._buffer, chunk]);
      this._processBuffer();
    });

    process.stdin.on("end", () => {
      this._stopped = true;
    });
  }

  _processBuffer() {
    while (true) {
      const headerEnd = this._buffer.indexOf("\r\n\r\n");
      if (headerEnd === -1) {
        return;
      }

      const headerText = this._buffer.slice(0, headerEnd).toString("utf8");
      const lengthMatch = headerText.match(/Content-Length:\s*(\d+)/i);
      if (!lengthMatch) {
        this._buffer = this._buffer.slice(headerEnd + 4);
        continue;
      }

      const contentLength = Number(lengthMatch[1]);
      const messageStart = headerEnd + 4;
      const messageEnd = messageStart + contentLength;
      if (this._buffer.length < messageEnd) {
        return;
      }

      const messageBytes = this._buffer.slice(messageStart, messageEnd);
      this._buffer = this._buffer.slice(messageEnd);

      let message = null;
      try {
        message = JSON.parse(messageBytes.toString("utf8"));
      } catch (error) {
        this._writeResponse({
          jsonrpc: "2.0",
          id: null,
          error: {
            code: -32700,
            message: "Parse error",
            data: stringifyError(error),
          },
        });
        continue;
      }

      void this._handleMessage(message);
    }
  }

  async _handleMessage(message) {
    if (!message || message.jsonrpc !== "2.0" || !message.method) {
      if (message?.id !== undefined) {
        this._writeResponse({
          jsonrpc: "2.0",
          id: message.id ?? null,
          error: { code: -32600, message: "Invalid Request" },
        });
      }
      return;
    }

    const id = message.id;
    const params = message.params ?? {};
    const isNotification = id === undefined || id === null;

    if (message.method === "notifications/initialized") {
      return;
    }

    if (message.method === "initialize") {
      if (isNotification) {
        return;
      }
      this._writeResponse({
        jsonrpc: "2.0",
        id,
        result: {
          protocolVersion: params.protocolVersion ?? DEFAULT_PROTOCOL_VERSION,
          capabilities: {
            tools: {},
          },
          serverInfo: {
            name: this.name,
            version: this.version,
          },
        },
      });
      return;
    }

    if (message.method === "ping") {
      if (!isNotification) {
        this._writeResponse({ jsonrpc: "2.0", id, result: {} });
      }
      return;
    }

    if (message.method === "tools/list") {
      if (isNotification) {
        return;
      }
      this._writeResponse({
        jsonrpc: "2.0",
        id,
        result: {
          tools: Object.entries(this.tools).map(([name, tool]) => ({
            name,
            description: tool.description,
            inputSchema: tool.inputSchema ?? {
              type: "object",
              properties: {},
              additionalProperties: false,
            },
          })),
        },
      });
      return;
    }

    if (message.method === "tools/call") {
      if (isNotification) {
        return;
      }
      const toolName = params.name;
      const argumentsObject =
        typeof params.arguments === "object" && params.arguments !== null
          ? params.arguments
          : {};
      const tool = this.tools[toolName];
      if (!tool) {
        this._writeResponse({
          jsonrpc: "2.0",
          id,
          result: {
            isError: true,
            content: [
              {
                type: "text",
                text: `Unknown tool: ${toolName}`,
              },
            ],
          },
        });
        return;
      }

      try {
        const rawResult = await tool.handler(argumentsObject);
        const normalized = normalizeToolResult(rawResult);
        this._writeResponse({
          jsonrpc: "2.0",
          id,
          result: normalized,
        });
      } catch (error) {
        this._writeResponse({
          jsonrpc: "2.0",
          id,
          result: {
            isError: true,
            content: [
              {
                type: "text",
                text: stringifyError(error),
              },
            ],
          },
        });
      }
      return;
    }

    if (!isNotification) {
      this._writeResponse({
        jsonrpc: "2.0",
        id,
        error: { code: -32601, message: `Method not found: ${message.method}` },
      });
    }
  }

  _writeResponse(responseObject) {
    if (this._stopped) {
      return;
    }
    const json = JSON.stringify(responseObject);
    const body = Buffer.from(json, "utf8");
    const header = Buffer.from(`Content-Length: ${body.length}\r\n\r\n`, "utf8");
    process.stdout.write(Buffer.concat([header, body]));
  }
}

export function normalizeToolResult(value) {
  if (value && typeof value === "object" && Array.isArray(value.content)) {
    return value;
  }

  if (typeof value === "string") {
    return {
      content: [{ type: "text", text: value }],
    };
  }

  const structuredContent =
    value && typeof value === "object" ? value : { value };
  return {
    content: [
      {
        type: "text",
        text: JSON.stringify(structuredContent, null, 2),
      },
    ],
    structuredContent,
  };
}
