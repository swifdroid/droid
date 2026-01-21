# Devcontainer Compilation Check (Mandatory)

Operational completion gate for Droid wrapper implementation/update. `.agent/architecture/BUILD_AND_TOOLING.md` owns the build boundary; this file owns the current exact in-container procedure. Re-read the active local configuration instead of relying on parent workspace assumptions.

Read values from the active app's `.devcontainer/devcontainer.json` before running the check. Toolchain, SDK bundle, image, mounts, and volume names may evolve; update this file when the supported configuration changes.

## Mandatory gate

A wrapper task is **not done** until both builds pass in the app devcontainer context:

1. Metadata/AppManifest build:
   - `/swift/toolchains/6.2-RELEASE/usr/bin/swift build -Xswiftc -DANDROIDBUILDING -c debug --build-path ./.build/.metadata --product AppManifest`
2. Android SDK build:
   - `/swift/toolchains/6.2-RELEASE/usr/bin/swift build --swift-sdk aarch64-unknown-linux-android35`

## How to run correctly

Run from the representative app root inside its configured Android devcontainer (currently mounted at `/workspaces/an6`). The active configuration must mount the live checkouts at:

- representative app → `/workspaces/an6`
- Droid checkout → `/workspaces/droid`
- JNIKit checkout → `/workspaces/jni-kit`
- core-libs checkout → `/workspaces/core-libs`
- configured toolchain/SDK/Android volumes → `/swift/toolchains`, `/swift/sdks`, `/opt/android`

Before command #2, ensure the Android Swift SDK is installed in that container session:

- `/swift/toolchains/6.2-RELEASE/usr/bin/swift sdk install /swift/sdks/swift-6.2-RELEASE-android-0.1.artifactbundle || true`

If command #2 fails with missing SDK, run `swift sdk list`, then install the bundle above, and rerun build.

## Evidence and failure handling

- Record both command results; do not report the wrapper complete if either command was skipped or failed.
- A host `swift build` does not replace either gate.
- Diagnose source failures in their owning repository. Do not patch generated app/Gradle output unless the task explicitly includes its source owner.
- After the check, audit `droid` and any explicitly affected repository for unexpected generated files.
