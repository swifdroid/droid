# Validation and Engineering Stories Public Content Ideas

Focused idea bank for README/`SwifDroid/docs`/publication material about Droid validation, generated consumers, JNI/tooling boundaries, compatibility evidence, and engineering stories.

Do not load this shard during ordinary source work. Read/update it only after a positive public-content capture check points here or when explicitly preparing public content.

## The generated Android app is evidence, not the source of truth

Status: architecture-approved
Good for: SwifDroid/docs | article | technical deep dive | short post

### Why users should care

Droid generates/feeds Android and Gradle consumer surfaces, but generated output is intentionally treated as a consumer and diagnostic surface rather than a second implementation authority. Fixes belong in the owning Swift/framework source, then the generated consumer is used to prove that the source produces the intended Android result.

That separation is a useful engineering story because it prevents generated files from becoming a hidden fork of framework behavior.

### Candidate example / visual

```text
Droid Swift source + stable framework rules
                 │
                 ▼
       generated Android/Gradle consumer
                 │
                 ├─ compile/integration evidence
                 └─ diagnostic surface

If generated output is wrong:
fix the owning Droid source, then regenerate/revalidate.
```

### Evidence / provenance

Stable owners:

- `.agent/architecture/DROID_FRAMEWORK.md` (`Source Authority`)
- `.agent/architecture/BUILD_AND_TOOLING.md` (`Invariants`, `Generated Consumer`)

### Publication caveat

This is an approved architecture/validation principle, not evidence that any specific generator path or generated application version has shipped. Before publication, attach a current source-verified example and the exact validation gate used for that release.

## A host Swift build is useful, but Android validation answers a different question

Status: architecture-approved
Good for: SwifDroid/docs | article | release notes | short post

### Why users should care

For Android-facing wrapper work, passing a host `swift build` does not prove that the Android Swift SDK, JNI surface, mounted dependencies, or generated consumer are correct. Droid's workflow therefore treats host compilation as useful early evidence while reserving Android/devcontainer gates for claims that depend on the actual Android build environment.

This is a compact correctness story for future release notes or technical writing: confidence comes from matching the validation gate to the claim, not from reporting one generic green build.

### Candidate example / visual

```text
source/API audit
      │
      ▼
host Swift check          -> fast local evidence
      │
      ▼
Android Swift SDK/devcontainer build
      │
      ▼
generated consumer / runtime evidence when required
```

### Evidence / provenance

Stable owners/procedures:

- `.agent/architecture/BUILD_AND_TOOLING.md`
- `.agent/DEVCONTAINER_COMPILATION_CHECK.md`
- `.agent/WORKFLOW.md` (`Verification Progression`)

### Publication caveat

This entry describes the approved validation hierarchy, not a completed validation result for a specific feature/release. Do not publish wording such as "validated on Android" unless the relevant Android/devcontainer/generated-consumer/runtime gate was actually executed and recorded for that feature.
