# Commit Rules

Git, staging, history, and publishing safety for Droid.

## Baseline and Scope

Before mutation, define exact approved paths and record:

```bash
git status --short --untracked-files=all
git branch --show-current
git rev-parse HEAD
```

This repository can contain extensive pre-existing staged, unstaged, and untracked user work. Treat all such state as user work unless the current task explicitly establishes otherwise.

- Do not add, edit, delete, rename, move, format, stage, unstage, revert, or otherwise touch files outside approved scope.
- Preserve existing staging boundaries exactly.
- Do not normalize a dirty worktree merely to make a task easier to review.
- If an approved file contains both task work and unrelated user edits, preserve unrelated content and inspect exact staged/unstaged layers.
- If safe isolation is uncertain, stop and report rather than guessing.

## Forbidden Git Mutations by Default

Never stage, commit, tag, push, publish, reset, checkout/restore files, clean, stash, amend, rebase, squash, cherry-pick, or otherwise rewrite/rearrange work/history unless explicitly authorized for the exact operation and target.

A request to implement/test/audit/document does not imply commit authorization. Commit authorization does not imply push/tag/publication/merge/rebase/squash authorization.

## Staging

When staging is explicitly authorized:

- stage only approved task-scope changes;
- never use broad `git add -A`, `git add .`, `git add -u`, or equivalent broad staging when unrelated/pre-existing work exists;
- prefer exact paths or exact hunks;
- do not unstage user changes simply to simplify a task commit unless explicitly authorized;
- verify the exact staged diff before commit.

Required pre-commit inspection:

```bash
git status --short --untracked-files=all
git diff --cached --check
git diff --cached
```

The staged diff must represent one intended logical commit and must not silently absorb pre-existing user work.

## Commit Atomicity

Keep commits logically coherent. Separate unrelated wrapper/API/tooling/docs/cleanup changes when they do not belong to the same behavior.

A cross-repository SwifDroid feature still requires separate repository-local commits. There is no parent workspace commit that can atomically include Droid and sibling repositories.

## Logical Commit Boundaries

A reviewed task or audit lineage may legitimately own several related repository changes without requiring them to be committed together. Commit boundaries follow durable Git history and review value, not artifact lineage or the fact that changes were discovered in the same audit.

- Prefer the smallest coherent commit whose staged contents have one clear primary intent.
- A companion/supporting change may be committed separately when the earlier commit remains valid, understandable, and non-broken without it.
- Configuration/metadata/housekeeping files such as `.gitignore`, package metadata, changelog/version files, generated ignore/exclude lists, CI/support configuration, or similar low-coupling files should normally be split into their own focused commit when that produces clearer per-file history and does not create a materially invalid intermediate repository state.
- Documentation and source/tooling corrections discovered by the same audit do not belong in one commit merely because they share an audit lineage. Keep them separate when they express different logical changes.
- Do not force a file into a commit solely because stable documentation already mentions the resulting repository state, provided the temporary intermediate state is harmless, obvious, and intentionally closed by a separate follow-up commit.
- Conversely, do not split changes when one commit would be misleading, uncompilable, behaviorally broken, destructive, or materially inconsistent without the other change. In that case the files form one atomic commit boundary.
- When choosing between combined vs separate commits, optimize for durable Git history: future readers should be able to understand why each file changed without unrelated commit messages lingering on that file's history.

## Commit Subject Style

Follow dominant maintainer-authored Droid history.

Canonical shape:

```text
<semantic emoji> <concise English action>
```

Rules:

- English only.
- Exactly one meaningful leading emoji followed by one space.
- Short action-oriented wording such as `Add`, `Implement`, `Fix`, `Improve`, `Update`, `Remove`, `Rework`, `Conform`, `Use`, `Mark`.
- Optional scope through `:`, commonly a type/component such as `RecyclerView: ...`, `Activity: ...`, `LayoutManager: ...`, `ActionBarCompat: ...`.
- Put Swift/Android/API symbols, identifiers, flags, values, filenames, or technical tokens in backticks when appropriate.
- No trailing period.
- Do not use generic Conventional Commit prefixes such as `feat:`, `fix:`, `chore:`, or `docs:` by default.
- Do not prefix with `Droid:`, `SwifDroid:`, or repository names merely to identify where the commit lives. `Droid: ...` is acceptable only when `Droid` is genuinely the component/symbol being changed, not as filler.
- Do not append contributor-integration suffixes such as `(#54 by @name)` or `#54 by @name` to ordinary local maintainer/agent commits.
- Never add agent/model/tool attribution, AI disclosure, execution-report boilerplate, or similar metadata to source headers or commit messages.

### Established Emoji Semantics

Droid history strongly supports:

- `🪚` - implementation, public API addition, substantial functional change, wrapper/framework expansion.
- `🔧` - fix, compatibility/configuration adjustment, targeted behavior correction.
- `✍️` - documentation comments, prose/log wording refinement, typo/text polish.
- `📖` - README/repository documentation update.
- `🧹` - cleanup/removal of unused/redundant material.
- `📜` - license/legal-document work.
- `🧪` - approved modern extension for test-only/regression-coverage commits; do not claim it is historically dominant if the affected Droid history does not show it.

Representative maintainer-authored history:

```text
✍️ Space: add documentation comments
✍️ RecyclerView: improve documentation comments
🪚 LayoutManager: add `staggeredGrid` shortcut
🪚 RecyclerView: add `hasFixedSize` property
🔧 Add `@State` support to `ViewVisibility`
🔧 Activity: base `exported=true` on `intentFilters`
🧹 AppCompatActivity: remove unused `print`
📜 Add LICENSE
📖 Update readme
```

Choose the emoji from Droid's own established semantic style. Do not import another repository's taxonomy merely because it is newer or more granular.

## Generated / External State

Do not commit generated Android/Gradle consumer output, devcontainer runtime state, SDK/toolchain caches, build output, local IDE state, or external representative-app changes unless the maintainer explicitly includes them in the deliverable.

Generated output is not framework source authority and must never be committed as a workaround for a Droid source problem.

## Post-Commit Verification

After an authorized commit inspect:

```bash
git show --stat --oneline --decorate -1
git status --short --untracked-files=all
```

Confirm:

- subject matches Droid history;
- committed paths/hunks match the approved logical change;
- pre-existing user work and staging boundaries remain preserved;
- no unexpected generated/local files entered the commit.

## Publishing and Integration

Build/test/audit/commit success never authorizes push, force-push, tag, release, package publication, merge, rebase, squash, or other integration. Each requires separate explicit maintainer authorization.

## Final State

After work re-check status/branch/HEAD and report actual staged, unstaged, and untracked state precisely.