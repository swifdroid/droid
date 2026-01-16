//
//  AppCompatActivity.swift
//  
//
//  Created by Mihael Isaev on 25.02.2023.
//

@MainActor
open class AppCompatActivity: FragmentActivity {
    open class override var className: JClassName { "androidx/appcompat/app/AppCompatActivity" }
    open class override var gradleDependencies: [AppGradleDependency] { [.appCompat, .composeBOM] }
    open class override var parentClass: String { "DroidAppCompatActivity()" }

    var permissionRequests: [Int: (_ results: [ActivityPermissionResult]) -> Void] = [:]
    fileprivate var _supportActionBar: SupportActionBar?

    open func onConfigurationChanged() {} // TODO: implement Configuration https://developer.android.com/reference/android/content/res/Configuration.html

    open func onContentChanged() {}

    open func onCreateSupportNavigateUpTaskStack() {} // TODO: implement TaskStackBuilder https://developer.android.com/reference/androidx/core/app/TaskStackBuilder

    open func onKeyDown(_ keyCode: KeyEvent.KeyCode, _ event: KeyEvent) -> Bool {
        return true
    }

    /// Please note: AppCompat uses its own feature id for the action bar: `.supportActionBar`.
    open func onMenuItemSelected(_ feature: AppCompatDelegate.Feature, _ item: MenuItem) -> Bool {
        return true
    }

    /// Please note: AppCompat uses its own feature id for the action bar: `.supportActionBar`.
    open func onMenuOpened(_ feature: AppCompatDelegate.Feature, _ menu: Menu) -> Bool {
            return true
    }

    /// Please note: AppCompat uses its own feature id for the action bar: `.supportActionBar`.
    open func onPanelClosed(_ feature: AppCompatDelegate.Feature, _ menu: Menu) {}

    // TODO: onPrepareSupportNavigateUpTaskStack
    // TODO: onSupportActionModeFinished
    // TODO: onSupportActionModeStarted

    /// This method is called whenever the user chooses to navigate Up within your application's activity hierarchy from the action bar.
    /// 
    /// If a parent was specified in the manifest for this activity or an activity-alias to it, default Up navigation will be handled automatically.
    /// See [getSupportParentActivityIntent](https://developer.android.com/reference/androidx/appcompat/app/AppCompatActivity#getSupportParentActivityIntent())
    /// for how to specify the parent. If any activity along the parent chain requires extra Intent arguments,
    /// the Activity subclass should override the method [onPrepareSupportNavigateUpTaskStack](https://developer.android.com/reference/androidx/appcompat/app/AppCompatActivity#onPrepareSupportNavigateUpTaskStack(androidx.core.app.TaskStackBuilder))
    /// to supply those arguments.
    ///
    /// See [Tasks and Back Stack](https://developer.android.com/guide/topics/fundamentals/tasks-and-back-stack)
    /// from the developer guide and [Navigation](https://developer.android.com/design/patterns/navigation)
    /// from the design guide for more information about navigating within your app.
    ///
    /// See the [androidx.core.app.TaskStackBuilder](https://developer.android.com/reference/androidx/core/app/TaskStackBuilder)
    /// class and the Activity methods [getSupportParentActivityIntent](https://developer.android.com/reference/androidx/appcompat/app/AppCompatActivity#getSupportParentActivityIntent()),
    /// [supportShouldUpRecreateTask](https://developer.android.com/reference/androidx/appcompat/app/AppCompatActivity#supportShouldUpRecreateTask(android.content.Intent)),
    /// and [supportNavigateUpTo](https://developer.android.com/reference/androidx/appcompat/app/AppCompatActivity#supportNavigateUpTo(android.content.Intent)) for help implementing custom Up navigation.
    open func onSupportNavigateUp() -> Bool {
        return true
    }

    // TODO: implement onWindowStartingSupportActionMode

    open override func onRequestPermissionsResult(requestCode: Int, results: [ActivityPermissionResult], deviceId: Int) {
        super.onRequestPermissionsResult(requestCode: requestCode, results: results, deviceId: deviceId)
        permissionRequests[requestCode]?(results)
    }

