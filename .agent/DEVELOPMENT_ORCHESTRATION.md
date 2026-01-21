# Development Orchestration

Model-independent authority for coordinating Droid repository work with LLMs and coding agents.

This file owns **roles, delegation, review, and gates**. Detailed `.artifacts/**` structure and task/report mechanics are owned by `ARTIFACTS_WORKFLOW.md`.

## Roles

### Coordinator / Reviewer

For non-trivial work, the reasoning/review layer:

- restores current context from real Git/source/stable docs and preserves the existing dirty worktree;
- performs or directs focused Android/JNI/framework/build/docs research;
- designs and independently audits the implementation plan;
- decomposes substantial work into numbered surgical task files;
- gives the implementation executor only a short coordinator prompt;
- independently inspects actual source/diff/Git/build/MCP/generated-consumer/docs evidence after execution;
- turns audit findings into focused correction task files;
- synchronizes durable stable documentation after accepted work;
- performs the lazy public-content capture check after meaningful work and appends only genuinely valuable README/`SwifDroid/docs`/migration/release/article/post material to the relevant `PUBLIC_CONTENT_IDEAS.md` shard while the context is fresh;
- keeps staging, commit, push, tag, and publication as separate explicit gates.

Executor reports are evidence, never proof.

The normal maintainer workflow uses the coordinator/reviewer as the strongest available reasoning layer. It should perform every repository/static/evidence operation that its trusted repository evidence surface can perform directly. Do not delegate Git/source/diff/hash/governance inspection to the implementation executor merely because the executor could also do it locally.

### Independent Auditor

The independent auditor is a **fresh, separate strong reviewer session**. This is the default independent plan/source/diff/evidence/milestone reviewer for substantial Droid work.

The independent auditor:

- is independent from the primary coordinator and from the implementation executor;
- uses only the trusted repository evidence surface for every local Droid repository/Git/source/test/package/`.agent/**`/`.artifacts/**` operation;
- does not substitute a different filesystem, shell, remote, GUI, or repository connector surface for required repository evidence unless the task explicitly changes that boundary;
- is normally read-only except for the exact ignored audit/report artifact explicitly authorized by its frozen prompt;
- treats coordinator/executor reports as claims to verify, not proof;
- returns findings to the primary coordinator; it does not silently repair production work unless a separate correction task explicitly authorizes that role change.

If the trusted repository evidence surface becomes unavailable, disappears, repeatedly times out, returns a transport/session failure, stops responding, or cannot provide a required local evidence operation, the independent auditor must:

```text
STOP IMMEDIATELY.
Do not substitute another local tool.
Tell the maintainer the trusted repository evidence surface is unavailable and ask them to tell you when it is available again.
Resume from the exact stopped evidence point only after the maintainer confirms availability.
```

Unavailability of the trusted repository evidence surface by itself is a procedural stop, not evidence that the audited Droid candidate is technically BLOCKED.

### Implementation Executor

The executor implements an already-reviewed task contract:

- read the next numbered task immediately before work;
- modify only its explicit scope/allowlist;
- follow closed mechanics without redesigning Droid/Android/JNI architecture;
- preserve unrelated staged/unstaged/untracked user work exactly;
- run required validation and inspect the actual diff;
- append execution evidence;
- continue automatically to the next already-approved task after PASS;
- stop the whole run on a genuine out-of-scope blocker.

The executor does not broaden scope merely to keep moving.

### Local Implementation Executor Profile

The normal implementation executor is a local coding agent. Treat it as an execution-focused implementation role that succeeds best with closed, surgical contracts rather than broad design prompts.

The local implementation executor:

- uses its own local filesystem/shell/Git/Swift/Android/devcontainer execution tools;
- must not use the coordinator/reviewer trusted repository evidence surface;
- receives already-researched and already-reviewed implementation mechanics rather than being asked to invent architecture;
- must preserve unrelated staged/unstaged/untracked user work;
- must not stage/commit/push/tag/publish unless the exact operation is separately authorized;
- should be delegated only the mutation or execution capability gap that the primary coordinator cannot safely perform through its trusted repository surface.

For multi-task work, never give the implementation executor one enormous implementation prompt. Give it one compact wave/coordinator prompt plus numbered surgical task files. The executor must read **only the current task file**. It must not preload, summarize, or reason from later task files. Only after the current task has passed its verification and its result has been appended to the execution report may it read the next task file.

## Default Flow

```text
verify current repository state
-> focused research
-> reviewed plan
-> independent plan audit
-> numbered surgical task files
-> short coordinator prompt
-> autonomous sequential execution + append-only evidence
-> independent source/diff/Git/build/runtime/docs audit
-> numbered correction wave if needed
-> independent re-audit
-> durable-doc synchronization
-> explicit staging/commit gate
-> explicit push/tag/publication gate when requested
```

For non-trivial iterative work, `ARTIFACTS_WORKFLOW.md` is mandatory and externalizes this flow under `.artifacts/**`.

## Delegation Rule

Never send an implementation executor one huge prompt containing several independent behaviors or a full correction audit.

Instead:

1. group work into tightly coupled, independently verifiable behaviors;
2. put detailed mechanics, allowlists, validation, and stop conditions into numbered task files;
3. give the executor one compact coordinator prompt that lists those files and the autonomous task loop.

If the coordinator prompt starts duplicating all task details, fix the decomposition before execution.

### Coordinator-First Capability Boundary

Before delegating work, ask whether the primary coordinator can complete it directly through its trusted repository evidence surface.

