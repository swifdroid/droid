//
//  Navigator.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

public typealias NavUri = Uri

@MainActor
public protocol Navigatorable: JObjectable {
    static var className: JClassName { get }
    init (_ object: JObject)
}

/// Navigator defines a mechanism for navigating within an app.
/// 
/// Each Navigator sets the policy for a specific type of navigation,
/// e.g. `ActivityNavigator` knows how to launch into destinations
/// backed by activities using `Context.startActivity`.
/// 
/// Navigators should be able to manage their own back stack when
/// navigating between two destinations that belong to that navigator.
/// The `NavController` manages a back stack of navigators representing
/// the current navigation stack across all navigators.
/// 
/// Each `Navigator` should add the `Navigator.Name` annotation to their class.
/// Any custom attributes used by the associated destination subclass should have
/// a name corresponding with the name of the `Navigator`,
/// e.g., `ActivityNavigator` uses `<declare-styleable name="ActivityNavigator">`
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/Navigator)
open class Navigator: Navigatorable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/Navigator" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    required public init (_ object: JObject) {
        self.object = object
    }
}

extension Navigator {
    /// Construct a new NavDestination associated with this Navigator.
    ///
    /// Any initialization of the destination should be done in the destination's
    /// constructor as it is not guaranteed that every destination
    /// will be created through this method.
    public func createDestination() -> NavDestination? {
        guard
            let clazz = JClass.load(NavDestination.className),
            let global = callObjectMethod(
                name: "createDestination",
                returningClass: clazz
            )
        else { return nil }
        return NavDestination(global)
    }
    
    /// Whether this `Navigator` is actively being used by a `NavController`.
    ///
    /// This is set to `true` when `onAttach` is called.
    public func isAttached() -> Bool {
        callBoolMethod(name: "isAttached") ?? false
    }

    // TODO: navigate
    // TODO: onAttach
    
    /// Informational callback indicating that the given `backStackEntry`
    /// has been affected by a `NavOptions.shouldLaunchSingleTop` operation.
    /// The entry provided is a new NavBackStackEntry instance
    /// with all the previous state of the old entry and possibly new arguments.
    public func onLaunchSingleTop(_ backStackEntry: NavBackStackEntry) {
        callVoidMethod(name: "onLaunchSingleTop", args: backStackEntry.signed(as: NavBackStackEntry.className))
    }

    // TODO: onRestoreState
    // TODO: onSaveState

    /// Attempt to pop this navigator's back stack, performing the appropriate navigation.
    ///
    /// Implementations should return `true` if navigation was successful.
    ///
    /// Implementations should return `false` if navigation could not be performed,
    /// for example if the navigator's back stack was empty.
    public func popBackStack() -> Bool {
        callBoolMethod(name: "popBackStack") ?? false
    }

    // TODO: popBackStack (extended)

    /// The state of the `Navigator` is the communication conduit
    /// between the `Navigator` and the `NavController` that has called `onAttach`.
    ///
    /// It is the responsibility of the `Navigator` to call `NavigatorState.push`
    /// and `NavigatorState.pop` to in order
    /// to update the `NavigatorState.backStack` at the appropriate times.
    public func state() -> NavigatorState? {
        guard
            let clazz = JClass.load(NavigatorState.className),
            let global = callObjectMethod(
                name: "getState",
                returningClass: clazz
            )
        else { return nil }
        return NavigatorState(global)
    }
}

extension Navigator {
    /// Interface indicating that this class should be passed
    /// to its respective Navigator to enable Navigator specific behavior.
    ///
    /// [Learn more](https://developer.android.com/reference/androidx/navigation/Navigator.Extras)
    @MainActor
    public final class Extras: JObjectable, @unchecked Sendable {
        public class var className: JClassName { "androidx/navigation/Navigator$Extras" }

        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }
    }
}