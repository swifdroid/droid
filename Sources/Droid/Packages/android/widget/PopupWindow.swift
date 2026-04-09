//
//  PopupWindow.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

extension AndroidPackage.WidgetPackage {
    public class PopupWindowClass: JClassName, @unchecked Sendable {}
    public class PopupWindowOnDismissListenerClass: JClassName, @unchecked Sendable {}
    public var PopupWindow: PopupWindowClass { .init(parent: self, name: "PopupWindow") }
    public var PopupWindowOnDismissListener: PopupWindowOnDismissListenerClass { .init(parent: self, name: "PopupWindow$OnDismissListener") }
}

/// A wrapper for `android.widget.PopupWindow`.
///
/// [Learn more](https://developer.android.com/reference/android/widget/PopupWindow)
@MainActor
open class PopupWindow: JObjectable, @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { "android/widget/PopupWindow" }

    /// JNI Object
    public let object: JObject

    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

// MARK: Dismiss

extension PopupWindow {
    /// Dismisses the popup window.
    public func dismiss() {
        object.callVoidMethod(name: "dismiss")
    }
}

// MARK: GetAllowScrollingAnchorParent

extension PopupWindow {
    /// Returns whether this popup allows scrolling anchor parent to position itself.
    public func allowScrollingAnchorParent() -> Bool {
        object.callBoolMethod(name: "getAllowScrollingAnchorParent") ?? true
    }
}

// MARK: GetAnimationStyle

extension PopupWindow {
    /// Returns the animation style resource for this popup.
    public func animationStyle() -> Int {
        Int(object.callIntMethod(name: "getAnimationStyle") ?? 0)
    }
}

// MARK: SetAnimationStyle

extension PopupWindow {
    /// Sets the animation style resource for this popup.
    @discardableResult
    public func animationStyle(_ animationStyle: Int) -> Self {
        object.callVoidMethod(name: "setAnimationStyle", args: Int32(animationStyle))
        return self
    }
}

// MARK: GetBackground

extension PopupWindow {
    /// Returns the drawable used as the popup window background.
    public func background() -> Drawable? {
        guard
            let returningClazz = JClass.load(Drawable.className),
            let global = object.callObjectMethod(name: "getBackground", returningClass: returningClazz)
        else { return nil }
        return Drawable(global)
    }
}

// MARK: SetBackgroundDrawable

extension PopupWindow {
    /// Sets the background drawable for this popup window.
    @discardableResult
    public func backgroundDrawable(_ background: Drawable?) -> Self {
        object.callVoidMethod(name: "setBackgroundDrawable", args: background.signed(as: Drawable.className))
        return self
    }
}

// MARK: GetContentView

extension PopupWindow {
    /// Returns the content view of the popup window.
    public func contentView() -> View? {
        guard
            let returningClazz = JClass.load(View.className),
            let global = object.callObjectMethod(name: "getContentView", returningClass: returningClazz)
        else { return nil }
        return View(id: nil, global, { nil })
    }
}

// MARK: SetContentView

extension PopupWindow {
    /// Sets the content view for this popup window.
    @discardableResult
    public func contentView(_ contentView: View?) -> Self {
        object.callVoidMethod(name: "setContentView", args: contentView.signed(as: View.className))
        return self
    }
}

// MARK: GetElevation

extension PopupWindow {
    /// Returns the elevation of this popup window.
    public func elevation() -> Float {
        object.callFloatMethod(name: "getElevation") ?? 0
    }
}

// MARK: SetElevation

extension PopupWindow {
    /// Sets the elevation for this popup window.
    @discardableResult
    public func elevation(_ elevation: Float) -> Self {
        object.callVoidMethod(name: "setElevation", args: elevation)
        return self
    }
}

// MARK: InputMethodMode

extension PopupWindow {
    /// Returns the current input method mode.
    public func inputMethodMode() -> Int {
        Int(object.callIntMethod(name: "getInputMethodMode") ?? 0)
    }

    /// Sets how the popup interacts with the input method.
    @discardableResult
    public func inputMethodMode(_ mode: Int) -> Self {
        object.callVoidMethod(name: "setInputMethodMode", args: Int32(mode))
        return self
    }
}

