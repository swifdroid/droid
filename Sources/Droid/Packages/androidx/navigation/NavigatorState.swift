//
//  NavigatorState.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// The NavigatorState encapsulates the state
/// shared between the Navigator and the NavController.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavigatorState)
@MainActor
public final class NavigatorState: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavigatorState" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension NavigatorState {
    // TODO: createBackStackEntry
    // TODO: getBackStack
    // TODO: getTransitionsInProgress

    /// This removes the given NavBackStackEntry from the set of the transitions in progress.
    /// This should be called in conjunction with pushWithTransition and popWithTransition
    /// as those call are responsible for adding entries to transitionsInProgress.
    /// 
    /// This should also always be called in conjunction with prepareForTransition
    /// to ensure all NavBackStackEntries settle into the proper state.
    /// 
    /// Failing to call this method could result in entries being prevented
    /// from reaching their final Lifecycle.State}.
    public func markTransitionComplete(_ backStackEntry: NavBackStackEntry) {
        callVoidMethod(
            name: "markTransitionComplete",
            args: backStackEntry.signed(as: NavBackStackEntry.className)
        )
    }

    /// Informational callback indicating that the given backStackEntry
    /// has been affected by a NavOptions.shouldLaunchSingleTop operation.
    /// 
    /// Replaces the topmost entry with same id with the new backStackEntry
    public func onLaunchSingleTop(_ backStackEntry: NavBackStackEntry) {
        callVoidMethod(
            name: "onLaunchSingleTop",
            args: backStackEntry.signed(as: NavBackStackEntry.className)
        )
    }

    /// Informational callback indicating that the given `backStackEntry`
    /// has been affected by a `NavOptions.shouldLaunchSingleTop` operation.
    ///
    /// This also adds the given and previous entry to the set of in progress transitions.
    ///
    /// Added entries have their `Lifecycle` capped at `Lifecycle.State.STARTED`
    /// until an entry is passed into the `markTransitionComplete` callback,
    /// when they are allowed to go to `Lifecycle.State.RESUMED`
    /// while previous entries have their `Lifecycle` held at `Lifecycle.State.CREATED`
    /// until an entry is passed into the `markTransitionComplete` callback,
    /// when they are allowed to go to `Lifecycle.State.DESTROYED` and have their state cleared.
    ///
    /// Replaces the topmost entry with same id with the new backStackEntry
    public func onLaunchSingleTopWithTransition(_ backStackEntry: NavBackStackEntry) {
        callVoidMethod(
            name: "onLaunchSingleTopWithTransition",
            args: backStackEntry.signed(as: NavBackStackEntry.className)
        )
    }

    /// Pop all destinations up to and including popUpTo.
    /// This will remove those destinations from the backStack,
    /// saving their state if saveState is true.
    public func pop(_ popUpTo: NavBackStackEntry, _ saveState: Bool) {
        callVoidMethod(
            name: "pop",
            args: popUpTo.signed(as: NavBackStackEntry.className),
                saveState
        )
    }

    /// Pops all destinations up to and including popUpTo.
    ///
    /// This also adds the given and incoming entry to the set of in progress transitions.
    /// Added entries have their Lifecycle held at `Lifecycle.State.CREATED`
    /// until an entry is passed into the `markTransitionComplete` callback,
    /// when they are allowed to go to `Lifecycle.State.DESTROYED` and have their state cleared.
    ///
    /// This will remove those destinations from the backStack, saving their state if saveState is true.
    public func popWithTransition(_ popUpTo: NavBackStackEntry, _ saveState: Bool) {
        callVoidMethod(
            name: "popWithTransition",
            args: popUpTo.signed(as: NavBackStackEntry.className),
                saveState
        )
    }

    /// This prepares the given `NavBackStackEntry` for transition.
    ///
    /// This should be called in conjunction with `markTransitionComplete`
    /// as that is responsible for settling the `NavBackStackEntry` into its final state.
    public func prepareForTransition(_ entry: NavBackStackEntry) {
        callVoidMethod(
            name: "prepareForTransition",
            args: entry.signed(as: NavBackStackEntry.className)
        )
    }

    /// Adds the given `backStackEntry` to the backStack.
    public func push(_ backStackEntry: NavBackStackEntry) {
        callVoidMethod(
            name: "push",
            args: backStackEntry.signed(as: NavBackStackEntry.className)
        )
    }

    /// Adds the given `backStackEntry` to the `backStack`.
    ///
    /// This also adds the given and previous entry to the set of in progress transitions.
    ///
    /// Added entries have their `Lifecycle` capped at `Lifecycle.State.STARTED`
    /// until an entry is passed into the `markTransitionComplete` callback,
    /// when they are allowed to go to `Lifecycle.State.RESUMED`.
    public func pushWithTransition(_ backStackEntry: NavBackStackEntry) {
        callVoidMethod(
            name: "pushWithTransition",
            args: backStackEntry.signed(as: NavBackStackEntry.className)
        )
    }
}