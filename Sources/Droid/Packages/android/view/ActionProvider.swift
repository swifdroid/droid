//
//  ActionProvider.swift
//  Droid
//
//  Created by Mihael Isaev on 24.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

/// An ActionProvider defines rich menu interaction in a single component.
/// 
/// ActionProvider can generate action views for use in the action bar, dynamically populate submenus of a MenuItem,
/// and handle default menu item invocations.
/// 
/// An ActionProvider can be optionally specified for a MenuItem and will be responsible for creating the action view
/// that appears in the ActionBar in place of a simple button in the bar. When the menu item is presented in a way
/// that does not allow custom action views, (e.g. in an overflow menu,) the ActionProvider can perform a default action.
/// 
/// [Learn more](https://developer.android.com/reference/android/view/ActionProvider)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class ActionProvider: JObjectable, Contextable, @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { "android/view/ActionProvider" }

    public let object: JObject

    public let context: ActivityContext

    public init (_ object: JObject, _ context: ActivityContext) {
        self.object = object
        self.context = context
    }

    /// Called to prepare an associated submenu for the menu item backed by this `ActionProvider`.
    ///
    /// if hasSubMenu() returns true, this method will be called when the menu item is selected
    /// to prepare the submenu for presentation to the user.
    /// 
    /// Apps may use this to create or alter submenu content right before display.
    public func onPrepareSubMenu(_ subMenu: SubMenu) { // TODO

    }
}

extension ActionProvider {
    /// Determines if this ActionProvider has a submenu associated with it.
    public func hasSubMenu() -> Bool {
        object.callBoolMethod(name: "hasSubMenu") ?? false
    }

    /// If `overridesItemVisibility()` returns true, the return value of this method will help
    /// determine the visibility of the MenuItem this ActionProvider is bound to.
    /// 
    /// If the MenuItem's visibility is explicitly set to false by the application,
    /// the MenuItem will not be shown, even if this method returns true.
    public func isVisible() -> Bool {
        object.callBoolMethod(name: "isVisible") ?? false
    }

    /// The result of this method determines whether or not isVisible()
    /// will be used by the MenuItem this ActionProvider is bound to help determine its visibility.
    /// 
    /// Return `true` if this `ActionProvider` overrides the visibility of the MenuItem it is bound to,
    /// `false` otherwise.
    /// 
    /// The default implementation returns false.
    public func overridesItemVisibility() -> Bool {
        object.callBoolMethod(name: "overridesItemVisibility") ?? false
    }

    /// If this `ActionProvider` is associated with an item in a menu,
    /// refresh the visibility of the item based on `overridesItemVisibility()` and `isVisible()`.
    /// 
    /// If `overridesItemVisibility()` returns false, this call will have no effect.
    public func refreshVisibility() {
        object.callVoidMethod(name: "refreshVisibility")
    }

    // TODO: setVisibilityListener
}

/// The media route action provider displays a media route button in the application's ActionBar
/// to allow the user to select routes and to control the currently selected route.
///
/// The application must specify the kinds of routes that the user should be allowed
/// to select by specifying the route types with the setRouteTypes(int) method.
///
/// Refer to MediaRouteButton for a description of the button that will appear in the action bar menu.
/// 
/// Note that instead of disabling the button when no routes are available, the action provider will instead make the menu item invisible.
/// 
/// In this way, the button will only be visible when it is possible for the user to discover and select a matching route.
/// 
/// [Learn more](https://developer.android.com/reference/android/app/MediaRouteActionProvider)
public final class MediaRouteActionProvider: ActionProvider, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { "android/app/MediaRouteActionProvider" }

    /// Factory method called by the Android framework to create new action views.
    /// 
    /// This method returns a new action view for the given `MenuItem`.
    ///
    /// If your ActionProvider implementation overrides the deprecated no-argument overload `onCreateActionView()`,
    /// overriding this method for devices running API 16 or later is recommended but optional.
    /// 
    /// The default implementation calls `onCreateActionView()` for compatibility with applications written for older platform versions.
    public func onCreateActionView(_ menuItem: MenuItem) -> View? { // TODO
        return nil
    }

    /// Performs an optional default action.
    ///
    /// For the case of an action provider placed in a menu item not shown as an action
    /// this method is invoked if previous callbacks for processing menu selection has handled the event.
    ///
    /// A menu item selection is processed in the following order:
    ///
    ///    - Receiving a call to MenuItem.OnMenuItemClickListener.onMenuItemClick.
    ///    - Receiving a call to Activity.onOptionsItemSelected(MenuItem)
    ///    - Receiving a call to Fragment.onOptionsItemSelected(MenuItem)
    ///    - Launching the Intent set via MenuItem.setIntent(android.content.Intent)
    ///    - Invoking this method.
    /// 
    ///The default implementation does not perform any action and returns false.
    public func onPerformDefaultAction() -> Bool { // TODO
        return false
    }
}

extension MediaRouteActionProvider {
    // TODO: setExtendedSettingsClickListener

    /// Sets the types of routes that will be shown in the media route chooser dialog launched by this button.
    public func routeTypes(_ types: Int) {
        object.callVoidMethod(name: "setRouteTypes", args: Int32(types))
    }
}

/// This is a provider for a share action.
/// 
/// It is responsible for creating views that enable data sharing and also to show a sub menu
/// with sharing activities if the hosting item is placed on the overflow menu.
/// 
/// [Learn more](https://developer.android.com/reference/android/widget/ShareActionProvider)
public final class ShareActionProvider: ActionProvider, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { "android/widget/ShareActionProvider" }
}

extension ShareActionProvider {
    /// The default name for storing share history.
    public static let defaultShareHistoryFileName = "share_history.xml"

    // TODO: setOnShareTargetSelectedListener
    
    /// Sets the file name of a file for persisting the share history which history will be used for ordering share targets.
    /// 
    /// This file will be used for all view created by `onCreateActionView()`.
    /// 
    /// Defaults to `defaultShareHistoryFileName`.
    /// 
    /// Set to null if share history should not be persisted between sessions.
    ///
    /// Note: The history file name can be set any time, however only the action views
    /// created by `onCreateActionView()` after setting the file name will be backed by the provided file. 
    public func shareHistoryFileName(_ file: String) {
        guard
            let str = JString(from: file)
        else { return }
        object.callVoidMethod(name: "setShareHistoryFileName", args: str.signedAsString())
    }

    /// Sets an intent with information about the share action.
    public func shareIntent(_ intent: Intent) {
        callVoidMethod(name: "setShareIntent", args: intent.signed(as: Intent.className))
    }
}

// TODO: implement `Uri` and `File` objects