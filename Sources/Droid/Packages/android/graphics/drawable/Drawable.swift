//
//  Drawable.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidPackage.GraphicsPackage.DrawablePackage {
    public class DrawableClass: JClassName, @unchecked Sendable {}
    public var Drawable: DrawableClass { .init(parent: self, name: "Drawable") }
}

/// A Drawable is a general abstraction for "something that can be drawn."
/// 
/// Most often you will deal with Drawable as the type of resource retrieved for drawing things to the screen;
/// the Drawable class provides a generic API for dealing with an underlying visual resource that may take a variety of forms.
/// 
/// Unlike a View, a Drawable does not have any facility to receive events or otherwise interact with the user.
///
/// [Learn more](https://developer.android.com/reference/android/graphics/drawable/Drawable)
@MainActor
open class Drawable: JObjectable, @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { .android.graphics.drawable.Drawable }
    
    public let object: JObject

    @discardableResult
    public init (_ object: JObject) {
        self.object = object
    }

    public init? () {
        guard
            let clazz = JClass.load(Drawable.className),
            let global = clazz.newObject()
        else {
            InnerLog.c("🟥 Drawable: Failed to create instance using empty initializer")
            return nil
        }
        self.object = global
    }
}

extension Drawable {
    /// Applies the specified theme to this Drawable and its children.
    public func applyTheme(_ theme: RStyle) -> Self {
        object.callVoidMethod(name: "applyTheme", args: theme.resourseId)
        return self
    }

    /// Indicates whether this Drawable can apply a theme.
    public func canApplyTheme() -> Bool {
        object.callBoolMethod(name: "canApplyTheme") ?? false
    }

    /// Removes the color filter for this drawable.
    public func clearColorFilter() -> Self {
        object.callVoidMethod(name: "clearColorFilter")
        return self
    }

    /// Return a copy of the drawable's bounds in a new Rect.
    /// 
    /// This returns the same values as `getBounds()`, but the returned object is guaranteed
    /// to not be changed later by the drawable (i.e. it retains no reference to this rect).
    /// 
    /// If the caller already has a Rect allocated, call `copyBounds(rect)`.
    public func copyBounds() -> Rect {
        guard
            let returningClazz = JClass.load(Rect.className),
            let global = object.callObjectMethod(name: "copyBounds", returningClass: returningClazz)
        else {
            InnerLog.c("🟥 Drawable.copyBounds(): Failed to get bounds")
            return .init()
        }
        return .init(global)
    }

    /// Return a copy of the drawable's bounds in the specified Rect (allocated by the caller).
    /// 
    /// The bounds specify where this will draw when its draw() method is called.
    public func copyBounds(_ rect: Rect) -> Self {
        object.callVoidMethod(name: "copyBounds", args: rect.object)
        return self
    }

    /// Create a drawable from file path name.
    public static func createFromPath(_ path: String) -> Drawable? {
        guard
            let str = JString(from: path),
            let returningClazz = JClass.load(Drawable.className),
            let global = returningClazz.staticObjectMethod(
                    name: "createFromPath",
                    args: str,
                    returningClass: returningClazz
                )
        else {
            InnerLog.c("🟥 Drawable.createFromPath(): Failed to create drawable from path \(path)")
            return nil
        }
        return .init(global)
    }

    // TODO: createFromResourceStream
    // TODO: createFromStream
    // TODO: createFromXml
    // TODO: createFromXmlInner
    // TODO: draw

    /// Gets the current alpha value for the drawable.
    /// 
    /// 0 means fully transparent, 255 means fully opaque.
    /// 
    /// This method is implemented by Drawable subclasses
    /// and the value returned is specific to how that class treats alpha.
    /// 
    /// The default return value is 255 if the class does not override
    /// this method to return a value specific to its use of alpha.
    public func alpha() -> Int {
        Int(object.callIntMethod(name: "getAlpha") ?? 0)
    }

    /// Return the drawable's bounds Rect. Note: for efficiency,
    /// the returned object may be the same object stored in the drawable
    /// (though this is not guaranteed), so if a persistent copy of the bounds is needed,
    /// call copyBounds(rect) instead. You should also not change the object returned
    /// by this method as it may be the same object stored in the drawable.
    public func bounds() -> Rect {
        guard
            let returningClazz = JClass.load(Rect.className),
            let global = object.callObjectMethod(name: "getBounds", returningClass: returningClazz)
        else {
            InnerLog.c("🟥 Drawable.getBounds(): Failed to get bounds")
            return .init()
        }
        return .init(global)
    }