// MARK: SoftInputMode

extension PopupWindow {
    /// Returns the soft input mode for this popup.
    public func softInputMode() -> Int {
        Int(object.callIntMethod(name: "getSoftInputMode") ?? 0)
    }

    /// Sets the soft input mode for this popup.
    @discardableResult
    public func softInputMode(_ mode: Int) -> Self {
        object.callVoidMethod(name: "setSoftInputMode", args: Int32(mode))
        return self
    }
}

// MARK: Height

extension PopupWindow {
    /// Returns the requested popup height.
    public func height() -> Int {
        Int(object.callIntMethod(name: "getHeight") ?? 0)
    }

    /// Sets the requested popup height.
    @discardableResult
    public func height(_ height: Int) -> Self {
        object.callVoidMethod(name: "setHeight", args: Int32(height))
        return self
    }
}

// MARK: Width

extension PopupWindow {
    /// Returns the requested popup width.
    public func width() -> Int {
        Int(object.callIntMethod(name: "getWidth") ?? 0)
    }

    /// Sets the requested popup width.
    @discardableResult
    public func width(_ width: Int) -> Self {
        object.callVoidMethod(name: "setWidth", args: Int32(width))
        return self
    }
}

// MARK: WindowLayoutMode

extension PopupWindow {
    /// Sets width and height specs to use for popup layout mode.
    @discardableResult
    public func windowLayoutMode(widthSpec: Int, heightSpec: Int) -> Self {
        object.callVoidMethod(name: "setWindowLayoutMode", args: Int32(widthSpec), Int32(heightSpec))
        return self
    }
}

// MARK: WindowLayoutType

extension PopupWindow {
    /// Returns the window layout type for this popup.
    public func windowLayoutType() -> Int {
        Int(object.callIntMethod(name: "getWindowLayoutType") ?? 0)
    }

    /// Sets the window layout type for this popup.
    @discardableResult
    public func windowLayoutType(_ layoutType: Int) -> Self {
        object.callVoidMethod(name: "setWindowLayoutType", args: Int32(layoutType))
        return self
    }
}

// MARK: MaxAvailableHeight

extension PopupWindow {
    /// Returns the maximum available popup height anchored to the specified view.
    public func maxAvailableHeight(anchor: View) -> Int {
        Int(object.callIntMethod(name: "getMaxAvailableHeight", args: anchor.signed(as: View.className)) ?? 0)
    }

    /// Returns the maximum available popup height with a vertical offset.
    public func maxAvailableHeight(anchor: View, yOffset: Int) -> Int {
        Int(object.callIntMethod(name: "getMaxAvailableHeight", args: anchor.signed(as: View.className), Int32(yOffset)) ?? 0)
    }

    /// Returns the maximum available popup height with optional bottom decorations ignored.
    public func maxAvailableHeight(anchor: View, yOffset: Int, ignoreBottomDecorations: Bool) -> Int {
        Int(object.callIntMethod(name: "getMaxAvailableHeight", args: anchor.signed(as: View.className), Int32(yOffset), ignoreBottomDecorations) ?? 0)
    }
}

// MARK: Is

extension PopupWindow {
    /// Returns whether the popup is currently positioned above its anchor.
    public func isAboveAnchor() -> Bool {
        object.callBoolMethod(name: "isAboveAnchor") ?? false
    }

    /// Returns whether the popup is attached in decor.
    public func isAttachedInDecor() -> Bool {
        object.callBoolMethod(name: "isAttachedInDecor") ?? false
    }

    /// Returns whether popup clipping to screen is enabled.
    public func isClippedToScreen() -> Bool {
        object.callBoolMethod(name: "isClippedToScreen") ?? false
    }

    /// Returns whether clipping is enabled for this popup.
    public func isClippingEnabled() -> Bool {
        object.callBoolMethod(name: "isClippingEnabled") ?? true
    }

    /// Returns whether clip-to-screen mode is enabled.
    public func isClipToScreenEnabled() -> Bool {
        object.callBoolMethod(name: "isClipToScreenEnabled") ?? false
    }

