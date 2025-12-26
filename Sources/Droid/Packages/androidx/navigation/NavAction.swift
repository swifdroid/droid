//
//  NavAction.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// Navigation actions provide a level of indirection between
/// your navigation code and the underlying destinations.
///
/// This allows you to define common actions that change their destination
/// or NavOptions based on the current `NavDestination`.
/// 
/// The NavOptions associated with a `NavAction` are used by default
/// when navigating to this action via `NavController.navigate`.
/// 
/// Actions should be added via `NavDestination.putAction`.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavAction)
@MainActor
public final class NavAction: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavAction" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension NavAction {
    /// The argument SavedState to be used by default when navigating to this action.
    public func defaultArguments() -> Bundle? {
        guard
            let returningClazz = JClass.load(Bundle.className),
            let global = callObjectMethod(name: "getDefaultArguments", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// The ID of the destination that should be navigated to when this action is used
    public func destinationId() -> Int32 {
        callIntMethod(name: "getDestinationId") ?? 0
    }

    /// The NavOptions to be used by default when navigating to this action.
    public func navOptions() -> NavOptions? {
        guard
            let returningClazz = JClass.load(NavOptions.className),
            let global = callObjectMethod(name: "getNavOptions", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// The argument SavedState to be used by default when navigating to this action.
    public func defaultArguments(_ defaultArguments: Bundle) {
        callVoidMethod(name: "setDefaultArguments", args: defaultArguments.object)
    }

    /// The NavOptions to be used by default when navigating to this action.
    public func navOptions(_ navOptions: NavOptions) {
        callVoidMethod(name: "setNavOptions", args: navOptions.object)
    }
}

/// DSL for building a NavAction.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavActionBuilder)
@MainActor
public final class NavActionBuilder: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavActionBuilder" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? () {
        guard
            let clazz = JClass.load(NavActionBuilder.className),
            let global = clazz.newObject()
        else { return nil }
        self.object = global
    }
}

extension NavActionBuilder {
    // TODO: getDefaultArguments

    /// The ID of the destination that should be navigated to when this action is used
    public func destinationId() -> Int32? {
        callIntMethod(name: "getDestinationId")
    }

    // TODO: navOptions

    /// The ID of the destination that should be navigated to when this action is used
    public func destinationId(_ destinationId: Int32) -> Self {
        callVoidMethod(name: "setDestinationId", args: destinationId)
        return self
    }
}