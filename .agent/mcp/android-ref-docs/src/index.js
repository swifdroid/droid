#!/usr/bin/env node

import {
  resolveMethodData,
  resolveReferenceData,
  searchReferenceClasses,
} from "../../shared/src/referenceResolver.js";
import { StdioMcpServer } from "../../shared/src/stdioMcpServer.js";

const tools = {
  "android_ref_docs.get_class": {
    description:
      "Resolve official Android reference docs for a class and return normalized class/constructor/method metadata.",
    inputSchema: {
      type: "object",
      properties: {
        className: {
          type: "string",
          description: "Canonical class name, e.g. android.app.Dialog",
        },
        referenceUrl: {
          type: "string",
          description:
            "Developer reference URL, e.g. https://developer.android.com/reference/android/app/Dialog",
        },
        refresh: {
          type: "boolean",
          description: "Ignore cache and refetch/reparse source.",
          default: false,
        },
        allowNetwork: {
          type: "boolean",
          description: "Attempt network fetch before local source/fixtures.",
          default: true,
        },
      },
      additionalProperties: false,
    },
    handler: async (args) =>
      resolveReferenceData({
        className: args.className,
        referenceUrl: args.referenceUrl,
        refresh: Boolean(args.refresh),
        allowNetwork: args.allowNetwork !== false,
      }),
  },
  "android_ref_docs.get_method": {
    description:
      "Return a single method from official Android reference docs using a stable method id.",
    inputSchema: {
      type: "object",
      properties: {
        className: { type: "string" },
        referenceUrl: { type: "string" },
        methodId: {
          type: "string",
          description: "Stable method id like dismiss() or extendSelection(int)",
        },
        refresh: { type: "boolean", default: false },
        allowNetwork: { type: "boolean", default: true },
      },
      required: ["methodId"],
      additionalProperties: false,
    },
    handler: async (args) =>
      resolveMethodData({
        className: args.className,
        referenceUrl: args.referenceUrl,
        methodId: args.methodId,
        refresh: Boolean(args.refresh),
        allowNetwork: args.allowNetwork !== false,
      }),
  },
  "android_ref_docs.search": {
    description:
      "Search reference classes by query. Supports canonical names and fixture-backed discovery.",
    inputSchema: {
      type: "object",
      properties: {
        query: { type: "string" },
        limit: { type: "number", default: 20 },
      },
      required: ["query"],
      additionalProperties: false,
    },
    handler: async (args) =>
      searchReferenceClasses({
        query: args.query,
        limit: Number.isFinite(args.limit) ? Number(args.limit) : 20,
      }),
  },
};

const server = new StdioMcpServer({
  name: "android-ref-docs",
  version: "0.1.0",
  tools,
});

server.start();
