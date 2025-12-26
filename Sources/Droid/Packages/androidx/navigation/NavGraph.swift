//
//  NavGraph.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// NavGraph is a collection of NavDestination nodes fetchable by ID.
///
/// A NavGraph serves as a 'virtual' destination: while the NavGraph itself
/// will not appear on the back stack, navigating to the NavGraph
/// will cause the getStartDestination to be added to the back stack.
/// 
/// Construct a new NavGraph. This NavGraph is not valid until you add
/// a destination and set the starting destination.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavGraph)
@MainActor
public final class NavGraph: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavGraph" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? (_ navGraphNavigator: Navigator) {
        guard
            let clazz = JClass.load(NavGraph.className),
            let global = clazz.newObject(args: navGraphNavigator.signed(as: Navigator.className))
        else { return nil }
        self.object = global
    }
}

extension NavGraph {
    /// Add all destinations from another collection to this one.
    /// As each destination has at most one parent,
    /// the destinations will be removed from the given NavGraph.
    public func addAll(_ other: NavGraph) {
        callVoidMethod(name: "addAll", args: other.signed(as: NavGraph.className))
    }

    /// Adds a destination to this NavGraph.
    /// The destination must have an NavDestination.id id} set.
    ///
    /// The destination must not have a parent set.
    /// If the destination is already part of a navigation graph, call remove before calling this method.
    public func addDestination(_ node: NavDestination) {
        callVoidMethod(name: "addDestination", args: node.signed(as: NavDestination.className))
    }

    // TODO: addDestinations

    /// Clear all destinations from this navigation graph.
    public func clear() {
        callVoidMethod(name: "clear")
    }

