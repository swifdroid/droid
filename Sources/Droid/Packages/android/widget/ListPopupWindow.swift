//
//  ListPopupWindow.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

extension AndroidPackage.WidgetPackage {
    public class ListPopupWindowClass: JClassName, @unchecked Sendable {}
    public var ListPopupWindow: ListPopupWindowClass { .init(parent: self, name: "ListPopupWindow") }
}

/// A wrapper for `android.widget.ListPopupWindow`.
///
/// [Learn more](https://developer.android.com/reference/android/widget/ListPopupWindow)
@MainActor
open class ListPopupWindow: JObjectable, @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { "android/widget/ListPopupWindow" }

    /// JNI Object
    public let object: JObject

    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

// MARK: Actions

extension ListPopupWindow {
    /// Clear the current selection in the drop-down list.
    public func clearListSelection() {
        object.callVoidMethod(name: "clearListSelection")
    }

    /// Dismiss the popup window.
    public func dismiss() {
        object.callVoidMethod(name: "dismiss")
    }

    /// Dismiss the popup window immediately.
    public func dismissImmediate() {
        object.callVoidMethod(name: "dismissImmediate")
    }

    /// Posts show operation to the UI thread.
    public func postShow() {
        object.callVoidMethod(name: "postShow")
    }

    /// Show the popup window.
    public func show() {
        object.callVoidMethod(name: "show")
    }
}

// MARK: Getters

extension ListPopupWindow {
    /// Returns the anchor view.
    public func anchorView() -> View? {
        guard
            let returningClazz = JClass.load(View.className),
            let global = object.callObjectMethod(name: "getAnchorView", returningClass: returningClazz)
        else { return nil }
        return View(id: nil, global, { nil })
    }

    /// Returns the animation style resource ID.
    public func animationStyle() -> Int {
        Int(object.callIntMethod(name: "getAnimationStyle") ?? 0)
    }

    /// Returns the popup background drawable.
    public func background() -> Drawable? {
        guard
            let returningClazz = JClass.load(Drawable.className),
            let global = object.callObjectMethod(name: "getBackground", returningClass: returningClazz)
        else { return nil }
        return Drawable(global)
    }

    /// Returns epicenter bounds for transitions.
    public func epicenterBounds() -> JObject? {
        guard
            let returningClazz = JClass.load("android/graphics/Rect"),
            let global = object.callObjectMethod(name: "getEpicenterBounds", returningClass: returningClazz)
        else { return nil }
        return global
    }

    /// Returns the popup height.
    public func height() -> Int {
        Int(object.callIntMethod(name: "getHeight") ?? 0)
    }

    /// Returns horizontal offset of the popup.
    public func horizontalOffset() -> Int {
        Int(object.callIntMethod(name: "getHorizontalOffset") ?? 0)
    }

    /// Returns input method mode.
    public func inputMethodMode() -> Int {
        Int(object.callIntMethod(name: "getInputMethodMode") ?? 0)
    }

    /// Returns the internal list view.
    public func listView() -> View? {
        guard
            let returningClazz = JClass.load("android/widget/ListView"),
            let global = object.callObjectMethod(name: "getListView", returningClass: returningClazz)
        else { return nil }
        return View(id: nil, global, { nil })
    }

    /// Returns prompt position.
    public func promptPosition() -> Int {
        Int(object.callIntMethod(name: "getPromptPosition") ?? 0)
    }

    /// Returns selected item object.
    public func selectedItem() -> JObject? {
        guard
            let returningClazz = JClass.load("java/lang/Object"),
            let global = object.callObjectMethod(name: "getSelectedItem", returningClass: returningClazz)
        else { return nil }
        return global
    }

    /// Returns selected item ID.
    public func selectedItemId() -> Int64 {
        object.callLongMethod(name: "getSelectedItemId") ?? 0
    }

    /// Returns selected item position.
    public func selectedItemPosition() -> Int {
        Int(object.callIntMethod(name: "getSelectedItemPosition") ?? -1)
    }

    /// Returns selected item view.
    public func selectedView() -> View? {
        guard
            let returningClazz = JClass.load(View.className),
            let global = object.callObjectMethod(name: "getSelectedView", returningClass: returningClazz)
        else { return nil }
        return View(id: nil, global, { nil })
    }

