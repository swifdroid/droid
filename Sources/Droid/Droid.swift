#if canImport(Android)
import Android
#if canImport(AndroidLogging)
import AndroidLogging
#endif
#endif
#if canImport(Logging)
import Logging
#endif

let DroidAppUIPackage = "stream/swift/droid/appui"

// MARK: - Log

public struct InnerLog {
    static var logger: Logger { DroidApp.shared.innerLogger }

    static func warnThatLoggerDisabled() {
        #if os(Android)
        #if DROIDLOGS
        // Logger is enabled
        #else
        InnerLog.logger.critical("""
        ⚠️ Droid InnerLog is disabled. To enable, compile with -D DROIDLOGS flag by enabling "Droid Logs" checkbox in Swift Stream IDE.
        """)
        #endif
        #endif
    }

    /// Critical
    static func c(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        #if DROIDLOGS
        InnerLog.logger.critical(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
        #endif
    }

    /// Debug
    static func d(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        #if DROIDLOGS
        InnerLog.logger.debug(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
        #endif
    }

    /// Error
    static func e(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        #if DROIDLOGS
        InnerLog.logger.error(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
        #endif
    }

    /// Info
    static func i(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        #if DROIDLOGS
        InnerLog.logger.info(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
        #endif
    }

    /// Notice
    static func n(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        #if DROIDLOGS
        InnerLog.logger.notice(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
        #endif
    }

    /// Trace
    static func t(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        #if DROIDLOGS
        InnerLog.logger.trace(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
        #endif
    }

    /// Warning
    static func w(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        #if DROIDLOGS
        InnerLog.logger.warning(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
        #endif
    }
}

public struct Log {
    static var logger: Logger { DroidApp.shared.globalLogger }

    /// Logs a critical-level message.
    ///
    /// Use for serious errors that require immediate attention.
    /// This is the highest severity and typically indicates a crash or unrecoverable failure.
    public static func c(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        Log.logger.critical(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
    }

    /// Logs a debug-level message.
    ///
    /// Use for debugging information during development.
    /// These messages are useful for developers but typically omitted from production builds.
    public static func d(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        Log.logger.debug(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
    }

    /// Logs an error-level message.
    ///
    /// Use when a recoverable but serious issue occurs.
    /// This indicates that something went wrong, but the app can continue running.
    public static func e(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        Log.logger.error(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
    }

    /// Logs an info-level message.
    ///
    /// Use for general, expected runtime events (e.g. app state updates).
    /// Helpful for tracking app flow in production environments.
    public static func i(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        Log.logger.info(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
    }

    /// Logs a notice-level message.
    ///
    /// Use for important runtime events that aren't errors but still worth noting.
    /// Typically used for significant app lifecycle milestones or business logic checkpoints.
    public static func n(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        Log.logger.notice(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
    }

    /// Logs a trace-level message.
    ///
    /// Use for very detailed, fine-grained debugging information.
    /// More verbose than `debug`, often used to trace execution flow at a granular level.
    public static func t(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        Log.logger.trace(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
    }

    /// Logs a warning-level message.
    ///
    /// Use when something unexpected happens, but the app can recover gracefully.
    /// Helps identify potential issues without halting the program.
    public static func w(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if os(Android)
        Log.logger.warning(message(), metadata: metadata(), file: file, function: function, line: line)
        #endif
    }
}

// MARK: - JNI methods

#if os(Android)
@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnCreate")
public func activityOnCreate(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, callerObject activityRef: jobject, activityId: jint) {
    InnerLog.t("💚 activityOnCreate(id: \(activityId))")
    let localEnv = JEnv(envPointer)
    let globalCallerObj = activityRef.box(localEnv)
    if let context = globalCallerObj?.object() {
        _activityOnCreate(localEnv, context, Int(activityId), nil)
    } else {
        InnerLog.c("💧 activityOnCreate: unable to wrap activity context")
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnCreateSavedInstanceState")
public func activityOnCreateSavedInstanceState(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, callerObject activityRef: jobject, activityId: jint, bundleObject: jobject) {
    InnerLog.t("💚 activityOnCreateSavedInstanceState(id: \(activityId))")
    let localEnv = JEnv(envPointer)
    let globalCallerObj = activityRef.box(localEnv)
    if let context = globalCallerObj?.object() {
        if let global = bundleObject.box(localEnv)?.object(as: Bundle.className) {
            _activityOnCreate(localEnv, context, Int(activityId), Bundle(global))
        } else {
            InnerLog.c("💧 activityOnCreateSavedInstanceState: unable to get Bundle")
            _activityOnCreate(localEnv, context, Int(activityId), nil)
        }
    } else {
        InnerLog.c("💧 activityOnCreateSavedInstanceState: unable to wrap activity context")
    }
}

private func _activityOnCreate(_ env: JEnv, _ context: JObject, _ activityId: Int, _ bundle: Bundle?) {
    if let saved = DroidApp.shared._savedActivities[activityId] {
        InnerLog.t("💚 _activityOnCreate(id: \(activityId)) → saved block")
        let (activity, savedInstanceState) = saved
        MainActor.assumeIsolated {
            #if os(Android)
            DroidApp.shared._activeActivities[activityId] = activity
            DroidApp.shared._savedActivities.removeValue(forKey: activityId)
            activity.attachOnCreate(to: context, savedInstanceState: bundle ?? savedInstanceState)
            #endif
        }
    } else if let pendingActivity = DroidApp.shared._pendingActivities.last {
        InnerLog.t("💚 _activityOnCreate(id: \(activityId)) → pending block")
        DroidApp.shared._pendingActivities.remove(at: DroidApp.shared._pendingActivities.count - 1)
        MainActor.assumeIsolated {
            #if os(Android)
            DroidApp.shared._activeActivities[activityId] = pendingActivity
            pendingActivity.attachOnCreate(to: context, savedInstanceState: nil)
            #endif
        }
    } else if let activityType = DroidApp.shared._activities.first(where: { $0.className == context.className.name }) {
        InnerLog.t("💚 _activityOnCreate(id: \(activityId)) → new block")
        MainActor.assumeIsolated {
            let activity = activityType.init()
            DroidApp.shared._activeActivities[activityId] = activity
            activity.attachOnCreate(to: context, savedInstanceState: nil)
        }
    } else {
        InnerLog.t("🟥 _activityOnCreate(id: \(activityId)) → else block")
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnPause")
public func activityOnPause(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    InnerLog.t("💚 activityOnPause(id: \(activityId))")
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onPause()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnSaveInstanceState")
public func activityOnSaveInstanceState(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint, bundleObject: jobject) {
    InnerLog.t("💚 activityOnSaveInstanceState(id: \(activityId))")
    let localEnv = JEnv(envPointer)
    guard let global = bundleObject.box(localEnv)?.object(as: Bundle.className) else {
        InnerLog.c("🟥 activityOnSaveInstanceState(id: \(activityId)) exit: unable to get Bundle")
        return
    }
    MainActor.assumeIsolated {
        if let activity = DroidApp.shared._activeActivities[Int(activityId)] {
            InnerLog.t("💚 activityOnSaveInstanceState(id: \(activityId)) → active activity(id: \(activityId)) found")
            let bundle = Bundle(global)
            activity.onSaveInstanceState(bundle: bundle)
            DroidApp.shared._savedActivities[Int(activityId)] = (activity, bundle)
            DroidApp.shared._activeActivities.removeValue(forKey: Int(activityId))
        } else {
            InnerLog.c("🟥 activityOnSaveInstanceState(id: \(activityId)) exit: active activity(id: \(activityId)) not found")
        }
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnStateNotSaved")
public func activityOnStateNotSaved(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    InnerLog.t("💚 activityOnStateNotSaved(id: \(activityId))")
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onStateNotSaved()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnResume")
public func activityOnResume(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, callerObject activityRef: jobject, activityId: jint) {
    InnerLog.t("💚 activityOnResume(id: \(activityId))")
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onResume()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnPostResume")
public func activityOnPostResume(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, callerObject activityRef: jobject, activityId: jint) {
    InnerLog.t("💚 activityOnPostResume(id: \(activityId))")
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onPostResume()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnRestart")
public func activityOnRestart(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, callerObject activityRef: jobject, activityId: jint) {
    InnerLog.t("💚 activityOnRestart(id: \(activityId))")
    let localEnv = JEnv(envPointer)
    let globalCallerObj = activityRef.box(localEnv)
    guard let context = globalCallerObj?.object() else {
        InnerLog.c("💧 activityOnRestart(id: \(activityId)): unable to wrap activity context")
        return
    }
    let activityId = Int(activityId)
    if let saved = DroidApp.shared._savedActivities[activityId] {
        InnerLog.t("💚 _activityOnRestart(id: \(activityId)) → saved block")
        let (activity, savedInstanceState) = saved
        MainActor.assumeIsolated {
            #if os(Android)
            DroidApp.shared._activeActivities[activityId] = activity
            DroidApp.shared._savedActivities.removeValue(forKey: activityId)
            activity.attachOnRestart(to: context, savedInstanceState: savedInstanceState)
            #endif
        }
    } else if let pendingActivity = DroidApp.shared._pendingActivities.last {
        InnerLog.t("💚 _activityOnRestart(id: \(activityId)) → pending block")
        DroidApp.shared._pendingActivities.remove(at: DroidApp.shared._pendingActivities.count - 1)
        MainActor.assumeIsolated {
            #if os(Android)
            DroidApp.shared._activeActivities[activityId] = pendingActivity
            pendingActivity.attachOnRestart(to: context, savedInstanceState: nil)
            #endif
        }
    } else if let activityType = DroidApp.shared._activities.first(where: { $0.className == context.className.name }) {
        InnerLog.t("💚 _activityOnRestart(id: \(activityId)) → new block")
        MainActor.assumeIsolated {
            let activity = activityType.init()
            DroidApp.shared._activeActivities[activityId] = activity
            activity.attachOnRestart(to: context, savedInstanceState: nil)
        }
    } else {
        InnerLog.t("🟥 _activityOnRestart(id: \(activityId)) → else block")
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnStart")
public func activityOnStart(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, callerObject activityRef: jobject, activityId: jint) {
    InnerLog.t("💚 activityOnStart(id: \(activityId))")
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onStart()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnStop")
public func activityOnStop(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    InnerLog.t("💚 activityOnStop(id: \(activityId))")
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onStop()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnDestroy")
public func activityOnDestroy(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    InnerLog.t("💚 activityOnDestroy(id: \(activityId))")
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onDestroy()
        DroidApp.shared._activeActivities.removeValue(forKey: Int(activityId))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnAttachedToWindow")
public func activityOnAttachedToWindow(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    InnerLog.t("💚 activityOnAttachedToWindow(id: \(activityId))")
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onAttachedToWindow()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnBackPressed")
public func activityOnBackPressed(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    InnerLog.t("💚 activityOnBackPressed(id: \(activityId))")
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onBackPressed()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnActivityResult1")
public func activityOnActivityResult1(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint, requestCode: jint, resultCode: jint, intentRef: jobject?, componentCallerRef: jobject?) {
    InnerLog.t("💚 activityOnActivityResult1(id: \(activityId))")
    let env = JEnv(envPointer)
    var intent: Intent?
    if let object = intentRef?.box(env)?.object() {
        MainActor.assumeIsolated {
            intent = .init(object)
        }
    }
    var componentCaller: ComponentCaller?
    if let object = componentCallerRef?.box(env)?.object() {
        componentCaller = .init(object)
    }
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onActivityResult(requestCode: Int(requestCode), resultCode: Int(resultCode), intent: intent, componentCaller: componentCaller)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnActivityResult2")
public func activityOnActivityResult2(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint, requestCode: jint, resultCode: jint, intentRef: jobject?) {
    InnerLog.t("💚 activityOnActivityResult2(id: \(activityId))")
    let env = JEnv(envPointer)
    var intent: Intent?
    if let object = intentRef?.box(env)?.object() {
        MainActor.assumeIsolated {
            intent = .init(object)
        }
    }
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onActivityResult(requestCode: Int(requestCode), resultCode: Int(resultCode), intent: intent, componentCaller: nil)
    }
}
@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnMultiWindowModeChanged")
public func activityOnMultiWindowModeChanged(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint, isInMultiWindowMode: jboolean) {
    InnerLog.t("💚 activityOnMultiWindowModeChanged(id: \(activityId))")
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onMultiWindowModeChanged(isInMultiWindowMode: isInMultiWindowMode != 0)
    }
}
@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnRequestPermissionsResult")
public func activityOnRequestPermissionsResult(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint, requestCode: jint, permissions: jobjectArray, grantResults: jarray, deviceId: jint) {
    InnerLog.t("💚 activityOnRequestPermissionsResult(id: \(activityId))")
    let env = JEnv(envPointer)
    guard let permissionsBox = permissions.box(env) else { return }
    guard let permissionsObject = permissionsBox.object() else { return }
    let permissionsArray = JObjectArray(env, permissionsObject).toArray().compactMap { JString($0).string() }
    let grantResultsLength = env.getArrayLength(grantResults)
    var grantResultsArray = [Int32](repeating: 0, count: Int(grantResultsLength))
    env.getIntArrayRegion(grantResults, start: 0, length: grantResultsLength, buffer: &grantResultsArray)
    var results: [ActivityPermissionResult] = []
    for (index, permission) in permissionsArray.enumerated() {
        let grantResult = grantResultsArray[index]
        if let value = ActivityPermissionResult(permission, grantResult) {
            results.append(value)
        }
    }
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onRequestPermissionsResult(requestCode: Int(requestCode), results: results, deviceId: Int(deviceId))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnCreateOptionsMenu")
public func activityOnCreateOptionsMenu(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint, menuRef: jobject) -> jboolean {
    InnerLog.t("💚 activityOnCreateOptionsMenu(id: \(activityId))")
    let env = JEnv(envPointer)
    var menu: Menu?
    if let object = menuRef.box(env)?.object() {
        MainActor.assumeIsolated {
            menu = .init(object)
        }
    }
    guard let menu else { return 1 }
    let result = MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onCreateOptionsMenu(menu: menu) ?? false
    }
    return UInt8(result ? 1 : 0)
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnPrepareOptionsMenu")
public func activityOnPrepareOptionsMenu(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint, menuRef: jobject) -> jboolean {
    InnerLog.t("💚 activityOnPrepareOptionsMenu(id: \(activityId))")
    let env = JEnv(envPointer)
    var menu: Menu?
    if let object = menuRef.box(env)?.object() {
        MainActor.assumeIsolated {
            menu = .init(object)
        }
    }
    guard let menu else { return 1 }
    let result = MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onPrepareOptionsMenu(menu: menu) ?? false
    }
    return UInt8(result ? 1 : 0)
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnOptionsItemSelected")
public func activityOnOptionsItemSelected(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint, itemRef: jobject) -> jboolean {
    InnerLog.t("💚 activityOnOptionsItemSelected(id: \(activityId))")
    let env = JEnv(envPointer)
    var item: MenuItem?
    if let object = itemRef.box(env)?.object() {
        MainActor.assumeIsolated {
            item = .init(object)
        }
    }
    guard let item else { return 0 }
    let result = MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onOptionsItemSelected(item: item) ?? false
    }
    return UInt8(result ? 1 : 0)
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnOptionsMenuClosed")
public func activityOnOptionsMenuClosed(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint, menuRef: jobject) {
    InnerLog.t("💚 activityOnOptionsMenuClosed(id: \(activityId))")
    let env = JEnv(envPointer)
    var menu: Menu?
    if let object = menuRef.box(env)?.object() {
        MainActor.assumeIsolated {
            menu = .init(object)
        }
    }
    guard let menu else { return }
    MainActor.assumeIsolated {
        DroidApp.shared._activeActivities[Int(activityId)]?.onOptionsMenuClosed(menu: menu)
    }
}
#endif