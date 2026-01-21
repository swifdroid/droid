# Artifacts Workflow

Stable operational authority for how Droid uses transient `.artifacts/**` working memory during research, planning, implementation, correction, verification, audit, and chat handoff.

This file defines the **workflow around artifacts**. Artifact contents never outrank `AGENTS.md`, stable `.agent/**` owners, current Git/source/build configuration, or explicit maintainer instruction.

## Core Principle

`.artifacts/**` is disposable external working memory.

It exists to keep long iterative framework/wrapper/tooling work precise without forcing one prompt or one chat context to carry the entire task.

It may be deleted at any time, absent on another machine or clean clone, or intentionally rebuilt from current repository facts.

Therefore:

- stable rules and durable architecture never depend on `.artifacts/**` existing;
- `.artifacts/**` is ignored by Git;
- plans/reports/task files are execution instructions and evidence, not permanent framework authority;
- generated Android/Gradle consumer output remains evidence/consumer state, not source authority;
- after meaningful durable changes, synchronize the relevant stable `.agent/**` owner instead of relying on an artifact forever;
- if artifacts disappear, reconstruct only what current Git/source/stable docs still support; never invent lost historical evidence.
- keep exactly one clearly active research/plan/task/correction lineage for the current substantial objective. When a maintainer-approved correction or replanning step invalidates an older lineage, remove or compact obsolete executor entry points so a future agent cannot plausibly execute two competing task packages;
- preserve historical rationale from superseded lineages only as the smallest useful review/rationale artifact. Do not keep obsolete task packages merely because they once passed an earlier audit;
- build products, dependency checkouts, disposable compiler workspaces, native build trees, indexes, caches, copied repositories, and generated runtime state are execution material rather than archival evidence. Preserve the smallest textual/raw evidence needed for adjudication and remove reproducible residue when the task no longer needs it.

## Mandatory Use for Substantial Iterative Work

Use `.artifacts/**` to externalize context before implementation when work is non-trivial, multi-file, cross-owner, public-API-sensitive, Android/JNI/lifecycle-sensitive, build/devcontainer/generated-consumer-sensitive, MCP-tooling-sensitive, documentation-sensitive, or otherwise cognitively dense.

Preferred lifecycle:

```text
restore current repo context
-> focused research
-> write research evidence
-> write implementation plan
-> independently audit plan
-> decompose implementation into surgical task files
-> run implementation executor task-by-task
-> append execution evidence after every task
-> independently audit actual source/diff/Git/build/runtime/docs evidence
-> create surgical correction tasks when needed
-> validate again
-> run final milestone review when closing a milestone
-> synchronize durable docs
-> separate staging/commit/push/tag/publication gates
```

Do not collapse a large researched implementation into one enormous executor prompt.

The primary coordinator should complete all static repository/evidence work supported by its trusted repository evidence surface. `.artifacts/**` delegation is for controlled implementation/audit/execution boundaries, not a reason to make the implementation executor rediscover facts the coordinator can already prove.

## Mandatory Large-Task Decomposition Rule

When implementation contains multiple natural behavior groups, several independent wrapper/framework mutations, multiple architecture boundaries, separate build/runtime/docs phases, or enough detail that one executor prompt becomes long or cognitively dense, the coordinator MUST decompose it before execution.

Detailed mechanics belong in numbered `.md` task files under `.artifacts/**`.

The executor receives one **short generic coordinator prompt** that only tells it:

- which repository to work in;
- which numbered task files to execute and in what order;
- to read each task immediately before executing it;
- to obey each task's allowlist/preservation/stop conditions;
- to append a report after every task;
- to continue automatically to the next task when the current task passes;
- to stop the entire run on an out-of-scope blocker rather than redesigning;
- not to stage/commit/push/tag/publish unless separately authorized.

For local implementation waves, the coordinator prompt must also state that the executor uses its own local execution tools and does not use the coordinator/reviewer trusted repository evidence surface.

The coordinator prompt must NOT duplicate detailed task requirements.

### Practical Split Threshold

Split rather than sending one large implementation prompt whenever any of these is true:

- more than one independently verifiable behavior is changing;
- more than one architecture/ownership boundary is involved;
- wrapper implementation, listener/JNI work, build validation, and docs synchronization form distinct phases;
- MCP/tooling changes have separate smoke/fixture validation from product source;
- the prompt would need long detailed mechanics;
- a failed middle step should prevent later work from executing.