    /// Returns whether this popup can take focus.
    public func isFocusable() -> Bool {
        object.callBoolMethod(name: "isFocusable") ?? false
    }

    /// Returns whether this popup is laid out in screen coordinates.
    public func isLaidOutInScreen() -> Bool {
        object.callBoolMethod(name: "isLaidOutInScreen") ?? false
    }

    /// Returns whether layout-in-screen mode is enabled.
    public func isLayoutInScreenEnabled() -> Bool {
        object.callBoolMethod(name: "isLayoutInScreenEnabled") ?? false
    }

    /// Returns whether layout inset decor is enabled.
    public func isLayoutInsetDecor() -> Bool {
        object.callBoolMethod(name: "isLayoutInsetDecor") ?? false
    }

    /// Returns whether touches outside the popup are consumed.
    public func isOutsideTouchable() -> Bool {
        object.callBoolMethod(name: "isOutsideTouchable") ?? false
    }

    /// Returns whether this popup is currently showing.
    public func isShowing() -> Bool {
        object.callBoolMethod(name: "isShowing") ?? false
    }

    /// Returns whether split touch mode is enabled.
    public func isSplitTouchEnabled() -> Bool {
        object.callBoolMethod(name: "isSplitTouchEnabled") ?? false
    }

    /// Returns whether this popup is touchable.
    public func isTouchable() -> Bool {
        object.callBoolMethod(name: "isTouchable") ?? true
    }

    /// Returns whether this popup is touch modal.
    public func isTouchModal() -> Bool {
        object.callBoolMethod(name: "isTouchModal") ?? true
    }

    /// Returns whether this popup is transitioning to dismiss.
    public func isTransitioningToDismiss() -> Bool {
        object.callBoolMethod(name: "isTransitioningToDismiss") ?? false
    }

    /// Returns whether this popup overlaps its anchor.
    public func overlapAnchor() -> Bool {
        object.callBoolMethod(name: "getOverlapAnchor") ?? false
    }
}

// MARK: Set

extension PopupWindow {
    /// Sets whether this popup should be attached in decor.
    @discardableResult
    public func attachedInDecor(_ enabled: Bool = true) -> Self {
        object.callVoidMethod(name: "setAttachedInDecor", args: enabled)
        return self
    }

    /// Sets whether clipping is enabled for this popup.
    @discardableResult
    public func clippingEnabled(_ enabled: Bool = true) -> Self {
        object.callVoidMethod(name: "setClippingEnabled", args: enabled)
        return self
    }

    /// Sets whether clip-to-screen mode is enabled.
    @discardableResult
    public func clipToScreenEnabled(_ enabled: Bool = true) -> Self {
        object.callVoidMethod(name: "setClipToScreenEnabled", args: enabled)
        return self
    }

    /// Sets whether this popup is shown as a dropdown.
    @discardableResult
    public func dropDown(_ isDropDown: Bool = true) -> Self {
        object.callVoidMethod(name: "setDropDown", args: isDropDown)
        return self
    }

    /// Changes the popup focusability.
    @discardableResult
    public func focusable(_ focusable: Bool = true) -> Self {
        object.callVoidMethod(name: "setFocusable", args: focusable)
        return self
    }

    /// Sets whether this popup should ignore cheek presses.
    @discardableResult
    public func ignoreCheekPress() -> Self {
        object.callVoidMethod(name: "setIgnoreCheekPress")
        return self
    }

    /// Sets clipping to screen state for this popup.
    @discardableResult
    public func isClippedToScreen(_ enabled: Bool = true) -> Self {
        object.callVoidMethod(name: "setIsClippedToScreen", args: enabled)
        return self
    }

    /// Sets laid-out-in-screen state for this popup.
    @discardableResult
    public func isLaidOutInScreen(_ enabled: Bool = true) -> Self {
        object.callVoidMethod(name: "setIsLaidOutInScreen", args: enabled)
        return self
    }

    /// Sets whether layout should happen in screen coordinates.
    @discardableResult
    public func layoutInScreenEnabled(_ enabled: Bool = true) -> Self {
        object.callVoidMethod(name: "setLayoutInScreenEnabled", args: enabled)
        return self
    }

