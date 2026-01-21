# Android Class Wrapper Guidelines (SwifDroid)

Detailed implementation policy for Android/AndroidX/Material wrappers under `Sources/Droid/Packages/**`.

## Scope, authority, and required context

- Read repository `AGENTS.md`, `.agent/architecture/ANDROID_WRAPPERS.md`, and `CODE_STYLE.md` first.
- `.agent/architecture/ANDROID_WRAPPERS.md` owns wrapper architecture; `.agent/architecture/JNI_DEPENDENCY_BOUNDARY.md` routes JNI lifetime/signature questions to JNIKit when needed; this file owns concrete Droid wrapper patterns.
- Inspect the exact official Android contract and the closest established source pattern. Neither an MCP result nor a neighboring wrapper alone proves correctness.
- Load `MCP_WRAPPER_WORKFLOW.md` only when using/changing the helper services. The completion gate is owned by `DEVCONTAINER_COMPILATION_CHECK.md`.

## Definition of done

A wrapper is complete only when its real callable surface matches the verified platform contract, unresolved behavior remains explicit, both mandatory devcontainer builds pass, and affected public docs/navigation/coverage state are synchronized. A class helper, empty type, TODO block, inventory row, or docs page is not implementation proof.

This guide documents the **exact** implementation recipe used by SwifDroid’s Android wrappers. It is intentionally opinionated and is derived from the existing wrappers listed below.

**Primary references (copy the style from these files):**
- `Sources/Droid/Packages/android/view/View.swift`
- `Sources/Droid/Packages/android/widget/TextView.swift`
- `Sources/Droid/Packages/android/widget/EditText.swift`
- `Sources/Droid/Packages/android/widget/Toast.swift`
- `Sources/Droid/Packages/android/widget/LinearLayout.swift`
- `Sources/Droid/Packages/android/widget/RelativeLayout.swift`
- `Sources/Droid/Packages/android/app/Dialog.swift`
- `Sources/Droid/Packages/android/graphics/drawable/Drawable.swift`
- `Sources/Droid/Packages/androidx/constraintlayout/widget/ConstraintLayout.swift`
- `Sources/Droid/Packages/comgoogleandroid/material/button/MaterialButton.swift`
- `Sources/Droid/Packages/comgoogleandroid/material/floatingactionbutton/FloatingActionButton.swift`

If your wrapper introduces layout params for children, also follow the existing pattern in:
- `Sources/Droid/Packages/android/view/View+LayoutParams/` (especially `View+LayoutParamToApply.swift` and the per-layout files like `View+ConstraintLayout.swift`)

---

## 0. Core rules (non-negotiable)

1. **Mirror official Android reference docs**
   Implement each method as described in the official reference documentation (behavior + signature + overloads).

2. **Write accurate Swift doc comments from official behavior**
   Concisely paraphrase the relevant platform behavior. Preserve important constraints and do not invent semantics or copy long upstream passages.

3. **Only one official link per class**
   Put the official reference link as:
   `/// [Learn more](https://developer.android.com/reference/<package>/<Class>)`
   **only in the class doc comment**, not in every method doc comment.

4. **Preserve SwifDroid’s wrapper architecture**
   - Views use deferred property application (`ViewPropertyToApply`) for setters.
   - Layout params use deferred application (`LayoutParamToApply`) for per-parent `LayoutParams`.

5. **Prefer TODOs over “almost correct” implementations**
   If something is missing (types, listeners, nested classes, signature ambiguity), add a clear `// TODO:` instead of guessing.

6. **Compilation validation in devcontainer is mandatory**
   Wrapper implementation is not complete until both required devcontainer builds pass (see `.agent/DEVCONTAINER_COMPILATION_CHECK.md`).

---

## 1. File location + naming

Place the wrapper file under `Sources/Droid/Packages/` using the same package mirroring convention as the codebase:

