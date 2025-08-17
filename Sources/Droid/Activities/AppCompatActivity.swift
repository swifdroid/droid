//
//  AppCompatActivity.swift
//  
//
//  Created by Mihael Isaev on 25.02.2023.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

extension AndroidPackage.SupportPackage.V7Package.AppPackage {
    public class AppCompatPackage: JClassName, @unchecked Sendable {}
    
    public var AppCompatActivity: AppCompatPackage { .init(parent: self, name: "AppCompatActivity") }
}

public final class ActivityContext: JObjectable, JClassLoadable, @unchecked Sendable {
    public let object: JObject

    public var cachedClassLoader: JClassLoader? = nil

    init (object: JObject) {
        self.object = object
    }

    #if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    public var R: InnerR { .init(self) }

    /// Helper method that returns the full path to an activity class.
    ///
    /// It uses `activity.packageName` if available.
    ///
    /// Otherwise, it falls back to the package name of the current context's class.
    func activityClass(_ activity: Activity.Type) -> String {
        let packageName =
            activity.packageName ??
            self.object.clazz.name.path.components(separatedBy: "/").dropLast().joined(separator: "/")
        return [packageName, activity.className].joined(separator: "/")
    }
}

#if os(Android)
extension AppCompatActivity: Sendable {}
#else
extension AppCompatActivity: @unchecked Sendable {}
#endif

#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class AppCompatActivity: Activity {
    open class var packageName: String? { nil }
    open class var className: JClassName { .init(stringLiteral: "androidx/appcompat/app/AppCompatActivity") }
    open class var gradleDependencies: [String] { [
        #"implementation("androidx.appcompat:appcompat:1.7.1")"#,
        #"implementation(platform("androidx.compose:compose-bom:2025.07.00"))"#
    ] }
    open class var javaImports: [String] { ["stream.swift.droid.appkit.activities.*"] }
    open class var parentClass: String { "DroidAppCompatActivity()" }

    open class nonisolated var allowEmbedded: Bool? { nil }
	open class nonisolated var allowTaskReparenting: Bool? { nil }
	open class nonisolated var alwaysRetainTaskState: Bool? { nil }
	open class nonisolated var autoRemoveFromRecents: Bool? { nil }
	open class nonisolated var banner: String? { nil }
	open class nonisolated var clearTaskOnLaunch: Bool? { nil }
	open class nonisolated var colorMode: String? { nil }
	open class nonisolated var configChanges: [ConfigChangeType] { [] }
	open class nonisolated var directBootAware: Bool? { nil }
	open class nonisolated var documentLaunchMode: DocumentLaunchMode? { nil }
	open class nonisolated var enabled: Bool? { nil }
	open class nonisolated var excludeFromRecents: Bool? { nil }
	open class nonisolated var exported: Bool? { nil }
	open class nonisolated var finishOnTaskLaunch: Bool? { nil }
	open class nonisolated var hardwareAccelerated: Bool? { nil }
	open class nonisolated var icon: String? { nil }
	open class nonisolated var roundIcon: String? { nil }
	open class nonisolated var immersive: Bool? { nil }
	open class nonisolated var label: String? { nil }
	open class nonisolated var launchMode: LaunchMode? { nil }
	open class nonisolated var lockTaskMode: LockTaskMode? { nil }
	open class nonisolated var maxRecents: Int? { nil }
	open class nonisolated var maxAspectRatio: Double? { nil }
	open class nonisolated var multiprocess: Bool? { nil }
	open class nonisolated var noHistory: Bool? { nil }
	open class nonisolated var parentActivityName: String? { nil }
	open class nonisolated var persistableMode: PersistableMode? { nil }
	open class nonisolated var permission: String? { nil }
	open class nonisolated var process: String? { nil }
	open class nonisolated var relinquishTaskIdentity: Bool? { nil }
	open class nonisolated var resizeableActivity: Bool? { nil }
	open class nonisolated var screenOrientation: ScreenOrientation? { nil }
	open class nonisolated var showForAllUsers: Bool? { nil }
	open class nonisolated var stateNotNeeded: Bool? { nil }
	open class nonisolated var supportsPictureInPicture: Bool? { nil }
	open class nonisolated var taskAffinity: String? { nil }
	open class nonisolated var theme: String? { nil }
	open class nonisolated var uiOptions: ApplicationUIOptions? { nil }
	open class nonisolated var windowSoftInputMode: [WindowSoftInputMode] { [] }
	open class nonisolated var intentFilter: DroidApp.IntentFilter? { nil }
	open class nonisolated var metaData: DroidApp.MetaData? { nil }
    
    var _context: ActivityContext!
    public var context: ActivityContext {
        if _context == nil {
            InnerLog.c("Attempt to reach nil context at \(Self.className). Seems you haven't started this activity yet.")
        }
        return _context
    }
    public var contentView: View?

    @discardableResult
    public required init() {
        #if !os(Android)
        _context = ActivityContext(object: .init(JObjectBox(), .init("")))
        onCreate(context)
        body { body }
        buildUI()
        #endif
    }

    public func attach(to context: JObject) {
        _context = ActivityContext(object: context)
        onCreate(self.context)
        body { body }
        buildUI()
    }

    open func onCreate(_ context: ActivityContext) {}

    public func setContentView(_ view: View) {
        view.willMoveToParent()
        guard let viewInstance = view.setStatusAsContentView(context) else {
            InnerLog.c("🟥 Unable to initialize ViewInstance for `setContentView`")
            return
        }
        #if os(Android)
        guard
            let env = JEnv.current(),
            let methodId = context.clazz.methodId(env: env, name: "setContentView", signature: .init(.object(.android.view.View), returning: .void))
        else { return }
        env.callVoidMethod(object: .init(context.ref, context.clazz), methodId: methodId, args: [viewInstance.object])
        #endif
        view.didMoveToParent()
    }

    @BodyBuilder open var body: BodyBuilder.Result { EmptyBodyBuilderItem() }

    @discardableResult
    open func body(@BodyBuilder block: BodyBuilder.SingleView) -> Self {
        InnerLog.d("activity body 1")
        if let contentView {
            InnerLog.d("activity body 2 (existing contentView)")
            contentView.body(block: block)
        } else {
            InnerLog.d("activity body 3")
            let item = block().bodyBuilderItem
            func setDefaultFrameLayout(_ item: BodyBuilderItem) {
                InnerLog.d("activity body setDefaultFrameLayout")
                let view = FrameLayout()
                view.addItem(item)
                setContentView(view)
                contentView = view
            }
            func proceedItem(_ item: BodyBuilderItem) {
                switch item {
                case .single(let view):
                    InnerLog.d("activity body 4 (single)")
                    setContentView(view)
                case .multiple(let views):
                    if views.count == 1, let view = views.first {
                        InnerLog.d("activity body 5 (multiple)")
                        setContentView(view)
                    } else {
                        InnerLog.d("activity body 6 (multiple)")
                        setDefaultFrameLayout(item)
                    }
                case .nested(let items):
                    if items.count == 1, let item = items.first {
                        InnerLog.d("activity body 7 (nested)")
                        proceedItem(item.bodyBuilderItem)
                    } else {
                        InnerLog.d("activity body 8 (nested)")
                        setDefaultFrameLayout(item)
                    }
                case .forEach:
                    InnerLog.d("activity body 9 (forEach)")
                    setDefaultFrameLayout(item)
                case .none:
                    InnerLog.d("activity body 10 (none)")
                    setDefaultFrameLayout(item)
                }
            }
            proceedItem(item)
        }
        return self
    }

    open func buildUI() {}

    public func getTheme() -> Resources.Theme? {
        #if os(Android)
        InnerLog.t("Activity.getTheme 1")
        guard let env = JEnv.current() else {
            InnerLog.t("Activity.getTheme 1.1 exit")
            return nil
        }
        guard let methodId = context.clazz.methodId(env: env, name: "getTheme", signature: .returning(.object(Resources.Theme.className))) else {
            InnerLog.t("Activity.getTheme 1.2 exit")
            return nil
        }
        let classLoader = context.getClassLoader()
        guard let lpClazz = JNICache.shared.getClass(Resources.Theme.className, classLoader) else {
            InnerLog.t("Activity.getTheme 1.3 exit")
            return nil
        }
        guard let globalObject = env.callObjectMethod(object: context.object, methodId: methodId, clazz: lpClazz) else {
            InnerLog.t("Activity.getTheme 1.4 exit")
            return nil
        }
        InnerLog.t("Activity.getTheme 2")
        return Resources.Theme(globalObject, context)
        #else
        return nil
        #endif
    }

    /// Starts activity the classic way
    public func startActivity(_ activity: Activity.Type) {
        #if os(Android)
        guard let _ = DroidApp.shared._activities.first(where: { $0 == activity }) else {
            InnerLog.c("Unable to start \(activity.className) because it is not registered in the App->Manifest->activities.")
            return
        }
        guard
            let env = JEnv.current(),
            let intent = Intent(env, context, .init(stringLiteral: context.activityClass(activity)))
        else {
            InnerLog.c("Unable to create `Intent` for \(activity).")
            return
        }
        guard
            let methodId = context.clazz.methodId(env: env, name: "startActivity", signature: .init(.object(.android.content.Intent), returning: .void))
        else {
            InnerLog.c("Current context object doesn't have `startActivity` method.")
            return
        }
        env.callVoidMethod(object: context.object, methodId: methodId, args: [intent.object])
        #endif
    }

    /// Starts pre-initialized activity
    public func startActivity<T: Activity>(_ activity: T) {
        DroidApp.shared._activityPendingToStart = activity
        startActivity(T.self)
    }
}

