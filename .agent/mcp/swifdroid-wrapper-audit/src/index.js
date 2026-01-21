#!/usr/bin/env node

import {
  auditWrapperFile,
  auditWorkspace,
} from "../../shared/src/swiftWrapperAudit.js";
import { StdioMcpServer } from "../../shared/src/stdioMcpServer.js";

const tools = {
  "swifdroid_wrapper_audit.analyze": {
    description:
      "Compare a SwifDroid wrapper with official Android reference metadata and report missing APIs.",
    inputSchema: {
      type: "object",
      properties: {
        wrapperFile: {
          type: "string",
          description:
            "Path to wrapper Swift file, e.g. Sources/Droid/Packages/android/app/Dialog.swift",
        },
        className: {
          type: "string",
          description:
            "Optional canonical class name when reference URL is not present in wrapper docs.",
        },
        referenceUrl: {
          type: "string",
          description:
            "Optional explicit reference URL. If omitted, the tool reads the class Learn more link.",
        },
        includeConstructors: {
          type: "boolean",
          default: true,
        },
        applyTodos: {
          type: "boolean",
          default: false,
        },
        allowNetwork: {
          type: "boolean",
          default: true,
        },
        refresh: {
          type: "boolean",
          default: false,
        },
      },
      required: ["wrapperFile"],
      additionalProperties: false,
    },
    handler: async (args) =>
      auditWrapperFile({
        wrapperFile: args.wrapperFile,
        className: args.className,
        referenceUrl: args.referenceUrl,
        includeConstructors: args.includeConstructors !== false,
        applyTodos: Boolean(args.applyTodos),
        allowNetwork: args.allowNetwork !== false,
        refresh: Boolean(args.refresh),
      }),
  },
  "swifdroid_wrapper_audit.apply_todos": {
    description:
      "Audit a wrapper and insert missing API TODO lines (`// TODO: implement ...`) in an idempotent block.",
    inputSchema: {
      type: "object",
      properties: {
        wrapperFile: { type: "string" },
        className: { type: "string" },
        referenceUrl: { type: "string" },
        includeConstructors: { type: "boolean", default: true },
        allowNetwork: { type: "boolean", default: true },
        refresh: { type: "boolean", default: false },
      },
      required: ["wrapperFile"],
      additionalProperties: false,
    },
    handler: async (args) =>
      auditWrapperFile({
        wrapperFile: args.wrapperFile,
        className: args.className,
        referenceUrl: args.referenceUrl,
        includeConstructors: args.includeConstructors !== false,
        applyTodos: true,
        allowNetwork: args.allowNetwork !== false,
        refresh: Boolean(args.refresh),
      }),
  },
  "swifdroid_wrapper_audit.audit_workspace": {
    description:
      "Audit all wrapper Swift files in a directory and return a missing-API summary.",
    inputSchema: {
      type: "object",
      properties: {
        rootDir: {
          type: "string",
          default: "Sources/Droid/Packages",
        },
        filter: { type: "string" },
        includeConstructors: { type: "boolean", default: true },
        allowNetwork: { type: "boolean", default: true },
      },
      additionalProperties: false,
    },
    handler: async (args) =>
      auditWorkspace({
        rootDir: args.rootDir ?? "Sources/Droid/Packages",
        filter: args.filter,
        includeConstructors: args.includeConstructors !== false,
        allowNetwork: args.allowNetwork !== false,
      }),
  },
};

const server = new StdioMcpServer({
  name: "swifdroid-wrapper-audit",
  version: "0.1.0",
  tools,
});

server.start();
