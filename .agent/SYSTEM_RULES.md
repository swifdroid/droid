# System Rules

Global invariants for Droid development.

## Planning and Evidence

- Every non-trivial change requires a reviewed plan before implementation.
- Stable docs describe verified source behavior or reviewed architecture, not temporary implementation history.
- Planned wrappers/APIs must never be described as already implemented.
- Temporary Android reference evidence, generated-app output, MCP reports, command logs, and debugging notes belong in `.artifacts/**` or explicitly designated tooling fixtures, not stable architecture docs.

## Source of Truth

- Droid Swift/Kotlin source and local architecture owners define framework behavior.
- Generated Android/Gradle projects are consumers, never framework authority.
- Documentation is a projection of verified public behavior, never semantic authority.
- `WRAPPED_CLASSES.md` is navigation/evidence, not proof of semantic completeness.

## JNI Boundary

- JNIKit owns raw JNI reference/thread/class-loader/signature semantics.
- Droid must not invent a conflicting lifetime model or retain raw JNI state merely for wrapper convenience.
- If a wrapper exposes behavior requiring a missing JNIKit capability, identify that dependency explicitly rather than silently implementing unsafe local workarounds.

## Vertical, Non-Speculative Implementation

- Prefer the smallest real framework/wrapper behavior that satisfies the verified task.
- Do not bulk-generate or manually add adjacent API surface without evidence and approved scope.
- If implementation reveals a materially wrong Android/JNI/lifecycle assumption, stop that path and re-plan.

## Documentation Self-Maintenance

- Maintain one owner per architecture rule family through `ARCH_INDEX.md`.
- Update only affected stable docs/routing/decisions/source maps.
- Public user-facing API changes require a targeted sibling docs audit, but sibling mutation is separately authorized.