    /// Sets whether the popup should inset decor areas.
    @discardableResult
    public func layoutInsetDecor(_ enabled: Bool = true) -> Self {
        object.callVoidMethod(name: "setLayoutInsetDecor", args: enabled)
        return self
    }

    /// Sets whether the popup should receive outside touch events.
    @discardableResult
    public func outsideTouchable(_ touchable: Bool = true) -> Self {
        object.callVoidMethod(name: "setOutsideTouchable", args: touchable)
        return self
    }

    /// Sets whether popup should overlap its anchor.
    @discardableResult
    public func overlapAnchor(_ overlapAnchor: Bool = true) -> Self {
        object.callVoidMethod(name: "setOverlapAnchor", args: overlapAnchor)
        return self
    }

    /// Sets the internal showing state.
    @discardableResult
    public func showing(_ isShowing: Bool) -> Self {
        object.callVoidMethod(name: "setShowing", args: isShowing)
        return self
    }

    /// Sets split touch mode.
    @discardableResult
    public func splitTouchEnabled(_ enabled: Bool = true) -> Self {
        object.callVoidMethod(name: "setSplitTouchEnabled", args: enabled)
        return self
    }

    /// Sets whether this popup is touchable.
    @discardableResult
    public func touchable(_ touchable: Bool = true) -> Self {
        object.callVoidMethod(name: "setTouchable", args: touchable)
        return self
    }

    /// Sets whether this popup is touch modal.
    @discardableResult
    public func touchModal(_ touchModal: Bool = true) -> Self {
        object.callVoidMethod(name: "setTouchModal", args: touchModal)
        return self
    }

    /// Sets transitioning-to-dismiss state.
    @discardableResult
    public func transitioningToDismiss(_ transitioningToDismiss: Bool = true) -> Self {
        object.callVoidMethod(name: "setTransitioningToDismiss", args: transitioningToDismiss)
        return self
    }
}

// MARK: Show

extension PopupWindow {
    /// Displays this popup window at the specified location.
    public func showAtLocation(_ parent: View, _ gravity: Int, _ x: Int, _ y: Int) {
        object.callVoidMethod(
            name: "showAtLocation",
            args: parent.signed(as: View.className), Int32(gravity), Int32(x), Int32(y)
        )
    }

    /// Displays this popup window anchored to the specified view.
    public func showAsDropDown(_ anchor: View) {
        object.callVoidMethod(name: "showAsDropDown", args: anchor.signed(as: View.className))
    }

    /// Displays this popup window anchored to the specified view with offsets.
    public func showAsDropDown(_ anchor: View, _ xoff: Int, _ yoff: Int) {
        object.callVoidMethod(name: "showAsDropDown", args: anchor.signed(as: View.className), Int32(xoff), Int32(yoff))
    }

    /// Displays this popup window anchored to the specified view with offsets and gravity.
    public func showAsDropDown(_ anchor: View, _ xoff: Int, _ yoff: Int, _ gravity: Int) {
        object.callVoidMethod(
            name: "showAsDropDown",
            args: anchor.signed(as: View.className), Int32(xoff), Int32(yoff), Int32(gravity)
        )
    }
}

// MARK: UpdateAboveAnchor

extension PopupWindow {
    /// Updates whether this popup is above its anchor.
    public func updateAboveAnchor(_ aboveAnchor: Bool) {
        object.callVoidMethod(name: "updateAboveAnchor", args: aboveAnchor)
    }
}

// MARK: CreatePopupLayoutParams

extension PopupWindow {
    /// Creates layout parameters used to display this popup.
    public func createPopupLayoutParams(_ token: JObject?) -> JObject? {
        guard
            let returningClazz = JClass.load("android/view/WindowManager$LayoutParams"),
            let global = object.callObjectMethod(
                name: "createPopupLayoutParams",
                args: token?.signed(as: "android/os/IBinder"),
                returningClass: returningClazz
            )
        else { return nil }
        return global
    }
}

// MARK: FindDropDownPosition

