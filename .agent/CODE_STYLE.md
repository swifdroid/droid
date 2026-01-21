# Droid Code Style Guideline

Repository-local source conventions for `droid/**`.

Read repository `AGENTS.md`, select the primary owner through `.agent/ARCH_INDEX.md`, and use this file for every Droid production/test source edit. Local architecture owners govern behavior; this file governs implementation style within those boundaries. Wrapper-specific rules live in `ANDROID_CLASS_WRAPPERS.md`. Parent SwifDroid governance is not required for ordinary repository work.

## Scope and authority

- Apply this guide to Droid production/test source and keep Kotlin/C support code consistent with the Swift owner it serves.
- Existing source is pattern evidence, not automatic authority for a new Android contract; verify exact upstream behavior.
- Do not force wrapper-specific patterns onto non-view domain, generation, or tooling code.

## DSL-first API shape

- Prefer fluent, SwiftUI-like builder APIs returning `Self`.
- Property setters should be chainable and read naturally (`.text(...)`, `.padding(...)`, `.gravity(...)`).
- Use `@resultBuilder` entry points (`BodyBuilder`, `AppBuilder`) for declarative construction.

## View wrapper pattern

For each implemented view/component wrapper:

1. Declare package class-name helpers in `extension ...Package`.
2. Define wrapper class (`open class ...: View/...`).
3. Override `className` and (when needed) `layoutParamsClass`.
4. Add `gradleDependencies` only when required.
5. Provide standard initializers:
   - `init(id: Int32? = nil)`
   - `init(id: Int32? = nil, @BodyBuilder content: ...)` for containers.

## Deferred property application

- New view properties/layout params should use dedicated structs:
  - `ViewPropertyToApply`
  - `LayoutParamToApply`
- Apply via `applyOrAppend(...)` rather than direct immediate JNI calls.
- Place each `ViewPropertyToApply` struct directly above its related setter method/extension.
- For one-off view keys, use inline string keys inside the struct (`let key: ViewPropertyKey = "setFoo"`).
- Add `ViewPropertyKey` / `LayoutParamKey` extension constants only when a key is reused in multiple places.

## Actor and state discipline

- UI-facing abstractions are `@MainActor` by default.
- State flows through `@State`, `ForEach`, and listener/trigger abstractions.
- Respect existing state lifecycle helpers (`StatesHolder`, `hold(in:)`, deinit cleanup).

## Manifest/Gradle DSL consistency

- Manifest builder methods follow paired instance/static style where already established.
- Keep method names aligned with Android XML attributes (`allowBackup`, `exported`, etc.).
- Gradle dependency wrappers should stay declarative and composable.

## Naming and file layout

- Keep Android package mirroring in filesystem (`Packages/android/...`, `androidx/...`, `comgoogleandroid/...`).
- Keep class names close to platform naming unless a compatibility suffix is intentional.
- Use `// MARK:` sections heavily for long API files.

## Documentation and comments

- Public API methods should have concise doc comments.
- Reference official Android docs links where appropriate.
- Keep comments factual and implementation-oriented; avoid redundant narration.
