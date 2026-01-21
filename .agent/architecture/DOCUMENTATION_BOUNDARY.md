# Documentation Boundary

Architecture ID: `DOC`

## Ownership

This document owns the synchronization boundary between Droid public APIs and the independent sibling `docs` repository.

## Invariants

- Droid source/architecture defines behavior; docs explain verified behavior.
- Public API additions/removals/renames/meaningful behavior changes require a targeted docs impact audit.
- A docs audit does not authorize docs mutation. The sibling repository has independent governance/Git state.
- Update only affected public pages/navigation/tracking; do not trigger broad docs rewrites from an unrelated source change.
- If source behavior is not fully verified, docs must not guess it.

Use `../skills/documentation_sync_skill.md` for the operational procedure.
