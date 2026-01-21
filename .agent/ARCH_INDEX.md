# Architecture Index

Authoritative architecture ownership/router map for Droid.

## Operational Routing

Use this index to select technical architecture owners. Non-trivial iterative LLM-assisted development is model-independent and routed separately through `DEVELOPMENT_ORCHESTRATION.md` + `ARTIFACTS_WORKFLOW.md`.

Supporting authorities:

- `WORKFLOW.md` - PLAN -> IMPLEMENT -> AUDIT
- `DEVELOPMENT_ORCHESTRATION.md` - coordinator/reviewer vs implementation-executor roles
- `ARTIFACTS_WORKFLOW.md` - transient research/plan/task/report/handoff mechanics
- `PUBLIC_CONTENT_IDEAS.md` + focused `public-content-ideas/**` shards - lazy durable README/`SwifDroid/docs`/migration/release/article/post candidate capture; never normal development context
- `COMMIT_RULES.md` - Git/staging/commit/publishing safety
- `CONTEXT_LOADING_RULES.md` - progressive context budget

These operational/public-content owners have no architecture IDs and do not consume architecture-owner slots.

| ID | Owner | Responsibility |
|---|---|---|
| `DRD` | `architecture/DROID_FRAMEWORK.md` | App/lifecycle/manifest/Gradle DSL, declarative state/view composition, framework-level public behavior |
| `WRP` | `architecture/ANDROID_WRAPPERS.md` | Android/AndroidX/Material wrapper identity, mapping, lifecycle/listener/property semantics |
| `BLD` | `architecture/BUILD_AND_TOOLING.md` | Swift package/devcontainer/generated-app/MCP/build integration boundary |
| `JDB` | `architecture/JNI_DEPENDENCY_BOUNDARY.md` | Droid-to-JNIKit dependency/lifetime/signature boundary and downstream escalation |
| `DOC` | `architecture/DOCUMENTATION_BOUNDARY.md` | Public docs synchronization boundary with sibling `docs` repository |

Routing examples:

- app entry/lifecycle/manifest/state/Gradle DSL -> `DRD`.
- Android wrapper/type/property/listener/method mapping -> `WRP`.
- devcontainer/build/generation/MCP mechanics -> `BLD`.
- raw JNI lifetime/signature/class-loader capability -> `JDB`.
- public user-facing documentation impact -> `DOC`.

Specialized implementation guides supplement these owners and cannot override them.
