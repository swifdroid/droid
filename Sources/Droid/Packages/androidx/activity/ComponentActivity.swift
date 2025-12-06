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
@MainActor
open class ComponentActivity: Activity {
    open class override var className: JClassName { "androidx/activity/ComponentActivity" }
    open class override var gradleDependencies: [AppGradleDependency] { [.composeBOM] }
    open class override var parentClass: String { "DroidComponentActivity()" }
}

extension ComponentActivity {
    public func addContentView(_ view: View, _ lp: LayoutParams) {
        guard let view = view.instance else { return }
        guard let context else {
            Log.c("🟥 ComponentActivity: Failed to addContentView: activity context is nil")
            return
        }
        context.object.callVoidMethod(name: "addContentView", args: view.signed(as: .android.view.View), lp.object.signed(as: .android.view.ViewGroup.LayoutParams))
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
        guard let context else {
            Log.c("🟥 ComponentActivity: Failed to initializeViewTreeOwners: activity context is nil")
            return
        }
        context.object.callVoidMethod(name: "initializeViewTreeOwners")
    }
    
    /// Invalidates the `android.view.Menu` to ensure that what is displayed
    /// matches the current internal state of the menu. This should be called whenever
    /// the state of the menu is changed, such as items being removed or disabled based on some user event.
    public func invalidateMenu() {
        guard let context else {
            Log.c("🟥 ComponentActivity: Failed to invalidateMenu: activity context is nil")
            return
        }
        context.object.callVoidMethod(name: "invalidateMenu")
    }

    /// Enables the edge-to-edge display for this activity.
    public func enableEdgeToEdge() {
        guard let context else {
            Log.c("🟥 ComponentActivity: Failed to enableEdgeToEdge: activity context is nil")
            return
        }
        guard
            let clazz = JClass.load("androidx/activity/EdgeToEdge")
        else {
            Log.d("Failed to load androidx/activity/EdgeToEdge class")
            return
        }
        clazz.staticVoidMethod(name: "enable", args: context.signed(as: ComponentActivity.className))
    }
}