    open override func onCreateOptionsMenu(menu: Menu) -> Bool {
        return _supportActionBar != nil
    }

    open override func onPrepareOptionsMenu(menu: Menu) -> Bool {
        if let supportActionBar = _supportActionBar {
            menu.clear()
            supportActionBar.buildMenu(menu)
        }
        return true
    }

    open override func onOptionsItemSelected(item: MenuItem) -> Bool {
        if let supportActionBar = _supportActionBar {
            if supportActionBar.parentIds.contains(item.itemId()) {
                return false
            }
            return true
        }
        return false
    }

    open override func onOptionsMenuClosed(menu: Menu) {
        super.onOptionsMenuClosed(menu: menu)
    }
}

extension AppCompatActivity {
    public func closeOptionsMenu() {
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to closeOptionsMenu: activity context is nil")
            return
        }
        context.object.callVoidMethod(name: "closeOptionsMenu")
    }

    public func dispatchKeyEvent(_ event: KeyEvent) -> Bool {
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to dispatchKeyEvent: activity context is nil")
            return false
        }
        return context.object.callBoolMethod(name: "dispatchKeyEvent", args: event.signed(as: KeyEvent.className)) ?? false
    }

    // TODO: getDelegate
    // TODO: getDrawerToggleDelegate
    // TODO: getMenuInflater
    // TODO: getResources

    /// Retrieve a reference to this activity's ActionBar.
    public func supportActionBar() -> ActionBarCompat! {
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to supportActionBar: activity context is nil")
            return nil
        }
        guard
            let env = JEnv.current()
        else { return nil }
        guard
            let returningClazz = JClass.load(ActionBarCompat.className),
            let value = context.object.callObjectMethod(env, name: "getSupportActionBar", returningClass: returningClazz)
        else {
            #if os(Android)
            if env.checkException() {
                env.describeException()
                env.clearException()
            }
            #endif
            return nil
        }
        return .init(value, context)
    }

    /// Obtain an `android.content.Intent` that will launch an explicit target activity specified by sourceActivity's `PARENT_ACTIVITY` element in the application's manifest.
    /// If the device is running **Jellybean** or newer, the `android:parentActivityName` attribute will be preferred if it is present.
    public func supportParentActivityIntent() -> Intent! {
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to supportParentActivityIntent: activity context is nil")
            return nil
        }
        guard
            let returningClazz = JClass.load(Intent.className),
            let value = context.object.callObjectMethod(name: "getSupportParentActivityIntent", returningClass: returningClazz)
        else { return nil }
        return .init(value)
    }

    public func invalidateOptionsMenu() {
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to invalidateOptionsMenu: activity context is nil")
            return
        }
        context.object.callVoidMethod(name: "invalidateOptionsMenu")
    }

    public func openOptionsMenu() {
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to openOptionsMenu: activity context is nil")
            return
        }
        context.object.callVoidMethod(name: "openOptionsMenu")
    }

    /// Set a Toolbar to act as the `androidx.appcompat.app.ActionBar` for this Activity window.
    ///
    /// When set to a non-null value the getActionBar method will return
    /// an `androidx.appcompat.app.ActionBar` object that can be used to control the given toolbar
    /// as if it were a traditional window decor action bar. The toolbar's menu will be populated
    /// with the Activity's options menu and the navigation button will be wired through the standard home menu select action.
    ///
    /// In order to use a Toolbar within the Activity's window content the application
    /// must not request the window feature `FEATURE_SUPPORT_ACTION_BAR`.
    public func supportActionBar(_ toolbar: Toolbar) {
        guard
            let toolbar = toolbar.instance
        else {
            Log.c("🟥 AppCompatActivity: Failed to setSupportActionBar: toolbar instance is nil")
            return
        }
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to setSupportActionBar: activity context is nil")
            return
        }
        context.object.callVoidMethod(name: "setSupportActionBar", args: toolbar.signed(as: Toolbar.className))
    }

    public func theme(_ resId: Int32) {
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to setTheme: activity context is nil")
            return
        }
        context.object.callVoidMethod(name: "setTheme", args: resId)
    }

    // TODO: startSupportActionMode

    public func supportNavigateUpTo(_ upIntent: Intent) {
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to supportNavigateUpTo: activity context is nil")
            return
        }
        context.object.callVoidMethod(name: "supportNavigateUpTo", args: upIntent.signed(as: Intent.className))
    }

    /// Enable extended support library window features.
    ///
    /// This is a convenience for calling `getWindow().requestFeature()`.
    public func supportRequestWindowFeature(_ feature: AppCompatDelegate.Feature) -> Bool {
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to supportRequestWindowFeature: activity context is nil")
            return false
        }
        return context.object.callBoolMethod(name: "supportRequestWindowFeature", args: feature.rawValue) ?? false
    }

    /// Returns true if sourceActivity should recreate the task when navigating 'up' by using targetIntent.
    ///
    /// If this method returns false the app can trivially call supportNavigateUpTo using the same parameters to correctly perform up navigation. If this method returns false, the app should synthesize a new task stack by using androidx.core.app.TaskStackBuilder or another similar mechanism to perform up navigation.
    public func supportShouldUpRecreateTask(_ targetIntent: Intent) -> Bool {
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to supportShouldUpRecreateTask: activity context is nil")
            return false
        }
        return context.object.callBoolMethod(name: "supportRequestWindowFeature", args: targetIntent.signed(as: Intent.className)) ?? false
    }

    // MARK: - Permissions

    /// Check if a particular permission is granted.
    ///
    /// - Parameter permission: ManifestPermission to check
    /// - Returns: true if permission is granted, false otherwise
    public func checkPermission(_ permission: ManifestPermission) -> Bool {
        #if os(Android)
        permission.warnIfMissing()
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to checkPermission: activity context is nil")
            return false
        }
        guard let clazz = JClass.load("androidx/core/content/ContextCompat") else { return false }
        guard let result = clazz.staticIntMethod(name: "checkSelfPermission", args: context.signed(as: "android/content/Context"), permission.value) else { return false }
        return result == 0
        #else
        return false
        #endif
    }

    /// Request permissions at runtime.
    ///
    /// - Parameters:
    ///   - permissions: ManifestPermission(s) to request
    ///   - requestCode: Request code to identify the permission request result
    public func requestPermissions(_ permissions: ManifestPermission..., requestCode: Int) {
        self.requestPermissions(permissions, requestCode: requestCode)
    }
    
    /// Request permissions at runtime.
    ///
    /// - Parameters:
    ///   - permissions: Array of ManifestPermission to request
    ///   - requestCode: Request code to identify the permission request result
    public func requestPermissions(_ permissions: [ManifestPermission], requestCode: Int) {
        #if os(Android)
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to requestPermissions: activity context is nil")
            return
        }
        let jPermissions = permissions.compactMap { $0.value.wrap() }
        guard
            let clazz = JClass.load("androidx/core/app/ActivityCompat")
        else { return }
        guard
            let array = jPermissions.javaArray(of: JString.className)
        else { return }
        clazz.staticVoidMethod(name: "requestPermissions", args: context.signed(as: "android/app/Activity"), array.signed(as: JString.className.asArray()), Int32(requestCode))
        #endif
    }

    public func requestPermissions(_ permissions: ManifestPermission..., requestCode: Int = Int.random(in: 1000...1100), _ result: @escaping (_ results: [ActivityPermissionResult]) -> Void) {
        self.requestPermissions(permissions, requestCode: requestCode, result)
    }

    /// Request permissions at runtime with a completion handler.
    ///
    /// - Parameters:
    ///   - permissions: Array of ManifestPermission to request
    ///   - requestCode: Request code to identify the permission request result, randomized by default
    ///   - result: Completion handler with array of `ActivityPermissionResult` and deviceId
    public func requestPermissions(_ permissions: [ManifestPermission], requestCode: Int = Int.random(in: 1000...1100), _ result: @escaping (_ results: [ActivityPermissionResult]) -> Void) {
        var results: [ActivityPermissionResult] = []
        var toRequest: [ManifestPermission] = []
        for p in permissions {
            if checkPermission(p) {
                results.append(.init(p, true))
            } else {
                toRequest.append(p)
            }
        }
        if toRequest.isEmpty {
            result(results)
        } else {
            permissionRequests[requestCode] = { [weak self] r in
                results.append(contentsOf: r)
                result(results)
                self?.permissionRequests.removeValue(forKey: requestCode)
            }
            requestPermissions(toRequest, requestCode: requestCode)
        }
    }

    /// Request permissions at runtime.
    ///
    /// - Parameters:
    ///   - permissions: Array of ManifestPermission to request
    ///   - requestCode: Request code to identify the permission request result, randomized by default
    /// - Returns: Array of permission results
    public func requestPermissions(_ permissions: ManifestPermission..., requestCode: Int = Int.random(in: 1000...1100)) async -> [ActivityPermissionResult] {
        await requestPermissions(permissions, requestCode: requestCode)
    }
    
    /// Request permissions at runtime.
    ///
    /// - Parameters:
    ///   - permissions: Array of ManifestPermission to request
    ///   - requestCode: Request code to identify the permission request result, randomized by default
    /// - Returns: Array of permission results
    public func requestPermissions(_ permissions: [ManifestPermission], requestCode: Int = Int.random(in: 1000...1100)) async -> [ActivityPermissionResult] {
        await withCheckedContinuation { continuation in
            self.requestPermissions(permissions, requestCode: requestCode) { results in
                continuation.resume(with: .success(results))
            }
        }
    }
}

