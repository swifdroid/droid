//
//  NavDestination.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// NavDestination represents one node within an overall navigation graph.
/// 
/// Each destination is associated with a Navigator which knows how
/// to navigate to this particular destination.
/// 
/// Destinations declare a set of putAction that they support.
/// These actions form a navigation API for the destination;
/// the same actions declared on different destinations that fill similar
/// roles allow application code to navigate based on semantic intent.
/// 
/// Each destination has a set of arguments that will be applied
/// when navigating to that destination. Any default values for those
/// arguments can be overridden at the time of navigation.
/// 
/// NavDestinations should be created via Navigator.createDestination.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavDestination)
@MainActor
public final class NavDestination: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavDestination" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? (_ navigatorName: String) {
        guard
            let clazz = JClass.load(NavDestination.className),
            let global = clazz.newObject(args: navigatorName)
        else { return nil }
        self.object = global
    }

    /// NavDestinations should be created via Navigator.createDestination.
    ///
    /// This constructor requires that the given Navigator has a Navigator.Name annotation.
    public init? (_ navigator: Navigator) {
        guard
            let clazz = JClass.load(NavDestination.className),
            let global = clazz.newObject(args: navigator.signed(as: Navigator.className))
        else { return nil }
        self.object = global
    }
}

extension NavDestination {
    /// Sets an argument type for an argument name
    public func addArgument(_ argName: String, _ argument: NavArgument) {
        callVoidMethod(name: "addArgument", args: argName, argument.object)
    }

    /// Add a deep link to this destination. Uris that match the given NavDeepLink uri
    /// sent to NavController.handleDeepLink or NavController.navigate
    /// will trigger navigating to this destination.
    /// 
    /// In addition to a direct Uri match, the following features are supported:
    /// 
    /// Uris without a scheme are assumed as http and https. For example,
    /// www.example.com will match http://www.example.com
    /// and https://www.example.com. Placeholders in the form
    /// of {placeholder_name} matches 1 or more characters.
    /// The String value of the placeholder will be available in the arguments SavedState
    /// with a key of the same name. For example, http://www.example.com/users/{id}
    /// will match http://www.example.com/users/4. The .* wildcard can be used
    /// to match 0 or more characters.
    /// 
    /// These Uris can be declared in your navigation XML files by adding one
    /// or more <deepLink app:uri="uriPattern" /> elements as a child to your destination.
    /// 
    /// Custom actions and mimetypes are also supported by NavDeepLink
    /// and can be declared in your navigation XML files
    /// by adding <app:action="android.intent.action.SOME_ACTION" />
    /// or <app:mimetype="type/subtype" /> as part of your deepLink declaration.
    /// 
    /// Deep link Uris, actions, and mimetypes added in navigation XML files
    /// will automatically replace instances of ${applicationId} with the applicationId of your app.
    /// Programmatically added deep links should use Context.getPackageName directly
    /// when constructing the uriPattern.
    /// 
    /// When matching deep links for calls to NavController.handleDeepLink
    /// or NavController.navigate the order of precedence is as follows:
    /// the deep link with the most matching arguments will be chosen,
    /// followed by the deep link with a matching action, followed
    /// by the best matching mimeType (e.i. when matching mimeType image/jpg: image/ * *\/jpg *\/ *).
    public func addDeepLink(_ navDeepLink: NavDeepLink) {
        callVoidMethod(name: "addDeepLink", args: navDeepLink.object)
    }

    /// Add a deep link to this destination. Matching Uris sent
    /// to NavController.handleDeepLink or NavController.navigate
    /// will trigger navigating to this destination.
    /// 
    /// In addition to a direct Uri match, the following features are supported:
    /// 
    /// Uris without a scheme are assumed as http and https.
    /// For example, www.example.com will match http://www.example.com
    /// and https://www.example.com.
    /// Placeholders in the form of {placeholder_name} matches 1 or more characters.
    /// The parsed value of the placeholder will be available in the arguments SavedState
    /// with a key of the same name. For example, http://www.example.com/users/{id}
    /// will match http://www.example.com/users/4.
    /// The .* wildcard can be used to match 0 or more characters.
    /// These Uris can be declared in your navigation XML files by adding one
    /// or more <deepLink app:uri="uriPattern" /> elements as a child to your destination.
    /// 
    /// Deep links added in navigation XML files will automatically replace instances
    /// of ${applicationId} with the applicationId of your app.
    /// Programmatically added deep links should use Context.getPackageName
    /// directly when constructing the uriPattern.
    public func addDeepLink(_ uriPattern: String) {
        callVoidMethod(name: "addDeepLink", args: uriPattern)
    }

