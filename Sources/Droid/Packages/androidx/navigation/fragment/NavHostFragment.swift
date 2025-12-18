//
//  NavHostFragment.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// NavHostFragment provides an area within your layout
/// for self-contained navigation to occur.
///
/// Each NavHostFragment has a NavController that defines valid navigation
/// within the navigation host. This includes the NavGraph as well
/// as navigation state such as current location and back stack that
/// will be saved and restored along with the NavHostFragment itself.
///
/// NavHostFragments register their navigation controller at the root
/// of their view subtree such that any descendant can obtain the controller
/// instance through the Navigation helper class's methods such
/// as Navigation.findNavController. View event listener implementations
/// such as android.view.View.OnClickListener within navigation destination
/// fragments can use these helpers to navigate based on user interaction
/// without creating a tight coupling to the navigation host.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/fragment/NavHostFragment)
@MainActor
open class NavHostFragment: Fragment, @unchecked Sendable {
    open override class var className: JClassName { "androidx/navigation/fragment/NavHostFragment" }

    public required init (_ object: JObject) {
        super.init(object)
    }

    public override init! () {
        guard let env = JEnv.current() else { return nil }
        super.init(env, Self.nativeNavHostFragmentObjectClassName, .static)
    }

    public convenience init? (_ className: JClassName) {
        guard let env = JEnv.current() else { return nil }
        self.init(env, Self.nativeNavHostFragmentObjectClassName, .static)
    }

    public override init? (_ env: JEnv, _ className: JClassName, _ initializer: Initializer = .normal) {
        super.init(env, className, initializer)
    }
}

extension NavHostFragment {
    /// Create a new NavHostFragment instance with an inflated NavGraph resource.
    public static func create(_ navGraphResId: Int32, _ startDestinationArgs: Bundle, _ context: Contextable) -> NavHostFragment? {
        guard
            let clazz = JClass.load(NavHostFragment.className),
            let global = clazz.staticObjectMethod(
                name: "create",
                args: navGraphResId, startDestinationArgs.signed(as: Bundle.className),
                returningClass: clazz
            )
        else { return nil }
        return NavHostFragment(global)
    }

    /// Find a NavController given a local Fragment.
    ///
    /// This method will locate the NavController associated with this Fragment,
    /// looking first for a NavHostFragment along the given Fragment's
    /// parent chain. If a NavController is not found, this method will look
    /// for one along this Fragment's view hierarchy as specified
    /// by `Navigation.findNavController`.
    public static func findNavController(_ fragment: Fragment) -> NavController? {
        guard
            let clazz = JClass.load(NavHostFragment.className),
            let returningClazz = JClass.load(NavController.className),
            let global = clazz.staticObjectMethod(
                name: "findNavController",
                args: fragment.signed(as: Fragment.className),
                returningClass: returningClazz
            )
        else { return nil }
        return NavController(global)
    }

    /// The navigation controller for this navigation host.
    ///
    /// This method will return null until this host fragment's `onCreate`
    /// has been called and it has had an opportunity to restore
    /// from a previous instance state.
    public func navController() -> NavController? {
        guard
            let returningClazz = JClass.load(NavController.className),
            let global = callObjectMethod(name: "getNavController", returningClass: returningClazz)
        else { return nil }
        return NavController(global)
    }

    // TODO: implement `on` methods
}