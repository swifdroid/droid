//
//  SlidingDrawer.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class SlidingDrawerClass: JClassName, @unchecked Sendable {}
    public class SlidingDrawerOnDrawerOpenListenerClass: JClassName, @unchecked Sendable {}
    public class SlidingDrawerOnDrawerCloseListenerClass: JClassName, @unchecked Sendable {}
    public class SlidingDrawerOnDrawerScrollListenerClass: JClassName, @unchecked Sendable {}
    public var SlidingDrawer: SlidingDrawerClass { .init(parent: self, name: "SlidingDrawer") }
    public var SlidingDrawerOnDrawerOpenListener: SlidingDrawerOnDrawerOpenListenerClass { .init(parent: self, name: "SlidingDrawer$OnDrawerOpenListener") }
    public var SlidingDrawerOnDrawerCloseListener: SlidingDrawerOnDrawerCloseListenerClass { .init(parent: self, name: "SlidingDrawer$OnDrawerCloseListener") }
    public var SlidingDrawerOnDrawerScrollListener: SlidingDrawerOnDrawerScrollListenerClass { .init(parent: self, name: "SlidingDrawer$OnDrawerScrollListener") }
}

/// A wrapper for `android.widget.SlidingDrawer`.
///
/// [Learn more](https://developer.android.com/reference/android/widget/SlidingDrawer)
open class SlidingDrawer: View {
    /// The JNI class name
    open override class var className: JClassName { "android/widget/SlidingDrawer" }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}

// MARK: Actions

extension SlidingDrawer {
    /// Closes the drawer with an animation.
    public func animateClose() {
        instance?.callVoidMethod(name: "animateClose")
    }

    /// Opens the drawer with an animation.
    public func animateOpen() {
        instance?.callVoidMethod(name: "animateOpen")
    }

    /// Toggles the drawer with an animation.
    public func animateToggle() {
        instance?.callVoidMethod(name: "animateToggle")
    }

    /// Closes the drawer immediately.
    public func close() {
        instance?.callVoidMethod(name: "close")
    }

    /// Opens the drawer immediately.
    public func open() {
        instance?.callVoidMethod(name: "open")
    }

    /// Toggles the drawer immediately.
    public func toggle() {
        instance?.callVoidMethod(name: "toggle")
    }

    /// Locks the drawer.
    public func lock() {
        instance?.callVoidMethod(name: "lock")
    }

    /// Unlocks the drawer.
    public func unlock() {
        instance?.callVoidMethod(name: "unlock")
    }
}

// MARK: DrawAndLayout

extension SlidingDrawer {
    /// Draw this view into the supplied canvas.
    public func dispatchDraw(_ canvas: JObject?) {
        instance?.callVoidMethod(name: "dispatchDraw", args: canvas?.signed(as: "android/graphics/Canvas"))
    }

    /// Called after inflation from XML has finished.
    public func onFinishInflate() {
        instance?.callVoidMethod(name: "onFinishInflate")
    }

    /// Called to assign a size and position to each child view.
    public func onLayout(_ changed: Bool, _ left: Int, _ top: Int, _ right: Int, _ bottom: Int) {
        instance?.callVoidMethod(name: "onLayout", args: changed, Int32(left), Int32(top), Int32(right), Int32(bottom))
    }

    /// Called to determine the size requirements for this view and all of its children.
    public func onMeasure(_ widthMeasureSpec: Int, _ heightMeasureSpec: Int) {
        instance?.callVoidMethod(name: "onMeasure", args: Int32(widthMeasureSpec), Int32(heightMeasureSpec))
    }
}

// MARK: Getters

extension SlidingDrawer {
    /// Returns the content view.
    public func content() -> View? {
        guard
            let returningClazz = JClass.load(View.className),
            let global = instance?.callObjectMethod(name: "getContent", returningClass: returningClazz)
        else { return nil }
        return View(global, { [weak self] in self?.instance?.context })
    }

    /// Returns the handle view.
    public func handle() -> View? {
        guard
            let returningClazz = JClass.load(View.className),
            let global = instance?.callObjectMethod(name: "getHandle", returningClass: returningClazz)
        else { return nil }
        return View(global, { [weak self] in self?.instance?.context })
    }

    /// Returns whether the drawer is currently moving.
    public func isMoving() -> Bool {
        instance?.callBoolMethod(name: "isMoving") ?? false
    }

    /// Returns whether the drawer is currently opened.
    public func isOpened() -> Bool {
        instance?.callBoolMethod(name: "isOpened") ?? false
    }
}

// MARK: Touch

extension SlidingDrawer {
    /// Intercepts touch events before they are dispatched to child views.
    public func onInterceptTouchEvent(_ event: MotionEvent) -> Bool {
        instance?.callBoolMethod(name: "onInterceptTouchEvent", args: event.signed(as: MotionEvent.className)) ?? false
    }

    /// Handles touch screen motion events.
    public func onTouchEvent(_ event: MotionEvent) -> Bool {
        instance?.callBoolMethod(name: "onTouchEvent", args: event.signed(as: MotionEvent.className)) ?? false
    }
}

// MARK: Listeners

struct SlidingDrawerOnDrawerCloseListenerViewProperty<T: JObjectable>: ViewPropertyToApply {
    let key: ViewPropertyKey = "setOnDrawerCloseListener"
    let value: T?
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value?.signed(as: .android.widget.SlidingDrawerOnDrawerCloseListener))
    }
}

struct SlidingDrawerOnDrawerOpenListenerViewProperty<T: JObjectable>: ViewPropertyToApply {
    let key: ViewPropertyKey = "setOnDrawerOpenListener"
    let value: T?
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value?.signed(as: .android.widget.SlidingDrawerOnDrawerOpenListener))
    }
}

struct SlidingDrawerOnDrawerScrollListenerViewProperty<T: JObjectable>: ViewPropertyToApply {
    let key: ViewPropertyKey = "setOnDrawerScrollListener"
    let value: T?
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value?.signed(as: .android.widget.SlidingDrawerOnDrawerScrollListener))
    }
}

extension SlidingDrawer {
    /// Sets the listener called when the drawer is closed.
    @discardableResult
    public func onDrawerCloseListener<T: JObjectable>(_ listener: T?) -> Self {
        SlidingDrawerOnDrawerCloseListenerViewProperty(value: listener).applyOrAppend(nil, self)
    }

    /// Sets the listener called when the drawer is opened.
    @discardableResult
    public func onDrawerOpenListener<T: JObjectable>(_ listener: T?) -> Self {
        SlidingDrawerOnDrawerOpenListenerViewProperty(value: listener).applyOrAppend(nil, self)
    }

    /// Sets the listener called during drawer scrolling.
    @discardableResult
    public func onDrawerScrollListener<T: JObjectable>(_ listener: T?) -> Self {
        SlidingDrawerOnDrawerScrollListenerViewProperty(value: listener).applyOrAppend(nil, self)
    }
}
