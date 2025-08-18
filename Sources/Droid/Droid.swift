#if canImport(Android)
import Android
#if canImport(AndroidLogging)
import AndroidLogging
#endif
#if canImport(AndroidLooper)
import AndroidLooper
#endif
#endif
#if canImport(Logging)
import Logging
#endif

public struct InnerLog {
    static var logger: Logger { DroidApp.shared.innerLogger }

    /// Critical
    static func c(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        InnerLog.logger.critical(message(), metadata: metadata(), file: file, function: function, line: line)
    }

    /// Debug
    static func d(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        InnerLog.logger.debug(message(), metadata: metadata(), file: file, function: function, line: line)
    }

    /// Error
    static func e(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        InnerLog.logger.error(message(), metadata: metadata(), file: file, function: function, line: line)
    }

    /// Info
    static func i(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        InnerLog.logger.info(message(), metadata: metadata(), file: file, function: function, line: line)
    }

    /// Notice
    static func n(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        InnerLog.logger.notice(message(), metadata: metadata(), file: file, function: function, line: line)
    }

    /// Trace
    static func t(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        InnerLog.logger.trace(message(), metadata: metadata(), file: file, function: function, line: line)
    }

    /// Warning
    static func w(
        _ message: @autoclosure () -> Logger.Message,
        metadata: @autoclosure () -> Logger.Metadata? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        InnerLog.logger.warning(message(), metadata: metadata(), file: file, function: function, line: line)
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
        Log.logger.critical(message(), metadata: metadata(), file: file, function: function, line: line)
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
        Log.logger.debug(message(), metadata: metadata(), file: file, function: function, line: line)
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
        Log.logger.error(message(), metadata: metadata(), file: file, function: function, line: line)
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
        Log.logger.info(message(), metadata: metadata(), file: file, function: function, line: line)
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
        Log.logger.notice(message(), metadata: metadata(), file: file, function: function, line: line)
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
        Log.logger.trace(message(), metadata: metadata(), file: file, function: function, line: line)
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
        Log.logger.warning(message(), metadata: metadata(), file: file, function: function, line: line)
    }
}

#if os(Android)
@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnCreate")
public func activityOnCreate(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, callerObject activityRef: jobject, activityId: jint) {
    let localEnv = JEnv(envPointer)
    let globalCallerObj = activityRef.box(localEnv)
    if let context = globalCallerObj?.object() {
        if let pendingActivity = DroidApp.shared._pendingActivities.last {
            DroidApp.shared._pendingActivities.remove(at: DroidApp.shared._pendingActivities.count - 1)
            #if canImport(AndroidLooper)
            Task { @UIThreadActor in
                #if os(Android)
                pendingActivity.attach(to: context)
                DroidApp.shared._activeActivities[Int(activityId)] = pendingActivity
                #endif
            }
            #endif
        } else if let activityType = DroidApp.shared._activities.first(where: { $0.className == context.className.name }) {
            #if canImport(AndroidLooper)
            Task { @UIThreadActor in
                let activity = activityType.init()
                activity.attach(to: context)
                DroidApp.shared._activeActivities[Int(activityId)] = activity
            }
            #endif
        }
    } else {
        InnerLog.c("💧 Unable to wrap activity context")
    }
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnPause")
public func activityOnPause(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    #if canImport(AndroidLooper)
    Task { @UIThreadActor in
        DroidApp.shared._activeActivities[Int(activityId)]?.onPause()
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnStateNotSaved")
public func activityOnStateNotSaved(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    #if canImport(AndroidLooper)
    Task { @UIThreadActor in
        DroidApp.shared._activeActivities[Int(activityId)]?.onStateNotSaved()
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnResume")
public func activityOnResume(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    #if canImport(AndroidLooper)
    Task { @UIThreadActor in
        DroidApp.shared._activeActivities[Int(activityId)]?.onResume()
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnRestart")
public func activityOnRestart(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    #if canImport(AndroidLooper)
    Task { @UIThreadActor in
        DroidApp.shared._activeActivities[Int(activityId)]?.onRestart()
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnStart")
public func activityOnStart(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    #if canImport(AndroidLooper)
    Task { @UIThreadActor in
        DroidApp.shared._activeActivities[Int(activityId)]?.onStart()
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnStop")
public func activityOnStop(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    #if canImport(AndroidLooper)
    Task { @UIThreadActor in
        DroidApp.shared._activeActivities[Int(activityId)]?.onStop()
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnDestroy")
public func activityOnDestroy(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    #if canImport(AndroidLooper)
    Task { @UIThreadActor in
        DroidApp.shared._activeActivities[Int(activityId)]?.onDestroy()
        DroidApp.shared._activeActivities.removeValue(forKey: Int(activityId))
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnAttachedToWindow")
public func activityOnAttachedToWindow(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    #if canImport(AndroidLooper)
    Task { @UIThreadActor in
        DroidApp.shared._activeActivities[Int(activityId)]?.onAttachedToWindow()
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnBackPressed")
public func activityOnBackPressed(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint) {
    #if canImport(AndroidLooper)
    Task { @UIThreadActor in
        DroidApp.shared._activeActivities[Int(activityId)]?.onBackPressed()
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_activityOnActivityResult")
public func activityOnActivityResult(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, activityId: jint, requestCode: jint, resultCode: jint, intentRef: jobject?, componentCallerRef: jobject?) {
    let env = JEnv(envPointer)
    var intent: Intent?
    if let object = intentRef?.box(env)?.object() {
        intent = .init(object)
    }
    var componentCaller: ComponentCaller?
    if let object = componentCallerRef?.box(env)?.object() {
        componentCaller = .init(object)
    }
    #if canImport(AndroidLooper)
    Task { @UIThreadActor in
        DroidApp.shared._activeActivities[Int(activityId)]?.onActivityResult(requestCode: Int(requestCode), resultCode: Int(resultCode), intent: intent, componentCaller: componentCaller)
    }
    #endif
}
#endif