extension AppCompatActivity {
    @MainActor
    public final class SupportActionBar: StatesHolder, BodyBuilderItemable {
        public var bodyBuilderItem: BodyBuilderItem { .supportActiionBar(self) }
        
        public let statesValues = StatesHolderValuesBox()

        deinit { releaseStates() }

        private var actionBar: ActionBarCompat?
        private let hiddenState: State<Bool> = .init(wrappedValue: false)
        private let backgroundDrawable: State<Drawable?> = .init(wrappedValue: nil)
        private let customView: State<View?> = .init(wrappedValue: nil)
        private let displayHomeAsUpEnabled: State<Bool?> = .init(wrappedValue: nil)
        private let displayShowCustomEnabled: State<Bool?> = .init(wrappedValue: nil)
        private let displayShowHomeEnabled: State<Bool?> = .init(wrappedValue: nil)
        private let displayShowTitleEnabled: State<Bool?> = .init(wrappedValue: nil)
        private let displayUseLogoEnabled: State<Bool?> = .init(wrappedValue: nil)
        private let elevation: State<Float?> = .init(wrappedValue: nil)
        private var elevationUnit: DimensionUnit = .dp
        private let hideOffset: State<Int?> = .init(wrappedValue: nil)
        private var hideOffsetUnit: DimensionUnit = .dp
        private let hideOnContentScrollEnabled: State<Bool?> = .init(wrappedValue: nil)
        private let homeActionContentDescription: State<String?> = .init(wrappedValue: nil)
        private let homeAsUpIndicator: State<Drawable?> = .init(wrappedValue: nil)
        private let homeButtonEnabled: State<Bool?> = .init(wrappedValue: nil)
        private let icon: State<Drawable?> = .init(wrappedValue: nil)
        private let logo: State<Drawable?> = .init(wrappedValue: nil)
        private let splitBackgroundDrawable: State<Drawable?> = .init(wrappedValue: nil)
        private let subtitleState: State<String?> = .init(wrappedValue: nil)
        private let titleState: State<String?> = .init(wrappedValue: nil)

