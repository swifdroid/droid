//
//  Navigation.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// Entry point for navigation operations.
///
/// This class provides utilities for finding a relevant NavController instance
/// from various common places in your application,
/// or for performing navigation in response to UI events.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/Navigation)
@MainActor
public final class Navigation: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/Navigation" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? (_ context: ActivityContext) {
        guard
            let clazz = JClass.load(Navigation.className),
            let global = clazz.newObject(args: context.signed(as: "android/content/Context"))
        else { return nil }
        self.object = global
    }
}

extension Navigation {
    /// Create an android.view.View.OnClickListener for navigating
    /// to a destination via a generated NavDirections.
    public func createNavigateOnClickListener(_ directions: NavDirections) -> JObject? {
        guard
            let clazz = JClass.load("android/view/View$OnClickListener"),
            let global = callObjectMethod(
                name: "createNavigateOnClickListener",
                args: directions.object,
                returningClass: clazz
            )
        else { return nil }
        return global
    }

    /// Create an android.view.View.OnClickListener for navigating to a destination.
    /// This supports both navigating via an action and directly navigating to a destination.
    public func createNavigateOnClickListener(_ resId: Int32, _ args: Bundle) -> JObject? {
         guard
            let clazz = JClass.load("android/view/View$OnClickListener"),
            let global = callObjectMethod(
                name: "createNavigateOnClickListener",
                args: resId, args.signed(as: Bundle.className),
                returningClass: clazz
            )
        else { return nil }
        return global
    }

    /// Find a NavController given a local View.
    /// 
    /// This method will locate the NavController associated with this view.
    /// This is automatically populated for views that are managed by a NavHost
    /// and is intended for use by various listener interfaces.
    public func findNavController(_ view: View) -> NavController? {
        guard
            let returningClazz = JClass.load(NavController.className),
            let instance = view.instance,
            let global = callObjectMethod(
                name: "findNavController",
                args: instance.signed(as: "android/view/View"),
                returningClass: returningClazz
            )
        else { return nil }
        return NavController(global)
    }

    /// Find a NavController given the id of a View and its containing Activity.
    /// This is a convenience wrapper around findNavController.
    ///
    /// This method will locate the NavController associated with this view.
    /// This is automatically populated for the id of a NavHost and its children.
    public func findNavController(_ context: ActivityContext, _ viewId: Int32) -> NavController? {
        guard
            let returningClazz = JClass.load(NavController.className),
            let global = callObjectMethod(
                name: "findNavController",
                args: context.signed(as: "android/content/Context"), viewId,
                returningClass: returningClazz
            )
        else { return nil }
        return NavController(global)
    }

    /// Associates a NavController with the given View, allowing developers
    /// to use findNavController and findNavController with that View
    /// or any of its children to retrieve the NavController.
    ///
    /// This is generally called for you by the hosting NavHost.
    public func setViewNavController(_ view: View, _ navController: NavController) {
        guard let instance = view.instance else { return }
        callVoidMethod(
            name: "setViewNavController",
            args: instance.signed(as: "android/view/View"), navController.signed(as: NavController.className)
        )
    }
}