//
//  Snackbar.swift
//  Droid
//
//  Created by Mihael Isaev on 24.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif


/// Snackbars provide lightweight feedback about an operation.
/// They show a brief message at the bottom of the screen on mobile and lower left on larger devices.
/// Snackbars appear above all other elements on screen and only one can be displayed at a time.
///
/// [Learn more](https://developer.android.com/reference/com/google/android/material/snackbar/Snackbar)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class Snackbar: JObjectable, Sendable {
    /// The JNI class name
    public class var className: JClassName { "com/google/android/material/snackbar/Snackbar" }
    public class var parentClassName: JClassName { "com/google/android/material/snackbar/BaseTransientBottomBar" }

    public let object: JObject
    public let view: View
    public let context: ActivityContext

    public init (_ object: JObject, _ view: View, _ context: Contextable) {
        self.object = object
        self.view = view
        self.context = context.context
    }

    /// Make a Snackbar to display a message
    ///
    /// Snackbar will try and find a parent view to hold Snackbar's view from the value given to view.
    /// Snackbar will walk up the view tree trying to find a suitable parent,
    /// which is defined as a `CoordinatorLayout` or the window decor's content view, whichever comes first.
    ///
    /// Having a `CoordinatorLayout` in your view hierarchy allows Snackbar
    /// to enable certain features, such as swipe-to-dismiss and automatically moving of widgets.
    public static func make(
        _ view: View,
        _ text: String,
        _ duration: Duration
    ) -> Self! {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let viewInstance = view.instance,
            let clazz = JClass.load(Self.className),
            let methodId = clazz.staticMethodId(name: "make", signature: .init(.object(.android.content.Context), .object(.android.view.View), .object(.java.lang.CharSequence), .int, returning: .object(Snackbar.className))),
            let str = JString(from: text),
            let global = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [viewInstance.context.object, viewInstance.object, str, duration.value])
        else { return nil }
        return .init(global, view, viewInstance.context)
        #else
        return nil
        #endif
    }

    /// Make a Snackbar to display a message
    ///
    /// Snackbar will try and find a parent view to hold Snackbar's view from the value given to view.
    /// Snackbar will walk up the view tree trying to find a suitable parent,
    /// which is defined as a `CoordinatorLayout` or the window decor's content view, whichever comes first.
    ///
    /// Having a `CoordinatorLayout` in your view hierarchy allows Snackbar
    /// to enable certain features, such as swipe-to-dismiss and automatically moving of widgets.
    public static func make(
        _ view: View,
        textResId: Int32,
        _ duration: Duration
    ) -> Self! {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let viewInstance = view.instance,
            let clazz = JClass.load(Self.className),
            let methodId = clazz.staticMethodId(name: "make", signature: .init(.object(.android.content.Context), .object(.android.view.View), .int, .int, returning: .object(Snackbar.className))),
            let global = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [viewInstance.context.object, viewInstance.object, textResId, duration.value])
        else { return nil }
        return .init(global, view, viewInstance.context)
        #else
        return nil
        #endif
    }

    /// Set the action to be displayed.
    public func action(_ text: String, _ handler: @escaping View.ClickListenerHandler) -> Self! {
        #if os(Android)
        let id = DroidApp.getNextViewId()
        guard
            let str = JString(from: text),
            let listenerInstance = NativeOnClickListener(id, viewId: id).setHandler(view, handler).instantiate(self.context),
            let returningClazz = JClass.load(Snackbar.className),
            let global = object.callObjectMethod(name: "setAction", args: str.signed(as: .java.lang.CharSequence), listenerInstance.object.signed(as: .android.view.ViewOnClickListener), returningClass: returningClazz, returning: .object(Snackbar.className))
        else { return self }
        return .init(global, view, context)
        #else
        return self
        #endif
    }

    /// Set the action to be displayed.
    public func action(textResId: Int32, _ handler: @escaping View.ClickListenerHandler) -> Self! {
        #if os(Android)
        let id = DroidApp.getNextViewId()
        guard
            let listenerInstance = NativeOnClickListener(id, viewId: id).setHandler(view, handler).instantiate(self.context),
            let returningClazz = JClass.load(Snackbar.className),
            let global = object.callObjectMethod(name: "setAction", args: textResId, listenerInstance.object.signed(as: .android.view.ViewOnClickListener), returningClass: returningClazz, returning: .object(Snackbar.className))
        else { return nil }
        return .init(global, view, context)
        #else
        return self
        #endif
    }

    /// Sets the text color of the action.
    public func actionTextColor(_ color: GraphicsColor) -> Self! {
        #if os(Android)
        guard
            let returningClazz = JClass.load(Snackbar.className),
            let global = object.callObjectMethod(name: "setActionTextColor", args: [(color.value, .int)], returningClass: returningClazz, returning: .object(Snackbar.className))
        else { return nil }
        return .init(global, view, context)
        #else
        return self
        #endif
    }

    /// Sets the tint color of the background Drawable.
    public func backgroundTint(_ color: GraphicsColor) -> Self! {
        #if os(Android)
        guard
            let returningClazz = JClass.load(Snackbar.className),
            let global = object.callObjectMethod(name: "setBackgroundTint", args: [(color.value, .int)], returningClass: returningClazz, returning: .object(Snackbar.className))
        else { return nil }
        return .init(global, view, context)
        #else
        return self
        #endif
    }

    // TODO: implement color methods with ColorStateList

    // TODO: implement BaseTransientBottomBar.addCallback it is parent method
    // TODO: implement setBackgroundTintMode

    /// Sets the max width of the action to be in the same line as the message.
    /// If the width is exceeded the action would go to the next line.
    public func maxInlineActionWidth(_ value: Int, _ unit: DimensionUnit = .dp) -> Self! {
        guard
            let returningClazz = JClass.load(Snackbar.className),
            let global = object.callObjectMethod(name: "setBackgroundTint", args: unit.toPixels(Int32(value)), returningClass: returningClazz, returning: .object(Snackbar.className))
        else { return nil }
        return .init(global, view, context)
    }

    /// Updates the text.
    public func text(_ text: String) -> Self! {
        guard
            let str = JString(from: text),
            let returningClazz = JClass.load(Snackbar.className),
            let global = object.callObjectMethod(name: "setBackgroundTint", args: str.signed(as: .java.lang.CharSequence), returningClass: returningClazz, returning: .object(Snackbar.className))
        else { return nil }
        return .init(global, view, context)
    }

    /// Updates the text.
    public func text(resId: Int32) -> Self! {
        guard
            let returningClazz = JClass.load(Snackbar.className),
            let global = object.callObjectMethod(name: "setBackgroundTint", args: resId, returningClass: returningClazz, returning: .object(Snackbar.className))
        else { return nil }
        return .init(global, view, context)
    }

    /// Sets the text color of the message.
    public func textColor(_ value: GraphicsColor) -> Self! {
        #if os(Android)
        guard
            let returningClazz = JClass.load(Snackbar.className),
            let global = object.callObjectMethod(name: "setTextColor", args: [(value.value, .int)], returningClass: returningClazz, returning: .object(Snackbar.className))
        else { return nil }
        return .init(global, view, context)
        #else
        return nil
        #endif
    }

    /// Sets the max line count of the message.
    public func textMaxLines(_ value: Int) -> Self! {
        guard
            let returningClazz = JClass.load(Snackbar.className),
            let global = object.callObjectMethod(name: "setTextMaxLines", args: Int32(value), returningClass: returningClazz, returning: .object(Snackbar.className))
        else { return nil }
        return .init(global, view, context)
    }

    /// Sets the animation mode.
    public func animationMode(_ value: AnimationMode) -> Self! {
        guard
            let returningClazz = JClass.load(Snackbar.className),
            let global = object.callObjectMethod(name: "setAnimationMode", args: value.rawValue, returningClass: returningClazz, returning: .object(Snackbar.parentClassName))
        else { return nil }
        return .init(global, view, context)
    }

    public func show() {
        object.callVoidMethod(name: "show")
    }

    public func dismiss() {
        object.callVoidMethod(name: "dismiss")
    }

    public func duration() -> Int {
        Int(object.callIntMethod(name: "getDuration") ?? 0)
    }

    public func isShown() -> Bool {
        object.callBoolMethod(name: "isShown") ?? false
    }
}

extension Snackbar {
    public enum AnimationMode: Int32 {
        /// Animation mode that corresponds to the slide in and out animations.
        case slide = 0
        /// Animation mode that corresponds to the fade in and out animations.
        case fade = 1
    }

    /// How long to display the message. Can be custom duration in milliseconds.
    public struct Duration: ExpressibleByIntegerLiteral, Sendable {
        let value: Int
        
        public init(integerLiteral value: Int) {
            self.value = value
        }

        /// Show the Snackbar indefinitely.
        /// 
        /// This means that the Snackbar will be displayed from the time that is shown until either it is dismissed, or another Snackbar is shown.
        public static let indefinite: Self = -2
        /// Show the Snackbar for a short period of time.
        public static let short: Self = -1
        /// Show the Snackbar for a long period of time.
        public static let long: Self = 0
    }
}