    /// Finds a destination in the collection by route from KClass.
    /// This will recursively check the parent of this navigation graph
    /// if node is not found in this navigation graph.
    public func findNode() -> NavDestination? {
        guard
            let returningClazz = JClass.load(NavDestination.className),
            let global = object.callObjectMethod(name: "findNode", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Finds a destination in the collection by route from KClass.
    /// This will recursively check the parent of this navigation graph
    /// if node is not found in this navigation graph.
    public func findNode(_ resId: Int32) -> NavDestination? {
        guard
            let returningClazz = JClass.load(NavDestination.className),
            let global = object.callObjectMethod(
                name: "findNode",
                args: resId,
                returningClass: returningClazz
            )
        else { return nil }
        return .init(global)
    }

    /// Finds a destination in the collection by route.
    /// This will recursively check the parent of this navigation graph
    /// if node is not found in this navigation graph.
    public func findNode(_ route: String) -> NavDestination? {
        guard
            let returningClazz = JClass.load(NavDestination.className),
            let global = object.callObjectMethod(
                name: "findNode",
                args: route,
                returningClass: returningClazz
            )
        else { return nil }
        return .init(global)
    }

    /// Searches all children and parents recursively.
    ///
    /// Does not revisit graphs (whether it's a child or parent) if it has already been visited.
    public func findNodeComprehensive(
        _ resId: Int32,
        _ lastVisited: NavDestination,
        _ searchChildren: Bool,
        _ matchingDest: NavDestination
    ) -> NavDestination? {
        guard
            let returningClazz = JClass.load(NavDestination.className),
            let global = object.callObjectMethod(
                name: "findNodeComprehensive",
                args: resId,
                    lastVisited.signed(as: NavDestination.className),
                    searchChildren,
                    matchingDest.signed(as: NavDestination.className),
                    returningClass: returningClazz
            )
        else { return nil }
        return .init(global)
    }

    /// Finds the actual start destination of the graph,
    /// handling cases where the graph's starting destination is itself a NavGraph.
    public func findStartDestination(_ receiver: NavGraph) -> NavDestination? {
        guard
            let returningClazz = JClass.load(NavDestination.className),
            let global = object.callObjectMethod(
                name: "findStartDestination",
                args: receiver.signed(as: NavGraph.className),
                returningClass: returningClazz
            )
        else { return nil }
        return .init(global)
    }

    /// The display name of this NavGraph.
    public func displayName() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = object.callObjectMethod(name: "getDisplayName", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// The display name of the starting destination for this NavGraph.
    public func startDestDisplayName() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = object.callObjectMethod(name: "getStartDestDisplayName", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// The starting destination id for this NavGraph.
    /// When navigating to the NavGraph, the destination represented
    /// by this id is the one the user will initially see.
    public func startDestinationId() -> Int32 {
        callIntMethod(name: "getStartDestinationId") ?? 0
    }

    /// The route for the starting destination for this NavGraph.
    /// When navigating to the NavGraph, the destination represented
    /// by this route is the one the user will initially see.
    public func startDestinationRoute() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = object.callObjectMethod(name: "getStartDestinationRoute", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    // TODO: iterator

    /// Remove a given destination from this NavGraph
    public func remove(_ node: NavDestination) {
        callVoidMethod(name: "remove", args: node.signed(as: NavDestination.className))
    }

    /// Sets the starting destination for this NavGraph.
    ///
    /// This will override any previously set startDestinationId.
    public func startDestination() {
        callVoidMethod(name: "setStartDestination")
    }

    /// Sets the starting destination for this NavGraph.
    ///
    /// This will override any previously set startDestinationId.
    public func startDestination(_ resId: Int32) {
        callVoidMethod(name: "setStartDestination", args: resId)
    }

    /// Sets the starting destination for this NavGraph.
    ///
    /// This will override any previously set startDestinationId.
    public func startDestination(_ startDestRoute: String) {
        callVoidMethod(name: "setStartDestination", args: startDestRoute)
    }

    /// Returns true if a destination with id is found in this navigation graph.
    public func contains(_ receiver: NavGraph, _ id: Int32) -> Bool {
        callBoolMethod(
            name: "contains",
            args: receiver.signed(as: NavGraph.className),
                id
        ) ?? false
    }

    /// Returns true if a destination with route is found in this navigation graph.
    public func contains(_ receiver: NavGraph, _ route: String) -> Bool {
        callBoolMethod(
            name: "contains",
            args: receiver.signed(as: NavGraph.className),
                route
        ) ?? false
    }

    /// Returns the destination with id.
    public func get(_ receiver: NavGraph, _ id: Int32) -> Bool {
        callBoolMethod(
            name: "get",
            args: receiver.signed(as: NavGraph.className), id
        ) ?? false
    }

    /// Returns the destination with route.
    public func get(_ receiver: NavGraph, _ route: String) -> Bool {
        callBoolMethod(
            name: "get",
            args: receiver.signed(as: NavGraph.className), route
        ) ?? false
    }

    /// Removes node from this navigation graph.
    public func minusAssign(_ receiver: NavGraph, _ node: NavDestination) {
        callVoidMethod(
            name: "minusAssign",
            args: receiver.signed(as: NavGraph.className),
                node.signed(as: NavDestination.className)
        )
    }

    /// Adds a destination to this NavGraph.
    /// The destination must have an id set.
    ///
    /// The destination must not have a parent set.
    /// If the destination is already part of a NavGraph,
    /// call NavGraph.remove before calling this method.
    public func plusAssign(_ receiver: NavGraph, _ node: NavDestination) {
        callVoidMethod(
            name: "plusAssign",
            args: receiver.signed(as: NavGraph.className),
                node.signed(as: NavDestination.className)
        )
    }

    /// Add all destinations from another collection to this one.
    /// As each destination has at most one parent,
    /// the destinations will be removed from the given NavGraph.
    public func plusAssign(_ receiver: NavGraph, _ other: NavGraph) {
        callVoidMethod(
            name: "plusAssign",
            args: receiver.signed(as: NavGraph.className),
                other.signed(as: NavGraph.className)
        )
    }
}

/// DSL for constructing a new NavGraph
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavGraphBuilder)
@MainActor
public final class NavGraphBuilder: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavGraphBuilder" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    /// DSL for constructing a new NavGraph
    ///
    /// Parameters:
    ///  - provider: navigator used to create the destination
    ///  - startDestination: the starting destination's route for this NavGraph
    ///  - route: the graph's unique route
    public init? (_ provider: NavigatorProvider, _ startDestination: String, _ route: String) {
        guard
            let clazz = JClass.load(NavGraphBuilder.className),
            let global = clazz.newObject(args: provider.signed(as: NavigatorProvider.className), startDestination, route)
        else { return nil }
        self.object = global
    }
}

extension NavGraphBuilder {
    /// Add the destination to the NavGraphBuilder
    public func addDestination(_ destination: NavDestination) {
        callVoidMethod(name: "addDestination", args: destination.signed(as: NavDestination.className))
    }

    /// Build the NavDestination by calling Navigator.createDestination.
    public func build() -> NavGraph? {
        guard
            let returningClazz = JClass.load(NavGraph.className),
            let global = object.callObjectMethod(name: "build", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Build and add a new destination to the NavGraphBuilder
    public func destination(_ navDestination: NavDestinationBuilder) -> NavDestination? {
        guard
            let returningClazz = JClass.load(NavDestination.className),
            let global = object.callObjectMethod(
                name: "destination",
                args: navDestination.signed(as: NavDestinationBuilder.className),
                returningClass: returningClazz
            )
        else { return nil }
        return .init(global)
    }

    /// The NavGraphBuilder's NavigatorProvider.
    public func provider() -> NavigatorProvider? {
        guard
            let returningClazz = JClass.load(NavigatorProvider.className),
            let global = object.callObjectMethod(name: "getProvider", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Adds this destination to the NavGraphBuilder
    public func unaryPlus(_ receiver: NavDestination) {
        callVoidMethod(
            name: "unaryPlus",
            args: receiver.signed(as: NavDestination.className)
        )
    }

    /// Construct a new DialogFragmentNavigator.Destination
    public func dialog(
        _ receiver: NavGraphBuilder,
        _ route: String,
        _ context: Contextable
    ) -> DialogFragment? {
        guard
            let returningClazz = JClass.load(DialogFragment.className),
            let global = object.callObjectMethod(
                name: "dialog",
                args: receiver.signed(as: NavGraphBuilder.className), route,
                returningClass: returningClazz
            )
        else { return nil }
        return .init(global)
    }

    /// Construct a new FragmentNavigator.Destination
    public func fragment(
        _ receiver: NavGraphBuilder,
        _ route: String,
        _ context: Contextable
    ) -> Fragment? {
        guard
            let returningClazz = JClass.load(DialogFragment.className),
            let global = object.callObjectMethod(
                name: "dialog",
                args: receiver.signed(as: NavGraphBuilder.className),
                    route,
                returningClass: returningClazz
            )
        else { return nil }
        return .init(global)
    }
}