- Android framework: `Sources/Droid/Packages/android/...`
- AndroidX: `Sources/Droid/Packages/androidx/...`
- Material / com.google.android: `Sources/Droid/Packages/comgoogleandroid/...`

The filename is the Swift wrapper type name, e.g. `Dialog.swift`, `MaterialButton.swift`, `ConstraintLayout.swift`.

---

## 2. Always add a package helper (JClassName DSL)

Every wrapper defines a `JClassName` helper in the corresponding package namespace so the class is discoverable via the package DSL.

Pattern:

```swift
extension AndroidPackage.WidgetPackage {
    public class TextViewClass: JClassName, @unchecked Sendable {}
    public var TextView: TextViewClass { .init(parent: self, name: "TextView") }
}
```

### 2.1. Inner classes (e.g. `LayoutParams`)

If the Android type contains an inner class you need to reference (most commonly `LayoutParams`):

```swift
extension AndroidPackage.WidgetPackage.LinearLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
```

Then register it with the layout params “router” used by the view system:

```swift
extension LayoutParams.Class {
    static let linearLayout: Self = .init(.android.widget.LinearLayout.LayoutParams)
}
```

---

## 3. Class doc comment style (with the single official link)

The class doc comment:
- Starts with a concise summary line.
- Contains the official class description (copied/paraphrased minimally; keep it accurate).
- Ends with the single official reference link.

Example structure:

```swift
/// Base class for Dialogs.
///
/// Note: Activities provide a facility to manage the creation, saving
/// and restoring of dialogs.
///
/// [Learn more](https://developer.android.com/reference/android/app/Dialog)
```

Do **not** add `[Learn more](...)` links to method doc comments.

---

## 4. Choose the correct wrapper “kind”

SwifDroid wrappers fall into two common categories:

### 4.1. View wrappers (`android.view.View` descendants)

Use this when the Android class is a `View` / `ViewGroup` / widget:

- Inherit from the closest existing SwifDroid wrapper (e.g. `View`, `ViewGroup`, `TextView`, `AppCompatButton`, `ImageButton`).
- Override `className`.
- Add `gradleDependencies` only when the Android class is from a library that must be pulled in (Material/AndroidX).
- Provide standard initializers:
  - `init(id: Int32? = nil)`
  - plus container initializer `init(id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView)` when the type is a container.

Template:

```swift
open class MyWidget: SomeBaseWidget {
    open override class var className: JClassName { .android.widget.MyWidget }
    open override class var gradleDependencies: [AppGradleDependency] { [] } // only if needed

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
```

### 4.2. Non-view wrappers (plain `JObjectable`)

Use this when the Android class is not a view (e.g. `Drawable`, `Dialog`):

- Conform to `JObjectable`.
- Store `public let object: JObject`.
- Provide:
  - `init(_ object: JObject)` for wrapping an existing JNI object.
  - `init?` constructors that call `JClass.load(...)` + `newObject(...)` when the Android type is instantiable.

Template:

```swift
/// … (official class docs)
/// [Learn more](https://developer.android.com/reference/...)
@MainActor
open class MyType: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/some/MyType" }
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    public init? (_ context: ActivityContext) {
        guard
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(args: context.signed(as: "android/content/Context"))
        else { return nil }
        self.object = global
    }
}
```

---

## 5. Method implementation rules

### 5.1. Keep Swift method names idiomatic, but map 1:1 to Java methods

The wrapper API is fluent and Swift-like, but must map cleanly to the underlying Java/Android method:

- Java `getFoo()` → Swift `foo()`
- Java `setFoo(x)` → Swift `foo(_ x: ...) -> Self` (chainable setters)
- Java `isFoo()` / `hasFoo()` → Swift `isFoo()` / `hasFoo()` returning `Bool`

If the existing SwifDroid area already uses a specific naming convention, follow that local convention consistently.

### 5.2. Doc comments: accurately paraphrase official method behavior (no links)

