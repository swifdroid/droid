//
//  PopupMenu.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

extension AndroidPackage.WidgetPackage {
    public class PopupMenuClass: JClassName, @unchecked Sendable {}
    public class PopupMenuOnMenuItemClickListenerClass: JClassName, @unchecked Sendable {}
    public class PopupMenuOnDismissListenerClass: JClassName, @unchecked Sendable {}
    public var PopupMenu: PopupMenuClass { .init(parent: self, name: "PopupMenu") }
    public var PopupMenuOnMenuItemClickListener: PopupMenuOnMenuItemClickListenerClass { .init(parent: self, name: "PopupMenu$OnMenuItemClickListener") }
    public var PopupMenuOnDismissListener: PopupMenuOnDismissListenerClass { .init(parent: self, name: "PopupMenu$OnDismissListener") }
}

/// A wrapper for `android.widget.PopupMenu`.
///
/// [Learn more](https://developer.android.com/reference/android/widget/PopupMenu)
@MainActor
open class PopupMenu: JObjectable, @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { "android/widget/PopupMenu" }

    /// JNI Object
    public let object: JObject

    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

// MARK: Dismiss

extension PopupMenu {
    /// Dismiss the popup menu.
    public func dismiss() {
        object.callVoidMethod(name: "dismiss")
    }
}

// MARK: GetGravity

extension PopupMenu {
    /// Returns the alignment of the popup window relative to the anchor view.
    public func gravity() -> Int {
        Int(object.callIntMethod(name: "getGravity") ?? 0)
    }
}

// MARK: SetGravity

extension PopupMenu {
    /// Sets the gravity used to align the popup window relative to the anchor view.
    @discardableResult
    public func gravity(_ gravity: Int) -> Self {
        object.callVoidMethod(name: "setGravity", args: Int32(gravity))
        return self
    }
}

// MARK: GetMenu

extension PopupMenu {
    /// Returns the menu associated with this popup.
    public func menu() -> Menu? {
        guard
            let returningClazz = JClass.load(Menu.className),
            let global = object.callObjectMethod(name: "getMenu", returningClass: returningClazz)
        else { return nil }
        return Menu(global)
    }
}

// MARK: GetMenuListView

extension PopupMenu {
    /// Returns the list view used to show menu items, when available.
    public func menuListView() -> View? {
        guard
            let returningClazz = JClass.load("android/widget/ListView"),
            let global = object.callObjectMethod(name: "getMenuListView", returningClass: returningClazz)
        else { return nil }
        return View(id: nil, global, { nil })
    }
}

// MARK: Inflate

extension PopupMenu {
    /// Inflate a menu resource into this popup menu.
    public func inflate(_ menuRes: Int) {
        object.callVoidMethod(name: "inflate", args: Int32(menuRes))
    }
}

// MARK: SetForceShowIcon

extension PopupMenu {
    /// Controls whether icons should be force-shown in the popup menu.
    @discardableResult
    public func forceShowIcon(_ forceShowIcon: Bool = true) -> Self {
        object.callVoidMethod(name: "setForceShowIcon", args: forceShowIcon)
        return self
    }
}

// MARK: Show

extension PopupMenu {
    /// Show the popup menu.
    public func show() {
        object.callVoidMethod(name: "show")
    }
}

// MARK: GetDragToOpenListener

extension PopupMenu {
    /// Returns an `OnTouchListener` that opens this popup menu when a drag gesture is performed.
    public func dragToOpenListener() -> JObject? {
        guard
            let returningClazz = JClass.load(.android.view.ViewOnTouchListener),
            let global = object.callObjectMethod(name: "getDragToOpenListener", returningClass: returningClazz)
        else { return nil }
        return global
    }
}

// MARK: GetMenuInflater

extension PopupMenu {
    /// Returns the menu inflater used to inflate menu resources into this popup.
    public func menuInflater() -> JObject? {
        guard
            let returningClazz = JClass.load("android/view/MenuInflater"),
            let global = object.callObjectMethod(name: "getMenuInflater", returningClass: returningClazz)
        else { return nil }
        return global
    }
}

// MARK: SetOnDismissListener

extension PopupMenu {
    /// Sets a listener that is called when this popup menu is dismissed.
    @discardableResult
    public func onDismissListener<T: JObjectable>(_ listener: T?) -> Self {
        object.callVoidMethod(name: "setOnDismissListener", args: listener?.signed(as: .android.widget.PopupMenuOnDismissListener))
        return self
    }
}

// MARK: SetOnMenuItemClickListener

extension PopupMenu {
    /// Sets a listener that is called when a menu item in this popup is clicked.
    @discardableResult
    public func onMenuItemClickListener<T: JObjectable>(_ listener: T?) -> Self {
        object.callVoidMethod(name: "setOnMenuItemClickListener", args: listener?.signed(as: .android.widget.PopupMenuOnMenuItemClickListener))
        return self
    }
}
