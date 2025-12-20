//
//  BottomNavigationView.swift
//  Droid
//
//  Created by Mihael Isaev on 8.12.2025.
//

#if os(Android)
import Android
#endif

extension ComGoogleAndroidPackage.MaterialPackage.BottomNavigationPackage {
    public class BottomNavigationViewClass: JClassName, @unchecked Sendable {}
    
    public var BottomNavigationView: BottomNavigationViewClass { .init(parent: self, name: "BottomNavigationView") }
}

/// Represents a standard bottom navigation bar for application.
/// It is an implementation of material design bottom navigation.
///
/// Bottom navigation bars make it easy for users to explore
/// and switch between top-level views in a single tap.
/// They should be used when an application has three to five top-level destinations.
/// 
/// [Learn more](https://developer.android.com/reference/com/google/android/material/bottomnavigation/BottomNavigationView)
@MainActor
open class BottomNavigationView: NavigationBarView {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.material.bottomnavigation.BottomNavigationView }
    open override class var gradleDependencies: [AppGradleDependency] { [
        .androidXNavigationFragment,
        .androidXNavigationUI,
        .material
    ] }
}

extension BottomNavigationView {
    /// Returns whether the items horizontally translate
    /// on selection when the item widths fill up the screen.
    public func isItemHorizontalTranslationEnabled() -> Bool {
        instance?.callBoolMethod(name: "isItemHorizontalTranslationEnabled") ?? false
    }

    /// Handles a touch event dispatched to the bottom navigation view.
    /// Forwards the given MotionEvent to the underlying implementation for processing.
    /// - Parameter event: The MotionEvent describing the touch (for example, down, move, or up events).
    /// - Returns: true if the event was consumed/handled by the view, false otherwise.
    /// - Note: If the underlying call cannot obtain a result, this method will return false.
    public func onTouchEvent(_ event: MotionEvent) -> Bool {
        instance?.callBoolMethod(name: "onTouchEvent", args: event.signed(as: MotionEvent.className)) ?? false
    }
}

// MARK: SetItemHorizontalTranslationEnabled

private struct ItemHorizontalTranslationEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemHorizontalTranslationEnabled"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension BottomNavigationView {
    /// Sets whether the menu items horizontally translate
    /// on selection when the combined item widths fill up the screen.
    @discardableResult
    public func itemHorizontalTranslationEnabled(_ value: Bool = true) -> Self {
        ItemHorizontalTranslationEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}