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
    private var lastViewId: Int32 = 0
    
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

    /// Returns app-wise unique identifier for the view.
    public func getNextViewId() -> Int32 {
        lastViewIdMutex.lock()
        defer { lastViewIdMutex.unlock() }
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
        case moduleGradle
        case projectGradle
        case settingsGradle
        case activities
        case generateActivity
        case gradleDependencies
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
        case .moduleGradle:
            print(_moduleGradle.render())
        case .projectGradle:
            print(_projectGradle.render())
        case .settingsGradle:
            print(_settingsGradle.render())
        case .gradleDependencies:
            var dependencies: Set<String> = _gradleDependencies.dependencies
            if let app = _manifest.items.compactMap({ $0 as? Application }).first {
                let activityTags = app.items.compactMap { $0 as? ActivityTag }
                for activity in activityTags.map { $0.class } {
                    for dep in activity.gradleDependencies {
                        dependencies.insert(dep)
                    }
                }
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
        case .activities:
            if let app = _manifest.items.compactMap({ $0 as? Application }).first {
                print(app.items.compactMap { $0 as? ActivityTag }.map { $0.class.className.name }.joined(separator: ","))
            }
        case .generateActivity:
            if let activityName = args.first, let activity = generateActivity(activityName) {
                print(activity)
            }
        }
        exit(0)
    }
    #endif
    
    private func start() {
        InnerLog.d("start")
        parseAppBuilderItem(body.appBuilderContent)
        _lifecycles.forEach { $0._didFinishLaunching.forEach { $0() } }
//        lifecycleHandler.add(.enterForeground) { self._lifecycles.forEach { $0._willEnterForeground.forEach { $0() } } }
//        lifecycleHandler.add(.enterBackground) { self._lifecycles.forEach { $0._didEnterBackground.forEach { $0() } } }
    }
    
    @AppBuilder open var body: AppBuilder.Content { _AppContent(appBuilderContent: .none) }
    
    var _activities: [Activity.Type] = []
    var _lifecycles: [AppLifecycle] = []
    var _manifest: AppManifest = Manifest
        .placeholders()
        .application {
            .allowBackup()
            .allowNativeHeapPointerTagging(false) // very important
        }
    var _gradleDependencies: AppGradleDependencies = .init()
    var _moduleGradle: AppGradle.ModuleAppGradle = ModuleGradle
        .applyPlugin("com.android.application")
        .applyPlugin("kotlin-android")
        .variable("kotlin_version", "__KOTLIN_VERSION__")
        .android {
            .defaultConfig {
                .testInstrumentationRunner("android.support.test.runner.AndroidJUnitRunner")
            }
            .signingConfigPlaceholder()
            .buildType(.release(minifyEnabled: false, signingConfig: "mySigning"))
            .buildType(.debug(minifyEnabled: false))
            .compileOptions {
                .sourceCompatibility("JavaVersion.VERSION_1_8")
                .targetCompatibility("JavaVersion.VERSION_1_8")
            }
            .kotlinOptions {
                .jvmTarget("1.8")
            }
            .buildFeatures {
                .viewBinding(true)
            }
            .split(.abi(reset: true, include: ["__ABI_ARCHS__"], universalApk: false))
        }
        .dependency(.implementation("org.jetbrains.kotlin", "kotlin-stdlib-jdk7", "$kotlin_version"))
        .dependency(.implementation("org.jetbrains.kotlinx", "kotlinx-coroutines-android", "1.6.4"))
        .dependency(.implementation("androidx.core", "core-ktx", "1.8.0"))
        .dependency(.implementation("androidx.appcompat", "appcompat", "1.6.1"))
        .dependency(.implementation("com.google.android.material", "material", "1.9.0"))
        .dependency(.implementation("androidx.constraintlayout", "constraintlayout", "2.1.4"))
        .dependency(.implementation("androidx.lifecycle", "lifecycle-livedata-ktx", "2.6.1"))
        .dependency(.implementation("androidx.lifecycle", "lifecycle-viewmodel-ktx", "2.6.1"))
        .dependency(.implementation("com.android.support.constraint", "constraint-layout", "2.0.4"))
        .dependency(.androidTestImplementation("com.android.support.test", "runner", "1.0.2"))
        .dependency(.androidTestImplementation("com.android.support.test.espresso", "espresso-core", "3.0.2"))
        .dependency(.testImplementation("junit", "junit", "4.13.2"))
    var _projectGradle: AppGradle.ProjectAppGradle = ProjectGradle
        .import("java.nio.file.Paths")
        .plugins {
            .plugin(id: "com.android.application", version: "8.0.1", apply: false)
            .plugin(id: "com.android.library", version: "8.0.1", apply: false)
            .plugin(id: "org.jetbrains.kotlin.android", version: "1.8.20", apply: false)
        }
        .custom("""
        task clean(type: Delete) {
            delete rootProject.buildDir
            delete new File(Paths.get(rootDir.toString(), "app/src/main/jniLibs").toString())
        }
        """)
    var _settingsGradle: SettingsGradle = SettingsGradle
        .pluginManagement {
            .repository(.google)
            .repository(.mavenCentral)
            .repository(.gradlePluginPortal)
        }
        .dependencyResolutionManagement {
            .repositoriesMode(.FAIL_ON_PROJECT_REPOS)
            .repository(.google)
            .repository(.mavenCentral)
        }
        .includes(":app")
        .custom("rootProject.name = \"__ROOT_PROJECT_NAME__\"")

    private func parseAppBuilderItem(_ item: AppBuilder.Item) {
        switch item {
        case .items(let v): v.forEach { parseAppBuilderItem($0) }
        case .lifecycle(let v): _lifecycles.append(v)
        case .manifest(let m): _manifest.merge(with: m)
        case .gradleDependencies(let d): _gradleDependencies.merge(with: d)
        case .moduleGradle(let g): _moduleGradle.merge(with: g)
        case .projectGradle(let g): _projectGradle.merge(with: g)
        case .none: break
        }
    }
}

