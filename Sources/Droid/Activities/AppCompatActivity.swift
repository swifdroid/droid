//
//  AppCompatActivity.swift
//  
//
//  Created by Mihael Isaev on 25.02.2023.
//

#if os(Android)
extension AppCompatActivity: Sendable {}
#else
extension AppCompatActivity: @unchecked Sendable {}
#endif

@MainActor
open class AppCompatActivity: FragmentActivity {
    open class override var className: JClassName { "androidx/appcompat/app/AppCompatActivity" }
    open class override var gradleDependencies: [AppGradleDependency] { [.appCompat, .composeBOM] }
    open class override var parentClass: String { "DroidAppCompatActivity()" }

    var permissionRequests: [Int: (_ results: [ActivityPermissionResult]) -> Void] = [:]

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
    public func supportActionBar() -> ActionBar! {
        guard let context else {
            Log.c("🟥 AppCompatActivity: Failed to supportActionBar: activity context is nil")
            return nil
        }
        guard
            let returningClazz = JClass.load(ActionBar.className),
            let value = context.object.callObjectMethod(name: "getSupportActionBar", returningClass: returningClazz)
        else { return nil }
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
                print("appending checked permission \(p.value)")
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
