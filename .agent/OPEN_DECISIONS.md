# Open Decisions

Unresolved Droid repository decisions only.

## `OD-001` - Release versus local JNIKit dependency selection

Question: how should `Package.swift` support local mounted JNIKit development and portable released consumption without manually rewriting the manifest?

Current governance fact: local development may use a mounted/path dependency depending on active devcontainer configuration. Do not invent the release-selection mechanism until the maintainer explicitly resolves it.

## `OD-002` - Wrapper coverage automation authority

Question: should manually curated wrapper maps remain navigation-only, or should generated tooling gain a stronger formal completeness role?

Current rule: MCP/maps are evidence/navigation, not semantic completeness authority. Any promotion requires an explicit architecture decision and acceptance criteria.