public final class Intent: JObjectable, @unchecked Sendable {
    /// JNI Object
    public let object: JObject
    
    public init (_ object: JObject) {
        self.object = object
    }

    public init? (_ env: JEnv, _ context: ActivityContext, _ className: JClassName) {
        #if os(Android)
        guard
            let classLoader = context.getClassLoader(),
            let intentClazz = classLoader.loadClass(.android.content.Intent),
            let activityClazz = classLoader.loadClass(className),
            let methodId = intentClazz.methodId(env: env, name: "<init>", signature: .init(.object(.android.content.Context), .object(.java.lang.Class), returning: .void)),
            let global = env.newObject(clazz: intentClazz, constructor: methodId, args: [context.object, activityClazz])
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }
}

// public final class AppCompatActivity: DroidApp.AnyActivity {
//     /// The globally retained JNI reference to the Java object.
//     public let ref: JObjectBox

//     /// The loaded `JClass`
//     public let clazz: JClass

//     /// Object wrapper
//     public let object: JObject

//     public required init(ref: JObjectBox, clazz: JClass, object: JObject) {
//         self.ref = ref
//         self.clazz = clazz
//         self.object = object
//     }

//     public class var className: JClassName { .init(stringLiteral: "androidx/appcompat/app/AppCompatActivity") }
//     public class var javaImports: [String] { ["android.support.v7.app.AppCompatActivity"] }
//     public class var parentClass: String { "AppCompatActivity()" }
// }
