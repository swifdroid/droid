# Patch Review Skill

Use for independent review of a Droid patch without granting mutation authority.

1. Re-establish task scope and primary architecture owner.
2. Inspect actual diff/source rather than relying on an execution report.
3. Check Android identity/signatures, lifecycle/state semantics, JNI boundary, generated-consumer assumptions, docs impact, and Git preservation as applicable.
4. Run/inspect the smallest meaningful validation evidence.
5. Report findings by severity with exact file/symbol evidence.
6. Review does not authorize edits, staging, commits, sibling mutation, or broad cleanup.
