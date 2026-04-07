//
//  Magnifier.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

extension AndroidPackage.WidgetPackage {
    public class MagnifierClass: JClassName, @unchecked Sendable {}
    public class MagnifierCallbackClass: JClassName, @unchecked Sendable {}
    public var Magnifier: MagnifierClass { .init(parent: self, name: "Magnifier") }
    public var MagnifierCallback: MagnifierCallbackClass { .init(parent: self, name: "Magnifier$Callback") }
}

/// A wrapper for `android.widget.Magnifier`.
///
/// [Learn more](https://developer.android.com/reference/android/widget/Magnifier)
@MainActor
open class Magnifier: JObjectable, @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { "android/widget/Magnifier" }

    /// JNI Object
    public let object: JObject

    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

// MARK: Methods

extension Magnifier {
    /// Dismisses this magnifier.
    public func dismiss() {
        object.callVoidMethod(name: "dismiss")
    }

    /// Returns the magnified content bitmap.
    public func content() -> JObject? {
        guard
            let returningClazz = JClass.load("android/graphics/Bitmap"),
            let global = object.callObjectMethod(name: "getContent", returningClass: returningClazz)
        else { return nil }
        return global
    }

    /// Returns the corner radius.
    public func cornerRadius() -> Float {
        object.callFloatMethod(name: "getCornerRadius") ?? 0
    }

    /// Returns the default horizontal source-to-magnifier offset.
    public func defaultHorizontalSourceToMagnifierOffset() -> Int {
        Int(object.callIntMethod(name: "getDefaultHorizontalSourceToMagnifierOffset") ?? 0)
    }

    /// Returns the default vertical source-to-magnifier offset.
    public func defaultVerticalSourceToMagnifierOffset() -> Int {
        Int(object.callIntMethod(name: "getDefaultVerticalSourceToMagnifierOffset") ?? 0)
    }

    /// Returns magnifier elevation.
    public func elevation() -> Float {
        object.callFloatMethod(name: "getElevation") ?? 0
    }

    /// Returns magnifier height.
    public func height() -> Int {
        Int(object.callIntMethod(name: "getHeight") ?? 0)
    }

    /// Returns magnifier default size.
    public class func magnifierDefaultSize() -> JObject? {
        guard
            let clazz = JClass.load(Self.className),
            let returningClazz = JClass.load("android/util/Size"),
            let global = clazz.staticObjectMethod(name: "getMagnifierDefaultSize", returningClass: returningClazz)
        else { return nil }
        return global
    }

    /// Returns magnifier default size.
    public func magnifierDefaultSize() -> JObject? {
        Self.magnifierDefaultSize()
    }

    /// Returns the original content bitmap.
    public func originalContent() -> JObject? {
        guard
            let returningClazz = JClass.load("android/graphics/Bitmap"),
            let global = object.callObjectMethod(name: "getOriginalContent", returningClass: returningClazz)
        else { return nil }
        return global
    }

    /// Returns the overlay drawable.
    public func overlay() -> Drawable? {
        guard
            let returningClazz = JClass.load(Drawable.className),
            let global = object.callObjectMethod(name: "getOverlay", returningClass: returningClazz)
        else { return nil }
        return Drawable(global)
    }

    /// Returns the current magnifier position.
    public func position() -> JObject? {
        guard
            let returningClazz = JClass.load("android/graphics/Point"),
            let global = object.callObjectMethod(name: "getPosition", returningClass: returningClazz)
        else { return nil }
        return global
    }

    /// Returns source content height.
    public func sourceHeight() -> Int {
        Int(object.callIntMethod(name: "getSourceHeight") ?? 0)
    }

    /// Returns source content position.
    public func sourcePosition() -> JObject? {
        guard
            let returningClazz = JClass.load("android/graphics/Point"),
            let global = object.callObjectMethod(name: "getSourcePosition", returningClass: returningClazz)
        else { return nil }
        return global
    }

    /// Returns source content width.
    public func sourceWidth() -> Int {
        Int(object.callIntMethod(name: "getSourceWidth") ?? 0)
    }

    /// Returns magnifier width.
    public func width() -> Int {
        Int(object.callIntMethod(name: "getWidth") ?? 0)
    }

    /// Returns current magnification zoom.
    public func zoom() -> Float {
        object.callFloatMethod(name: "getZoom") ?? 0
    }

    /// Returns whether clipping is enabled.
    public func isClippingEnabled() -> Bool {
        object.callBoolMethod(name: "isClippingEnabled") ?? true
    }

    /// Sets callback invoked when a magnifier operation completes.
    public func setOnOperationCompleteCallback<T: JObjectable>(_ callback: T?) {
        object.callVoidMethod(name: "setOnOperationCompleteCallback", args: callback?.signed(as: .android.widget.MagnifierCallback))
    }

    /// Sets the magnification zoom.
    @discardableResult
    public func setZoom(_ zoom: Float) -> Self {
        object.callVoidMethod(name: "setZoom", args: zoom)
        return self
    }

    /// Shows magnifier at source coordinates.
    public func show(_ sourceX: Float, _ sourceY: Float, _ magnifierCenterX: Float, _ magnifierCenterY: Float) {
        object.callVoidMethod(name: "show", args: sourceX, sourceY, magnifierCenterX, magnifierCenterY)
    }

    /// Shows magnifier at source coordinates.
    public func show(_ sourceX: Float, _ sourceY: Float) {
        object.callVoidMethod(name: "show", args: sourceX, sourceY)
    }

    /// Updates magnifier content and position.
    public func update() {
        object.callVoidMethod(name: "update")
    }
}