Prefer several precise tasks over one overloaded prompt, but do not create artificial one-line tasks that destroy locality. One task should represent one tightly coupled behavior group with one meaningful verification gate.

## Recommended Directory Structure

```text
.artifacts/
├── NEW_CHAT.md
├── planning/
│   └── <work-slug>/
│       ├── RESEARCH_REPORT.md
│       ├── IMPLEMENTATION_PLAN.md
│       └── PLAN_AUDIT.md
├── implementation/
│   └── <work-slug>/
│       ├── 01-<task>.md
│       ├── 02-<task>.md
│       ├── ...
│       ├── EXECUTION_REPORT.md
│       └── COORDINATOR_PROMPT.md
├── corrections/
│   └── <work-slug>/
│       ├── 01-<correction>.md
│       ├── 02-<correction>.md
│       ├── ...
│       ├── EXECUTION_REPORT.md
│       └── COORDINATOR_PROMPT.md
├── verification/
│   └── <work-slug>/
│       ├── VERIFICATION_TASK.md
│       ├── VERIFICATION_REPORT.md
│       └── COORDINATOR_PROMPT.md
├── reviews/
│   └── <focused-review>.md
└── patches/
    └── <temporary-patch-evidence>
```

Use only directories/files needed by the current work. Do not manufacture empty bureaucracy.

## Planning Artifacts

### `RESEARCH_REPORT.md`

Stores verified implementation-time evidence needed to design the work, for example:

- current branch/HEAD/status and preservation constraints;
- exact Droid source/API/wrapper surface involved;
- authoritative Android reference/source evidence;
- established local wrapper/state/lifecycle/JNI patterns;
- active devcontainer/toolchain/SDK/mount facts when relevant;
- MCP helper behavior/fixtures when relevant;
- generated-consumer and sibling docs evidence when relevant;
- known constraints/unknowns.

Research must distinguish verified facts from architectural conclusions. MCP output and neighboring wrappers are evidence aids, not semantic authority by themselves.

### `IMPLEMENTATION_PLAN.md`

Contains the reviewed implementation design:

- exact goal/scope/non-goals;
- primary architecture owner and supporting boundaries;
- API/lifecycle/JNI/build ownership decisions;
- source topology and sequencing;
- exact mutation allowlist and preservation constraints;
- generated-consumer/devcontainer/MCP/docs verification strategy;
- validation strategy;
- explicit deferred work.

It should be implementation-ready before an executor receives production mutation work.

### `PLAN_AUDIT.md`

Records an independent audit of the plan against current source/Git, stable governance, architecture owners, upstream Android/JNI evidence, current devcontainer/build configuration, and affected docs/consumer state.

Do not treat a plan as ready merely because it was written.

## Surgical Implementation Task Contract

Each numbered implementation/correction task should contain only the context needed for one tightly coupled batch.

Use this shape when applicable:

```text
# Task NN - Title

## Goal
## Preconditions
## Allowed production paths
## Required implementation
## Android / JNI / lifecycle rules
## Preservation constraints
## Explicitly forbidden work
## Verification
## Completion report
## Stop conditions
```

Every task must make scope mechanically clear enough that the executor does not need to invent architecture.

Important:

- exact path allowlists are strongly preferred;
- state which earlier task output may be relied on;
- state exact Android identity/signatures/nullability/availability when relevant;
- state listener/state/JNI ownership expectations when relevant;
- identify whether deferrable configuration uses apply-or-append or a live-instance action;
- include the smallest meaningful source/build/devcontainer/MCP/runtime/docs gate;
- preserve all unrelated staged/unstaged/untracked user work;
- if a task uncovers a plan contradiction requiring broader scope, it stops instead of silently widening scope.

## Autonomous Executor Loop

```text
read Task NN completely
-> inspect required current Git/source/build facts
-> implement only Task NN allowlist
-> run Task NN verification
-> inspect actual diff
-> append Task NN result to EXECUTION_REPORT.md
-> if PASS: immediately continue to Task NN+1
-> if BLOCKED: append blocker and stop entire run
```

The executor does not ask for confirmation between already-approved numbered tasks.

The executor must **not read later task files early**. The context-loading boundary is part of the correctness contract:

```text
Task NN is unread until Task NN-1 has a recorded PASS.
```