    /// Returns soft input mode.
    public func softInputMode() -> Int {
        Int(object.callIntMethod(name: "getSoftInputMode") ?? 0)
    }

    /// Returns vertical offset of the popup.
    public func verticalOffset() -> Int {
        Int(object.callIntMethod(name: "getVerticalOffset") ?? 0)
    }

    /// Returns the popup width.
    public func width() -> Int {
        Int(object.callIntMethod(name: "getWidth") ?? 0)
    }

    /// Returns whether drop-down is always visible.
    public func isDropDownAlwaysVisible() -> Bool {
        object.callBoolMethod(name: "isDropDownAlwaysVisible") ?? false
    }

    /// Returns whether input method is not needed.
    public func isInputMethodNotNeeded() -> Bool {
        object.callBoolMethod(name: "isInputMethodNotNeeded") ?? false
    }

    /// Returns whether this popup is modal.
    public func isModal() -> Bool {
        object.callBoolMethod(name: "isModal") ?? false
    }

    /// Returns whether this popup is showing.
    public func isShowing() -> Bool {
        object.callBoolMethod(name: "isShowing") ?? false
    }
}

// MARK: Keyboard

extension ListPopupWindow {
    /// Handles key-down events.
    public func onKeyDown(_ keyCode: Int, _ event: KeyEvent) -> Bool {
        object.callBoolMethod(name: "onKeyDown", args: Int32(keyCode), event.signed(as: KeyEvent.className)) ?? false
    }

    /// Handles key events before IME processing.
    public func onKeyPreIme(_ keyCode: Int, _ event: KeyEvent) -> Bool {
        object.callBoolMethod(name: "onKeyPreIme", args: Int32(keyCode), event.signed(as: KeyEvent.className)) ?? false
    }

    /// Handles key-up events.
    public func onKeyUp(_ keyCode: Int, _ event: KeyEvent) -> Bool {
        object.callBoolMethod(name: "onKeyUp", args: Int32(keyCode), event.signed(as: KeyEvent.className)) ?? false
    }

    /// Performs item click at the given position.
    public func performItemClick(_ position: Int) -> Bool {
        object.callBoolMethod(name: "performItemClick", args: Int32(position)) ?? false
    }
}

// MARK: Setters

extension ListPopupWindow {
    /// Creates a drag-to-open listener for an anchor view.
    @discardableResult
    public func createDragToOpenListener(_ src: View) -> JObject? {
        guard
            let returningClazz = JClass.load(.android.view.ViewOnTouchListener),
            let global = object.callObjectMethod(
                name: "createDragToOpenListener",
                args: src.signed(as: View.className),
                returningClass: returningClazz
            )
        else { return nil }
        return global
    }

    /// Sets the data adapter.
    @discardableResult
    public func adapter<T: JObjectable>(_ adapter: T?) -> Self {
        object.callVoidMethod(name: "setAdapter", args: adapter?.signed(as: "android/widget/ListAdapter"))
        return self
    }

    /// Sets the anchor view.
    @discardableResult
    public func anchorView(_ anchor: View?) -> Self {
        object.callVoidMethod(name: "setAnchorView", args: anchor.signed(as: View.className))
        return self
    }

    /// Sets popup animation style.
    @discardableResult
    public func animationStyle(_ style: Int) -> Self {
        object.callVoidMethod(name: "setAnimationStyle", args: Int32(style))
        return self
    }

    /// Sets popup background drawable.
    @discardableResult
    public func backgroundDrawable(_ background: Drawable?) -> Self {
        object.callVoidMethod(name: "setBackgroundDrawable", args: background.signed(as: Drawable.className))
        return self
    }

    /// Sets content width.
    @discardableResult
    public func contentWidth(_ width: Int) -> Self {
        object.callVoidMethod(name: "setContentWidth", args: Int32(width))
        return self
    }

    /// Sets whether drop-down is always visible.
    @discardableResult
    public func dropDownAlwaysVisible(_ alwaysVisible: Bool = true) -> Self {
        object.callVoidMethod(name: "setDropDownAlwaysVisible", args: alwaysVisible)
        return self
    }

    /// Sets drop-down gravity.
    @discardableResult
    public func dropDownGravity(_ gravity: Int) -> Self {
        object.callVoidMethod(name: "setDropDownGravity", args: Int32(gravity))
        return self
    }