    // TODO: getCallback
    // TODO: getChangingConfigurations
    // TODO: getColorFilter: implement ColorFilter
    // TODO: getConstantState

    /// Gets the current drawable, which may be itself or a child drawable.
    public func current() -> Drawable {
        guard
            let returningClazz = JClass.load(Drawable.className),
            let global = object.callObjectMethod(name: "getCurrent", returningClass: returningClazz)
        else {
            InnerLog.c("🟥 Drawable.getCurrent(): Failed to get current drawable")
            return self
        }
        return .init(global)
    }

    /// Return the drawable's dirty bounds Rect. Note: for efficiency,
    /// the returned object may be the same object stored
    /// in the drawable (though this is not guaranteed).
    ///
    /// By default, this returns the full drawable bounds.
    /// Custom drawables may override this method to perform more precise invalidation.
    public func dirtyBounds() -> Rect {
        guard
            let returningClazz = JClass.load(Rect.className),
            let global = object.callObjectMethod(name: "getDirtyBounds", returningClass: returningClazz)
        else {
            InnerLog.c("🟥 Drawable.getDirtyBounds(): Failed to get dirty bounds")
            return .init()
        }
        return .init(global)
    }

    /// Populates `outRect` with the hotspot bounds.
    public func hotspotBounds(_ outRect: Rect) -> Self {
        object.callVoidMethod(name: "getHotspotBounds", args: outRect.object)
        return self
    }

    /// Returns the drawable's intrinsic height.
    ///
    /// Intrinsic height is the height at which the drawable would like to be laid out,
    /// including any inherent padding. If the drawable has no intrinsic height,
    /// such as a solid color, this method returns -1.
    public func intrinsicHeight(_ unit: DimensionUnit = .dp) -> Int {
        let pixels = object.callIntMethod(name: "getIntrinsicHeight") ?? 0
        return unit.fromPixels(pixels)
    }

    /// Returns the drawable's intrinsic width.
    ///
    /// Intrinsic width is the width at which the drawable would like to be laid out,
    /// including any inherent padding. If the drawable has no intrinsic width,
    /// such as a solid color, this method returns -1.
    public func intrinsicWidth(_ unit: DimensionUnit = .dp) -> Int {
        let pixels = object.callIntMethod(name: "getIntrinsicWidth") ?? 0
        return unit.fromPixels(pixels)
    }

    /// Returns the resolved layout direction for this Drawable.
    public func layoutDirection() -> LayoutDirection {
        let value = object.callIntMethod(name: "getLayoutDirection") ?? 0
        return LayoutDirection(rawValue: value) ?? .ltr
    }

    /// Retrieve the current level.
    public func level() -> Int {
        Int(object.callIntMethod(name: "getLevel") ?? 0)
    }

    /// Returns the minimum height suggested by this Drawable.
    ///
    /// If a View uses this Drawable as a background, it is suggested that the View
    /// use at least this value for its height. (There will be some scenarios
    /// where this will not be possible.) This value should `INCLUDE` any padding.
    public func minimumHeight(_ unit: DimensionUnit = .dp) -> Int {
        let pixels = object.callIntMethod(name: "getMinimumHeight") ?? 0
        return unit.fromPixels(pixels)
    }

    /// Returns the minimum width suggested by this Drawable.
    /// 
    /// If a View uses this Drawable as a background, it is suggested that the View
    /// use at least this value for its height. (There will be some scenarios
    /// where this will not be possible.) This value should `INCLUDE` any padding.
    public func minimumWidth(_ unit: DimensionUnit = .dp) -> Int {
        let pixels = object.callIntMethod(name: "getMinimumWidth") ?? 0
        return unit.fromPixels(pixels)
    }

    // TODO: getOpacity
    // public func getOpacity() -> PixelFormat {
    //     let value = object.callIntMethod(name: "getOpacity") ?? 0
    //     return PixelFormat(rawValue: value) ?? .unknown
    // }

    /// Return in insets the layout insets suggested
    /// by this Drawable for use with alignment operations during layout.
    public func opticalInsets() -> Insets? {
        guard
            let returningClazz = JClass.load(Insets.className),
            let global = object.callObjectMethod(name: "getOpticalInsets", returningClass: returningClazz)
        else {
            InnerLog.c("🟥 Drawable.getOpticalInsets(): Failed to get optical insets")
            return nil
        }
        return .init(global)
    }

    // TODO: getOutline: implement Outline
    // TODO: implement the rest of Drawable methods
}