extension PopupWindow {
    /// Finds the popup position relative to the anchor.
    public func findDropDownPosition(_ anchor: View, _ outParams: JObject?, _ xOffset: Int, _ yOffset: Int, _ width: Int, _ height: Int, _ gravity: Int, _ allowScroll: Bool) -> Bool {
        object.callBoolMethod(
            name: "findDropDownPosition",
            args: anchor.signed(as: View.className),
                  outParams?.signed(as: "android/view/WindowManager$LayoutParams"),
                  Int32(xOffset), Int32(yOffset), Int32(width), Int32(height), Int32(gravity), allowScroll
        ) ?? false
    }
}

// MARK: GetEnterTransition

extension PopupWindow {
    /// Returns the transition used when this popup appears.
    public func enterTransition() -> JObject? {
        guard
            let returningClazz = JClass.load("android/transition/Transition"),
            let global = object.callObjectMethod(name: "getEnterTransition", returningClass: returningClazz)
        else { return nil }
        return global
    }
}

// MARK: GetEpicenterBounds

extension PopupWindow {
    /// Returns the epicenter bounds used for transitions.
    public func epicenterBounds() -> JObject? {
        guard
            let returningClazz = JClass.load("android/graphics/Rect"),
            let global = object.callObjectMethod(name: "getEpicenterBounds", returningClass: returningClazz)
        else { return nil }
        return global
    }
}

// MARK: GetExitTransition

extension PopupWindow {
    /// Returns the transition used when this popup disappears.
    public func exitTransition() -> JObject? {
        guard
            let returningClazz = JClass.load("android/transition/Transition"),
            let global = object.callObjectMethod(name: "getExitTransition", returningClass: returningClazz)
        else { return nil }
        return global
    }
}

// MARK: GetOnDismissListener

extension PopupWindow {
    /// Returns the dismiss listener currently assigned to this popup.
    public func onDismissListener() -> JObject? {
        guard
            let returningClazz = JClass.load(.android.widget.PopupWindowOnDismissListener),
            let global = object.callObjectMethod(name: "getOnDismissListener", returningClass: returningClazz)
        else { return nil }
        return global
    }
}

// MARK: GetTransitionEpicenter

extension PopupWindow {
    /// Returns the transition epicenter.
    public func transitionEpicenter() -> JObject? {
        guard
            let returningClazz = JClass.load("android/graphics/Rect"),
            let global = object.callObjectMethod(name: "getTransitionEpicenter", returningClass: returningClazz)
        else { return nil }
        return global
    }
}

// MARK: SetEnterTransition

extension PopupWindow {
    /// Sets the transition used when this popup appears.
    @discardableResult
    public func enterTransition(_ transition: JObject?) -> Self {
        object.callVoidMethod(name: "setEnterTransition", args: transition?.signed(as: "android/transition/Transition"))
        return self
    }
}

// MARK: SetEpicenterBounds

extension PopupWindow {
    /// Sets the epicenter bounds used for transitions.
    @discardableResult
    public func epicenterBounds(_ bounds: JObject?) -> Self {
        object.callVoidMethod(name: "setEpicenterBounds", args: bounds?.signed(as: "android/graphics/Rect"))
        return self
    }
}

// MARK: SetExitTransition

extension PopupWindow {
    /// Sets the transition used when this popup disappears.
    @discardableResult
    public func exitTransition(_ transition: JObject?) -> Self {
        object.callVoidMethod(name: "setExitTransition", args: transition?.signed(as: "android/transition/Transition"))
        return self
    }
}

// MARK: SetOnDismissListener

extension PopupWindow {
    /// Registers a callback to be invoked when this popup is dismissed.
    @discardableResult
    public func onDismissListener<T: JObjectable>(_ listener: T?) -> Self {
        object.callVoidMethod(name: "setOnDismissListener", args: listener?.signed(as: .android.widget.PopupWindowOnDismissListener))
        return self
    }
}

// MARK: SetTouchInterceptor

extension PopupWindow {
    /// Sets a touch interceptor for this popup.
    @discardableResult
    public func touchInterceptor<T: JObjectable>(_ listener: T?) -> Self {
        object.callVoidMethod(name: "setTouchInterceptor", args: listener?.signed(as: .android.view.ViewOnTouchListener))
        return self
    }
}
