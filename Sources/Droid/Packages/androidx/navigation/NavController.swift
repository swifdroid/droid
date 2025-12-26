//
//  NavController.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// NavController manages app navigation within a NavHost.
/// 
/// Apps will generally obtain a controller directly from a host,
/// or by using one of the utility methods on the Navigation class
/// rather than create a controller directly.
/// 
/// Navigation flows and destinations are determined by the navigation
/// graph owned by the controller. These graphs are typically navInflater
/// from an Android resource, but, like views, they can also be constructed
/// or combined programmatically or for the case of dynamic navigation structure.
/// (For example, if the navigation structure of the application is determined
/// by live data obtained' from a remote server.)
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavController)
@MainActor
open class NavController: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "androidx/navigation/NavController" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? (_ context: Contextable) {
        guard
            let clazz = JClass.load(NavController.className),
            let global = clazz.newObject(args: context.context.signed(as: "android/content/Context"))
        else { return nil }
        self.object = global
    }
}

extension NavController {
    // TODO: addOnDestinationChangedListener

    /// Clears any saved state associated with KClass T
    /// that was previously saved via popBackStack
    /// when using a saveState value of true.
    public func clearBackStack() -> Bool {
        callBoolMethod(name: "clearBackStack") ?? false
    }

    /// Clears any saved state associated with destinationId
    /// that was previously saved via popBackStack
    /// when using a saveState value of true.
    public func clearBackStack(_ destinationId: Int32) -> Bool {
        callBoolMethod(name: "clearBackStack", args: destinationId) ?? false
    }

    /// Clears any saved state associated with route
    /// that was previously saved via popBackStack
    /// when using a saveState value of true.
    public func clearBackStack(route: String) -> Bool {
        callBoolMethod(name: "clearBackStack", args: route) ?? false
    }