After Task NN passes and its report section is appended, the executor may open Task NN+1 for the first time. This keeps a weaker local executor from blending future requirements into the current mutation or inventing cross-task shortcuts.

## `EXECUTION_REPORT.md`

Execution reports are append-only evidence.

After each task append a distinct section containing:

- actual paths changed;
- implementation facts;
- exact validation commands/results;
- devcontainer/generated-consumer/MCP/runtime/docs evidence when actually observed;
- Git state including preservation of pre-existing work;
- deviations/blockers.

Never rewrite earlier task sections to hide a failed or stopped attempt. A resumed task appends a new clearly named section.

An executor report is never proof by itself. The coordinator/reviewer independently inspects actual source/diff/Git afterward.

## Frozen Prompt and Identity Convention

When a delegated executor/auditor prompt has been reviewed and is ready for dispatch, prefer a frozen artifact name such as:

```text
EXECUTOR_<WORK>_WAVE_01_FROZEN.md
AUDITOR_<WORK>_AUDIT_01_FROZEN.md
```

After finalization, record and surface its exact SHA-256 and complete logical line count. A launch instruction should require both identities when practical. If the detailed prompt changes, its previous hash/line identity and mini-launcher are stale; finalize a new identity before dispatch.

Frozen means the delegated session executes the exact reviewed prompt. It does not make transient `.artifacts/**` stable repository authority.

## Independent Auditor Artifact Contract

An independent audit prompt must explicitly say:

```text
Role: fresh separate strong independent auditor
Repository: exact Droid path
Local tool boundary: trusted repository evidence surface ONLY
No substitution with a different filesystem, shell, remote, GUI, or repository connector surface
Read-only repository scope except the exact authorized ignored report artifact
STOP immediately if the trusted repository evidence surface becomes unavailable or cannot supply required evidence
Ask the maintainer to tell the auditor when the trusted repository evidence surface is available again
Resume from the exact stopped evidence point only after confirmation
```

The prompt must define exact authorities/evidence to read, verdict vocabulary, report path, mutation prohibition, and whether a clean result returns authority to PRIMARY rather than authorizing later implementation/commit work itself.

## Local Implementation Wave Artifact Contract

For substantial local implementation, use a wave directory containing surgical numbered tasks, one append-only report, and one compact frozen wave prompt. Example:

```text
.artifacts/implementation/<work-slug>/wave-01/
├── 01-<behavior>.md
├── 02-<behavior>.md
├── 03-<integration-gate>.md
├── EXECUTION_REPORT.md
└── EXECUTOR_WAVE_01_FROZEN.md
```

The wave prompt must tell the local implementation executor:

- use its own local filesystem/shell/Git/Swift/Android/devcontainer execution tools;
- do not use the coordinator/reviewer trusted repository evidence surface;
- verify the exact baseline and preservation constraints before mutation;
- execute tasks numerically;
- read exactly one task immediately before executing it;
- do not read any later task until the current task records PASS;
- modify only each task's exact allowlist;
- inspect the actual diff and append evidence after each task;
- continue automatically after PASS;
- STOP the entire wave on BLOCKED, authority mismatch, unsafe scope expansion, or preservation failure;
- never redesign architecture or guess Android/JNI semantics to keep moving;
- never stage/commit/push/tag/publish unless separately authorized.

The detailed wave prompt should contain orchestration and frozen baseline/protection facts, while task-specific implementation mechanics remain in the numbered task files.

## Verification Delegation

When the coordinator/reviewer lacks a direct tool needed to execute a required devcontainer build, Android runtime/UI interaction, generated-app check, or other command/runtime verification, create a focused verification artifact rather than accepting a blind spot.

Recommended shape:

```text
.artifacts/verification/<work-slug>/
├── VERIFICATION_TASK.md
├── VERIFICATION_REPORT.md
└── COORDINATOR_PROMPT.md
```

The verification task is read-only unless the maintainer explicitly authorizes otherwise. It must state exact commands/actions, required observations, environment assumptions, report format, and Git-mutation prohibitions.

The delegated agent writes the report from actual execution. The coordinator/reviewer then checks that report plus every repository fact available through its own tools. Delegated evidence fills an execution-capability gap; it does not replace independent source/Git review.

For wrapper work, delegated verification must still respect `.agent/DEVCONTAINER_COMPILATION_CHECK.md`; host-only success cannot substitute for mandatory Android/devcontainer evidence.

