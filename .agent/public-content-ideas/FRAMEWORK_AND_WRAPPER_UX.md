# Framework and Wrapper UX Public Content Ideas

Focused idea bank for README/`SwifDroid/docs`/publication material about Droid's Swift-facing framework and Android wrapper experience.

Do not load this shard during ordinary source work. Read/update it only after a positive public-content capture check points here or when explicitly preparing public content.

## Idiomatic Swift without pretending Android is something else

Status: architecture-approved
Good for: README | SwifDroid/docs | article | short post

### Why users should care

A useful Droid story is that Swift ergonomics and Android fidelity are not opposing goals. Public APIs should feel discoverable and natural in Swift while the wrapper still represents the exact Android/AndroidX/Material class, inheritance, overload, nullability, availability, lifecycle, and return behavior.

That gives future documentation a stronger explanation than "Android APIs wrapped in Swift": Droid aims to make Android pleasant from Swift without inventing a second fictional platform model.

### Candidate example / visual

A compact diagram can preserve the design idea without tying publication to one unstable API:

```text
idiomatic Swift call site
        │
        ▼
Droid public wrapper
        │
        ├─ preserves Android class identity
        ├─ preserves overload/nullability/API-level rules
        └─ preserves lifecycle/listener semantics
        │
        ▼
verified Android behavior
```

A future concrete page should replace the abstract middle with one source-verified wrapper example from the release being documented.

### Evidence / provenance

Stable owners:

- `.agent/architecture/DROID_FRAMEWORK.md` (`API Shape`)
- `.agent/architecture/ANDROID_WRAPPERS.md` (`Identity and Exactness`, `Properties and Actions`, `Listeners`)
- `.agent/ANDROID_CLASS_WRAPPERS.md` for implementation patterns

### Publication caveat

This entry captures an approved architecture principle, not proof that every current wrapper is complete or that every convenience API is released. Before publication, select an actually shipped wrapper/example and verify exact source plus release status.

## Configuration before a native View exists vs actions on a live object

Status: architecture-approved
Good for: SwifDroid/docs | article | migration guide | short post

### Why users should care

Droid deliberately distinguishes values that can be declared before the Android object exists from actions that semantically require the live native instance. That boundary makes declarative Swift configuration useful without lying about Android object state.

This can become a strong explanation of Droid's apply-or-append model: configuration may be queued and applied when the native object is created, while genuinely live actions stay live actions.

### Candidate example / visual

Conceptual visual:

```text
Swift declaration
   │
   ├─ deferrable property/layout value
   │      └─ apply now OR append until native instance exists
   │
   └─ live-instance action
          └─ call current Android object directly
```

A future public example should use a currently shipped wrapper/property/action pair whose exact behavior has been source-verified.

### Evidence / provenance

Stable owners:

- `.agent/architecture/DROID_FRAMEWORK.md` (`Deferrable Configuration`)
- `.agent/architecture/ANDROID_WRAPPERS.md` (`Properties and Actions`)

### Publication caveat

The architecture rule is approved, but this entry intentionally avoids naming a concrete API until a released source example is selected and verified. Do not turn the conceptual visual into a claim that every property/action follows identical mechanics without checking its owning wrapper.
