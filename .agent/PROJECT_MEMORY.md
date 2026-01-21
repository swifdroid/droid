# Project Memory

Durable current-state facts for Droid agents.

- Droid is an independent Git repository and public Swift framework for native Android apps.
- JNIKit is a dependency and owns raw JNI semantics independently.
- Generated Android/Gradle projects consume Droid source and are not source authority.
- Wrapper APIs aim for idiomatic Swift while preserving exact Android identity/behavior.
- Deferred property/layout configuration and live-instance actions are intentionally distinct patterns.
- UI-facing state/listener code has established actor/lifecycle constraints that must be preserved.
- `.agent/WRAPPED_CLASSES.md` is navigation/evidence only, not a completeness contract.
- `.agent/mcp/**` is local helper tooling; its reports do not define wrapper semantics.
- Public user-facing API changes require a targeted audit of the sibling docs repository.
- Parent `../SwifDroid` governance is optional coordination context, not required local context.

Do not persist transient Git snapshots, machine-specific devcontainer mounts, current generated-app paths, or debugging diaries here.