    /// Parses a dynamic label containing arguments into a String.
    /// 
    /// Supports String Resource arguments by parsing R.string values
    /// of ReferenceType arguments found in android:label into their String values.
    /// 
    /// Returns null if label is null.
    /// 
    /// Returns the original label if the label was a static string.
    public func fillInLabel(_ context: ActivityContext, _ bundle: Bundle) -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "fillInLabel", args: context.signed(as: .android.content.Context), bundle.signed(as: Bundle.className), returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// Returns the NavAction for the given action ID.
    /// This will recursively check the getParent of this destination
    /// if the action destination is not found in this destination.
    public func action(_ actionId: Int32) -> NavAction? {
        guard
            let returningClazz = JClass.load(NavAction.className),
            let global = callObjectMethod(name: "getAction", args: actionId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    // TODO: getArguments

    /// The human readable name of this destination.
    public func displayName() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getDisplayName", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }
    
    // TODO: getHierarchy

    /// The destination's unique ID. This should be an ID resource
    /// generated by the Android resource system.
    ///
    /// If using safe args, setting this manually will override the ID
    /// that was set based on route from KClass.
    public func id() -> Int32 {
        callIntMethod(name: "getId") ?? 0
    }

    /// The descriptive label of this destination.
    public func label() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.CharSequence),
            let global = callObjectMethod(name: "getLabel", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// The name associated with this destination's Navigator.
    public func navigatorName() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getNavigatorName", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// Gets the NavGraph that contains this destination.
    /// This will be set when a destination is added to a NavGraph via NavGraph.addDestination.
    public func parent() -> NavGraph? {
        guard
            let returningClazz = JClass.load(NavGraph.className),
            let global = callObjectMethod(name: "getParent", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// The destination's unique route.
    /// Setting this will also update the id of the destinations
    /// so custom destination ids should only be set after setting the route.
    public func route() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getRoute", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// Checks the given deep link NavUri, and determines whether
    /// it matches a Uri pattern added to the destination by a call to addDeepLink.
    /// It returns true if the deep link is a valid match, and false otherwise.
    ///
    /// This should be called prior to NavController.navigate to ensure the deep link can be navigated to.
    public func hasDeepLink(_ deepLink: NavUri) -> Bool {
        callBoolMethod(name: "hasDeepLink", args: deepLink.object) ?? false
    }

    /// Checks the given deep link NavDeepLinkRequest, and determines whether
    /// it matches a Uri pattern added to the destination by a call to addDeepLink.
    /// It returns true if the deep link is a valid match, and false otherwise.
    ///
    /// This should be called prior to NavController.navigate to ensure the deep link can be navigated to.
    public func hasDeepLink(_ deepLinkRequest: NavDeepLinkRequest) -> Bool {
        callBoolMethod(name: "hasDeepLink", args: deepLinkRequest.object) ?? false
    }

    /// Checks if the NavDestination's route was generated from T
    ///
    /// Returns true if equal, false otherwise.he given NavDestination's route.
    public func hasRoute(_ receiver: NavDestination) -> Bool {
        callBoolMethod(name: "hasRoute", args: receiver.object) ?? false
    }

    /// Sets the NavAction destination for an action ID.
    public func putAction(_ actionId: Int32, _ navAction: NavAction) {
        callVoidMethod(name: "putAction", args: actionId, navAction.object)
    }

    /// Creates a NavAction for the given destId and associates it with the actionId.
    public func putAction(_ actionId: Int32, _ destinationId: Int32) {
        callVoidMethod(name: "putAction", args: actionId, destinationId)
    }

    /// Unsets the NavAction for an action ID.
    public func removeAction(_ actionId: Int32) {
        callVoidMethod(name: "removeAction", args: actionId)
    }

    /// Unsets the argument type for an argument name.
    public func removeArgument(_ argName: String) {
        callVoidMethod(name: "removeArgument", args: argName)
    }

    /// The destination's unique ID. This should be an ID resource generated by the Android resource system.
    ///
    /// If using safe args, setting this manually will override the ID that was set based on route from KClass.
    @discardableResult
    public func id(_ id: Int32) -> Self {
        callVoidMethod(name: "setId", args: id)
        return self
    }

    /// Sets the class name associated with this destination's Navigator.
    @discardableResult
    public func className<T>(_ type: T.Type) -> Self where T: Fragmentable {
        guard let clazz = JClass.load(FragmentNavigator.Destination.className) else { return self }
        _ = self.cast(to: FragmentNavigator.Destination.className)?.callObjectMethod(name: "setClassName", args: type.nativeFragmentClassName.fullName, returningClass: clazz)
        return self
    }

    /// The descriptive label of this destination.
    @discardableResult
    public func label(_ label: String) -> Self {
        callVoidMethod(name: "setLabel", args: label.signedAsCharSequence())
        return self
    }

    /// Gets the NavGraph that contains this destination.
    /// This will be set when a destination is added to a NavGraph via NavGraph.addDestination.
    @discardableResult
    public func parent(_ parent: NavGraph) -> Self {
        callVoidMethod(name: "setParent", args: parent.signed(as: NavGraph.className))
        return self
    }

    /// The destination's unique route.
    /// Setting this will also update the id of the destinations
    /// so custom destination ids should only be set after setting the route.
    @discardableResult
    public func route(_ route: String) -> Self {
        callVoidMethod(name: "setRoute", args: route)
        return self
    }

    // TODO: NavDestination.Companion
}

///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavDestinationBuilder)
@MainActor
public final class NavDestinationBuilder: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavDestinationBuilder" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    /// DSL for constructing a new NavDestination with a unique route.
    ///
    /// This will also update the id of the destination based on route.
    public init? (_ navigator: Navigator, _ route: String) {
        guard
            let clazz = JClass.load(NavDestinationBuilder.className),
            let global = clazz.newObject(args: navigator.signed(as: Navigator.className), route)
        else { return nil }
        self.object = global
    }
}

extension NavDestinationBuilder {
    /// Add a NavArgument to this destination.
    public func argument(_ name: String, _ argument: NavArgument) {
        callVoidMethod(name: "argument", args: name, argument.signed(as: NavArgument.className))
    }

    /// Build the NavDestination by calling Navigator.createDestination.
    public func build() -> NavDestination? {
        guard
            let returningClazz = JClass.load(NavDestination.className),
            let global = callObjectMethod(name: "build", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Add a deep link to this destination.
    /// 
    /// In addition to a direct Uri match, the following features are supported:
    /// 
    /// Uris without a scheme are assumed as http and https.
    /// For example, www.example.com will match http://www.example.com and https://www.example.com.
    /// Placeholders in the form of {placeholder_name} matches 1 or more characters.
    /// The String value of the placeholder will be available in the arguments SavedState
    /// with a key of the same name. For example, http://www.example.com/users/{id}
    /// will match http://www.example.com/users/4.
    /// The .* wildcard can be used to match 0 or more characters.
    public func deepLink(_ navDeepLink: NavDeepLink) {
        callVoidMethod(name: "deepLink", args: navDeepLink.signed(as: NavDeepLink.className))
    }

    /// Add a deep link to this destination.
    /// 
    /// The arguments in T are expected to be identical (in name and type)
    /// to the arguments in the route from KClass that was used to construct this NavDestinationBuilder.
    /// 
    /// Extracts deeplink arguments from T and appends it to the basePath.
    /// See docs on the safe args version of NavDeepLink.Builder.setUriPattern
    /// for the final uriPattern's generation logic.
    /// 
    /// In addition to a direct Uri match, basePaths without a scheme are assumed
    /// as http and https. For example, www.example.com will match http://www.example.com
    /// and https://www.example.com.
    public func deepLinkSafeArgs(_ basePath: String) {
        callVoidMethod(name: "deepLinkSafeArgs", args: basePath)
    }

    /// The destination's unique ID.
    public func id() -> Int32 {
        callIntMethod(name: "getId") ?? 0
    }

    /// The descriptive label of the destination
    public func label() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.CharSequence),
            let global = callObjectMethod(name: "getLabel", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// The destination's unique route.
    public func route() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getRoute", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// The descriptive label of the destination
    public func label(_ label: String) {
        callVoidMethod(name: "setLabel", args: label.signedAsCharSequence())
    }

    /// The navigator the destination that will be used in instantiateDestination to create the destination.
    public func navigator() -> Navigator? {
        guard
            let returningClazz = JClass.load(Navigator.className),
            let global = callObjectMethod(name: "getNavigator", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }
}