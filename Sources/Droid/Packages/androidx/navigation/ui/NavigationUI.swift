//
//  NavigationUI.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// Class which hooks up elements typically in the 'chrome'
/// of your application such as global navigation patterns like
/// a navigation drawer or bottom nav bar with your NavController.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/ui/NavigationUI)
@MainActor
open class NavigationUI: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "androidx/navigation/ui/NavigationUI" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? (_ context: Contextable) {
        guard
            let clazz = JClass.load(NavigationUI.className),
            let global = clazz.newObject(args: context.context.signed(as: "android/content/Context"))
        else { return nil }
        self.object = global
    }
}

extension NavigationUI {
    /// Handles the Up button by delegating its behavior to the given NavController.
    /// This is an alternative to using NavController.navigateUp directly
    /// when the given AppBarConfiguration needs to be considered
    /// when determining what should happen when the Up button is pressed.
    ///
    /// In cases where no Up action is available,
    /// the `AppBarConfiguration.fallbackOnNavigateUpListener`
    /// will be called to provide additional control.
    public static func navigateUp(
        _ navController: NavController,
        _ configuration: AppBarConfiguration
    ) -> Bool {
        guard
            let clazz = JClass.load(NavigationUI.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "navigateUp",
            args: navController.object.signed(as: NavController.className),
                 configuration.object.signed(as: AppBarConfiguration.className)
        ) ?? false
    }

    // TODO: navigateUp with Openable

    /// Attempt to navigate to the NavDestination associated with the given MenuItem.
    /// This MenuItem should have been added via one of the helper methods in this class.
    /// 
    /// Importantly, it assumes the menu item id matches
    /// a valid `NavDestination.getAction` or destination id to be navigated to.
    /// 
    /// By default, the back stack will be popped back to the navigation graph's start destination.
    /// Menu items that have `android:menuCategory="secondary"` will not pop the back stack.
    public static func onNavDestinationSelected(
        _ item: MenuItem,
        _ navController: NavController,
        _ saveState: Bool? = nil
    ) -> Bool {
        var args: [any JSignatureItemable] = []
        args.append(item.object.signed(as: MenuItem.className),)
        args.append(navController.object.signed(as: NavController.className))
        if let saveState {
            args.append(saveState)
        }
        guard
            let clazz = JClass.load(NavigationUI.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "onNavDestinationSelected",
            args: args
        ) ?? false
    }

    /// Sets up the ActionBar returned by `AppCompatActivity.getSupportActionBar` for use with a NavController.
    /// 
    /// By calling this method, the title in the action bar will automatically be updated
    /// when the destination changes (assuming there is a valid label).
    /// 
    /// The AppBarConfiguration you provide controls how the Navigation button is displayed.
    /// Call navigateUp to handle the Up button.
    /// 
    /// Destinations that implement `androidx.navigation.FloatingWindow` will be ignored.
    public static func setupActionBarWithNavController(
        _ activity: AppCompatActivity,
        _ navController: NavController,
        _ configuration: AppBarConfiguration
    ) {
        guard
            let context = activity.context,
            let clazz = JClass.load(NavigationUI.className)
        else { return }
        clazz.staticVoidMethod(
            name: "setupActionBarWithNavController",
            args: context.signed(as: AppCompatActivity.className),
                 navController.object.signed(as: NavController.className),
                 configuration.object.signed(as: AppBarConfiguration.className)
        )
    }

    // TODO: setupActionBarWithNavController with Openable

    /// Sets up a `NavigationBarView` for use with a NavController.
    /// This will call `onNavDestinationSelected` when a menu item is selected.
    /// The selected item in the `NavigationBarView` will automatically be updated when the destination changes.
    ///
    /// Destinations that implement `androidx.navigation.FloatingWindow` will be ignored.
    public static func setupWithNavController(
        _ navigationBarView: NavigationBarView,
        _ navController: NavController,
        _ saveState: Bool? = nil
    ) {
        var args: [any JSignatureItemable] = []
        guard let navigationBarView = navigationBarView.instance else { return }
        args.append(navigationBarView.signed(as: NavigationBarView.className))
        args.append(navController.object.signed(as: NavController.className))
        if let saveState {
            args.append(saveState)
        }
        guard
            let clazz = JClass.load(NavigationUI.className)
        else { return }
        clazz.staticVoidMethod(
            name: "setupWithNavController",
            args: args
        )
    }

    /// Sets up a NavigationView for use with a NavController.
    /// This will call onNavDestinationSelected when a menu item is selected.
    /// The selected item in the `NavigationView` will automatically be updated when the destination changes.
    /// 
    /// If the `NavigationView` is directly contained with an `Openable` layout,
    /// it will be closed when a menu item is selected.
    /// 
    /// Similarly, if the `NavigationView` has a `BottomSheetBehavior` associated
    /// with it (as is the case when using a `com.google.android.material.bottomsheet.BottomSheetDialog`),
    /// the bottom sheet will be hidden when a menu item is selected.
    /// 
    /// Destinations that implement `androidx.navigation.FloatingWindow` will be ignored.
    public static func setupWithNavController(
        _ navigationView: NavigationView,
        _ navController: NavController,
        _ saveState: Bool? = nil
    ) {
        guard let navigationView = navigationView.instance else { return }
        var args: [any JSignatureItemable] = []
        args.append(navigationView.signed(as: NavigationView.className))
        args.append(navController.object.signed(as: NavController.className))
        if let saveState {
            args.append(saveState)
        }
        guard
            let clazz = JClass.load(NavigationUI.className)
        else { return }
        clazz.staticVoidMethod(
            name: "setupWithNavController",
            args: args
        )
    }

    /// Sets up a `Toolbar` for use with a `NavController`.
    /// 
    /// By calling this method, the title in the `Toolbar` will automatically be updated
    /// when the destination changes (assuming there is a valid label).
    /// 
    /// The `AppBarConfiguration` you provide controls how the Navigation button
    /// is displayed and what action is triggered when the Navigation button is tapped.
    /// This method will call navigateUp when the Navigation button is clicked.
    /// 
    /// Destinations that implement `androidx.navigation.FloatingWindow` will be ignored.
    public static func setupWithNavController(
        _ toolbar: Toolbar,
        _ navController: NavController,
        _ configuration: AppBarConfiguration
    ) {
        guard
            let toolbar = toolbar.instance,
            let clazz = JClass.load(NavigationUI.className)
        else { return }
        clazz.staticVoidMethod(
            name: "setupWithNavController",
            args: toolbar.signed(as: Toolbar.className),
                 navController.object.signed(as: NavController.className),
                 configuration.object.signed(as: AppBarConfiguration.className)
        )
    }

    // TODO: setupWithNavController with Openable
    // TODO: setupWithNavController with CollapsingToolbarLayout
}