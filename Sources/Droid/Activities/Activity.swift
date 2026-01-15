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

@MainActor
open class Activity: Contextable, AnyActivity, Sendable {
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
	open class nonisolated var exported: Bool? {
        if intentFilters.contains(.mainLauncher) { return true }
        return nil
    }
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
    
    public private(set) var context: ActivityContext?
    public var contentView: View?

	@discardableResult
    public required init() {
        #if !os(Android)
        context = ActivityContext(object: .init(JObjectBox(), .init("")))
        onCreate(context!, savedInstanceState: nil)
        body { body }
        buildUI()
        #endif
    }

    public init (_ object: JObject) {
        context = ActivityContext(object: object)
    }

    public func attachOnCreate(to contextObject: JObject, savedInstanceState: Bundle?) {
        InnerLog.t("Activity.attachOnCreate(to:savedInstanceState:)")
        context = ActivityContext(object: contextObject)
        onCreate(context!, savedInstanceState: savedInstanceState)
    }

    public func attachOnRestart(to contextObject: JObject, savedInstanceState: Bundle?) {
        InnerLog.t("Activity.attachOnRestart(to:savedInstanceState:)")
        context = ActivityContext(object: contextObject)
        onRestart()
    }

    private var _hasCalledOnCreate = false

    /// Called when the activity is starting. This is where most initialization
    /// should go. Note that this method is calling `body()` and `buildUI()`.
    open func onCreate(_ context: ActivityContext, savedInstanceState: Bundle?) {
        InnerLog.t("🟢 onCreate called")
        if _hasCalledOnCreate {
            InnerLog.t("🟢 onCreate: already called before")
            if savedInstanceState != nil {
                contentView?.removeFromParent()
                contentView = nil
                InnerLog.t("🟢 onCreate: executing body()")
                body { body }
                InnerLog.t("🟢 onCreate: executing buildUI()")
                buildUI()
            }
        } else {
            InnerLog.t("🟢 onCreate: first time call")
            _hasCalledOnCreate = true
            InnerLog.t("🟢 onCreate: executing body()")
            body { body }
            InnerLog.t("🟢 onCreate: executing buildUI()")
            buildUI()
        }
    }

    /// Sets the activity content to an explicit view.
    ///
    /// If you want to further configure the view after setting it as content view,
    /// you can use the `proceed` closure.
    public func contentView(_ view: View, _ proceed: ((View) -> Void)? = nil) {
        contentView = view
        proceed?(contentView!)
        view.willMoveToParent()
        guard let context else {
            InnerLog.c("🟥 Unable to set content view: activity context is nil")
            return
        }
        guard let viewInstance = view.setStatusAsContentView({ [weak self] in
            InnerLog.t("🟡 Activity.contentView(id: \(view.id)): getting context for view (\(self?.context != nil))")
            return self?.context
        }) else {
            InnerLog.c("🟥 Unable to initialize ViewInstance for `setContentView`")
            return
        }
        #if os(Android)
        context.callVoidMethod(name: "setContentView", args: viewInstance.object.signed(as: .android.view.View))
        #endif
        view.didMoveToParent()
    }

    /// it is called under the hood from **`super.onCreate()`** before `buildUI()`.
    @BodyBuilder open var body: BodyBuilder.Result { EmptyBodyBuilderItem() }

