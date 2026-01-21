# Public Content Ideas

Stable low-context workflow owner for preserving high-value user-facing examples, framework capabilities, documentation angles, README material, `SwifDroid/docs` website-documentation ideas, migration/release-story material, and article/post concepts discovered during Droid development.

This is an **idea bank, not normal implementation context**. Detailed entries live in focused shards under `.agent/public-content-ideas/` so ordinary Droid development does not pay their context cost.

## Why This Exists

Research, wrapper design, implementation, Android/JNI validation, audits, and corrections often expose examples or explanations that would be expensive to reconstruct accurately during a later documentation pass.

Useful material may include:

- a concise Swift API example that demonstrates a Droid capability;
- a before/after wrapper or migration example;
- an explanation of how Droid keeps Swift ergonomics without falsifying Android behavior;
- a lifecycle/state/listener insight useful to users;
- a compatibility or availability story;
- a native Android/devcontainer/generated-consumer validation result that materially increases trust;
- a diagram that explains framework, JNIKit, generated-app, or docs boundaries;
- an implementation/correction story suitable for a technical article or short post.

Capture these while the evidence and reasoning are fresh. Publication and polishing happen later and only with maintainer approval.

## Capture Rule

After meaningful research, design, implementation, correction, validation, audit, or an accepted checkpoint, the coordinator/reviewer MUST perform a very short **public-content capture check** from information already in context:

> Did this work produce a genuinely valuable public-facing example, capability, explanation, migration note, validation result, or publication angle that would be wasteful to rediscover later?

If **no**:

- do nothing;
- do not open this bank.

If **yes**:

1. open only this router and the single relevant shard;
2. append the smallest useful entry while the reasoning/evidence is fresh;
3. record lifecycle status, provenance, and publication caveat so future writers cannot present planned or merely implemented behavior as released;
4. do not polish the entry into final marketing/public documentation unless the current task explicitly owns public content;
5. continue the development workflow without loading unrelated shards.

This check is similar in timing to keeping `.artifacts/NEW_CHAT.md` current, but the lifecycles are intentionally different:

- `.artifacts/NEW_CHAT.md` is disposable transient continuation context;
- this bank is durable, versioned `.agent/**` candidate communication material.

## Context-Budget Rule

Do **not** load this router or its shards during ordinary source work merely because they exist.

Load them only when:

- a public-content capture check is positive;
- the task explicitly prepares README/public website docs/migration guides/release notes/articles/posts;
- the maintainer asks to review or curate the idea bank.

Never browse the bank "just in case". Never bulk-load all shards. Read the router, then exactly the relevant shard(s).

This bank has no architecture ID and does not consume architecture-owner slots or the normal supporting-owner budget.

## SwifDroid Documentation Boundary

For this repository, **public website/documentation means the independent sibling `SwifDroid/docs` repository**.

The idea bank stays in `droid/.agent/**` because it captures communication value discovered while developing Droid. Promotion into `SwifDroid/docs` is a separate maintainer-controlled phase:

- capture does not authorize mutation of the sibling repository;
- Droid source/architecture remains technical truth;
- before publishing a technical claim, re-verify the owning Droid source and current lifecycle/release status;
- follow `architecture/DOCUMENTATION_BOUNDARY.md` and `skills/documentation_sync_skill.md` when actual docs synchronization is authorized.

README promotion remains local to this repository when explicitly authorized. Release notes, migration guides, website pages, and other public materials may live in `SwifDroid/docs` according to that repository's own governance.

## Shard Layout

Current shards:

- `public-content-ideas/FRAMEWORK_AND_WRAPPER_UX.md` - Swift-facing framework/wrapper ergonomics, exact Android identity, lifecycle/state behavior, deferred-vs-live actions, API examples, and migration/user-experience stories.
- `public-content-ideas/VALIDATION_AND_ENGINEERING_STORIES.md` - Android/devcontainer/generated-consumer validation, JNI/tooling boundaries, compatibility/correctness insights, diagrams, and engineering stories.

Create a new shard only when a topic becomes independently useful enough that adding it to an existing shard would create context noise. Prefer stable themes over one file per tiny idea.

Potential future shards may include, only when justified:

- `APP_LIFECYCLE_AND_STATE.md`
- `MIGRATIONS_AND_COMPATIBILITY.md`
- `BUILD_AND_DISTRIBUTION.md`

Do not pre-create empty shards.

## Entry Contract

Each captured entry should be compact and contain only what future public-writing work needs:

```text
## Short descriptive title

Status: idea | architecture-approved | implemented | validated | shipped | superseded
Good for: README | SwifDroid/docs | migration guide | release notes | article | short post

### Why users should care
A few sentences about user/developer value, not internal task bookkeeping.

### Candidate example / visual
Small Swift/Kotlin/diagram/before-after snippet worth preserving.

### Evidence / provenance
Stable owner, source/test/native evidence, and/or meaningful commit when available.

### Publication caveat
Anything future writers must not overclaim.
```

Sections that add no value may be omitted, but **status and publication caveat are mandatory for anything not already shipped**.

## Status Discipline

Use status truthfully:

- `idea` - worth preserving, not approved architecture;
- `architecture-approved` - accepted design/rule, not proof of implementation or release;
- `implemented` - source exists but final required validation/release may still be pending;
- `validated` - intended behavior passed the relevant Droid/Android/native/consumer validation gate;
- `shipped` - part of an actual released/publicly supported version;
- `superseded` - retained only when historical context remains useful; otherwise remove during maintainer-approved curation.

Never turn `idea`, `architecture-approved`, `implemented`, or `validated` into wording that implies the capability is already released.

## Provenance and Evidence

Prefer stable architecture owners and actual source/tests/native evidence over memory. A meaningful commit hash may be added when it helps future writers anchor a design or implementation milestone, but tiny entries do not need one merely for ceremony.

For native/runtime claims, distinguish clearly between:

- source inspection;
- host compilation;
- Android Swift SDK/devcontainer compilation;
- generated-consumer evidence;
- live Android/runtime observation.

Do not upgrade status based on a weaker gate than the claim requires.

## Promotion, Publication, and Cleanup

This bank is a staging area for communication value, not an alternate public documentation set.

Only with explicit maintainer approval may future work:

- promote an entry into local `README.md`;
- promote it into the sibling `SwifDroid/docs` repository;
- use it for migration guides or release notes;
- turn it into an article/post outline or public diagram;
- consolidate/deduplicate shards;
- mark entries shipped/superseded after verifying reality;
- remove entries that no longer retain useful communication value.

Do not automatically remove an entry merely because one channel used it; the same material may remain useful elsewhere. Publication, consolidation, status promotion, and cleanup are explicit phases.

## Quality Bar

Capture only material with real future communication value.

Good candidates answer at least one of these:

- "This demonstrates why writing native Android code through Swift/Droid is cleaner or safer for users."
- "This example explains an important Droid capability in a few lines."
- "This Android/JNI/lifecycle correctness choice is a strong engineering story."
- "Users upgrading, wrapping, or debugging Droid will benefit from this migration/compatibility insight."
- "This native validation result materially increases confidence in a public claim."

Do not fill the bank with routine refactors, generic praise, task bookkeeping, wrapper counts, or test/build counts without a meaningful user/engineering story.