For each wrapper method:
- Write a concise Swift doc comment derived from the official contract without copying long upstream text.
- Include parameter/return details if they matter for correct usage.
- Do **not** add `[Learn more](...)` in method docs.

### 5.3. Use `@discardableResult` for fluent APIs

Any method that returns `Self` should be `@discardableResult`.

### 5.4. Actions vs properties (View wrappers)

**Action methods** (immediate effects; cannot be reliably deferred) call the instance directly:

```swift
public func hide() {
    instance?.callVoidMethod(name: "hide")
}
```

**Property setters** should use `ViewPropertyToApply` so they can be called before the view is instantiated and still apply later.

Pattern:

```swift
struct EnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setEnabled"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

extension MyWidget {
    @discardableResult
    public func enabled(_ value: Bool = true) -> Self {
        EnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}
```

Key rule:
- If a key is used only once, keep it inline inside the `ViewPropertyToApply` struct.
- Add `extension ViewPropertyKey { ... }` constants only for keys that are reused in multiple places/files.

Placement rule:
- Put each `ViewPropertyToApply` struct immediately above its related setter section (`// MARK: Set...` + setter extension).

### 5.5. Layout params (when the wrapper is a parent/container)

If the Android type has a custom `LayoutParams` class and you want SwifDroid to support fluent child configuration:

1. In the parent wrapper file:
   - Register `layoutParamsClass`.
   - Override `applicableLayoutParams()` to include the supported keys.
   - Declare `LayoutParamKey` entries.
   - Implement `LayoutParamToApply` structs that mutate the `LayoutParams`.

2. In `Sources/Droid/Packages/android/view/View+LayoutParams/`:
   - Add/extend `View+<Parent>.swift` to expose fluent `extension View { ... }` methods that use your `LayoutParamToApply` structs via `.applyOrAppend(self)`.

Parent wrapper file pattern:

```swift
open class MyLayout: ViewGroup {
    public override class var className: JClassName { .android.widget.MyLayout }
    public override class var layoutParamsClass: LayoutParams.Class { .myLayout }

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [.myRule]
    }
}

extension LayoutParamKey {
    static let myRule: Self = "myRule"
}

struct MyRuleLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .myRule
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}
```

View extension pattern:

```swift
extension View {
    @discardableResult
    public func myRule(_ value: Int32) -> Self {
        MyRuleLayoutParam(value: value).applyOrAppend(self)
    }
}
```

### 5.6. Overloads: implement them explicitly

If the Android API exposes multiple overloads:
- Provide multiple Swift methods.
- Use explicit signatures when JNI overload resolution is ambiguous.

Example (typed `CharSequence` arg):

```swift
guard let string = JString(from: text) else { return self }
object.callVoidMethod(name: "setText", args: [(string, .object(.java.lang.CharSequence))])
```

### 5.7. Units: expose `DimensionUnit` and convert to/from pixels

Follow the existing pattern:
- Getters returning sizes accept a unit parameter defaulting to `.dp` and use `unit.fromPixels(...)`.
- Setters accept `(Int, DimensionUnit)` and call `unit.toPixels(...)`.

### 5.8. Return types: wrap JNI objects into Swift wrappers

When returning another Android object:
- Load the returning class with `JClass.load(...)`.
- Call `callObjectMethod(... returningClass: ...)`.
- Wrap the `JObject` into the corresponding Swift wrapper type.

Example:

```swift
guard
    let returningClazz = JClass.load(Drawable.className),
    let global = instance?.callObjectMethod(name: "getIcon", returningClass: returningClazz)
else { return nil }
return Drawable(global)
```

---

## 6. Platform guards + fallbacks

SwifDroid compiles on non-Android platforms. Keep Android-only code inside `#if os(Android)` when required.

Common fallback patterns:
- Constructors return `nil` on non-Android.
- Fluent setters return `self` on non-Android.
- “Action” methods become no-ops on non-Android.

---

