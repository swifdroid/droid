//
//  Activity.swift
//  
//
//  Created by Mihael Isaev on 25.06.2025.
//

extension AndroidPackage.AppPackage {
    public class ActivityPackage: JClassName, @unchecked Sendable {}
    
    public var Activity: ActivityPackage { .init(parent: self, name: "Activity") }
}

#if os(Android)
extension Activity: Sendable {}
#else
extension Activity: @unchecked Sendable {}
#endif

@MainActor
open class Activity: AnyActivity {
    /// The body of the view hierarchy.
    public typealias Body = BodyBuilderItemable
    public typealias Style = RStyle
    public typealias IntentFilter = DroidApp.IntentFilter
    public typealias MetaData = DroidApp.MetaData

	open class var packageName: String? { nil }
    open class var className: JClassName { .android.app.Activity }
    open class var gradleDependencies: [AppGradleDependency] { [] }
    open class var javaImports: [String] { ["stream.swift.droid.appkit.activities.*"] }
    open class var parentClass: String { "DroidActivity()" }

    open class nonisolated var allowEmbedded: Bool? { nil }
	open class nonisolated var allowTaskReparenting: Bool? { nil }
	open class nonisolated var alwaysRetainTaskState: Bool? { nil }
	open class nonisolated var autoRemoveFromRecents: Bool? { nil }
	open class nonisolated var banner: String? { nil }
	open class nonisolated var clearTaskOnLaunch: Bool? { nil }
	open class nonisolated var colorMode: ActivityColorMode? { nil }
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
	open class nonisolated var parentActivityName: AnyActivity.Type? { nil }
	open class nonisolated var persistableMode: PersistableMode? { nil }
	open class nonisolated var permission: ManifestPermission? { nil }
	open class nonisolated var process: String? { nil }
	open class nonisolated var relinquishTaskIdentity: Bool? { nil }
	open class nonisolated var resizeableActivity: Bool? { nil }
	open class nonisolated var screenOrientation: ScreenOrientation? { nil }
	open class nonisolated var showForAllUsers: Bool? { nil }
	open class nonisolated var stateNotNeeded: Bool? { nil }
	open class nonisolated var supportsPictureInPicture: Bool? { nil }
	open class nonisolated var taskAffinity: String? { nil }
	open class nonisolated var theme: Style? { nil }
	open class nonisolated var uiOptions: ApplicationUIOptions? { nil }
	open class nonisolated var windowSoftInputMode: [WindowSoftInputMode] { [] }
	open class nonisolated var intentFilters: [IntentFilter] { [] }
	open class nonisolated var metaData: [MetaData] { [] }
    
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

    public init (_ object: JObject) {
        _context = .init(object: object)
    }

    public func attach(to context: JObject) {
        _context = ActivityContext(object: context)
        onCreate(self.context)
        body { body }
        buildUI()
    }

    open func onCreate(_ context: ActivityContext) {}

    public func contentView(_ view: View, _ proceed: ((View) -> Void)? = nil) {
        contentView = view
        proceed?(contentView!)
        view.willMoveToParent()
        guard let viewInstance = view.setStatusAsContentView(context) else {
            InnerLog.c("🟥 Unable to initialize ViewInstance for `setContentView`")
            return
        }
        #if os(Android)
        context.callVoidMethod(name: "setContentView", args: viewInstance.object.signed(as: .android.view.View))
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
                contentView(FrameLayout()) { $0.addItem(item) }
            }
            func proceedItem(_ item: BodyBuilderItem) {
                switch item {
                case .single(let view):
                    InnerLog.d("activity body 4 (single)")
                    contentView(view)
                case .multiple(let views):
                    if views.count == 1, let view = views.first {
                        InnerLog.d("activity body 5 (multiple)")
                        contentView(view)
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

    // MARK: Lifecycle

    open func onPause() {}
	open func onStateNotSaved() {}
	open func onResume() {}
	open func onRestart() {}
	open func onStart() {}
	open func onStop() {}
	open func onDestroy() {
        contentView?.removeFromParent()
    }
	open func onAttachedToWindow() {}
	open func onBackPressed() {}
	open func onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?, componentCaller: ComponentCaller?) {}
    open func onMultiWindowModeChanged(isInMultiWindowMode: Bool) {}
    open func onRequestPermissionsResult(requestCode: Int, results: [ActivityPermissionResult], deviceId: Int) {}

    // MARK: Methods

    public func theme() -> Resources.Theme? {
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
        guard let lpClazz = JNICache.shared.getClass(Resources.Theme.className) else {
            InnerLog.t("Activity.getTheme 1.3 exit")
            return nil
        }
        guard let globalObject = env.callObjectMethod(object: context.object, methodId: methodId, returningClass: lpClazz) else {
            InnerLog.t("Activity.getTheme 1.4 exit")
            return nil
        }
        InnerLog.t("Activity.getTheme 2")
        return Resources.Theme(globalObject)
        #else
        return nil
        #endif
    }
}

extension Activity {
    public func findViewById(_ id: Int32) -> View? {
        guard
            let returningClazz = JClass.load(.android.view.View),
            let global = context.object.callObjectMethod(name: "findViewById", args: id, returningClass: returningClazz)
        else { return nil }
        return .init(id: id, global, context)
    }
}

public final class ComponentCaller: JObjectable, @unchecked Sendable {
    static let className: JClassName = "android/app/ComponentCaller"

    /// JNI Object
    public let object: JObject
    
    public init (_ object: JObject) {
        self.object = object
    }
}

public final class ActivityContext: Contextable, JObjectable, JClassLoadable, @unchecked Sendable {
    public let object: JObject

    public var context: ActivityContext { self }

    public var cachedClassLoader: JClassLoader? = nil

    init (object: JObject) {
        self.object = object
    }
    
    @MainActor
    public var R: InnerR { .init() }

    /// Helper method that returns the full path to an activity class.
    ///
    /// It uses `activity.packageName` if available.
    ///
    /// Otherwise, it falls back to the package name of the current context's class.
    func activityClass(_ activity: AnyActivity.Type) -> String {
        let packageName =
            activity.packageName ??
            self.object.clazz.name.path.components(separatedBy: "/").dropLast().joined(separator: "/")
        return [packageName, activity.className].joined(separator: "/")
    }
}