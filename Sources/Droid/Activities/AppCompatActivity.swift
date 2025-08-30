//
//  AppCompatActivity.swift
//  
//
//  Created by Mihael Isaev on 25.02.2023.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

#if os(Android)
extension AppCompatActivity: Sendable {}
#else
extension AppCompatActivity: @unchecked Sendable {}
#endif

#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class AppCompatActivity: FragmentActivity {
    open class override var className: JClassName { "androidx/appcompat/app/AppCompatActivity" }
    open class override var gradleDependencies: [String] { [
        #"implementation("androidx.appcompat:appcompat:1.7.1")"#,
        #"implementation(platform("androidx.compose:compose-bom:2025.07.00"))"#
    ] }
    open class override var parentClass: String { "DroidAppCompatActivity()" }

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
}

extension AppCompatActivity {
    public func closeOptionsMenu() {
        _context.object.callVoidMethod(name: "closeOptionsMenu")
    }

    public func dispatchKeyEvent(_ event: KeyEvent) -> Bool {
        _context.object.callBoolMethod(name: "dispatchKeyEvent", args: event.signed(as: KeyEvent.className)) ?? false
    }

    // TODO: getDelegate
    // TODO: getDrawerToggleDelegate
    // TODO: getMenuInflater
    // TODO: getResources

    /// Retrieve a reference to this activity's ActionBar.
    public func supportActionBar() -> ActionBar! {
        guard
            let value = _context.object.callObjectMethod(name: "getSupportActionBar", returning: .object(ActionBar.className))
        else { return nil }
        return .init(value, context)
    }

    /// Obtain an `android.content.Intent` that will launch an explicit target activity specified by sourceActivity's `PARENT_ACTIVITY` element in the application's manifest.
    /// If the device is running **Jellybean** or newer, the `android:parentActivityName` attribute will be preferred if it is present.
    public func supportParentActivityIntent() -> Intent! {
        guard
            let value = _context.object.callObjectMethod(name: "getSupportParentActivityIntent", returning: .object(Intent.className))
        else { return nil }
        return .init(value)
    }

    public func invalidateOptionsMenu() {
        _context.object.callVoidMethod(name: "invalidateOptionsMenu")
    }

    public func openOptionsMenu() {
        _context.object.callVoidMethod(name: "openOptionsMenu")
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
        else { return }
        _context.object.callVoidMethod(name: "setSupportActionBar", args: toolbar.signed(as: Toolbar.className))
    }

    public func theme(_ resId: Int32) {
        _context.object.callVoidMethod(name: "setTheme", args: resId)
    }

    // TODO: startSupportActionMode

    public func supportNavigateUpTo(_ upIntent: Intent) {
        _context.object.callVoidMethod(name: "supportNavigateUpTo", args: upIntent.signed(as: Intent.className))
    }

    /// Enable extended support library window features.
    ///
    /// This is a convenience for calling `getWindow().requestFeature()`.
    public func supportRequestWindowFeature(_ feature: AppCompatDelegate.Feature) -> Bool {
        _context.object.callBoolMethod(name: "supportRequestWindowFeature", args: feature.rawValue) ?? false
    }

    /// Returns true if sourceActivity should recreate the task when navigating 'up' by using targetIntent.
    ///
    /// If this method returns false the app can trivially call supportNavigateUpTo using the same parameters to correctly perform up navigation. If this method returns false, the app should synthesize a new task stack by using androidx.core.app.TaskStackBuilder or another similar mechanism to perform up navigation.
    public func supportShouldUpRecreateTask(_ targetIntent: Intent) -> Bool {
        _context.object.callBoolMethod(name: "supportRequestWindowFeature", args: targetIntent.signed(as: Intent.className)) ?? false
    }
}
