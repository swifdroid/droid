# Workflow

Mandatory development workflow for Droid.

## PLAN -> IMPLEMENT -> AUDIT

1. **PLAN** - research current facts, define exact API/behavior paths, primary architecture owner, Android/JNI evidence, generated-consumer/build needs, docs impact, and completion criteria. Externalize substantial research/plan state under `.artifacts/planning/<slug>/` according to `ARTIFACTS_WORKFLOW.md`.
2. **IMPLEMENT** - execute only reviewed scope while preserving unrelated working-tree state. Large/multi-behavior work is decomposed into numbered surgical task files before an implementation executor receives it.
3. **AUDIT** - verify source semantics, lifecycle/state/JNI boundaries, mandatory builds/tooling, representative consumer behavior when needed, docs impact, and exact Git state with concrete evidence; use focused correction task files when needed and synchronize durable knowledge that actually changed.

Small typo/prose-only work may skip a formal plan but still requires scope/result verification.

For substantial iterative work, `ARTIFACTS_WORKFLOW.md` is mandatory operational guidance. Detailed mechanics live in task files; the implementation-wave prompt stays compact and drives autonomous task-by-task execution with append-only reporting. The implementation executor reads only the current task and may open the next task only after the current task records PASS. Independent plan/source/milestone audits normally use a fresh separate auditor session with the trusted repository evidence surface and the hard availability-stop rule defined in `DEVELOPMENT_ORCHESTRATION.md`.

After meaningful research/design/implementation/validation/correction/audit, perform the lazy public-content capture check owned by `PUBLIC_CONTENT_IDEAS.md`. Decide from information already in context first. If no valuable README/`SwifDroid/docs`/migration/release/article/post material appeared, do nothing and do not open the bank. If positive, open only the router plus the relevant shard and append the smallest useful status/caveat-aware entry before the context goes stale.

## Wrapper Development

For Android wrappers:

1. verify exact upstream Android identity/signature/availability from current reliable reference/source evidence;
2. inspect established Droid wrapper patterns;
3. implement only verified surface;
4. keep unresolved overloads/listeners/types explicit rather than guessing;
5. run the mandatory completion gate in `DEVCONTAINER_COMPILATION_CHECK.md`;
6. use MCP helper workflow only when it materially assists the task and never treat its report as semantic proof by itself.

## Verification Progression

Use the smallest evidence first, then expand by risk:

```text
source/API audit
-> focused package/build check
-> mandatory Android/devcontainer build gate when applicable
-> MCP smoke tests when helper tooling changes
-> representative generated-app/runtime evidence for integration-sensitive behavior
-> targeted sibling docs audit for public user-facing change
```

## Git Safety

Follow `COMMIT_RULES.md`. Never stage, commit, tag, push, publish, or rewrite history without explicit authorization.
