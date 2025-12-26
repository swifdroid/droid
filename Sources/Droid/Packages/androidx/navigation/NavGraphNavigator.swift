//
//  NavGraphNavigator.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// A Navigator built specifically for NavGraph elements.
/// Handles navigating to the correct destination when
/// the NavGraph is the target of navigation actions.
///
/// Construct a Navigator capable of routing incoming navigation requests
/// to the proper destination within a NavGraph.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavGraphNavigator)
@MainActor
public final class NavGraphNavigator: Navigator, @unchecked Sendable {
    public override class var className: JClassName { "androidx/navigation/NavGraphNavigator" }

    /// Base Droid constructor with existing JNI object
    public required init (_ object: JObject) {
        super.init(object)
    }

    public init? (_ navigatorProvider: NavigatorProvider) {
        guard
            let clazz = JClass.load(NavGraphNavigator.className),
            let global = clazz.newObject(args: navigatorProvider.signed(as: NavigatorProvider.className))
        else { return nil }
        super.init(global)
    }
}

extension NavGraphNavigator {
    /// Creates a new NavGraph associated with this navigator.
    public func createDestination() -> NavGraph? {
        guard
            let returningClazz = JClass.load(NavGraph.className),
            let global = object.callObjectMethod(name: "createDestination", returningClass: returningClazz)
        else { return nil }
        return NavGraph(global)
    }

    // TODO: getBackStack

    // TODO: navigate
}