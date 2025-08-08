//
//  DroidApp.swift
//  Droid
//
//  Created by Mihael Isaev on 26.10.2021.
//

#if canImport(Android)
import Android
#else
#if canImport(Glibc)
import Glibc
#endif
#endif
#if canImport(AndroidLooper)
import AndroidLooper
#endif
#if canImport(AndroidLogging)
import AndroidLogging
#endif
#if canImport(Logging)
import Logging
#endif
#if !os(Android)
import FoundationEssentials
#endif

open class DroidApp: @unchecked Sendable {
    nonisolated(unsafe) static var shared: DroidApp!

    public typealias Content = AppBuilder.Content
    public typealias Lifecycle = AppLifecycle
	public typealias Manifest = AppManifest
    public typealias GradleDependencies = AppGradleDependencies
    public typealias ProjectGradle = AppGradle.ProjectAppGradle
    public typealias ModuleGradle = AppGradle.ModuleAppGradle
    
    public static func main() {
        if shared == nil {
            shared = Self()
        }
        Self.start()
    }
    
    var isStarted = false

    /// Last unique id for the view which increases via mutex
    private var lastViewId: Int32 = 0x7F000000
    
    public class var current: Self { shared as! Self }
    
    required public init () {
        globalLogLevelMutex.activate(recursive: true)
        innerLogLevelMutex.activate(recursive: true)
        lastViewIdMutex.activate(recursive: true)
        setLogLevel(.notice)
        setInnerLogLevel(.notice)
    }

    deinit {
        globalLogLevelMutex.destroy()
        innerLogLevelMutex.destroy()
        lastViewIdMutex.destroy()
    }

    /// Mutex used to protect access to the logger's log level.
    private var globalLogLevelMutex = pthread_mutex_t()
    private var innerLogLevelMutex = pthread_mutex_t()

    /// Mutex used to protect access to the last view id variable.
    private var lastViewIdMutex = pthread_mutex_t()

    // MARK: - Logging

    /// The global logger instances used for all Droid operations.
    ///
    /// This logger writes to Android's logging system (e.g., `Log.i`, `Log.e`).
    var globalLogger = Logger(label: "")
    var innerLogger = Logger(label: "")

    // MARK: - Logging Control

    /// Sets the current log level for the `logger` instance.
    ///
    /// This allows dynamic control of verbosity for Droid logs.
    ///
    /// - Parameter level: The minimum `Logger.Level` required for messages to be emitted.
    public func setLogLevel(_ level: Logger.Level) {
        globalLogLevelMutex.lock()
        defer { globalLogLevelMutex.unlock() }
        globalLogger.logLevel = level
    }

    func setInnerLogLevel(_ level: Logger.Level) {
        innerLogLevelMutex.lock()
        defer { innerLogLevelMutex.unlock() }
        innerLogger.logLevel = level
    }

    /// Sets the current log level for the `logger` instance.
    ///
    /// This allows dynamic control of verbosity for Droid logs.
    ///
    /// - Parameter level: The minimum `Logger.Level` required for messages to be emitted.
    public static func setLogLevel(_ level: Logger.Level) {
        shared.setLogLevel(level)
    }

    public static func setInnerLogLevel(_ level: Logger.Level) {
        shared.setInnerLogLevel(level)
    }

    /// Returns app-wise unique identifier for the view.
    public func getNextViewId() -> Int32 {
        lastViewIdMutex.lock()
        defer { lastViewIdMutex.unlock() }
        if (lastViewId >= 0x00FFFFFF) {
            lastViewId = 0x7F000000
        }
        lastViewId += 1
        return lastViewId
    }

    /// Returns app-wise unique identifier for the view.
    public static func getNextViewId() -> Int32 {
        shared.getNextViewId()
    }

    #if canImport(Android)
    /// Start method for initial JNI call from the Application class.
    public static func start(
        _ envPointer: UnsafeMutablePointer<JNIEnv?>,
        _ appObject: jobject,
        _ localCallerObjectRef: jobject
    ) {
        if shared == nil {
            #if canImport(AndroidLooper)
            AndroidLooper.AndroidLooper_initialize(envPointer)
            #endif
            #if canImport(AndroidLogging)
            LoggingSystem.bootstrap(AndroidLogHandler.taggedBySource)
            #endif
            let jvm = envPointer.jvm()
            JNIKit.shared.initialize(with: jvm)
            shared = Self()
        }
        start()
    }
    #endif
    