    /// Create a deep link to a destination within this NavController.
    public func createDeepLink() -> NavDeepLinkBuilder? {
        guard
            let returningClazz = JClass.load(NavDeepLinkBuilder.className),
            let global = object.callObjectMethod(name: "createDeepLink", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// By default, handleDeepLink will automatically add calls
    /// to NavOptions.Builder.setPopUpTo with a saveState of true
    /// when the deep link takes you to another graph
    /// (e.g., a different navigation graph than the one your start destination is in).
    /// 
    /// You can disable this behavior by passing false for saveState.
    public func enableDeepLinkSaveStates(_ enable: Bool) {
        callVoidMethod(name: "enableDeepLinkSaveStates", args: enable)
    }

    /// Gets the topmost NavBackStackEntry for a route from KClass.
    ///
    /// This is always safe to use with the current destination
    /// or its parent or grandparent navigation graphs as these destinations
    /// are guaranteed to be on the back stack.
    public func backStackEntry() -> NavBackStackEntry? {
        guard
            let returningClazz = JClass.load(NavBackStackEntry.className),
            let global = object.callObjectMethod(name: "getBackStackEntry", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Gets the topmost NavBackStackEntry for a destination id.
    ///
    /// This is always safe to use with the current destination
    /// or its parent or grandparent navigation graphs as these destinations
    /// are guaranteed to be on the back stack.
    public func backStackEntry(destinationId: Int32) -> NavBackStackEntry? {
        guard
            let returningClazz = JClass.load(NavBackStackEntry.className),
            let global = object.callObjectMethod(name: "getBackStackEntry", args: destinationId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Gets the topmost NavBackStackEntry for a route.
    ///
    /// This is always safe to use with the current destination
    /// or its parent or grandparent navigation graphs as these destinations
    /// are guaranteed to be on the back stack.
    public func backStackEntry(route: String) -> NavBackStackEntry? {
        guard
            let returningClazz = JClass.load(NavBackStackEntry.className),
            let global = object.callObjectMethod(name: "getBackStackEntry", args: route, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// The topmost NavBackStackEntry.
    public func currentBackStackEntry() -> NavBackStackEntry? {
        guard
            let returningClazz = JClass.load(NavBackStackEntry.className),
            let global = object.callObjectMethod(name: "getCurrentBackStackEntry", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    // TODO: getCurrentBackStackEntryFlow

    /// The current destination.
    public func currentDestination() -> NavDestination? {
        guard
            let returningClazz = JClass.load(NavDestination.className),
            let global = object.callObjectMethod(name: "getCurrentDestination", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// The topmost navigation graph associated with this NavController.
    ///
    /// When this is set any current navigation graph data (including back stack) will be replaced.
    public func graph() -> NavGraph? {
        guard
            let returningClazz = JClass.load(NavGraph.className),
            let global = object.callObjectMethod(name: "getGraph", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    // TODO: getNavInflater

    /// The NavController's NavigatorProvider. All Navigators used to construct
    /// the navigation graph for this nav controller should be added
    /// to this navigator provider before the graph is constructed.
    /// 
    /// This can only be set before the graph is set via setGraph().
    /// 
    /// Generally, the Navigators are set for you by the NavHost hosting
    /// this NavController and you do not need to manually interact with the navigator provider.
    public func navigatorProvider() -> NavigatorProvider? {
        guard
            let returningClazz = JClass.load(NavigatorProvider.className),
            let global = object.callObjectMethod(name: "getNavigatorProvider", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// The previous visible NavBackStackEntry.
    ///
    /// This skips over any NavBackStackEntry that is associated with a NavGraph.
    public func previousBackStackEntry() -> NavBackStackEntry? {
        guard
            let returningClazz = JClass.load(NavBackStackEntry.className),
            let global = object.callObjectMethod(name: "getPreviousBackStackEntry", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    // TODO: getViewModelStoreOwner

    // TODO: getVisibleEntries

    /// Checks the given Intent for a Navigation deep link and navigates
    /// to the deep link if present. This is called automatically for you
    /// the first time you set the graph if you've passed in an Activity
    /// as the context when constructing this NavController,
    /// but should be manually called if your Activity receives
    /// new Intents in Activity.onNewIntent.
    /// 
    /// The types of Intents that are supported include:
    /// 
    /// Intents created by NavDeepLinkBuilder or createDeepLink.
    /// This assumes that the current graph shares the same hierarchy
    /// to get to the deep linked destination as when the deep link was constructed.
    /// Intents that include a data Uri. This Uri will be checked against the Uri patterns
    /// in the NavDeepLinks added via NavDestination.addDeepLink.
    /// 
    /// The navigation graph should be set before calling this method.
    public func handleDeepLink(_ intent: Intent) -> Bool {
        callBoolMethod(name: "handleDeepLink", args: intent.signed(as: Intent.className)) ?? false
    }

    /// Checks the given NavDeepLinkRequest for a Navigation deep link
    /// and navigates to the destination if present.
    ///
    /// The navigation graph should be set before calling this method.
    public func handleDeepLink(_ request: NavDeepLinkRequest) -> Bool {
        callBoolMethod(name: "handleDeepLink", args: request.signed(as: NavDeepLinkRequest.className)) ?? false
    }

    /// Navigate to a destination via the given deep link Uri.
    /// NavDestination.hasDeepLink should be called on the navigation graph
    /// prior to calling this method to check if the deep link is valid.
    /// If an invalid deep link is given, an IllegalArgumentException will be thrown.
    public func navigate(_ deepLink: NavUri) {
        callVoidMethod(name: "navigate", args: deepLink.signed(as: NavUri.className))
    }

    /// Navigate via the given NavDirections.
    public func navigate(_ directions: NavDirections) {
        callVoidMethod(name: "navigate", args: directions.signed(as: NavDirections.className))
    }

    /// Navigate to a destination via the given NavDeepLinkRequest.
    /// NavDestination.hasDeepLink should be called on the navigation graph
    /// prior to calling this method to check if the deep link is valid.
    /// If an invalid deep link is given, an IllegalArgumentException will be thrown.
    public func navigate(_ request: NavDeepLinkRequest) {
        callVoidMethod(name: "navigate", args: request.signed(as: NavDeepLinkRequest.className))
    }

    /// Navigate to a destination from the current navigation graph.
    /// This supports both navigating via an action and directly navigating to a destination.
    public func navigate(_ resId: Int32) {
        callVoidMethod(name: "navigate", args: resId)
    }

    /// Navigate to a destination via the given deep link Uri.
    /// NavDestination.hasDeepLink should be called on the navigation graph
    /// prior to calling this method to check if the deep link is valid.
    /// If an invalid deep link is given, an IllegalArgumentException will be thrown.
    public func navigate(_ deepLink: NavUri, _ navOptions: NavOptions) {
        callVoidMethod(name: "navigate", args: deepLink.signed(as: NavUri.className), navOptions.signed(as: NavOptions.className))
    }

    /// Navigate via the given NavDirections
    public func navigate(_ directions: NavDirections, _ navOptions: NavOptions) {
        callVoidMethod(name: "navigate", args: directions.signed(as: NavDirections.className), navOptions.signed(as: NavOptions.className))
    }

    /// Navigate via the given NavDirections
    public func navigate(_ directions: NavDirections, _ navigatorExtras: Navigator.Extras) {
        callVoidMethod(name: "navigate", args: directions.signed(as: NavDirections.className), navigatorExtras.signed(as: Navigator.Extras.className))
    }

    /// Navigate to a destination via the given NavDeepLinkRequest.
    /// NavDestination.hasDeepLink should be called on the navigation graph
    /// prior to calling this method to check if the deep link is valid.
    /// If an invalid deep link is given, an IllegalArgumentException will be thrown.
    public func navigate(_ request: NavDeepLinkRequest, _ navOptions: NavOptions) {
        callVoidMethod(name: "navigate", args: request.signed(as: NavDeepLinkRequest.className), navOptions.signed(as: NavOptions.className))
    }

    /// Navigate to a destination from the current navigation graph.
    /// This supports both navigating via an action and directly navigating to a destination.
    public func navigate(_ resId: Int32, _ args: Bundle) {
        callVoidMethod(name: "navigate", args: resId, args.signed(as: Bundle.className))
    }

    /// Navigate to a destination via the given deep link Uri.
    /// NavDestination.hasDeepLink should be called on the navigation graph
    /// prior to calling this method to check if the deep link is valid.
    /// If an invalid deep link is given, an IllegalArgumentException will be thrown.
    public func navigate(_ deepLink: NavUri, _ navOptions: NavOptions, _ navigatorExtras: Navigator.Extras) {
        callVoidMethod(name: "navigate", args: deepLink.signed(as: NavUri.className), navOptions.signed(as: NavOptions.className), navigatorExtras.signed(as: Navigator.Extras.className))
    }

    /// Navigate to a destination via the given NavDeepLinkRequest.
    /// NavDestination.hasDeepLink should be called on the navigation graph
    /// prior to calling this method to check if the deep link is valid.
    /// If an invalid deep link is given, an IllegalArgumentException will be thrown.
    public func navigate(_ request: NavDeepLinkRequest, _ navOptions: NavOptions, _ navigatorExtras: Navigator.Extras) {
        callVoidMethod(name: "navigate", args: request.signed(as: NavDeepLinkRequest.className), navOptions.signed(as: NavOptions.className), navigatorExtras.signed(as: Navigator.Extras.className))
    }

    /// Navigate to a destination from the current navigation graph.
    /// This supports both navigating via an action and directly navigating to a destination.
    ///
    /// If given NavOptions pass in NavOptions.restoreState true,
    /// any args passed here will be overridden by the restored args.
    public func navigate(_ resId: Int32, _ args: Bundle, _ navOptions: NavOptions) {
        callVoidMethod(name: "navigate", args: resId, args.signed(as: Bundle.className), navOptions.signed(as: NavOptions.className))
    }

    /// Navigate to a route in the current NavGraph.
    /// If an invalid route is given, an IllegalArgumentException will be thrown.
    ///
    /// If given NavOptions pass in NavOptions.restoreState true,
    /// any args passed here as part of the route will be overridden by the restored args.
    public func navigate(_ route: String, _ navOptions: NavOptions, _ navigatorExtras: Navigator.Extras) {
        callVoidMethod(name: "navigate", args: route, navOptions.signed(as: NavOptions.className), navigatorExtras.signed(as: Navigator.Extras.className))
    }

    /// Navigate to a destination from the current navigation graph.
    /// This supports both navigating via an action and directly navigating to a destination.
    ///
    /// If given NavOptions pass in NavOptions.restoreState true,
    /// any args passed here will be overridden by the restored args.
    public func navigate(_ resId: Int32, _ args: Bundle, _ navOptions: NavOptions, _ navigatorExtras: Navigator.Extras) {
        callVoidMethod(name: "navigate", args: resId, args.signed(as: Bundle.className), navOptions.signed(as: NavOptions.className), navigatorExtras.signed(as: Navigator.Extras.className))
    }

    /// Attempts to navigate up in the navigation hierarchy.
    /// Suitable for when the user presses the "Up" button marked
    /// with a left (or start)-facing arrow in the upper left (or starting) corner of the app UI.
    ///
    /// The intended behavior of Up differs from Back when the user did not
    /// reach the current destination from the application's own task.
    /// e.g. if the user is viewing a document or link in the current app in an activity
    /// hosted on another app's task where the user clicked the link.
    /// In this case the current activity (determined by the context used to create
    /// this NavController) will be Activity.finish and the user will be taken
    /// to an appropriate destination in this app on its own task.
    public func navigateUp() -> Bool {
        callBoolMethod(name: "navigateUp") ?? false
    }

    /// Attempts to pop the controller's back stack.
    /// Analogous to when the user presses the system `android.view.KeyEvent.KEYCODE_BACK`
    /// button when the associated navigation host has focus.
    public func popBackStack() -> Bool {
        callBoolMethod(name: "popBackStack") ?? false
    }

    /// Attempts to pop the controller's back stack back to a specific destination.
    public func popBackStack(_ destinationId: Int32, _ inclusive: Bool) -> Bool {
        callBoolMethod(name: "popBackStack", args: destinationId, inclusive) ?? false
    }

    /// Attempts to pop the controller's back stack back to a specific destination.
    public func popBackStack(_ inclusive: Bool, _ saveState: Bool) -> Bool {
        callBoolMethod(name: "popBackStack", args: inclusive, saveState) ?? false
    }

    /// Attempts to pop the controller's back stack back to a specific destination.
    public func popBackStack(_ destinationId: Int32, _ inclusive: Bool, _ saveState: Bool) -> Bool {
        callBoolMethod(name: "popBackStack", args: destinationId, inclusive, saveState) ?? false
    }

    /// Attempts to pop the controller's back stack back to a specific destination.
    public func popBackStack(route: String, _ inclusive: Bool, _ saveState: Bool) -> Bool {
        callBoolMethod(name: "popBackStack", args: route, inclusive, saveState) ?? false
    }

    // TODO: removeOnDestinationChangedListener

    /// Restores all navigation controller state from a SavedState.
    /// This should be called before any call to setGraph.
    ///
    /// State may be saved to a SavedState by calling saveState.
    /// Restoring controller state is the responsibility of a NavHost.
    public func restoreState(_ navState: Bundle) {
        callVoidMethod(name: "restoreState", args: navState.signed(as: Bundle.className))
    }

    // TODO: saveState

    /// The topmost navigation graph associated with this NavController.
    ///
    /// When this is set any current navigation graph data (including back stack) will be replaced.
    public func graph(_ graph: NavGraph) {
        callVoidMethod(name: "setGraph", args: graph.signed(as: NavGraph.className))
    }

    /// The topmost navigation graph associated with this NavController.
    ///
    /// When this is set any current navigation graph data (including back stack) will be replaced.
    public func graph(_ graph: NavGraph, _ startDestinationArgs: Bundle) {
        callVoidMethod(name: "setGraph", args: graph.signed(as: NavGraph.className), startDestinationArgs.signed(as: Bundle.className))
    }

    /// Sets the navigation graph to the specified resource. Any current navigation graph data (including back stack) will be replaced.
    ///
    /// The inflated graph can be retrieved via graph.
    public func graph(_ graphResId: Int32) {
        callVoidMethod(name: "setGraph", args: graphResId)
    }

    /// Sets the navigation graph to the specified resource. Any current navigation graph data (including back stack) will be replaced.
    ///
    /// The inflated graph can be retrieved via graph.
    public func graph(_ graphResId: Int32, _ startDestinationArgs: Bundle) {
        callVoidMethod(name: "setGraph", args: graphResId, startDestinationArgs.signed(as: Bundle.className))
    }
}