//
//  ComponentActivity.swift
//  Droid
//
//  Created by Mihael Isaev on 27.08.2025.
//

#if os(Android)
extension ComponentActivity: Sendable {}
#else
extension ComponentActivity: @unchecked Sendable {}
#endif

/// Base class for activities that enables composition of higher level components.
/// 
/// Rather than all functionality being built directly into this class, only the minimal set of lower level building blocks are included.
/// Higher level components can then be used as needed without enforcing a deep `Activity` class hierarchy or strong coupling between components.
/// 
/// [Learn more](https://developer.android.com/reference/androidx/activity/ComponentActivity)
#if os(Android)
@MainActor
#endif
open class ComponentActivity: Activity {
    open class override var className: JClassName { "androidx/activity/ComponentActivity" }
    open class override var gradleDependencies: [String] { [
        #"implementation(platform("androidx.compose:compose-bom:2025.07.00"))"#
    ] }
    open class override var parentClass: String { "DroidComponentActivity()" }
}

extension ComponentActivity {
    public func addContentView(_ view: View, _ lp: LayoutParams) {
        guard
            let view = view.instance
        else { return }
        _context.object.callVoidMethod(name: "addContentView", args: view.signed(as: .android.view.View), lp.object.signed(as: .android.view.ViewGroup.LayoutParams))
    }

    // public func addMenuProvider(_ provider: NativeMenuProvider) {
    // TODO: addMenuProvider
    // }

    // TODO: addOnConfigurationChangedListener
    // TODO: addOnContextAvailableListener
    // TODO: addOnMultiWindowModeChangedListener
    // TODO: addOnNewIntentListener
    // TODO: addOnPictureInPictureModeChangedListener
    // TODO: addOnTrimMemoryListener
    // TODO: addOnUserLeaveHintListener
    // TODO: getActivityResultRegistry
    // TODO: getDefaultViewModelCreationExtras
    // TODO: getDefaultViewModelProviderFactory
    // TODO: getFullyDrawnReporter
    // TODO: getLastCustomNonConfigurationInstance
    // TODO: getLifecycle
    // TODO: getNavigationEventDispatcher
    // TODO: getOnBackPressedDispatcher
    // TODO: getSavedStateRegistry
    // TODO: getViewModelStore

    /// Sets the view tree owners before setting the content view so that the inflation process
    /// and attach listeners will see them already present.
    public func initializeViewTreeOwners() {
        _context.object.callVoidMethod(name: "initializeViewTreeOwners")
    }
    
    /// Invalidates the `android.view.Menu` to ensure that what is displayed
    /// matches the current internal state of the menu. This should be called whenever
    /// the state of the menu is changed, such as items being removed or disabled based on some user event.
    public func invalidateMenu() {
        _context.object.callVoidMethod(name: "invalidateMenu")
    }
}