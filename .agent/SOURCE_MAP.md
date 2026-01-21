# Source Map

Durable Droid navigation map. Verify exact current paths before mutation.

- `Package.swift` - package/products/targets/dependency boundary
- `Sources/Droid/DroidApp.swift`, `AppBuilder.swift`, `AppLifecycle.swift` - app entry/configuration/lifecycle
- `Sources/Droid/Activities/` - activity abstractions
- `Sources/Droid/Manifest/` - manifest DSL
- `Sources/Droid/Gradle/` - dependency/configuration model
- `Sources/Droid/State.swift`, `ForEach.swift`, `BodyBuilder.swift` - declarative state/composition
- `Sources/Droid/Packages/android/` - Android platform wrappers
- `Sources/Droid/Packages/androidx/` - AndroidX wrappers
- `Sources/Droid/Packages/comgoogleandroid/` - Material/Google/Flexbox wrappers
- `Sources/Droid/Packages/swift/` - SwifDroid-owned bridges/listeners
- `appkit/` - Kotlin/Android support module
- `.devcontainer/` - configured Android/container development environment
- `.agent/mcp/` - local Android reference/wrapper-audit tooling and fixtures
- `.agent/ANDROID_CLASS_WRAPPERS.md` - wrapper implementation patterns
- `.agent/WRAPPED_CLASSES.md` - wrapper navigation/evidence map
- `.agent/DEVCONTAINER_COMPILATION_CHECK.md` - exact mandatory wrapper build gate
- `PLAN.md`, `NEW_WIDGET.md` - current task/context documents when present; not architecture authority

Use this map before broad discovery. It is navigation, not semantic proof.
