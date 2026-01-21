# Droid - Agent Governance

## Repository Identity

`droid` is an independent Git repository implementing the public Swift framework for native Android applications.

It owns app/lifecycle/manifest/Gradle DSLs, declarative view/state behavior, Android/AndroidX/Material wrappers, SwifDroid-owned listener bridges, Kotlin support code, and local wrapper/reference tooling.

It depends on JNIKit but does not own JNI reference/thread/signature semantics. It has a separate sibling documentation repository, but public documentation does not define Droid behavior.

This repository is designed to be opened directly by LLM/coding agents. Parent `../SwifDroid` governance is optional cross-repository coordination context, not a prerequisite for normal Droid work.

## Authority Hierarchy

When local documents conflict, higher authority wins:

1. `.agent/SYSTEM_RULES.md` - global repository invariants
2. `.agent/WORKFLOW.md`, `.agent/DEVELOPMENT_ORCHESTRATION.md`, `.agent/ARTIFACTS_WORKFLOW.md`, and `.agent/COMMIT_RULES.md` - development/orchestration/artifact/Git workflow
3. `.agent/ARCH_INDEX.md` and the owning `.agent/architecture/*.md` file - technical architecture authority
4. `.agent/CODE_STYLE.md` and applicable specialized guides - implementation policy
5. `.agent/MASTER_PLAN.md` - repository capability roadmap
6. `.agent/OPEN_DECISIONS.md` - unresolved choices only
7. `.agent/PROJECT_MEMORY.md` and `.agent/SOURCE_MAP.md` - durable current-state/navigation facts
8. `.agent/TASKS.md`, `.agent/TODO.md`, `.agent/TECH_DEBT.md`, `.agent/TASKS_ARCHIVE.md` - work state
9. `.agent/CONTEXT_LOADING_RULES.md`, `.agent/PUBLIC_CONTENT_IDEAS.md`, `.agent/SKILL_INDEX.md`, `.agent/skills/*` - progressive context, lazy public-content capture, and focused procedures

Specialized local guides:

- `.agent/ANDROID_CLASS_WRAPPERS.md` - detailed wrapper implementation patterns
- `.agent/MCP_WRAPPER_WORKFLOW.md` - operational MCP wrapper/reference procedure
- `.agent/WRAPPED_CLASSES.md` - navigation/evidence map, not semantic completeness authority
- `.agent/DEVCONTAINER_COMPILATION_CHECK.md` - exact current wrapper completion build gate

`.artifacts/**` is transient plans/evidence/working memory, never stable authority. Root `PLAN.md`/`NEW_WIDGET.md` are task/context documents, not higher architecture authority.

## Mandatory Workflow

Use **PLAN -> IMPLEMENT -> AUDIT** for non-trivial work.

- Define exact behavior/repository/path scope, architecture owner, public API effect, build/runtime evidence, and docs impact before mutation.
- Implement the smallest coherent behavior. Do not bulk-expand adjacent wrappers/API merely because they are nearby.
- Audit source semantics, JNI boundary, state/lifecycle ownership, generated-consumer behavior when relevant, mandatory build gates, documentation impact, and Git state.
- If implementation disproves a reviewed Android/JNI/API assumption, stop that path and re-plan.

### Mandatory Iterative-Development Routing

For non-trivial iterative LLM-assisted work, load `.agent/DEVELOPMENT_ORCHESTRATION.md` and `.agent/ARTIFACTS_WORKFLOW.md`.

- Use `.artifacts/**` as disposable Git-ignored external working memory for research, plans, numbered surgical tasks, execution evidence, verification, reviews, corrections, and chat handoff.
- Large implementation/correction work is decomposed into numbered task files; the executor receives one short generic coordinator prompt and runs approved tasks autonomously in order.
- If `.artifacts/**` is missing, reconstruct current context from stable docs + Git + actual source/build state instead of guessing lost transient state.
- Executor reports are evidence, never proof; independently audit actual source/diff/Git afterward.
- After meaningful research/design/implementation/validation/correction/audit, perform the lazy public-content capture check owned by `.agent/PUBLIC_CONTENT_IDEAS.md`. Decide from already-loaded context first; open the router plus one relevant shard only when the check is positive.

## Mandatory Context Routing

For every Droid production/test edit:

1. read this file;
2. read `.agent/CODE_STYLE.md`;
3. use `.agent/ARCH_INDEX.md` to select one primary architecture owner;
4. load at most two supporting architecture owners when genuinely needed;
5. use `.agent/SOURCE_MAP.md` before broad discovery;
6. inspect only the exact implementation/test/support files required.