    @discardableResult
    private static func start() -> DroidApp {
        guard !shared.isStarted else { return shared }
        shared.isStarted = true
        #if ANDROIDBUILDING
        shared.parseAppBuilderItem(shared.body.appBuilderContent)
        shared.parseAndroidBuildingArguments()
        #endif
        #if ANDROIDJSONDETAILS
        shared.parseAppBuilderItem(shared.body.appBuilderContent)
        shared.parseAndroidJsonDetailsArguments()
        #endif
        #if ANDROIDPREVIEW
        shared.previewStart()
        #else
        shared.start()
        #endif
        return shared
    }

    public var configuration = AppConfiguration()
    func updateConfiguration(_ values: [Int32]) {
        let fields = configuration.update(values) // TODO: notify
        InnerLog.d("configuration changed for: \(fields)")
    }
    
    #if !os(Android)
    private enum _AndroidJsonDetailsAction: String {
        case manifest
    }
    
    private func parseAndroidJsonDetailsArguments() {
        var args = CommandLine.arguments
        
        if let index = args.firstIndex(of: "--action"), args.count >= index + 1  {
            let raw = args[index + 1]
            guard let action = _AndroidJsonDetailsAction(rawValue: raw) else {
                print("Unknown --action argument: \(raw)")
                print("Possible values: manifest")
                exit(1)
            }
            args.removeFirst(index + 2)
            return proceedAndroidJsonDetailsAction(action, args)
        }
        
        print("No action had been provided")
        exit(1)
    }
    
    private func proceedAndroidJsonDetailsAction(_ action: _AndroidJsonDetailsAction, _ args: [String]) {
        switch action {
        case .manifest:
            struct Result: Encodable {
                let package, androidVersionCode, androidVersionName: String?
            }
            let resultModel = Result(
                package: _manifest.params[.package],
                androidVersionCode: _manifest.params[.androidVersionCode],
                androidVersionName: _manifest.params[.androidVersionName]
            )
            do {
                let data = try JSONEncoder().encode(resultModel)
                if let string = String(data: data, encoding: .utf8) {
                    print(string)
                } else {
                    print("Unable to generate JSON string")
                }
            } catch {
                print("Error has occured during JSON generation: \(error)")
            }
        }
        exit(0)
    }
    
    private enum _AndroidBuildingAction: String {
        case manifest
        case gradleDependencies
        case activityNames
        case generateAllActivities
    }
    
    private func parseAndroidBuildingArguments() {
        var args = CommandLine.arguments
        
        if let index = args.firstIndex(of: "--action"), args.count >= index + 1  {
            let raw = args[index + 1]
            guard let action = _AndroidBuildingAction(rawValue: raw) else {
                print("Unknown --action argument: \(raw)")
                print("Possible values: manifest, moduleGradle, projectGradle, activities")
                exit(1)
            }
            args.removeFirst(index + 2)
            return proceedAndroidBuildingAction(action, args)
        }
        
        print("No action has been provided")
        exit(1)
    }
    
    private func proceedAndroidBuildingAction(_ action: _AndroidBuildingAction, _ args: [String]) {
        switch action {
        case .gradleDependencies:
            var dependencies: Set<String> = []
            if let app = _manifest.items.compactMap({ $0 as? Application }).first {
                let activityTags = app.items.compactMap { $0 as? ActivityTag }
                for activity in activityTags.map({ $0.class }) {
                    #if !os(Android)
                    _ = activity.init()
                    #endif
                    for dep in activity.gradleDependencies {
                        dependencies.insert(dep)
                    }
                }
            }
            for dep in _gradleDependencies.dependencies {
                dependencies.insert(dep)
            }
            do {
                let data = try JSONEncoder().encode(dependencies)
                if let string = String(data: data, encoding: .utf8) {
                    print(string)
                } else {
                    print("Unable to generate JSON string")
                }
            } catch {
                print("Error has occured during JSON generation: \(error)")
            }
        case .manifest:
            print(_manifest.generateXML())
        case .activityNames:
            if let app = _manifest.items.compactMap({ $0 as? Application }).first {
                let activityTags = app.items.compactMap { $0 as? ActivityTag }
                print(activityTags.map { $0.class.className }.joined(separator: ","))
            }
        case .generateAllActivities:
            if let app = _manifest.items.compactMap({ $0 as? Application }).first {
                let activityTags = app.items.compactMap { $0 as? ActivityTag }
                var activities: [String: String] = [:]
                for activity in activityTags.map({ $0.class }) {
                    if let base64 = generateActivity(activity)?.data(using: .utf8)?.base64EncodedString() {
                        activities[activity.className] = base64
                    }
                }
                do {
                    let data = try JSONEncoder().encode(activities)
                    if let string = String(data: data, encoding: .utf8) {
                        print(string)
                    } else {
                        print("Unable to generate JSON string")
                    }
                } catch {
                    print("Error has occured during JSON generation: \(error)")
                }
            }
        }
        exit(0)
    }
    #endif
    