        let menu: MenuBuilder.Block
        
        public init (@MenuBuilder block: @escaping MenuBuilder.Block) {
            menu = block
        }

        public convenience init () {
            self.init { EmptyMenuBuilderItem() }
        }

        func attach(to activity: AppCompatActivity) {
            guard let actionBar = activity.supportActionBar() else {
                Log.w("🟥 AppCompatActivity.SupportActionBar: Failed to attach: activity has no supportActionBar")
                return
            }
            activity._supportActionBar = self
            self.actionBar = actionBar
            hiddenState.wrappedValue = !actionBar.isShowing()
            hiddenState.listenDistinct { [weak self] isHidden in
                if isHidden {
                    self?.actionBar?.hide()
                } else {
                    self?.actionBar?.show()
                }
            }.hold(in: self)
            if hiddenState.wrappedValue {
                if actionBar.isShowing() {
                    actionBar.hide()
                }
            } else {
                if !actionBar.isShowing() {
                    actionBar.show()
                }
            }
            backgroundDrawable.listen { [weak self] value in
                guard let value else { return }
                self?.actionBar?.backgroundDrawable(value)
            }.hold(in: self)
            if let value = backgroundDrawable.wrappedValue {
                actionBar.backgroundDrawable(value)
            }
            customView.listen { [weak self] value in
                guard let value else { return }
                self?.actionBar?.customView(value)
            }.hold(in: self)
            if let value = customView.wrappedValue {
                actionBar.customView(value)
            }
            displayHomeAsUpEnabled.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.displayHomeAsUpEnabled(value)
            }.hold(in: self)
            if let value = displayHomeAsUpEnabled.wrappedValue {
                actionBar.displayHomeAsUpEnabled(value)
            }
            displayShowCustomEnabled.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.displayShowCustomEnabled(value)
            }.hold(in: self)
            if let value = displayShowCustomEnabled.wrappedValue {
                actionBar.displayShowCustomEnabled(value)
            }
            displayShowHomeEnabled.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.displayShowHomeEnabled(value)
            }.hold(in: self)
            if let value = displayShowHomeEnabled.wrappedValue {
                actionBar.displayShowHomeEnabled(value)
            }
            displayShowTitleEnabled.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.displayShowTitleEnabled(value)
            }.hold(in: self)
            if let value = displayShowTitleEnabled.wrappedValue {
                actionBar.displayShowTitleEnabled(value)
            }
            displayUseLogoEnabled.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.displayUseLogoEnabled(value)
            }.hold(in: self)
            if let value = displayUseLogoEnabled.wrappedValue {
                actionBar.displayUseLogoEnabled(value)
            }
            elevation.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.elevation(value, self?.elevationUnit ?? .dp)
            }.hold(in: self)
            if let value = elevation.wrappedValue {
                actionBar.elevation(value, elevationUnit)
            }
            hideOffset.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.hideOffset(value, self?.hideOffsetUnit ?? .dp)
            }.hold(in: self)
            if let value = hideOffset.wrappedValue {
                actionBar.hideOffset(value, hideOffsetUnit)
            }
            hideOnContentScrollEnabled.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.hideOnContentScrollEnabled(value)
            }.hold(in: self)
            if let value = hideOnContentScrollEnabled.wrappedValue {
                actionBar.hideOnContentScrollEnabled(value)
            }
            homeActionContentDescription.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.homeActionContentDescription(value)
            }.hold(in: self)
            if let value = homeActionContentDescription.wrappedValue {
                actionBar.homeActionContentDescription(value)
            }
            homeAsUpIndicator.listen { [weak self] value in
                guard let value else { return }
                self?.actionBar?.homeAsUpIndicator(value)
            }.hold(in: self)
            if let value = homeAsUpIndicator.wrappedValue {
                actionBar.homeAsUpIndicator(value)
            }
            homeButtonEnabled.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.homeButtonEnabled(value)
            }.hold(in: self)
            if let value = homeButtonEnabled.wrappedValue {
                actionBar.homeButtonEnabled(value)
            }
            icon.listen { [weak self] value in
                guard let value else { return }
                self?.actionBar?.icon(value)
            }.hold(in: self)
            if let value = icon.wrappedValue {
                actionBar.icon(value)
            }
            logo.listen { [weak self] value in
                guard let value else { return }
                self?.actionBar?.logo(value)
            }.hold(in: self)
            if let value = logo.wrappedValue {
                actionBar.logo(value)
            }
            splitBackgroundDrawable.listen { [weak self] value in
                guard let value else { return }
                self?.actionBar?.splitBackgroundDrawable(value)
            }.hold(in: self)
            if let value = splitBackgroundDrawable.wrappedValue {
                actionBar.splitBackgroundDrawable(value)
            }
            subtitleState.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.subtitle(value)
            }.hold(in: self)
            if let value = subtitleState.wrappedValue {
                actionBar.subtitle(value)
            }
            titleState.listenDistinct { [weak self] value in
                guard let value else { return }
                self?.actionBar?.title(value)
            }.hold(in: self)
            if let value = titleState.wrappedValue {
                actionBar.title(value)
            }
        }

        var parentIds: [Int] = []

        func buildMenu(_ menu: Menu) {
            parentIds.removeAll()
            func proceedItem(_ builderItem: MenuBuilder.Item, in menu: Menu) {
                switch builderItem {
                    case .items(let items):
                        for item in items {
                            proceedItem(item, in: menu)
                        }
                    case .menu(let submenu):
                        let id: Int32 = .nextViewId()
                        if let sm = menu.addSubMenu(groupId: 0, itemId: Int(id), order: 0, submenu.titleState.wrappedValue) {
                            parentIds.append(Int(id))
                            proceedItem(submenu.menu().menuBuilderContent, in: sm)
                        }
                    case .menuItem(let item):
                        menu.add(item.titleState.wrappedValue).showAsAction(item.showAsAction)
                    case .none:
                        break
                }
            }
            proceedItem(self.menu().menuBuilderContent, in: menu)
        }

        /// Show or hide the ActionBar.
        /// 
        /// - Parameter state: Either a `Bool` or a `State<Bool>` representing the visibility.
        public func hidden<S>(_ state: S = State(wrappedValue: true)) -> Self where S: StateValuable, S.Value == Bool {
            if let state = state.stateValue {
                hiddenState.merge(with: state).hold(in: self)
            } else {
                hiddenState.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set the `ActionBar`'s background.
        ///
        /// - Parameter state: Either a `Drawable` or a `State<Drawable>` representing the background drawable.
        public func backgroundDrawable<S>(_ state: S) -> Self where S: StateValuable, S.Value == Drawable {
            if let state = state.stateValue {
                backgroundDrawable.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                backgroundDrawable.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set the action bar into custom navigation mode, supplying a view for custom navigation.
        ///
        /// - Parameter state: Either a `View` or a `State<View>` representing the custom view.
        public func customView<S>(_ state: S) -> Self where S: StateValuable, S.Value == View {
            if let state = state.stateValue {
                customView.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                customView.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set whether home should be displayed as an "up" affordance.
        /// 
        /// Set this to true if selecting "home" returns up by a single level in your UI rather than to the top level or front page.
        /// 
        /// - Parameter state: Either a `Bool` or a `State<Bool>` representing whether home is displayed as up.
        public func displayHomeAsUpEnabled<S>(_ state: S = State(wrappedValue: true)) -> Self where S: StateValuable, S.Value == Bool {
            if let state = state.stateValue {
                displayHomeAsUpEnabled.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                displayHomeAsUpEnabled.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set whether a custom view should be displayed, if set.
        ///
        /// - Parameter state: Either a `Bool` or a `State<Bool>` representing whether the custom view is displayed.
        public func displayShowCustomEnabled<S>(_ state: S = State(wrappedValue: true)) -> Self where S: StateValuable, S.Value == Bool {
            if let state = state.stateValue {
                displayShowCustomEnabled.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                displayShowCustomEnabled.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set whether to include the application home affordance in the action bar.
        /// Home is presented as either an activity icon or logo.
        ///
        /// - Parameter state: Either a `Bool` or a `State<Bool>` representing whether home is displayed.
        public func displayShowHomeEnabled<S>(_ state: S = State(wrappedValue: true)) -> Self where S: StateValuable, S.Value == Bool {
            if let state = state.stateValue {
                displayShowHomeEnabled.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                displayShowHomeEnabled.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set whether an activity title/subtitle should be displayed.
        ///
        /// - Parameter state: Either a `Bool` or a `State<Bool>` representing whether the title is displayed.
        public func displayShowTitleEnabled<S>(_ state: S = State(wrappedValue: true)) -> Self where S: StateValuable, S.Value == Bool {
            if let state = state.stateValue {
                displayShowTitleEnabled.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                displayShowTitleEnabled.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set whether to display the activity logo rather than the activity icon. A logo is often a wider, more detailed image.
        ///
        /// - Parameter state: Either a `Bool` or a `State<Bool>` representing whether to use the logo.
        public func displayUseLogoEnabled<S>(_ state: S = State(wrappedValue: true)) -> Self where S: StateValuable, S.Value == Bool {
            if let state = state.stateValue {
                displayUseLogoEnabled.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                displayUseLogoEnabled.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set the Z-axis elevation of the action bar in pixels.
        ///
        /// The action bar's elevation is the distance it is placed from its parent surface. Higher values are closer to the user.
        ///
        /// - Parameters:
        ///   - state: Either a `Float` or a `State<Float>` representing the elevation value.
        ///   - unit: DimensionUnit for the elevation value, `.dp` by default.
        public func elevation<S>(_ state: S, _ unit: DimensionUnit = .dp) -> Self where S: StateValuable, S.Value == Float {
            if let state = state.stateValue {
                elevation.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                elevation.wrappedValue = state.simpleValue
            }
            elevationUnit = unit
            return self
        }

        /// Set the current hide offset of the action bar.
        /// 
        /// The action bar's current hide offset is the distance that the action bar is currently scrolled offscreen in pixels.
        /// 
        /// The valid range is 0 (fully visible) to the action bar's current measured height (fully invisible).
        ///
        /// - Parameters:
        ///   - state: Either an `Int` or a `State<Int>` representing the hide offset value.
        ///   - unit: DimensionUnit for the hide offset value, `.dp` by default.
        public func hideOffset<S>(_ state: S, _ unit: DimensionUnit = .dp) -> Self where S: StateValuable, S.Value == Int {
            if let state = state.stateValue {
                hideOffset.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                hideOffset.wrappedValue = state.simpleValue
            }
            hideOffsetUnit = unit
            return self
        }

        /// Enable hiding the action bar on content scroll.
        /// 
        /// If enabled, the action bar will scroll out of sight along with a nested scrolling child view's content.
        /// The action bar must be in overlay mode to enable hiding on content scroll.
        /// 
        /// When partially scrolled off screen the action bar is considered hidden.
        /// A call to show will cause it to return to full view.
        ///
        /// - Parameter state: Either a `Bool` or a `State<Bool>` representing whether to hide on content scroll.
        public func hideOnContentScrollEnabled<S>(_ state: S = State(wrappedValue: true)) -> Self where S: StateValuable, S.Value == Bool {
            if let state = state.stateValue {
                hideOnContentScrollEnabled.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                hideOnContentScrollEnabled.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set an alternate description for the Home/Up action, when enabled.
        ///
        /// This description is commonly used for accessibility/screen readers when the Home action is enabled.
        /// (See [setDisplayHomeAsUpEnabled](https://developer.android.com/reference/androidx/appcompat/app/ActionBar#setDisplayHomeAsUpEnabled(boolean)).)
        /// Examples of this are, "Navigate Home" or "Navigate Up" depending on the `DISPLAY_HOME_AS_UP` display option.
        /// If you have changed the home-as-up indicator using `setHomeAsUpIndicator` to indicate more specific functionality
        /// such as a sliding drawer, you should also set this to accurately describe the action.
        ///
        /// Setting this to null will use the system default description.
        ///
        /// - Parameter state: Either a `String` or a `State<String>` representing the content description.
        public func homeActionContentDescription<S>(_ state: S) -> Self where S: StateValuable, S.Value == String {
            if let state = state.stateValue {
                homeActionContentDescription.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                homeActionContentDescription.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set an alternate drawable to display next to the icon/logo/title when `DISPLAY_HOME_AS_UP` is enabled.
        /// This can be useful if you are using this mode to display an alternate selection for up navigation, such as a sliding drawer.
        ///
        /// If you pass null to this method, the default drawable from the theme will be used.
        ///
        /// If you implement alternate or intermediate behavior around Up,
        /// you should also call `setHomeActionContentDescription()` to provide a correct description of the action for accessibility support.
        ///
        /// - Parameter state: Either a `Drawable` or a `State<Drawable>` representing the up indicator.
        public func homeAsUpIndicator<S>(_ state: S) -> Self where S: StateValuable, S.Value == Drawable {
            if let state = state.stateValue {
                homeAsUpIndicator.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                homeAsUpIndicator.wrappedValue = state.simpleValue
            }
            return self
        }
        
        /// Enable or disable the "home" button in the corner of the action bar.
        /// Note that this is the application home/up affordance on the action bar, not the system wide home button.)
        ///
        /// This defaults to true for packages targeting
        /// 
        /// Setting the `DISPLAY_HOME_AS_UP` display option will automatically enable the home button.
        ///
        /// - Parameter state: Either a `Bool` or a `State<Bool>` representing whether the home button is enabled.
        public func homeButtonEnabled<S>(_ state: S = State(wrappedValue: true)) -> Self where S: StateValuable, S.Value == Bool {
            if let state = state.stateValue {
                homeButtonEnabled.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                homeButtonEnabled.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set the icon to display in the 'home' section of the action bar.
        ///
        /// The action bar will use an icon specified by its style or the activity icon by default.
        /// Whether the home section shows an icon or logo is controlled by the display option `DISPLAY_USE_LOGO`.
        ///
        /// - Parameter state: Either a `Drawable` or a `State<Drawable>` representing the icon.
        public func icon<S>(_ state: S) -> Self where S: StateValuable, S.Value == Drawable {
            if let state = state.stateValue {
                icon.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                icon.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set the logo to display in the 'home' section of the action bar.
        /// 
        /// The action bar will use a logo specified by its style or the activity logo by default.
        /// Whether the home section shows an icon or logo is controlled by the display option `DISPLAY_USE_LOGO`.
        ///
        /// - Parameter state: Either a `Drawable` or a `State<Drawable>` representing the logo.
        public func logo<S>(_ state: S) -> Self where S: StateValuable, S.Value == Drawable {
            if let state = state.stateValue {
                logo.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                logo.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set the ActionBar's split background.
        /// This will appear in the split action bar containing menu-provided action buttons on some devices and configurations.
        /// 
        /// You can enable split action bar with `uiOptions`
        ///
        /// - Parameter state: Either a `Drawable` or a `State<Drawable>` representing the split background drawable.
        public func splitBackgroundDrawable<S>(_ state: S) -> Self where S: StateValuable, S.Value == Drawable {
            if let state = state.stateValue {
                splitBackgroundDrawable.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                splitBackgroundDrawable.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set the action bar's subtitle.
        /// 
        /// This will only be displayed if `DISPLAY_SHOW_TITLE` is set.
        ///
        /// - Parameter state: Either a `String` or a `State<String>` representing the subtitle.
        public func subtitle<S>(_ state: S) -> Self where S: StateValuable, S.Value == String {
            if let state = state.stateValue {
                subtitleState.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                subtitleState.wrappedValue = state.simpleValue
            }
            return self
        }

        /// Set the action bar's title.
        /// 
        /// This will only be displayed if `DISPLAY_SHOW_TITLE` is set.
        ///
        /// - Parameter state: Either a `String` or a `State<String>` representing the title.
        public func title<S>(_ state: S) -> Self where S: StateValuable, S.Value == String {
            if let state = state.stateValue {
                titleState.mergeWithNonOptional(with: state).hold(in: self)
            } else {
                titleState.wrappedValue = state.simpleValue
            }
            return self
        }
    }
}

extension AppCompatActivity {
    @MainActor
    public final class ActionSubMenu: Sendable {
        let titleState: State<String>
        let menu: MenuBuilder.Block
        
        public init<S>(_ title: S, @MenuBuilder block: @escaping MenuBuilder.Block) where S: StateValuable, S.Value == String {
            if let state = title.stateValue {
                titleState = state
            } else {
                titleState = State(wrappedValue: title.simpleValue)
            }
            menu = block
        }
    }

    @MainActor
    public final class ActionMenuItem: Sendable {
        let titleState: State<String>
        let showAsAction: MenuItem.ShowAsAction
        
        public init<S>(_ title: S, _ showAsAction: MenuItem.ShowAsAction = .collapseActionView) where S: StateValuable, S.Value == String {
            if let state = title.stateValue {
                titleState = state
            } else {
                titleState = State(wrappedValue: title.simpleValue)
            }
            self.showAsAction = showAsAction
        }
    }
}