// MARK: - Core-context Functions

extension DroidApp {
    
    
//    public func showToast(_ text: String, _ length: ToastLength = .short) {
//        coreContext.showToast(text, length.rawValue)
//    }
//
//    func launched(_ activity: Activity) {
//        _lifecycles.forEach { $0._didFinishLaunching.forEach { $0() } }
//        coreContext.launched(activity)
//    }
}

class LifecycleHandler {
//    private let context: JSObject
//
//    var closures: [String: JSClosure] = [:]
//
//    init (_ global: JSObject) {
//        let dict: [String: String] = [:]
//        context = dict.jsValue().object!
//        global.lifecycle = context.jsValue()
//    }
//
//    deinit {
//        closures.forEach { $0.value.release() }
//    }
//
//    enum Event: String {
//        case enterForeground, enterBackground
//    }
//
//    func add(_ event: Event, _ action: @escaping () -> Void) {
//        closures[event.rawValue] = JSClosure { args in
//            return JSPromise(resolver: { handler in
//                action()
//                handler(.success(.undefined))
//            }).jsValue()
//        }
//        context[event.rawValue] = closures[event.rawValue]?.jsValue() ?? .null
//    }
}

public enum ToastLength: Int {
    case short = 0, long
}

class CoreContext {
//    private let context: JSObject
//
//    init (_ global: JSObject) {
//        context = global.core.object!
//    }
//
//    func launched(_ activity: Activity) {
//        guard let json = activity.model.json() else { return }
//        context.launched.function?.callAsFunction(this: context, json)
//    }
//
//    func showToast(_ text: String, _ length: Int = 0) {
//        if length == 0 {
//            context.showToastShort.function?.callAsFunction(this: context, text)
//        } else {
//            context.showToastLong.function?.callAsFunction(this: context, text)
//        }
//    }
}

#if ANDROIDBUILDING

#endif
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