    /// Declarative way to add views to the activity.
    ///
    /// If you declare one view at the root level, it will be used as the content view directly.
    /// 
    /// If you declare multiple views at the root level, a **`FrameLayout`**
    /// will be created as the content view and the views will be added to it.
    @discardableResult
    open func body(@BodyBuilder block: BodyBuilder.SingleView) -> Self {
        InnerLog.t("activity body 1")
        if let contentView {
            InnerLog.t("activity body 2 (existing contentView)")
            contentView.body(block: block)
        } else {
            InnerLog.t("activity body 3")
            let item = block().bodyBuilderItem
            func setDefaultFrameLayout(_ item: BodyBuilderItem) {
                InnerLog.t("activity body setDefaultFrameLayout")
                contentView(FrameLayout()) { $0.addItem(item) }
            }
            func proceedItem(_ item: BodyBuilderItem) {
                switch item {
                case .single(let view):
                    InnerLog.t("activity body 4 (single)")
                    contentView(view)
                case .multiple(let views):
                    if views.count == 1, let view = views.first {
                        InnerLog.t("activity body 5 (multiple)")
                        contentView(view)
                    } else {
                        InnerLog.t("activity body 6 (multiple)")
                        setDefaultFrameLayout(item)
                    }
                case .nested(let items):
                    if items.count == 1, let item = items.first {
                        InnerLog.t("activity body 7 (nested)")
                        proceedItem(item.bodyBuilderItem)
                    } else {
                        InnerLog.t("activity body 8 (nested)")
                        setDefaultFrameLayout(item)
                    }
                case .forEach:
                    InnerLog.t("activity body 9 (forEach)")
                    setDefaultFrameLayout(item)
                case .none:
                    InnerLog.t("activity body 10 (none)")
                    setDefaultFrameLayout(item)
                }
            }
            proceedItem(item)
        }
        return self
    }

    /// it is called under the hood from **`super.onCreate()`** after `body()`.
    open func buildUI() {}

    // MARK: Lifecycle

    private var requestApplyInsetsAfterRestart = false