Normally keep these in the coordinator/reviewer layer when the trusted repository evidence surface supports them:

```text
Git/status/diff/history/object identity
source/test/package/project inspection
.agent/** and .artifacts/** inspection
exact path/hash/read-back checks
task/report/manifest consistency checks
historical evidence reconciliation
static wrapper/API ownership audit
durable governance/documentation synchronization
```

Delegate to the local implementation executor only the smallest operation that genuinely needs local mutation or unavailable execution capabilities, such as compiler/test/build/devcontainer/runtime work or production edits that cannot be performed safely through the current coordinator tool surface.

## Planning Gate

Non-trivial Droid work requires reviewed planning when it crosses multiple files/owners or changes public APIs, Android wrapper contracts, state/lifecycle/listener ownership, JNI dependency behavior, manifest/Gradle metadata, build/devcontainer/generated-app mechanics, MCP tooling, or user-facing documentation obligations.

The plan must be grounded in current source/Git/upstream Android/JNI/build evidence and close:

- scope/non-goals;
- primary architecture owner and supporting boundaries;
- exact Android/JNI identity/signature/lifecycle mechanics when relevant;
- allowed/forbidden mutation paths and preservation constraints;
- generated-consumer/devcontainer/MCP verification when relevant;
- docs impact and sibling-repository mutation boundary;
- validation and stop conditions.

Known plan defects are corrected before implementation.

## Independent Audit

After executor work, independently inspect:

- complete Git status/changed paths and preservation of pre-existing user work;
- actual changed/created source and direct callers;
- Android identity/signatures/overloads/nullability/availability for wrapper work;
- state/lifecycle/listener ownership and `@MainActor` boundaries when affected;
- JNI dependency/lifetime/signature boundary when affected;
- manifest/Gradle/dependency metadata when affected;
- required devcontainer/generated-consumer/runtime evidence;
- MCP helper output only as evidence, never semantic proof;
- public docs impact and sibling boundary;
- forbidden/deferred scope;
- actual validation evidence.

If the coordinator/reviewer cannot directly execute a required build/runtime/UI/Android/MCP verification because its current tool surface lacks the necessary command/runtime environment, it must not leave that evidence permanently unverified. Create a focused read-only verification task/prompt for an agent that does have the required environment/tools, require exact commands/observations and a written report artifact, then review that report together with every repository fact that can still be checked directly. Clearly distinguish delegated execution evidence from directly inspected source/Git evidence.

If defects remain, create a new focused numbered correction wave instead of one large correction prompt.

## Milestone Completion Audit

When a Droid roadmap/task milestone is being closed, passing implementation tasks, correction waves, mandatory builds, and live/consumer acceptance is not sufficient by itself.

Before declaring the milestone complete or moving it to the final commit gate, run one additional independent conformance audit using a different strong reviewer model/session from the implementation executor and, where practical, from the primary coordinator that designed the work.

The final auditor is normally the independent auditor profile above. It reviews the complete delivered milestone against the current roadmap and relevant stable architecture/governance owners, including Android/JNI mechanics, lifecycle/state ownership, build/generated-consumer behavior, docs synchronization, and deferred scope. Record the review under `.artifacts/reviews/`. A blocker reopens a focused correction wave; only a clean verdict allows stable milestone/task state to mark completion.

## Prompt Rules

Agent prompts are written in English unless the maintainer explicitly requests otherwise.

Every prompt should identify the repository/context, role, exact scope or task files, mutation permissions, preservation constraints, Git prohibitions, stop conditions, and expected evidence.

Do not make prompts self-contained by duplicating large task files. For artifact-driven execution, self-containment means the prompt explicitly points to the authoritative local task artifacts the executor must read.

When the primary coordinator prepares a detailed implementation-executor or independent-auditor prompt under `.artifacts/**`, it must also provide the maintainer a short ready-to-copy mini-launch prompt. The artifact-backed prompt is the detailed authority; the user-facing mini-prompt is only the launch envelope. Exact mechanics are owned by `ARTIFACTS_WORKFLOW.md`.

## Context Discipline

Do not bulk-load all task files into coordinator/executor context.

- The coordinator/reviewer loads only artifacts and source evidence needed for the current planning/audit step.
- The executor reads the next numbered task immediately before executing it.
- `PUBLIC_CONTENT_IDEAS.md` and its shards are not normal development context. Perform the capture check from current work first; open the router plus one relevant shard only when positive or when the task explicitly prepares public content.
- Operational docs and the public-content bank do not consume architecture-owner slots; architecture loading remains governed by `CONTEXT_LOADING_RULES.md`.
- Sibling repositories remain zero-context by default and are loaded only for concrete compatibility/documentation evidence.

## Git Gates

Implementation remains unstaged unless the maintainer explicitly authorizes staging/commit scope.

Normal implementation tasks forbid staging, commit/amend, merge/rebase/reset/restore/clean/stash, branch mutation, push, tag/publication, unrelated fixes, sibling mutation, and history rewriting.

Staging, commit, push, tag, and publication remain separate phases governed by `COMMIT_RULES.md` and explicit maintainer authorization.

## Disposable Working Memory

`.artifacts/**` may be deleted or absent on another machine. Stable workflow/architecture must remain recoverable from `AGENTS.md`, `.agent/**`, Git, source/build configuration, and current maintainer instruction.

Use `ARTIFACTS_WORKFLOW.md` for artifact structure, `NEW_CHAT.md` reconstruction, task/report conventions, verification delegation, correction waves, milestone reviews, and promotion of durable facts back into stable docs.