## Immutable Primary Evidence and Retry Boundary

Treat valid primary execution evidence as reusable authority for that exact source/command execution. Load-bearing evidence should preserve, when applicable:

```text
exact candidate/source identity
exact command and working directory
complete stdout/stderr or the intentionally frozen raw log
true numeric exit status
direct SHA-256 / line identity of retained evidence
```

Once valid primary evidence exists and the candidate source identity has not changed, a parser/report/manifest/summary defect does not automatically justify rerunning an expensive build/runtime gate. Correct or re-derive evidence from the immutable primary log when possible.

Before an expensive devcontainer/full build/runtime gate, validate cheap source/diff/parser/wrapper mechanics first. Delegated prompts that can launch expensive gates should state an explicit retry/attempt budget for an unchanged candidate when repeated execution would be costly or disruptive.

## Prompt-Owned Cleanup

Local implementation-executor prompts are responsible for disposable machine output they create. After each isolated probe/build/test step, once required evidence has been captured and verified, remove prompt-owned reproducible residue that no later step in the accepted pass needs.

Default rule:

```text
prompt-local + reproducible + disposable + no longer needed
=> remove after evidence capture
```

Before final response, sweep prompt-owned `/tmp`, disposable `.artifacts/**` build trees, copied workspaces, temporary `.build`/DerivedData/index/cache roots, and similar residue. Never broad-clean unknown paths or delete reusable project-root build/cache state, user evidence, unrelated untracked files, or anything whose ownership is ambiguous.

## Final Milestone Conformance Review

When a roadmap/task milestone is being closed, after implementation, corrections, mandatory builds, and required live/consumer acceptance pass, create one final milestone review under `.artifacts/reviews/` before stable task/roadmap state marks it complete.

Use a different strong reviewer model/session from the implementation executor and, where practical, from the primary coordinator. Review the **entire delivered milestone** against current roadmap and stable owners, including Android/JNI mechanics, state/lifecycle ownership, generated-consumer/build behavior, documentation synchronization, and deferred scope.

A blocker becomes a new focused correction wave. Do not bury correction work inside the review prompt.

## Correction Waves

After independent audit, do not send a giant correction prompt containing every defect.

Instead:

1. group findings into the smallest coherent correction behaviors;
2. create numbered files under `.artifacts/corrections/<work-slug>/`;
3. define exact allowlists, preservation rules, and validation for each;
4. create/reset an append-only correction `EXECUTION_REPORT.md` for that wave;
5. give the executor one short coordinator prompt pointing to those files;
6. let the executor run them sequentially and automatically;
7. independently audit the final repository state again.

If another materially distinct issue appears, create another focused correction wave rather than growing the old coordinator prompt.

## `COORDINATOR_PROMPT.md`

This file is intentionally compact and model/vendor independent.

It contains orchestration only, not implementation detail already present in numbered tasks.

Minimum responsibilities:

```text
repository/context
baseline Git expectations and preservation rules
list of numbered task files
execute numerically
read one task immediately before work
append report after each task
continue automatically after PASS
stop on blocker
Git mutation prohibitions
compact final report shape
```

If `COORDINATOR_PROMPT.md` starts restating detailed requirements from every task, the decomposition has failed and must be corrected before execution.

## Mandatory User-Facing Mini-Launcher

Whenever the coordinator writes a detailed executor/auditor prompt into `.artifacts/**` for the maintainer to dispatch to another session/agent, the same user-facing update must include a **ready-to-copy mini-launch prompt**.

This applies to both:

- local implementation-executor waves;
- separate strong independent auditor/reviewer sessions.

The mini-launcher should contain only launch/orchestration facts:

```text
target role/model
exact repository path
exact frozen main prompt path
exact SHA-256
complete logical line count
required tool boundary
high-level mutation/read-only boundary
instruction to execute the frozen prompt exactly and return its required report/verdict
```

Do not duplicate the detailed task mechanics in the mini-launcher. When useful, store the same mini-launcher under the artifact directory as `*_MINI_LAUNCHER_FROZEN.md`, but the maintainer must still receive a copyable launcher in the coordinator's chat response.

If the frozen detailed prompt changes before dispatch, recompute its hash/line count and issue a fresh mini-launcher. Never dispatch a launcher whose identity points at an older prompt body.

## `NEW_CHAT.md` Purpose