    /// Called to retrieve per-instance state from an activity before being killed
    /// so that the state can be restored in `onCreate()` or `onRestoreInstanceState()`
    open func onSaveInstanceState(bundle: Bundle) {
        context = nil
    }
    /// The system calls this method as the first indication that the user is leaving your activity,
    /// though it does not always mean the activity is being destroyed.
    /// It indicates that the activity is no longer in the foreground,
    /// but it is still visible if the user is in multi-window mode.
    /// There are several reasons why an activity might enter this state:
    /// 
    /// - An event that interrupts app execution, as described in the section
    /// about the `onResume()` callback, pauses the current activity. This is the most common case.
    /// - In multi-window mode, only one app has focus at any time, and the system pauses all the other apps.
    /// - The opening of a new, semi-transparent activity, such as a dialog,
    /// pauses the activity it covers. As long as the activity is partially visible but not in focus, it remains paused.
    /// 
    /// When an activity moves to the `Paused` state, any lifecycle-aware component
    /// tied to the activity's lifecycle receives the `ON_PAUSE` event.
    /// This is where the lifecycle components can stop any functionality
    /// that does not need to run while the component is not in the foreground,
    /// such as stopping a camera preview.
    /// 
    /// Use the `onPause()` method to pause or adjust operations that can't continue,
    /// or might continue in moderation, while the Activity is in the `Paused` state, and that you expect to resume shortly.
    /// 
    /// You can also use the `onPause()` method to release system resources,
    /// handles to sensors (like GPS), or any resources that affect battery life
    /// while your activity is `Paused` and the user does not need them.
    /// 
    /// However, as mentioned in the section about `onResume()`, a `Paused`
    /// activity might still be fully visible if the app is in multi-window mode.
    /// Consider using `onStop()` instead of `onPause()` to fully release
    /// or adjust UI-related resources and operations to better support multi-window mode.
    open func onPause() {}
    /// Called after `onSaveInstanceState()` when the activity is being re-initialized
    /// after previously being shut down.
	open func onStateNotSaved() {}
    /// When the activity enters the `Resumed` state, it comes to the foreground,
    /// and the system invokes the `onResume()` callback.
    /// This is the state in which the app interacts with the user.
    /// The app stays in this state until something happens to take focus away from the app,
    /// such as the device receiving a phone call, the user navigating to another activity,
    /// or the device screen turning off.
    /// 
    /// When the activity moves to the Resumed state, any lifecycle-aware component
    /// tied to the activity's lifecycle receives the `ON_RESUME` event.
    /// This is where the lifecycle components can enable any functionality that needs
    /// to run while the component is visible and in the foreground, such as starting a camera preview.
    /// 
    /// When an interruptive event occurs, the activity enters the Paused state
    /// and the system invokes the `onPause()` callback.
    /// 
    /// If the activity returns to the Resumed state from the Paused state,
    /// the system once again calls the `onResume()` method.
    /// For this reason, implement `onResume()` to initialize components that you release
    /// during `onPause()` and to perform any other initializations that must occur
    /// each time the activity enters the `Resumed` state.
	open func onResume() {}
    /// Called after `onRestart()` and before `onResume()`.
    /// 
    /// In this method, `requestApplyInsets` is called on `contentView` or `decorView` (if available) after `onRestart()`.
    open func onPostResume() {
        InnerLog.t("🟢 onPostResume called, requestApplyInsetsAfterRestart: \(requestApplyInsetsAfterRestart)")
        if requestApplyInsetsAfterRestart {
            requestApplyInsetsAfterRestart = false
            if let contentView {
                InnerLog.t("🟢 Activity.onPostResume: requested apply insets for contentView id: \(contentView.id)")
                contentView.requestApplyInsets()
            }
            if let window = window() {
                if let decorView = window.decorView() {
                    InnerLog.t("🟢 Activity.onPostResume: requested apply insets for decorView")
                    decorView.requestApplyInsets()
                } else {
                    InnerLog.c("🟥 Activity.onPostResume: Failed to get DecorView")
                }
            } else {
                InnerLog.c("🟥 Activity.onPostResume: Failed to get Window: activity context is nil")
            }
        }
    }
    /// Called after onStop() when the current activity is being re-displayed to the user
    /// (the user has navigated back to it). It will be followed by onStart().
    /// Note that this method is calling `body()` and `buildUI()`.
	open func onRestart() {
        InnerLog.t("🟢 onRestart called, will request apply insets after restart")
        requestApplyInsetsAfterRestart = true
    }
    /// When the activity enters the `Started` state, the system invokes `onStart()`.
    /// 
    /// This call makes the activity visible to the user as the app prepares for
    /// the activity to enter the foreground and become interactive.
    /// 
    /// For example, this method is where the code that maintains the UI is initialized.
    ///
    /// The `onStart()` method completes quickly and, as with the `Created` state,
    /// the activity does not remain in the `Started` state.
    /// Once this callback finishes, the activity enters the `Resumed` state
    /// and the system invokes the `onResume()` method.
	open func onStart() {}
    /// When your activity is no longer visible to the user, it enters the `Stopped` state,
    /// and the system invokes the `onStop()` callback. This can occur
    /// when a newly launched activity covers the entire screen.
    /// The system also calls `onStop()` when the activity finishes
    /// running and is about to be terminated.
    /// 
    /// When the activity moves to the `Stopped` state, any lifecycle-aware component
    /// tied to the activity's lifecycle receives the `ON_STOP` event.
    /// This is where the lifecycle components can stop any functionality
    /// that does not need to run while the component is not visible on the screen.
    /// 
    /// In the `onStop()` method, release or adjust resources that are not needed
    /// while the app is not visible to the user. For example, your app might pause
    /// animations or switch from fine-grained to coarse-grained location updates.
    /// Using `onStop()` instead of `onPause()` means that UI-related work continues,
    /// even when the user is viewing your activity in multi-window mode.
    /// 
    /// Also, use `onStop()` to perform relatively CPU-intensive shutdown operations.
    /// For example, if you can't find a better time to save information to a database,
    /// you might do so during `onStop()`.
	open func onStop() {}
    /// `onDestroy()` is called before the activity is destroyed.
    /// The system invokes this callback for one of two reasons:
    /// 
    /// - The activity is finishing, due to the user completely dismissing
    /// the activity or due to `finish()` being called on the activity.
    /// - The system is temporarily destroying the activity due to a configuration change,
    /// such as device rotation or entering multi-window mode.
    /// 
    /// When the activity moves to the destroyed state, any lifecycle-aware component
    /// tied to the activity's lifecycle receives the `ON_DESTROY` event.
    /// This is where the lifecycle components can clean up anything they need to before the Activity is destroyed.
    /// 
    /// Instead of putting logic in your Activity to determine why it is being destroyed,
    /// use a `ViewModel` object to contain the relevant view data for your Activity.
    /// If the Activity is recreated due to a configuration change,
    /// the `ViewModel` does not have to do anything, since it is preserved
    /// and given to the next Activity instance.
    /// 
    /// If the Activity isn't recreated, then the `ViewModel` has the `onCleared()` method called,
    /// where it can clean up any data it needs to before being destroyed.
    /// You can distinguish between these two scenarios with the `isFinishing()` method.
    /// 
    /// If the activity is finishing, `onDestroy()` is the final lifecycle callback the activity receives.
    /// If `onDestroy()` is called as the result of a configuration change,
    /// the system immediately creates a new activity instance and
    /// then calls `onCreate()` on that new instance in the new configuration.
    /// 
    /// The `onDestroy()` callback releases all resources not released by earlier callbacks, such as `onStop()`.
    ///
    /// In this method `contentView` and `context` are set to `nil` to release references.
	open func onDestroy() {
        contentView?.removeFromParent()
        contentView = nil
        context = nil
    }
    /// Called when the activity has been attached to the window.
	open func onAttachedToWindow() {}
	/// Called when the user presses the back button.
    open func onBackPressed() {}
	/// Called when an activity you launched exits, giving you the `requestCode`
    /// you started it with, the `resultCode` it returned, and any additional data from it
    /// as an `Intent`.
    open func onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?, componentCaller: ComponentCaller?) {}
    /// Called when the activity is entering multi-window mode.
    open func onMultiWindowModeChanged(isInMultiWindowMode: Bool) {}
    /// Callback for the result from requesting permissions.
    /// The `results` parameter is an array of `ActivityPermissionResult`
    /// corresponding to the requested permissions.
    open func onRequestPermissionsResult(requestCode: Int, results: [ActivityPermissionResult], deviceId: Int) {}
    /// Initialize the contents of the Activity's standard options menu.
    /// You should place your menu items in to menu.
    /// 
    /// This is only called once, the first time the options menu is displayed.
    /// To update the menu every time it is displayed, see `onPrepareOptionsMenu`.
    /// 
    /// The default implementation populates the menu with standard system menu items.
    /// These are placed in the `Menu.CATEGORY_SYSTEM` group so that they
    /// will be correctly ordered with application-defined menu items.
    /// Deriving classes should always call through to the base implementation.
    /// 
    /// You can safely hold on to menu (and any items created from it),
    /// making modifications to it as desired, until the next time `onCreateOptionsMenu()` is called.
    /// 
    /// When you add items to the menu, you can implement the Activity's `onOptionsItemSelected` method to handle them there.
    ///
    /// - Returns: You must return true for the menu to be displayed; if you return false it will not be shown.
    open func onCreateOptionsMenu(menu: Menu) -> Bool { true }
    /// Prepare the Screen's standard options menu to be displayed.
    /// 
    /// This is called right before the menu is shown, every time it is shown.
    /// 
    /// You can use this method to efficiently enable/disable items or otherwise dynamically modify the contents.
    /// 
    /// The default implementation updates the system menu items based on the activity's state.
    /// 
    /// Deriving classes should always call through to the base class implementation.
    ///
    /// - Returns: You must return true for the menu to be displayed; if you return false it will not be shown.
    open func onPrepareOptionsMenu(menu: Menu) -> Bool { true }
    /// This hook is called whenever an item in your options menu is selected.
    /// 
    /// The default implementation simply returns false to have the normal processing happen
    /// (calling the item's Runnable or sending a message to its Handler as appropriate).
    /// 
    /// You can use this method for any items for which you would like to do processing without those other facilities.
    /// 
    /// Derived classes should call through to the base class for it to perform the default menu handling.
    ///
    /// - Returns: Return false to allow normal menu processing to proceed, true to consume it here. Returns false by default.
    open func onOptionsItemSelected(item: MenuItem) -> Bool { false }

    /// This hook is called whenever the options menu is being closed
    /// (either by the user canceling the menu with the back/menu button, or when an item is selected).
    open func onOptionsMenuClosed(menu: Menu) {}

    /// Called when a context menu for the view is about to be shown.
    /// Unlike `onCreateOptionsMenu(Menu)`, this will be called every time
    /// the context menu is about to be shown and should be populated for the view
    /// (or item inside the view for AdapterView subclasses, this can be found in the `menuInfo`)).
    /// 
    /// Use `onContextItemSelected(MenuItem)` to know when an item has been selected.
    /// 
    /// It is not safe to hold onto the context menu after this method returns.
    open func onCreateContextMenu(
        menu: ContextMenu,
        v: View?,
        menuInfo: ContextMenu.ContextMenuInfo?
    ) {}

    /// This hook is called whenever an item in a context menu is selected.
    /// 
    /// The default implementation simply returns false to have the normal processing happen
    /// (calling the item's Runnable or sending a message to its Handler as appropriate).
    /// 
    /// You can use this method for any items for which you would like to do processing without those other facilities.
    /// 
    /// Use `MenuItem.getMenuInfo()` to get extra information set by the View that added this menu item.
    /// 
    /// Derived classes should call through to the base class for it to perform the default menu handling.
    ///
    /// - Returns: Return false to allow normal context menu processing to proceed, true to consume it here. Returns false by default.
    open func onContextItemSelected(item: MenuItem) -> Bool { false }

    /// This hook is called whenever the context menu is being closed
    /// (either by the user canceling the menu with the back/menu button, or when an item is selected).
    open func onContextMenuClosed(menu: Menu) {}

    // MARK: Methods

    /// Retrieves the current theme associated with the activity.
    public func theme() -> Resources.Theme? {
        #if os(Android)
        guard let context else {
            InnerLog.t("Activity.getTheme 0 exit: context is nil")
            return nil
        }
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

    /// Retrieves the value of the `android.R.attr.actionBarSize` attribute from the current theme.
    public func actionBarSize() -> Int {
        theme()?.actionBarSize() ?? 0
    }

    /// Retrieves a SharedPreferences object from the context
    public func sharedPreferences(_ name: String, _ mode: Int32 = 0) -> SharedPreferences? {
        guard let context else {
            InnerLog.c("🟥 Activity: Failed to get SharedPreferences: activity context is nil")
            return nil
        }
        return context.sharedPreferences(name, mode)
    }
}

