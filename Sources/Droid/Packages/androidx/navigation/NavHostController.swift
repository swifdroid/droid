//
//  NavHostController.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// Subclass of NavController that offers additional APIs for use by a NavHost to connect the NavController to external dependencies.
///
/// Apps should generally not construct controllers, instead obtain a relevant controller directly from a navigation host via NavHost.navController or by using one of the utility methods on the Navigation class.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavHostController)
@MainActor
public final class NavHostController: NavController, @unchecked Sendable {
    public override class var className: JClassName { "androidx/navigation/NavHostController" }
    
    /// Base Droid constructor with existing JNI object
    public override init (_ object: JObject) {
        super.init(object)
    }

    public override init? (_ context: Contextable) {
        guard
            let clazz = JClass.load(NavHostController.className),
            let global = clazz.newObject(args: context.context.signed(as: "android/content/Context"))
        else { return nil }
        super.init(global)
    }
}

extension NavHostController {
    /// Set whether the NavController should handle the system
    /// Back button events via the registered OnBackPressedDispatcher.
    @discardableResult
    public func enableOnBackPressed(value: Bool = true) -> Self {
        object.callVoidMethod(name: "enableOnBackPressed", args: value)
        return self
    }

    // TODO: setLifecycleOwner
    // TODO: setOnBackPressedDispatcher
    // TODO: setViewModelStore
}