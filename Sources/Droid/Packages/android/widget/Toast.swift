//
//  Toast.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

extension AndroidPackage.WidgetPackage {
    public class ToastClass: JClassName, @unchecked Sendable {}
    public var Toast: ToastClass { .init(parent: self, name: "Toast") }
}

#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class Toast: JObjectable, @unchecked Sendable {
    public static var className: JClassName { .android.widget.Toast }

    let context: ActivityContext
    public let object: JObject

    public convenience init? (_ context: ActivityContext) {
        guard let env = JEnv.current() else { return nil }
        self.init(env, context)
    }
    
    init? (_ env: JEnv, _ context: ActivityContext) {
        #if os(Android)
        guard
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(.android.content.Context), returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [context.object])
        else { return nil }
        self.context = context
        self.object = global
        #else
        return nil
        #endif
    }

    init (_ context: ActivityContext, _ object: JObject) {
        self.context = context
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
    public func setView(_ view: View) -> Self {
        guard
            let instance = view.setStatusAsContentView(context)
        else { return self }
        object.callVoidMethod(name: "setView", args: instance.signed(as: .android.view))
        return self
    }

    public func getView() -> JObject? {
        object.callObjectMethod(name: "getView", returning: .object(.android.view))
    }

    @discardableResult
    public func setDuration(_ length: Length) -> Self {
        object.callVoidMethod(name: "setDuration", args: length.rawValue)
        return self
    }

    @discardableResult
    public func setText(_ text: String) -> Self {
        #if os(Android)
        guard let string = JString(from: text) else { return self }
        object.callVoidMethod(name: "setText", args: [(string, .object(.java.lang.CharSequence))])
        #endif
        return self
    }

    @discardableResult
    public func setText(_ resId: Int32) -> Self {
        object.callVoidMethod(name: "setText", args: resId)
        return self
    }

    public private(set) var horizontalMargin: Float = 0
    public private(set) var verticalMargin: Float = 0
    public private(set) var marginDimensionUnit: DimensionUnit = .dp

    @discardableResult
    public func setMargin(_ horizontalMargin: Float, _ verticalMargin: Float, unit: DimensionUnit = .dp) -> Self {
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

    public func setGravity(gravity: Gravity, xOffset: Int, yOffset: Int, unit: DimensionUnit = .dp) {
        self.gravity = gravity
        self.gravityXOffset = xOffset
        self.gravityYOffset = yOffset
        self.gravityDimensionUnit = unit
        object.callVoidMethod(name: "setGravity", args: Int32(gravity.rawValue), unit.toPixels(Int32(xOffset)), unit.toPixels(Int32(yOffset)))
    }

    private var callback: NativeToastCallback?

    public func callback(onShown: @escaping () async -> Void, onHidden: @escaping () async -> Void) {
        #if os(Android)
        if let callback {
            object.callVoidMethod(name: "removeCallback", args: [(callback.object, .object("android/widget/Toast$Callback"))])
        }
        guard let callback = NativeToastCallback(context: context, onShown: onShown, onHidden: onHidden) else {
            return
        }
        self.callback = callback
        object.callVoidMethod(name: "addCallback", args: [(callback.object, .object("android/widget/Toast$Callback"))])
        #endif
    }

    @discardableResult
    public static func makeText(_ text: String, context: ActivityContext, duration: Length = .short) -> Toast? {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(.android.widget.Toast),
            let methodId = clazz.staticMethodId(name: "makeText", signature: .init(.object(.android.content.Context), .object(.java.lang.CharSequence), .int, returning: .object(.android.widget.Toast))),
            let string = JString(from: text),
            let global = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [context.object, string, duration.rawValue])
        else { return nil }
        return Toast(context, global)
        #else
        return nil
        #endif
    }

    @discardableResult
    public static func makeText(_ text: String, context: ActivityContext, duration: Length = .short, icon: Drawable) -> Toast? {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(.android.widget.Toast),
            let methodId = clazz.staticMethodId(name: "makeText", signature: .init(.object(.android.content.Context), .object(.java.lang.CharSequence), .int, .object(.android.graphics.drawable.Drawable), returning: .object(.android.widget.Toast))),
            let string = JString(from: text),
            let global = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [context.object, string, duration.rawValue, icon.object])
        else { return nil }
        return Toast(context, global)
        #else
        return nil
        #endif
    }

    @discardableResult
    public static func makeText(context: ActivityContext, stringResId: Int32, duration: Length = .short) -> Toast? {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(.android.widget.Toast),
            let methodId = clazz.staticMethodId(name: "makeText", signature: .init(.object(.android.content.Context), .int, .int, returning: .object(.android.widget.Toast))),
            let global = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [context.object, stringResId, duration.rawValue])
        else { return nil }
        return Toast(context, global)
        #else
        return nil
        #endif
    }
}