`.artifacts/NEW_CHAT.md` is transient continuation context for the **next coordinator/reviewer conversation**, not stable governance.

Keep enough current context to continue without replaying a long conversation or reopening accepted decisions. Update it after continuity-critical transitions such as:

- branch/HEAD or phase changes;
- accepted audit/correction verdicts;
- devcontainer/toolchain/SDK prerequisite changes;
- new active planning/implementation/correction/verification/review artifact sets;
- important blocker state;
- exact next intended action;
- current dirty-worktree preservation facts that matter to continuation.

Do not turn it into an ever-growing transcript. Replace stale continuation instructions with a current snapshot while preserving only rationale that still matters.

## Recreating `.artifacts` on Another Machine or After Deletion

If `.artifacts/` or `NEW_CHAT.md` is missing:

1. read root `AGENTS.md` and the minimum stable `.agent/**` governance required for the task;
2. inspect current Git branch/HEAD/status directly, including staged/unstaged/untracked layers;
3. inspect `TASKS.md`, `OPEN_DECISIONS.md`, `PROJECT_MEMORY.md`, `SOURCE_MAP.md`, and relevant architecture owners only as needed;
4. inspect actual changed source and recent relevant Git history rather than guessing unfinished work;
5. re-read active devcontainer/build configuration instead of assuming historical machine-local paths;
6. inspect exact affected sibling source/docs only when the current task requires cross-repository evidence;
7. identify the current work phase from repository evidence and maintainer instruction;
8. create `.artifacts/` directories only as needed;
9. create a fresh `.artifacts/NEW_CHAT.md` from **verified current facts**;
10. if non-trivial work is continuing, recreate fresh research/plan/task artifacts instead of pretending deleted transient plans still exist;
11. never infer uncommitted/lost implementation evidence that is no longer present on disk.

A reconstructed `NEW_CHAT.md` should normally contain:

```text
repository identity/path used in this environment
current branch / HEAD / full Git status
current roadmap/work phase
stable governance and architecture owners relevant to continuation
verified completed/accepted work that constrains the next step
current uncommitted user/agent changes and preservation rules
active Android/JNI/devcontainer/dependency/docs facts needed by the work
current artifact index, if recreated
next intended action
orchestration rules required for continuation
```

Machine-local paths/tool context IDs are allowed in `NEW_CHAT.md` because it is transient. Stable `.agent/**` docs must remain portable.

## Promotion to Stable Documentation and Public-Content Capture

At the end of an accepted implementation/correction cycle, decide what learned information is durable.

At the same continuity-critical checkpoints where `.artifacts/NEW_CHAT.md` is refreshed, also perform the lazy public-content capture check owned by `PUBLIC_CONTENT_IDEAS.md`. This does **not** mean opening the bank every time. First decide from already-loaded context whether a genuinely useful README/`SwifDroid/docs`/migration/release/article/post example, capability, validation result, diagram, or explanation appeared. Only after a positive check open the router plus one relevant shard and append the compact entry while the reasoning/evidence is fresh.

`NEW_CHAT.md` and the public-content bank have different lifecycles: `NEW_CHAT.md` is transient/disposable execution continuity; `PUBLIC_CONTENT_IDEAS.md` and `.agent/public-content-ideas/**` are durable versioned candidate communication material. Capturing an idea does not authorize mutation of the sibling `SwifDroid/docs` repository or any publication channel.

Promote only durable facts/rules into the correct stable owner:

- Droid/framework/wrapper architecture rule -> owning architecture document;
- high-level development flow -> `WORKFLOW.md`;
- delegation/review/gates -> `DEVELOPMENT_ORCHESTRATION.md`;
- artifact mechanics -> this file;
- Git/commit/publishing rule -> `COMMIT_RULES.md`;
- code/wrapper implementation policy -> `CODE_STYLE.md` or the applicable specialized guide;
- source navigation fact -> `SOURCE_MAP.md`;
- durable current-state fact -> `PROJECT_MEMORY.md`;
- unresolved decision -> `OPEN_DECISIONS.md`;
- active executable work -> `TASKS.md`.

Do not promote execution diaries, transient commit hashes, local tool IDs, temporary error logs, generated-consumer snapshots, or large execution reports.

## Git Rule

`.artifacts/` must remain ignored by repository `.gitignore`.

Do not stage/commit artifacts merely because they were useful during development. They are intentionally local/transient unless the maintainer explicitly changes this repository policy.
