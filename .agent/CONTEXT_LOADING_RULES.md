# Context Loading Rules

Mandatory progressive-loading discipline for Droid coding agents.

## Default Budget

- load `CODE_STYLE.md` for every production/test edit;
- load **1 primary architecture owner**;
- load **at most 2 supporting owners** only when needed;
- load **at most 1 operational skill** by default;
- inspect the **smallest exact source/test/support subset**;
- sibling repositories are **0 by default**.

Do not bulk-load all wrappers, all Android reference pages, generated projects, MCP fixtures, JNIKit source, or docs pages.

## Loading Sequence

1. Read `AGENTS.md`.
2. If the work is non-trivial iterative LLM-assisted development, load `DEVELOPMENT_ORCHESTRATION.md` and `ARTIFACTS_WORKFLOW.md`. These are operational routing docs and do not consume architecture-owner slots.
3. Read `CODE_STYLE.md` for source/test edits.
4. Use `ARCH_INDEX.md` to select the primary owner.
5. Add specialized guide(s) only when the task requires them.
6. Use `SOURCE_MAP.md` before broad discovery.
7. Inspect exact relevant source/test/Kotlin/build files.
8. Load one operational skill through `SKILL_INDEX.md` if applicable.
9. Treat `PUBLIC_CONTENT_IDEAS.md` and `.agent/public-content-ideas/**` as lazy communication context, not normal development context. First perform the public-content capture check from already-loaded work; only if positive, or if the task explicitly prepares README/public `SwifDroid/docs`/migration/release/article/post content, load the router and exactly the relevant shard(s). These files do not consume architecture-owner slots.
10. Inspect JNIKit/docs/core-libs only for a concrete cross-repository compatibility/documentation question. The sibling `docs` repository remains zero-context by default even when the local idea bank contains candidate documentation material.
11. Stop once ownership, scope, and evidence are clear.

## Wrapper Context

Wrapper work normally loads:

- `architecture/ANDROID_WRAPPERS.md`;
- `ANDROID_CLASS_WRAPPERS.md`;
- `DEVCONTAINER_COMPILATION_CHECK.md` for completion;
- `MCP_WRAPPER_WORKFLOW.md` only when MCP helpers are used/changed.

## Escalation

Repository-wide wrapper/doc/tooling audits may deliberately exceed the default budget. State why and keep unrelated source mutation out of scope.
