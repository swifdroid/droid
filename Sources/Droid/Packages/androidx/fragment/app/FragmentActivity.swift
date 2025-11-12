//
//  ComponentActivity.swift
//  Droid
//
//  Created by Mihael Isaev on 27.08.2025.
//

#if os(Android)
extension FragmentActivity: Sendable {}
#else
extension FragmentActivity: @unchecked Sendable {}
#endif

/// Base class for activities that want to use the support-based Fragments.
/// 
/// [Learn more](https://developer.android.com/reference/androidx/fragment/app/FragmentActivity)
@MainActor
open class FragmentActivity: ComponentActivity {
    open class override var className: JClassName { "androidx/fragment/app/FragmentActivity" }
    open class override var gradleDependencies: [AppGradleDependency] { [.composeBOM] }
    open class override var parentClass: String { "DroidFragmentActivity()" }

    /// Return the `FragmentManager` for interacting with fragments associated with this activity.
    public func supportFragmentManager() -> FragmentManager! {
        guard
            let returningClazz = JClass.load(FragmentManager.className),
            let global = _context.object.callObjectMethod(name: "getSupportFragmentManager", returningClass: returningClazz)
        else { return nil }
        return .init(global, self)
    }
}

extension FragmentActivity {
    // TODO: setEnterSharedElementCallback
    // TODO: setExitSharedElementCallback

    /// Called by `Fragment.startActivityForResult()` to implement its behavior.
    public func startActivityFromFragment(
        _ fragment: Fragment,
        _ intent: Intent,
        requestCode: Int
    ) {
        _context.object.callVoidMethod(name: "startActivityFromFragment", args: fragment.signed(as: Fragment.className), intent.signed(as: Intent.className), Int32(requestCode))
    }

    /// Called by `Fragment.startActivityForResult()` to implement its behavior.
    public func startActivityFromFragment(
        _ fragment: Fragment,
        _ intent: Intent,
        requestCode: Int,
        options: Bundle
    ) {
        _context.object.callVoidMethod(name: "startActivityFromFragment", args: fragment.signed(as: Fragment.className), intent.signed(as: Intent.className), Int32(requestCode), options.signed(as: Bundle.className))
    }
}