Additional routing:

- Android/AndroidX/Material wrapper work -> `.agent/architecture/ANDROID_WRAPPERS.md` + `.agent/ANDROID_CLASS_WRAPPERS.md`.
- Use/change MCP helpers -> additionally `.agent/MCP_WRAPPER_WORKFLOW.md` and `.agent/architecture/BUILD_AND_TOOLING.md`.
- Wrapper completion -> `.agent/DEVCONTAINER_COMPILATION_CHECK.md` is mandatory exact build procedure.
- JNI lifetime/signature/class-loader changes -> `.agent/architecture/JNI_DEPENDENCY_BOUNDARY.md`; inspect JNIKit only when the contract actually requires it.
- Public user-facing API changes -> `.agent/skills/documentation_sync_skill.md` for the docs audit boundary.
- Positive public-content capture check or explicit README/docs/release/article/post work -> `.agent/PUBLIC_CONTENT_IDEAS.md` plus exactly the relevant thematic shard; never browse unrelated shards.

Full loading discipline: `.agent/CONTEXT_LOADING_RULES.md`.

## Framework Invariants

- Generated Android/Gradle artifacts consume Droid source truth; never fix generated output as a substitute for fixing the owning source.
- UI-facing state/listener behavior preserves established `@MainActor` and lifecycle ownership.
- Deferrable properties/layout params follow the established apply-or-append model; live-instance actions call the live object directly.
- Manifest/Gradle metadata remains synchronized with components that require it.
- Public APIs should be idiomatic Swift while preserving exact Android identity/behavior.
- Do not guess unresolved Android types, listeners, overloads, signatures, constants, lifecycle behavior, or availability. Keep explicit TODO/blocking evidence instead.
- `WRAPPED_CLASSES.md` is a navigation/evidence map, not proof of complete upstream API coverage.

Architecture owners: `.agent/architecture/DROID_FRAMEWORK.md` and `.agent/architecture/ANDROID_WRAPPERS.md`.

## JNI Boundary

Droid may expose ergonomic wrappers over JNIKit, but JNIKit owns raw reference/thread/class-loader/signature semantics. Do not duplicate or weaken JNI lifetime authority inside Droid merely to simplify a wrapper.

Local routing owner: `.agent/architecture/JNI_DEPENDENCY_BOUNDARY.md`.

## Build / Devcontainer / Generation Boundary

Current container/generation/tooling behavior is owned locally by `.agent/architecture/BUILD_AND_TOOLING.md`. Exact wrapper completion commands are owned by `.agent/DEVCONTAINER_COMPILATION_CHECK.md` and must be re-read because environment paths/toolchain versions can change.

Host `swift build` does not replace mandatory Android/devcontainer wrapper gates.

## Documentation Boundary

Public API additions/removals/behavior changes require a targeted audit of the sibling `docs` repository when they affect users. The docs repository is independent Git state and mutation there requires separate authorization.

Candidate public-content material is captured durably in `.agent/PUBLIC_CONTENT_IDEAS.md` and focused local shards. Promotion into the sibling `SwifDroid/docs` repository, local README, release notes, migration guides, or other public channels remains an explicit maintainer-controlled phase.

Documentation explains verified Droid behavior; it cannot define or override this repository's API semantics.

## Documentation Self-Maintenance

Update stable local governance only when durable architecture, routing, source locations, decisions, verified debt, or work state change. Temporary wrapper inventories, command output, generated reference data, and audit reports belong in `.artifacts/**` or explicitly designated tooling data, not architecture owners.

Stable governance must describe agent roles and capability boundaries abstractly. Do not persist concrete model, provider, client, reviewer, or agent-tool product identifiers in `AGENTS.md` or `.agent/**`; exact runtime identities belong only in transient `.artifacts/**` prompts/evidence. Repository-owned protocols, services, source tools, and build/runtime interfaces may be named when they are part of Droid itself.

## Git Safety

Follow `.agent/COMMIT_RULES.md`. This repository may contain extensive pre-existing staged, unstaged, and untracked user work. Preserve it exactly. Never stage, commit, amend, reset, clean, stash, restore, rebase, squash, tag, push, or publish unless explicitly authorized for this repository and exact scope.

## Cross-Repository Coordination

Use parent SwifDroid root only when work is genuinely cross-repository. Return to this repository for all Droid mutation, validation, commit decisions, and final Git-state reporting.