    /// Sets epicenter bounds.
    @discardableResult
    public func epicenterBounds(_ bounds: JObject?) -> Self {
        object.callVoidMethod(name: "setEpicenterBounds", args: bounds?.signed(as: "android/graphics/Rect"))
        return self
    }

    /// Sets whether outside touch should be ignored.
    @discardableResult
    public func forceIgnoreOutsideTouch(_ forceIgnoreOutsideTouch: Bool = true) -> Self {
        object.callVoidMethod(name: "setForceIgnoreOutsideTouch", args: forceIgnoreOutsideTouch)
        return self
    }

    /// Sets popup height.
    @discardableResult
    public func height(_ height: Int) -> Self {
        object.callVoidMethod(name: "setHeight", args: Int32(height))
        return self
    }

    /// Sets horizontal offset.
    @discardableResult
    public func horizontalOffset(_ horizontalOffset: Int) -> Self {
        object.callVoidMethod(name: "setHorizontalOffset", args: Int32(horizontalOffset))
        return self
    }

    /// Sets input method mode.
    @discardableResult
    public func inputMethodMode(_ mode: Int) -> Self {
        object.callVoidMethod(name: "setInputMethodMode", args: Int32(mode))
        return self
    }

    /// Sets list selector drawable.
    @discardableResult
    public func listSelector(_ selector: Drawable?) -> Self {
        object.callVoidMethod(name: "setListSelector", args: selector.signed(as: Drawable.className))
        return self
    }

    /// Sets whether popup is modal.
    @discardableResult
    public func modal(_ modal: Bool = true) -> Self {
        object.callVoidMethod(name: "setModal", args: modal)
        return self
    }

    /// Sets dismiss listener.
    @discardableResult
    public func onDismissListener<T: JObjectable>(_ listener: T?) -> Self {
        object.callVoidMethod(name: "setOnDismissListener", args: listener?.signed(as: "android/widget/PopupWindow$OnDismissListener"))
        return self
    }

    /// Sets item click listener.
    @discardableResult
    public func onItemClickListener<T: JObjectable>(_ listener: T?) -> Self {
        object.callVoidMethod(name: "setOnItemClickListener", args: listener?.signed(as: "android/widget/AdapterView$OnItemClickListener"))
        return self
    }

    /// Sets item selected listener.
    @discardableResult
    public func onItemSelectedListener<T: JObjectable>(_ listener: T?) -> Self {
        object.callVoidMethod(name: "setOnItemSelectedListener", args: listener?.signed(as: "android/widget/AdapterView$OnItemSelectedListener"))
        return self
    }

    /// Sets whether popup overlaps anchor.
    @discardableResult
    public func overlapAnchor(_ overlapAnchor: Bool = true) -> Self {
        object.callVoidMethod(name: "setOverlapAnchor", args: overlapAnchor)
        return self
    }

    /// Sets prompt position.
    @discardableResult
    public func promptPosition(_ position: Int) -> Self {
        object.callVoidMethod(name: "setPromptPosition", args: Int32(position))
        return self
    }

    /// Sets prompt view.
    @discardableResult
    public func promptView(_ prompt: View?) -> Self {
        object.callVoidMethod(name: "setPromptView", args: prompt.signed(as: View.className))
        return self
    }

    /// Sets selected item position.
    @discardableResult
    public func selection(_ position: Int) -> Self {
        object.callVoidMethod(name: "setSelection", args: Int32(position))
        return self
    }

    /// Sets soft input mode.
    @discardableResult
    public func softInputMode(_ mode: Int) -> Self {
        object.callVoidMethod(name: "setSoftInputMode", args: Int32(mode))
        return self
    }

    /// Sets vertical offset.
    @discardableResult
    public func verticalOffset(_ verticalOffset: Int) -> Self {
        object.callVoidMethod(name: "setVerticalOffset", args: Int32(verticalOffset))
        return self
    }

    /// Sets popup width.
    @discardableResult
    public func width(_ width: Int) -> Self {
        object.callVoidMethod(name: "setWidth", args: Int32(width))
        return self
    }

    /// Sets window layout type.
    @discardableResult
    public func windowLayoutType(_ layoutType: Int) -> Self {
        object.callVoidMethod(name: "setWindowLayoutType", args: Int32(layoutType))
        return self
    }
}