## 7. Gradle dependencies

If the wrapped class is from a library (Material, AndroidX ConstraintLayout, etc.), declare:

```swift
open override class var gradleDependencies: [AppGradleDependency] { [.material] }
```

Do not add dependencies unless they are required for the class to exist at runtime.

---

## 8. TODO conventions (keep wrappers honest)

Use TODOs to mark:
- missing wrapper types needed as parameters/return types,
- listener interfaces that require a native bridge,
- methods not implemented yet,
- signatures that need confirmation.

Preferred style:

```swift
// TODO: addOnCheckedChangeListener: implement MaterialButton.OnCheckedChangeListener https://developer.android.com/reference/com/google/android/material/button/MaterialButton.OnCheckedChangeListener
```

If you need to keep a placeholder for a method, prefer commented stubs with a `// TODO:` note rather than a wrong implementation.

---

## 9. Organization + formatting

- Use `// MARK:` sections heavily (one per method or per logical group for large files).
- Keep method implementations in `extension <Type> { ... }` blocks (matches the existing codebase).
- Keep `ViewPropertyToApply` structs directly above the matching setter method/section.
- Use inline string keys for one-off view property keys (`let key: ViewPropertyKey = "setFoo"`).
- Promote keys to `extension ViewPropertyKey` / `extension LayoutParamKey` only when reused across multiple places.
- Keep structs implementing `ViewPropertyToApply` / `LayoutParamToApply` close to their related API and name them consistently:
  - `<Thing>ViewProperty`
  - `<Thing>LayoutParam`

---

## 10. Implementation checklist

Before considering a wrapper “done”:

- [ ] Package helper (`...Package { ...Class }`) exists.
- [ ] Class doc comment contains the single `[Learn more](...)` link.
- [ ] `className` is correct and matches Android runtime class path.
- [ ] `gradleDependencies` is correct (only if required).
- [ ] Views: standard `init(id:)` exists; containers also have `init(id:, content:)`.
- [ ] Setters use `ViewPropertyToApply` (when deferrable); actions call instance directly.
- [ ] Layouts: `layoutParamsClass` + `applicableLayoutParams()` + layout param keys/structs are implemented (and `View+LayoutParams` has the fluent methods).
- [ ] Every method has correct behavior and doc comment; unimplemented parts have explicit TODOs.

---

## 11. MCP-assisted workflow

Use the MCP services documented in `.agent/MCP_WRAPPER_WORKFLOW.md`:

- `android-ref-docs`: resolve official class/method metadata.
- `swifdroid-wrapper-audit`: detect missing wrapper APIs and add `// TODO: implement ...` lines idempotently.

Recommended flow for new classes:

1. Resolve class metadata using `android_ref_docs.get_class`.
2. Create wrapper using this guideline and existing SwifDroid patterns.
3. Run `swifdroid_wrapper_audit.apply_todos` on the wrapper file.
4. Implement TODO-marked methods with `android_ref_docs.get_method` one-by-one.

---

## 12. Mandatory compilation check (devcontainer)

After wrapper changes, run both commands from `/workspaces/an6` inside the devcontainer context:

1. `/swift/toolchains/6.2-RELEASE/usr/bin/swift build -Xswiftc -DANDROIDBUILDING -c debug --build-path ./.build/.metadata --product AppManifest`
2. `/swift/toolchains/6.2-RELEASE/usr/bin/swift build --swift-sdk aarch64-unknown-linux-android35`

Before command #2, ensure Android Swift SDK is installed in that session:

- `/swift/toolchains/6.2-RELEASE/usr/bin/swift sdk install /swift/sdks/swift-6.2-RELEASE-android-0.1.artifactbundle || true`

Reference and full mount details: `.agent/DEVCONTAINER_COMPILATION_CHECK.md`.

Resolution priority in docs parser:
- live `developer.android.com` reference,
- local Android SDK source fallback,
- local fixture snapshot fallback.