    private func start() {
        InnerLog.d("start")
        parseAppBuilderItem(body.appBuilderContent)
        _lifecycles.forEach { $0._didFinishLaunching.forEach { $0() } }
    }
    
    @AppBuilder open var body: AppBuilder.Content { _AppContent(appBuilderContent: .none) }
    
    var _activities: [Activity.Type] = []
    var _lifecycles: [AppLifecycle] = []
    var _manifest: AppManifest = Manifest
        .placeholders()
        .application {
            .name("stream.swift.droid.appkit.DroidApp")
            .allowBackup()
            .label("__TARGET_NAME__")
        }
    var _gradleDependencies: AppGradleDependencies = .init()
    
    private func parseAppBuilderItem(_ item: AppBuilder.Item) {
        switch item {
        case .items(let v): v.forEach { parseAppBuilderItem($0) }
        case .lifecycle(let v): _lifecycles.append(v)
        case .manifest(let m): _manifest.merge(with: m)
        case .gradleDependencies(let d): _gradleDependencies.merge(with: d)
        case .none: break
        }
    }
}

struct AndroidBuildingArguments {
    let mainTarget: String
    
    static func generate() -> Self {
        let args = CommandLine.arguments
        let mainTarget: String
        if let index = args.firstIndex(of: "--mainTarget"), args.count >= index + 1  {
            mainTarget = args[index + 1]
        } else {
            print("🚨 Unable to get --mainTarget argument")
            exit(-1)
        }
        return .init(mainTarget: mainTarget)
    }
}
// private var _androidBuildingArguments: AndroidBuildingArguments?
var androidBuildingArguments: AndroidBuildingArguments {
    // guard let v = _androidBuildingArguments else {
        return .generate()
    // }
    // return v
}

#if canImport(Android)
import Android

@_cdecl("Java_stream_swift_droid_appkit_DroidApp_onCreate")
/// Called when the app initalized and setup completed on the Java side
public func onCreate(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, app: jobject) {
    // TODO
}
@_cdecl("Java_stream_swift_droid_appkit_DroidApp_configurationChanged")
/// Called by the system when the device configuration changes
public func configurationChanged(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, newValues: jintArray) {
    InnerLog.d("update config 1")
    let env = JEnv(envPointer)
    let length = env.getArrayLength(newValues)
    var swiftArray = [Int32](repeating: 0, count: Int(length))
    env.getIntArrayRegion(newValues, start: 0, length: length, buffer: &swiftArray)
    if let shared = DroidApp.shared {
        InnerLog.d("update config 5.1")
        if shared.isStarted {
            InnerLog.d("update config 5.2")
        } else {
            InnerLog.d("update config 5.3")
        }
        shared.updateConfiguration(swiftArray)
        InnerLog.d("update config 5.4")
    } else {
        InnerLog.d("update config failed, shared app is nil")
    }
    InnerLog.d("update config 6")
}
@_cdecl("Java_stream_swift_droid_appkit_DroidApp_lowMemory")
/// This is called when the overall system is running low on memory,
/// and actively running processes should trim their memory usage.
public func lowMemory(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject) {
    
}
@_cdecl("Java_stream_swift_droid_appkit_DroidApp_trimMemory")
/// Called when the operating system has determined
/// that it is a good time for a process to trim unneeded memory from its process.
public func lowMemory(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, level: jint) {
    
}
#endif