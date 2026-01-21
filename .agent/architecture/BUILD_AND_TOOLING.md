# Build and Tooling Architecture

Architecture ID: `BLD`

## Ownership

This document owns Droid package/build/devcontainer/generated-app/MCP helper integration boundaries.

Exact wrapper completion commands are owned operationally by `../DEVCONTAINER_COMPILATION_CHECK.md`; MCP procedure is owned by `../MCP_WRAPPER_WORKFLOW.md`.

## Invariants

- Current package/devcontainer configuration is source authority for toolchain paths and mounted sibling locations.
- Do not persist machine-specific paths as architecture assumptions.
- Android reference SDK-source discovery must remain portable: prefer `ANDROID_SDK_ROOT`, then `ANDROID_HOME`, then home-relative macOS/Linux SDK conventions; never encode a maintainer username/path as a fallback.
- Android reference cache reads/writes default to `.agent/mcp/.cache/android-ref-docs/`, with `SWIFDROID_ANDROID_REF_CACHE_ROOT` providing a process-start-time override for isolated validation or other explicitly scoped use.
- Refresh-enabled MCP validation must use an isolated task-owned cache root when reusable repository-cache preservation is required; set the override before Node/MCP startup and do not use snapshot/restore as a substitute for isolation.
- Host `swift build` is useful evidence but does not replace Android Swift SDK/devcontainer gates when those are required.
- Generated app/Gradle output is a consumer and diagnostic surface, not source authority.
- MCP reference/audit helpers provide evidence/navigation, not semantic ownership.
- Changes to MCP parser/audit tooling require its focused smoke/fixture validation.

## Generated Consumer

When representative generated-app evidence is required, resolve its current location/mounts from active `.devcontainer`/project configuration at task time. Do not assume historical `/workspaces/...` locations without re-reading current config.

## Dependency Configuration

Local mounted dependencies may differ from released package consumption. Do not invent a release dependency-selection strategy merely to make local devcontainer builds portable; unresolved choices belong in `OPEN_DECISIONS.md`.
