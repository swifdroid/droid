# Documentation Sync Skill

Use when a Droid change may affect public user-facing documentation.

1. Identify exact public API/behavior delta from Droid source/diff.
2. Determine which sibling docs pages/navigation/tracking entries can actually be affected.
3. Inspect only those docs surfaces and verify claims against current Droid source.
4. Report one of: `no docs impact`, `docs update required`, or `docs blocked by unverified source behavior`.
5. Do not mutate the sibling docs repository unless separately authorized under its local governance.
6. Never let docs text redefine Droid semantics.
