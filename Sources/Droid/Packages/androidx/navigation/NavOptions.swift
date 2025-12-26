//
//  NavOptions.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// NavOptions stores special options for navigate actions
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavOptions)
@MainActor
public final class NavOptions: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavOptions" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension NavOptions {
    /// The custom enter Animation/Animator that should be run.
    public func enterAnim() -> Int32? {
        callIntMethod(name: "getEnterAnim")
    }

    /// The custom exit Animation/Animator that should be run.
    public func exitAnim() -> Int32? {
        callIntMethod(name: "getExitAnim")
    }

    /// The custom enter Animation/Animator that should be run
    /// when this destination is popped from the back stack.
    public func popEnterAnim() -> Int32? {
        callIntMethod(name: "getPopEnterAnim")
    }

    /// The custom exit Animation/Animator that should be run
    /// when this destination is popped from the back stack.
    public func popExitAnim() -> Int32? {
        callIntMethod(name: "getPopExitAnim")
    }

    /// The destination to pop up to before navigating.
    /// When set, all non-matching destinations should be popped from the back stack.
    public func popUpToId() -> Int32? {
        callIntMethod(name: "getPopUpTo")
    }

    /// Route for the destination to pop up to before navigating.
    /// When set, all non-matching destinations should be popped from the back stack.
    public func popUpToRoute() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getPopUpToRoute", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// Route from an Object for the destination to pop up to before navigating.
    /// When set, all non-matching destinations should be popped from the back stack.
    public func popUpToRouteObject() -> JObject? {
        guard
            let clazz = JClass.load("java/lang/Object"),
            let global = callObjectMethod(name: "getPopUpToRoute", returningClass: clazz)
        else { return nil }
        return global
    }

    /// Whether the destination set in `popUpToRoute` should be popped from the back stack.
    public func isPopUpToInclusive() -> Bool {
        callBoolMethod(name: "isPopUpToInclusive") ?? false
    }

    /// Whether this navigation action should launch as single-top
    /// (i.e., there will be at most one copy of a given destination on the top of the back stack).
    ///
    /// This functions similarly to how
    /// `android.content.Intent.FLAG_ACTIVITY_SINGLE_TOP` works with activities.
    public func shouldLaunchSingleTop() -> Bool {
        callBoolMethod(name: "shouldLaunchSingleTop") ?? false
    }

    /// Whether the back stack and the state of all destinations between the current destination
    /// and popUpToRoute should be saved for later restoration
    /// via Builder.setRestoreState or the restoreState attribute using the same ID
    /// as popUpToRoute (note: this matching ID is true if isPopUpToInclusive is true.
    /// If isPopUpToInclusive is false, this matching ID is the id of the last destination that is popped).
    public func shouldPopUpToSaveState() -> Bool {
        callBoolMethod(name: "shouldPopUpToSaveState") ?? false
    }

    /// Whether this navigation action should restore any state previously saved
    /// by Builder.setPopUpTo or the popUpToSaveState attribute.
    public func shouldRestoreState() -> Bool {
        callBoolMethod(name: "shouldRestoreState") ?? false
    }

    /// Builder for constructing new instances of NavOptions.
    ///
    /// [Learn more](https://developer.android.com/reference/androidx/navigation/NavOptions.Builder)
    @MainActor
    public final class Builder: JObjectable, @unchecked Sendable {
        public class var className: JClassName { "androidx/navigation/NavOptions$Builder" }

        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }

        public init? () {
            guard
                let clazz = JClass.load(Builder.className),
                let global = clazz.newObject()
            else { return nil }
            self.object = global
        }

        public func build() -> NavOptions? {
            guard
                let returningClazz = JClass.load(NavOptions.className),
                let global = callObjectMethod(name: "build", returningClass: returningClazz)
            else { return nil }
            return .init(global)
        }

        /// Sets a custom Animation or Animator resource for the enter animation.
        ///
        /// Note: Animator resources are not supported for navigating to a new Activity
        public func enterAnim(_ enterAnim: Int32) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = callObjectMethod(name: "setEnterAnim", args: enterAnim, returningClass: clazz)
            return self
        }

        /// Sets a custom Animation or Animator resource for the exit animation.
        ///
        /// Note: Animator resources are not supported for navigating to a new Activity
        public func exitAnim(_ exitAnim: Int32) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = callObjectMethod(name: "setExitAnim", args: exitAnim, returningClass: clazz)
            return self
        }

        /// Launch a navigation target as single-top if you are making a lateral navigation
        /// between instances of the same target (e.g. detail pages about similar data items)
        /// that should not preserve history.
        public func launchSingleTop(_ singleTop: Bool) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = callObjectMethod(name: "setLaunchSingleTop", args: singleTop, returningClass: clazz)
            return self
        }

        /// Sets a custom Animation or Animator resource for the enter animation
        /// when popping off the back stack.
        ///
        /// Note: Animator resources are not supported for navigating to a new Activity
        public func popEnterAnim(_ popEnterAnim: Int32) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = callObjectMethod(name: "setPopEnterAnim", args: popEnterAnim, returningClass: clazz)
            return self
        }

        /// Sets a custom Animation or Animator resource for
        /// the exit animation when popping off the back stack.
        ///
        /// Note: Animator resources are not supported for navigating to a new Activity    
        public func popExitAnim(_ popExitAnim: Int32) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = callObjectMethod(name: "setPopExitAnim", args: popExitAnim, returningClass: clazz)
            return self
        }

        /// Pop up to a given destination before navigating.
        /// This pops all non-matching destinations from the back stack until this destination is found.
        public func popUpTo(_ inclusive: Bool, _ saveState: Bool) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = callObjectMethod(name: "setPopUpTo", args: inclusive, saveState, returningClass: clazz)
            return self
        }

        /// Pop up to a given destination before navigating.
        /// This pops all non-matching destinations from the back stack until this destination is found.
        public func popUpTo(_ destinationId: Int32, _ inclusive: Bool, _ saveState: Bool) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = callObjectMethod(name: "setPopUpTo", args: destinationId, inclusive, saveState, returningClass: clazz)
            return self
        }

        /// Pop up to a given destination before navigating.
        /// This pops all non-matching destinations from the back stack until this destination is found.
        public func popUpTo(_ route: String, _ inclusive: Bool, _ saveState: Bool) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = callObjectMethod(name: "setPopUpTo", args: route, inclusive, saveState, returningClass: clazz)
            return self
        }

        /// Whether this navigation action should restore any state previously saved
        /// by setPopUpTo or the popUpToSaveState attribute.
        /// If no state was previously saved with the destination ID being navigated to, this has no effect.
        public func restoreState(_ restoreState: Bool) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = callObjectMethod(name: "setRestoreState", args: restoreState, returningClass: clazz)
            return self
        }
    }
}