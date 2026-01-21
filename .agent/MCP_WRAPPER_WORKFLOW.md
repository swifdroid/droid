# MCP Wrapper Workflow

Operational guide for Droid wrapper reference resolution and audit. `.agent/architecture/BUILD_AND_TOOLING.md` owns the helper-tool boundary; `ANDROID_CLASS_WRAPPERS.md` remains implementation policy. Parent SwifDroid governance is not required for this procedure.

MCP output is discovery/audit evidence, not API authority. Verify exact official metadata, generated TODOs, and Swift bindings before implementation or completion claims.

## Services

- `android-ref-docs`
  - Resolves official Android reference metadata (`class`, constructors, methods, doc text).
  - Resolution order: live `developer.android.com` HTML -> local Android SDK source -> local fixture snapshot.
- `swifdroid-wrapper-audit`
  - Audits wrapper files against reference metadata.
  - Can insert idempotent `// TODO: implement ...` entries in a dedicated auto-generated block.

## Location

- Docs server: `.agent/mcp/android-ref-docs/src/index.js`
- Audit server: `.agent/mcp/swifdroid-wrapper-audit/src/index.js`
- Shared logic: `.agent/mcp/shared/src/`
- Fixtures (golden snapshots): `.agent/mcp/shared/fixtures/reference/`
- Default Android reference cache: `.agent/mcp/.cache/android-ref-docs/`

## Android SDK discovery and reference-cache isolation

Local Android SDK source discovery is portable and ordered. `android-ref-docs` checks these SDK roots in order, keeping only the first occurrence of an exact duplicate:

1. `ANDROID_SDK_ROOT`
2. `ANDROID_HOME`
3. `$HOME/Library/Android/sdk`
4. `$HOME/Android/Sdk`

Do not add username-specific absolute SDK paths to MCP source or stable documentation.

The Android reference cache root is selected when the resolver module is initialized:

- if `SWIFDROID_ANDROID_REF_CACHE_ROOT` is unset, empty, or whitespace-only, cache reads/writes use the repository default `.agent/mcp/.cache/android-ref-docs/`;
- if `SWIFDROID_ANDROID_REF_CACHE_ROOT` is non-empty, its trimmed value is resolved with `path.resolve(...)` and becomes the cache root for both reads and writes;
- because the value is captured at module initialization, set the environment variable before starting the Node/MCP process. Changing it after the process has loaded the resolver does not retarget that process.

`refresh:true` bypasses a cache read but still writes a successfully resolved reference into the selected cache root. For refresh-enabled smoke, protocol, or maintenance validation, use a unique task-owned absolute temporary cache root, set `SWIFDROID_ANDROID_REF_CACHE_ROOT` before process startup, capture evidence, then remove only that exact temporary root. Do not snapshot/restore or otherwise mutate the reusable repository cache merely to make validation appear clean.

## Client Setup

From repo root (`droid/`), register these Node stdio MCP services in the active MCP-capable client using that client's own registration/configuration mechanism:

1. Docs parser service:
   - name: `android-ref-docs`
   - command: `node "$PWD/.agent/mcp/android-ref-docs/src/index.js"`
2. Wrapper-audit service:
   - name: `swifdroid-wrapper-audit`
   - command: `node "$PWD/.agent/mcp/swifdroid-wrapper-audit/src/index.js"`
3. Verify both registrations using the active client's MCP listing/inspection mechanism before relying on them.

## MCP Tool Names

### `android-ref-docs`

- `android_ref_docs.get_class`
  - Input: `className` or `referenceUrl`
- `android_ref_docs.get_method`
  - Input: `className`/`referenceUrl` + `methodId`
- `android_ref_docs.search`
  - Input: `query`

### `swifdroid-wrapper-audit`

- `swifdroid_wrapper_audit.analyze`
  - Input: `wrapperFile` (+ optional `className` / `referenceUrl`)
- `swifdroid_wrapper_audit.apply_todos`
  - Input: `wrapperFile`
- `swifdroid_wrapper_audit.audit_workspace`
  - Input: optional `rootDir`, optional `filter`

## Recommended prompts

1. Implement new wrapper from official docs:
   - "Implement wrapper for `android.widget.Button` using `android_ref_docs.get_class` and follow `.agent/ANDROID_CLASS_WRAPPERS.md`."

2. Implement a single missing method:
   - "Implement `android.widget.EditText#onTextContextMenuItem(int)` using `android_ref_docs.get_method`."

3. Add missing TODOs before implementation:
   - "Run `swifdroid_wrapper_audit.apply_todos` for `Sources/Droid/Packages/android/app/Dialog.swift`."

## Behavior rules when generating wrappers

- Keep one `[Learn more](...)` link only in the class doc comment.
- Paraphrase official method behavior accurately in concise method doc comments.
- Prefer `// TODO:` markers instead of speculative wrappers when parameter/return types are missing.
- Keep wrapper style aligned with `.agent/ANDROID_CLASS_WRAPPERS.md`.
- Compilation validation in devcontainer is mandatory before considering wrapper work complete.

## Mandatory build validation

After MCP-driven wrapper generation/audit changes, run both builds in `/workspaces/an6`:

1. `/swift/toolchains/6.2-RELEASE/usr/bin/swift build -Xswiftc -DANDROIDBUILDING -c debug --build-path ./.build/.metadata --product AppManifest`
2. `/swift/toolchains/6.2-RELEASE/usr/bin/swift build --swift-sdk aarch64-unknown-linux-android35`

Before build #2, run:

- `/swift/toolchains/6.2-RELEASE/usr/bin/swift sdk install /swift/sdks/swift-6.2-RELEASE-android-0.1.artifactbundle || true`

For exact container mount expectations, follow `.agent/DEVCONTAINER_COMPILATION_CHECK.md`.

## Smoke check

The smoke uses `refresh:true`, so maintenance validation should isolate its cache rather than write the reusable repository cache. Start the process with a unique absolute temporary root, for example:

- `SWIFDROID_ANDROID_REF_CACHE_ROOT=/tmp/swifdroid-android-ref-cache-<unique> node .agent/mcp/tests/smoke.mjs`

After capturing the required evidence, remove only the exact temporary root created for that run and verify it is absent.

The smoke validates:

- offline reference resolution for `Dialog`, `View`, `TextView`, `ConstraintLayout`, and `MaterialButton`;
- generated TODO insertion and byte-idempotency on a temporary wrapper copy;
- full generated TODO reconciliation, including restoration of still-missing IDs, stale generated-ID removal, preservation of manual TODOs without duplication, deterministic sorting, and a final unchanged pass;
- invocation-owned wrapper temporary-directory cleanup even when the wrapper smoke body fails.

## Maintenance gate

When parser, resolver, mappings, fixtures, or audit logic changes:

1. choose a unique task-owned absolute temporary cache root;
2. set `SWIFDROID_ANDROID_REF_CACHE_ROOT` before starting the smoke/MCP process and run the focused smoke;
3. exercise the exact affected tool on a representative wrapper, using a disposable wrapper copy whenever mutation is expected;
4. confirm production wrappers and the reusable repository cache did not change unless the task explicitly authorized those exact mutations;
5. remove only the exact task-owned temporary cache/wrapper state and verify cleanup;
6. review generated diffs, exact source/cache identities when relevant, and repository status.
