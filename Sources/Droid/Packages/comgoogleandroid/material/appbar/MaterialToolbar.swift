//
//  MaterialToolbar.swift
//  Droid
//
//  Created by Mihael Isaev on 21.11.2025.
//

/// `MaterialToolbar` is a `Toolbar` that implements certain Material features,
/// such as elevation overlays for Dark Themes and centered titles.
/// 
/// [Learn more](https://developer.android.com/reference/com/google/android/material/appbar/MaterialToolbar)
public final class MaterialToolbar: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { "com/google/android/material/appbar/MaterialToolbar" }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }

    var titleState: State<String>?
    var subtitleState: State<String>?
}

// MARK: - Methods

extension MaterialToolbar {
    /// Check whether this Toolbar is currently hosting an expanded action view.
    public func hasExpandedActionView() -> Bool {
        instance?.callBoolMethod(name: "hasExpandedActionView") ?? false
    }
}

extension MaterialToolbar {
    /// Hide the overflow items from the associated menu.
    public func hideOverflowMenu() -> Bool {
        instance?.callBoolMethod(name: "hideOverflowMenu") ?? false
    }
}

extension MaterialToolbar {
    /// Invalidates the to ensure that what is displayed matches the current internal state of the menu.
    ///
    /// This should be called whenever the state of the menu is changed, such as items being removed or disabled based on some user event.
    /// Only the items in the Menu that were provided by `MenuProviders` should be removed and repopulated, leaving
    /// all manually inflated menu items untouched, as they should continue to be managed manually.
    public func invalidateMenu() {
        instance?.callVoidMethod(name: "invalidateMenu")
    }
}

extension MaterialToolbar {
    /// Returns whether the toolbar will attempt to register its own `OnBackInvokedCallback` in supported configurations
    /// to handle collapsing expanded action items when a back invocation occurs.
    public func isBackInvokedCallbackEnabled() -> Bool {
        instance?.callBoolMethod(name: "isBackInvokedCallbackEnabled") ?? false
    }
}

extension MaterialToolbar {
    /// Check whether the overflow menu is currently showing.
    /// This may not reflect a pending show operation in progress.
    public func isOverflowMenuShowing() -> Bool {
        instance?.callBoolMethod(name: "isOverflowMenuShowing") ?? false
    }
}

extension MaterialToolbar {
    public func onHoverEvent(_ event: MotionEvent) -> Bool {
        instance?.callBoolMethod(name: "onHoverEvent", args: event.signed(as: MotionEvent.className)) ?? false
    }
}

extension MaterialToolbar {
    public func onRtlPropertiesChanged(_ direction: LayoutDirection) {
        instance?.callVoidMethod(name: "onRtlPropertiesChanged", args: direction.rawValue)
    }
}

extension MaterialToolbar {
    public func onTouchEvent(_ event: MotionEvent) -> Bool {
        instance?.callBoolMethod(name: "onTouchEvent", args: event.signed(as: MotionEvent.className)) ?? false
    }
}

// TODO: implement removeMenuProvider

extension MaterialToolbar: _SetTitleable {}
extension MaterialToolbar: _SetSubtitleable {}
