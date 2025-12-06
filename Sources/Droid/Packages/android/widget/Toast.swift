//
//  Toast.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

extension AndroidPackage.WidgetPackage {
    public class ToastClass: JClassName, @unchecked Sendable {}
    public var Toast: ToastClass { .init(parent: self, name: "Toast") }
}

@MainActor
public final class Toast: JObjectable, @unchecked Sendable {
    public static var className: JClassName { .android.widget.Toast }

    private(set) weak var context: ActivityContext?
    public let object: JObject

    public convenience init? (_ context: Contextable) {
        guard let env = JEnv.current() else { return nil }
        self.init(env, context)
    }
    
    init? (_ env: JEnv, _ context: Contextable) {
        #if os(Android)
        guard let context = context.context else  {
            InnerLog.c("🟥 Toast: Failed to initialize: context is nil")
            return nil
        }
        guard
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(Self.className),
            let global = clazz.newObject(env, args: context.object.signed(as: .android.content.Context))
        else { return nil }
        self.context = context
        self.object = global
        #else
        return nil
        #endif
    }

    init (_ context: Contextable, _ object: JObject) {
        self.context = context.context
        self.object = object
    }

    public enum Length: Int32 {
        case short = 0
        case long = 1
    }

    @discardableResult
    public func show() -> Self {
        object.callVoidMethod(name: "show")
        return self
    }

    public func cancel() {
        object.callVoidMethod(name: "cancel")
    }

    @discardableResult
    public func view(_ view: View) -> Self {
        guard
            let context,
            let instance = view.setStatusAsContentView(context)
        else { return self }
        object.callVoidMethod(name: "setView", args: instance.signed(as: .android.view.View))
        return self
    }

    public func view() -> JObject? {
        guard let returningClazz = JClass.load(.android.view.View) else { return nil }
        return object.callObjectMethod(name: "getView", returningClass: returningClazz)
    }

    @discardableResult
    public func duration(_ length: Length) -> Self {
        object.callVoidMethod(name: "setDuration", args: length.rawValue)
        return self
    }

    @discardableResult
    public func text(_ text: String) -> Self {
        #if os(Android)
        guard let string = JString(from: text) else { return self }
        object.callVoidMethod(name: "setText", args: [(string, .object(.java.lang.CharSequence))])
        #endif
        return self
    }

    @discardableResult
    public func text(_ resId: Int32) -> Self {
        object.callVoidMethod(name: "setText", args: resId)
        return self
    }

    public private(set) var horizontalMargin: Float = 0
    public private(set) var verticalMargin: Float = 0
    public private(set) var marginDimensionUnit: DimensionUnit = .dp

    @discardableResult
    public func margin(_ horizontalMargin: Float, _ verticalMargin: Float, unit: DimensionUnit = .dp) -> Self {
        self.horizontalMargin = horizontalMargin
        self.verticalMargin = verticalMargin
        self.marginDimensionUnit = unit
        object.callVoidMethod(name: "setDuration", args: horizontalMargin, verticalMargin)
        return self
    }

    public private(set) var gravity: Gravity?
    public private(set) var gravityXOffset: Int = 0
    public private(set) var gravityYOffset: Int = 0
    public private(set) var gravityDimensionUnit: DimensionUnit = .dp

    public func gravity(gravity: Gravity, xOffset: Int, yOffset: Int, unit: DimensionUnit = .dp) {
        self.gravity = gravity
        self.gravityXOffset = xOffset
        self.gravityYOffset = yOffset
        self.gravityDimensionUnit = unit
        object.callVoidMethod(name: "setGravity", args: Int32(gravity.rawValue), unit.toPixels(Int32(xOffset)), unit.toPixels(Int32(yOffset)))
    }

    #if os(Android)
    private var callback: NativeToastCallback?
    #endif

    public func callback(onShown: @escaping () async -> Void, onHidden: @escaping () async -> Void) {
        #if os(Android)
        if let instance = callback?.instance {
            object.callVoidMethod(name: "removeCallback", args: [(instance.object, .object("android/widget/Toast$Callback"))])
        }
        let callback = NativeToastCallback(DroidApp.getNextViewId(), viewId: nil)
            .setHandlers(onShown: onShown, onHidden: onHidden)
        self.callback = callback
        guard
            let context,
            let instance = callback.instantiate(context)
        else { return }
        object.callVoidMethod(name: "addCallback", args: [(instance.object, .object("android/widget/Toast$Callback"))])
        #endif
    }

    @discardableResult
    public static func makeText(_ text: String, context: Contextable, duration: Length = .short) -> Toast? {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let context = context.context,
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(.android.widget.Toast),
            let methodId = clazz.staticMethodId(name: "makeText", signature: .init(.object(.android.content.Context), .object(.java.lang.CharSequence), .int, returning: .object(.android.widget.Toast))),
            let string = JString(from: text),
            let global = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [context.object, string, duration.rawValue], returningClass: clazz)
        else { return nil }
        return Toast(context, global)
        #else
        return nil
        #endif
    }

    @discardableResult
    public static func makeText(_ text: String, context: Contextable, duration: Length = .short, icon: Drawable) -> Toast? {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let context = context.context,
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(.android.widget.Toast),
            let methodId = clazz.staticMethodId(name: "makeText", signature: .init(.object(.android.content.Context), .object(.java.lang.CharSequence), .int, .object(.android.graphics.drawable.Drawable), returning: .object(.android.widget.Toast))),
            let string = JString(from: text),
            let global = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [context.object, string, duration.rawValue, icon.object], returningClass: clazz)
        else { return nil }
        return Toast(context, global)
        #else
        return nil
        #endif
    }

    @discardableResult
    public static func makeText(stringResId: Int32, context: Contextable, duration: Length = .short) -> Toast? {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let context = context.context,
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(.android.widget.Toast),
            let methodId = clazz.staticMethodId(name: "makeText", signature: .init(.object(.android.content.Context), .int, .int, returning: .object(.android.widget.Toast))),
            let global = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [context.object, stringResId, duration.rawValue], returningClass: clazz)
        else { return nil }
        return Toast(context, global)
        #else
        return nil
        #endif
    }
}