extension Activity {
    public func findViewById(_ id: Int32) -> View? {
        guard let context else {
            Log.c("🟥 Activity: Failed to findViewById: activity context is nil")
            return nil
        }
        guard
            let returningClazz = JClass.load(.android.view.View),
            let global = context.object.callObjectMethod(name: "findViewById", args: id, returningClass: returningClazz)
        else { return nil }
        return .init(id: id, global, { [weak self] in
            InnerLog.t("🟡 Activity.findViewById(id: \(id)): getting context for view (\(self?.context != nil))")
            return self?.context
        })
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

/// Interface to global information about an application environment.
/// 
/// This is an abstract class whose implementation is provided by the Android system.
/// It allows access to application-specific resources and classes,
/// as well as up-calls for application-level operations such as launching activities,
/// broadcasting and receiving intents, etc.
public final class ActivityContext: Contextable, JObjectable, JClassLoadable, @unchecked Sendable {
    public let object: JObject

    public var context: ActivityContext? { self }

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

    /// Retrieves a SharedPreferences object
    public func sharedPreferences(_ name: String, _ mode: Int32 = 0) -> SharedPreferences? {
        guard let clazz = JClass.load(SharedPreferences.className) else {
            return nil
        }
        guard let global = callObjectMethod(name: "getSharedPreferences", args: name, mode, returningClass: clazz) else {
            return nil
        }
        return SharedPreferences(global)
    }
}

extension Activity {
    /// Retrieve the current Window for the activity.
    /// This can be used to directly access parts of the Window API
    /// that are not available through Activity/Screen.
    public func window() -> Window? {
        guard let context else {
            InnerLog.c("🟥 Activity: Failed to get Window: activity context is nil")
            return nil
        }
        guard
            let clazz = JClass.load(Window.className),
            let global = context.callObjectMethod(name: "getWindow", returningClass: clazz)
        else { return nil }
        return Window(global)
    }
}