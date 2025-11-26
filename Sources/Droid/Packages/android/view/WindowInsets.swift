//
//  WindowInsets.swift
//  Droid
//
//  Created by Mihael Isaev on 20.11.2025.
//

/// Describes a set of insets for window content.
///
/// WindowInsetsCompats are immutable and may be expanded
/// to include more inset types in the future. To adjust insets,
/// use one of the supplied clone methods to obtain
/// a new `WindowInsetsCompat` instance with the adjusted properties.
/// 
/// [Learn more](https://developer.android.com/reference/android/view/WindowInsets)
@MainActor
public final class WindowInsets: JObjectable, @unchecked Sendable {
    /// The JNI class name
    nonisolated public static let className: JClassName = "android/view/WindowInsets"

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    // TODO: getBoundingRects
    // TODO: getBoundingRectsIgnoringVisibility
    
    /// Returns the display cutout if there is one.
    public func displayCutout() -> DisplayCutout? {
        guard
            let returningClazz = JClass.load(DisplayCutout.className),
            let global = object.callObjectMethod(name: "getDisplayCutout", returningClass: returningClazz)
        else { return nil }
        return DisplayCutout(global)
    }

    /// Returns the display shape in the coordinate space of the window.
    public func displayShape() -> DisplayShape? {
        guard
            let returningClazz = JClass.load(DisplayShape.className),
            let global = object.callObjectMethod(name: "getDisplayShape", returningClass: returningClazz)
        else { return nil }
        return DisplayShape(global)
    }

    /// Returns the assumed size of the window, relative to
    /// which the `insets(int)` and `boundingRects(int)` have been calculated.
    ///
    /// May be used with `boundingRects(int)` to better understand their position within the window,
    /// such as the area between the edge of a bounding rect and the edge of the window.
    /// 
    /// Note: the size may not match the actual size of the window,
    /// which is determined during the layout pass - as `WindowInsets` are dispatched before layout.
    /// 
    /// Caution: using this value in determining the actual window size
    /// may make the result of layout passes unstable and should be avoided.
    public func frame() -> Size? {
        guard
            let returningClazz = JClass.load(Size.className),
            let global = object.callObjectMethod(name: "getFrame", returningClass: returningClazz)
        else { return nil }
        return Size(global)
    }

    /// Returns the insets of a specific set of windows causing insets,
    /// denoted by the typeMask bit mask of Types.
    /// 
    /// When running on devices with API Level 29 and before,
    /// the returned insets are an approximation based on the information available.
    /// 
    /// This is especially true for the IME type, which currently only works
    /// when running on devices with SDK level 23 and above.
    public func insets(_ mask: Int32) -> Insets? {
        guard
            let returningClazz = JClass.load(Insets.className),
            let global = object.callObjectMethod(name: "getInsets", args: mask, returningClass: returningClazz)
        else { return nil }
        return Insets(global)
    }

    /// Returns the insets a specific set of windows can cause,
    /// denoted by the typeMask bit mask of Types,
    /// regardless of whether that type is currently visible or not.
    ///
    /// The insets represents the area of a a window that that may be partially
    /// or fully obscured by the system window identified by typeMask.
    /// This value does not change based on the visibility state of those elements.
    // For example, if the status bar is normally shown, but temporarily hidden,
    // the inset returned here will still provide the inset associated with the status bar being shown.
    ///
    /// When running on devices with API Level 29 and before,
    /// the returned insets are an approximation based on the information available.
    /// This is especially true for the IME type, which currently only works
    /// when running on devices with SDK level 23 and above.
    public func insetsIgnoringVisibility(_ mask: Int32) -> Insets? {
        guard
            let returningClazz = JClass.load(Insets.className),
            let global = object.callObjectMethod(name: "getInsetsIgnoringVisibility", args: mask, returningClass: returningClazz)
        else { return nil }
        return Insets(global)
    }

    /// Returns a Rect representing the bounds of the system privacy indicator,
    /// for the current orientation, in the window space coordinates.
    /// 
    /// This method returns null if the system component doesn't have
    /// such indicators or the bounds have been consumed.
    public func privacyIndicatorBounds() -> Rect? {
        guard
            let returningClazz = JClass.load(Rect.className),
            let global = object.callObjectMethod(name: "getPrivacyIndicatorBounds", returningClass: returningClazz)
        else { return nil }
        return Rect(global)
    }

    /// Returns the `RoundedCorner` of the given position if there is one.
    public func roundedCorner(_ position: RoundedCorner.Position) -> RoundedCorner? {
        guard
            let returningClazz = JClass.load(RoundedCorner.className),
            let global = object.callObjectMethod(name: "getRoundedCorner", args: position.rawValue, returningClass: returningClazz)
        else { return nil }
        return RoundedCorner(global)
    }

    /// Returns true if this WindowInsets has any non-zero insets.
    public func hasInsets() -> Bool {
        object.callBoolMethod(name: "hasInsets") ?? false
    }

    // TODO: inset

    /// Check if these insets have been fully consumed.
    ///
    /// Insets are considered "consumed" if the applicable consume* methods
    /// have been called such that all insets have been set to zero.
    /// This affects propagation of insets through the view hierarchy;
    /// insets that have not been fully consumed will continue to propagate down to child views.
    ///
    /// The result of this method is equivalent to the return value of `fitSystemWindows`.
    public func isConsumed() -> Bool {
        object.callBoolMethod(name: "isConsumed") ?? false
    }

    /// Returns true if the associated window has a round shape.
    ///
    /// A round window's left, top, right and bottom edges reach all the way
    /// to the associated edges of the window but the corners may not be visible.
    /// Views responding to round insets should take care to
    /// not lay out critical elements within the corners where they may not be accessible.
    ///
    /// When running on platforms with API 19 and below, this method always returns `false`.
    public func isRound() -> Bool {
        object.callBoolMethod(name: "isRound") ?? false
    }

    /// Returns whether a set of windows that may cause insets is currently visible on screen,
    /// regardless of whether it actually overlaps with this window.
    /// When running on devices with API Level 29 and before,
    /// the returned value is an approximation based on the information available.
    /// This is especially true for the IME type, which currently only works
    /// when running on devices with SDK level 23 and above.
    public func isVisible(_ mask: Int32) -> Bool {
        object.callBoolMethod(name: "isVisible", args: mask) ?? false
    }
}

// TODO: implement WindowInsets.Builder

extension WindowInsets {
    /// Class that defines different sides for insets.
    ///
    /// [Learn more](https://developer.android.com/reference/android/view/WindowInsets.Side)
    @MainActor
    public final class Side: JObjectable, @unchecked Sendable {
        /// The JNI class name
        public static let className: JClassName = "android/view/WindowInsets$Side"
        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }

        public static let bottom: Int32 = 8
        public static let left: Int32 = 1
        public static let right: Int32 = 4
        public static let top: Int32 = 2

        /// Returns all four sides.
        public static func all() -> Int32 {
            guard 
                let clazz = JClass.load(Side.className),
                let value = clazz.staticIntMethod(name: "all")
            else { return 0 }
            return value
        }
    }
}

extension WindowInsets {
    /// Class that defines different types of sources causing window insets.
    ///
    /// [Learn more](https://developer.android.com/reference/android/view/WindowInsets.Type)
    @MainActor
    public final class InsetType: JObjectable, @unchecked Sendable {
        /// The JNI class name
        public static let className: JClassName = "android/view/WindowInsets$Type"
        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }

        /// An insets type representing the window of a caption bar.
        public static func captionBar() -> Int32 {
            guard 
                let clazz = JClass.load(InsetType.className),
                let value = clazz.staticIntMethod(name: "captionBar")
            else { return 0 }
            return value
        }

        /// Returns an insets type representing the area that used by `DisplayCutoutCompat`.
        ///
        /// This is equivalent to the safe insets on `getDisplayCutout`.
        public static func displayCutout() -> Int32 {
            guard 
                let clazz = JClass.load(InsetType.className),
                let value = clazz.staticIntMethod(name: "displayCutout")
            else { return 0 }
            return value
        }

        /// An insets type representing the window of an InputMethod.
        public static func ime() -> Int32 {
            guard 
                let clazz = JClass.load(InsetType.className),
                let value = clazz.staticIntMethod(name: "ime")
            else { return 0 }
            return value
        }

        /// An insets type representing mandatory system gestures.
        public static func mandatorySystemGestures() -> Int32 {
            guard 
                let clazz = JClass.load(InsetType.className),
                let value = clazz.staticIntMethod(name: "mandatorySystemGestures")
            else { return 0 }
            return value
        }

        /// An insets type representing any system bars for navigation.
        public static func navigationBars() -> Int32 {
            guard 
                let clazz = JClass.load(InsetType.className),
                let value = clazz.staticIntMethod(name: "navigationBars")
            else { return 0 }
            return value
        }

        /// An insets type representing any system bars for displaying status.
        public static func statusBars() -> Int32 {
            guard 
                let clazz = JClass.load(InsetType.className),
                let value = clazz.staticIntMethod(name: "statusBars")
            else { return 0 }
            return value
        }

        /// All system bars. Includes `statusBars`, `captionBar`
        /// as well as `navigationBars`, `systemOverlays` but not `ime`.
        public static func systemBars() -> Int32 {
            guard 
                let clazz = JClass.load(InsetType.className),
                let value = clazz.staticIntMethod(name: "systemBars")
            else { return 0 }
            return value
        }

        /// Returns an insets type representing the system gesture insets.
        ///
        /// The system gesture insets represent the area of a window
        /// where system gestures have priority and may consume some or all touch input,
        /// e.g. due to the a system bar occupying it, or it being reserved for touch-only gestures.
        ///
        /// Simple taps are guaranteed to reach the window even within the system gesture insets,
        /// as long as they are outside the system window insets.
        ///
        /// When `SYSTEM_UI_FLAG_LAYOUT_STABLE` is requested,
        /// an inset will be returned even when the system gestures are inactive
        /// due to `SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN` or `SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION`.
        public static func systemGestures() -> Int32 {
            guard 
                let clazz = JClass.load(InsetType.className),
                let value = clazz.staticIntMethod(name: "systemGestures")
            else { return 0 }
            return value
        }

        /// System overlays represent the insets caused by the system visible elements.
        /// Unlike `navigationBars` or `statusBars`, system overlays might not be hidden by the client.
        /// For compatibility reasons, this type is included in `systemBars`.
        /// In this way, views which fit `systemBars` fit `systemOverlays`.
        /// Examples include climate controls, multi-tasking affordances, etc.
        public static func systemOverlays() -> Int32 {
            guard 
                let clazz = JClass.load(InsetType.className),
                let value = clazz.staticIntMethod(name: "systemOverlays")
            else { return 0 }
            return value
        }

        public static func tappableElement() -> Int32 {
            guard 
                let clazz = JClass.load(InsetType.className),
                let value = clazz.staticIntMethod(name: "tappableElement")
            else { return 0 }
            return value
        }
    }
}

/// An Insets instance holds four integer offsets which describe changes to the four edges of a Rectangle.
/// By convention, positive values move edges towards the centre of the rectangle.
///
/// Insets are immutable so may be treated as values.
/// 
/// [Learn more](https://developer.android.com/reference/android/graphics/Insets)
@MainActor
public final class Insets: JObjectable, @unchecked Sendable {
    /// The JNI class name
    public static let className: JClassName = "android/graphics/Insets"

    /// JNI Object
    public let object: JObject

    private var _bottom, _left, _right, _top: Int32?
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public func bottom(_ unit: DimensionUnit = .dp) -> Int {
        if let _bottom { return unit.fromPixels(_bottom) }
        guard let v = object.intField(name: "bottom") else { return 0 }
        _bottom = v
        return unit.fromPixels(v)
    }

    public func left(_ unit: DimensionUnit = .dp) -> Int {
        if let _left { return unit.fromPixels(_left) }
        guard let v = object.intField(name: "left") else { return 0 }
        _left = v
        return unit.fromPixels(v)
    }

    public func right(_ unit: DimensionUnit = .dp) -> Int {
        if let _right { return unit.fromPixels(_right) }
        guard let v = object.intField(name: "right") else { return 0 }
        _right = v
        return unit.fromPixels(v)
    }

    public func top(_ unit: DimensionUnit = .dp) -> Int {
        if let _top { return unit.fromPixels(_top) }
        guard let v = object.intField(name: "top") else { return 0 }
        _top = v
        return unit.fromPixels(v)
    }

    /// Add two Insets.
    public static func add(_ a: Insets, _ b: Insets) -> Insets? {
        guard
            let clazz = JClass.load(Insets.className),
            let global = clazz.staticObjectMethod(
                name: "add",
                args: a.signed(as: Insets.className), b.signed(as: Insets.className),
                returningClass: clazz
            )
        else { return nil }
        return Insets(global)
    }

    /// Returns the component-wise maximum of two Insets.
    public static func max(_ a: Insets, _ b: Insets) -> Insets? {
        guard
            let clazz = JClass.load(Insets.className),
            let global = clazz.staticObjectMethod(
                name: "max",
                args: a.signed(as: Insets.className), b.signed(as: Insets.className),
                returningClass: clazz
            )
        else { return nil }
        return Insets(global)
    }

    /// Returns the component-wise minimum of two Insets.
    public static func min(_ a: Insets, _ b: Insets) -> Insets? {
        guard
            let clazz = JClass.load(Insets.className),
            let global = clazz.staticObjectMethod(
                name: "min",
                args: a.signed(as: Insets.className), b.signed(as: Insets.className),
                returningClass: clazz
            )
        else { return nil }
        return Insets(global)
    }

    /// Return an Insets instance with the appropriate values.
    public static func of(_ r: Rect) -> Insets? {
        guard
            let clazz = JClass.load(Insets.className),
            let global = clazz.staticObjectMethod(
                name: "of",
                args: r.signed(as: Rect.className),
                returningClass: clazz
            )
        else { return nil }
        return Insets(global)
    }

    /// Return an Insets instance with the appropriate values.
    public static func of(left: Int, top: Int, right: Int, bottom: Int, _ unit: DimensionUnit = .dp) -> Insets? {
        guard
            let clazz = JClass.load(Insets.className),
            let global = clazz.staticObjectMethod(
                name: "of",
                args: unit.toPixels(Int32(left)), unit.toPixels(Int32(top)), unit.toPixels(Int32(right)), unit.toPixels(Int32(bottom)),
                returningClass: clazz
            )
        else { return nil }
        return Insets(global)
    }

    /// Subtract two Insets.
    public static func subtract(_ a: Insets, _ b: Insets) -> Insets? {
        guard
            let clazz = JClass.load(Insets.className),
            let global = clazz.staticObjectMethod(
                name: "subtract",
                args: a.signed(as: Insets.className), b.signed(as: Insets.className),
                returningClass: clazz
            )
        else { return nil }
        return Insets(global)
    }
}

/// Represents the area of the display that is not functional for displaying content.
///
/// [Learn more](https://developer.android.com/reference/android/view/DisplayCutout)
@MainActor
public final class DisplayCutout: JObjectable, @unchecked Sendable {
    /// The JNI class name
    public static let className: JClassName = "android/view/DisplayCutout"

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    /// Returns a bounding rectangle for a non-functional area
    /// on the display which is located on the bottom of the screen.
    public func boundingRectBottom() -> Rect? {
        guard
            let returningClazz = JClass.load(Rect.className),
            let global = object.callObjectMethod(name: "getBoundingRectBottom", returningClass: returningClazz)
        else { return nil }
        return Rect(global)
    }

    /// Returns a bounding rectangle for a non-functional area
    /// on the display which is located on the left of the screen.
    public func boundingRectLeft() -> Rect? {
        guard
            let returningClazz = JClass.load(Rect.className),
            let global = object.callObjectMethod(name: "getBoundingRectLeft", returningClass: returningClazz)
        else { return nil }
        return Rect(global)
    }

    /// Returns a bounding rectangle for a non-functional area
    /// on the display which is located on the right of the screen.
    public func boundingRectRight() -> Rect? {
        guard
            let returningClazz = JClass.load(Rect.className),
            let global = object.callObjectMethod(name: "getBoundingRectRight", returningClass: returningClazz)
        else { return nil }
        return Rect(global)
    }

    /// Returns a bounding rectangle for a non-functional area
    /// on the display which is located on the top of the screen.
    public func boundingRectTop() -> Rect? {
        guard
            let returningClazz = JClass.load(Rect.className),
            let global = object.callObjectMethod(name: "getBoundingRectTop", returningClass: returningClazz)
        else { return nil }
        return Rect(global)
    }

    // TODO: getBoundingRects

    /// Returns a `Path` that contains the cutout paths of all sides on the display.
    /// 
    /// To get a cutout path for one specific side,
    /// apps can intersect the `Path` with the `Rect` obtained
    /// from `boundingRectLeft()`, `boundingRectTop()`,
    /// `boundingRectRight()` or `boundingRectBottom()`.
    public func cutoutPath() -> Path? {
        guard
            let returningClazz = JClass.load(Path.className),
            let global = object.callObjectMethod(name: "getCutoutPath", returningClass: returningClazz)
        else { return nil }
        return Path(global)
    }

    /// Returns the inset from the bottom which avoids the display cutout.
    public func safeInsetBottom(_ unit: DimensionUnit = .dp) -> Int {
        guard let inset = object.callIntMethod(name: "getSafeInsetBottom") else { return 0 }
        return unit.fromPixels(inset)
    }

    /// Returns the inset from the left which avoids the display cutout in pixels.
    public func safeInsetLeft(_ unit: DimensionUnit = .dp) -> Int {
        guard let inset = object.callIntMethod(name: "getSafeInsetLeft") else { return 0 }
        return unit.fromPixels(inset)
    }

    /// Returns the inset from the right which avoids the display cutout in pixels.
    public func safeInsetRight(_ unit: DimensionUnit = .dp) -> Int {
        guard let inset = object.callIntMethod(name: "getSafeInsetRight") else { return 0 }
        return unit.fromPixels(inset)
    }

    /// Returns the inset from the top which avoids the display cutout in pixels.
    public func safeInsetTop(_ unit: DimensionUnit = .dp) -> Int {
        guard let inset = object.callIntMethod(name: "getSafeInsetTop") else { return 0 }
        return unit.fromPixels(inset)
    }

    /// Returns the insets representing the curved areas of a waterfall display.
    /// A waterfall display has curved areas along the edges of the screen.
    /// Apps should be careful when showing UI and handling touch input
    /// in those insets because the curve may impair legibility
    /// and can frequently lead to unintended touch inputs.
    public func waterfallInsets() -> Insets? {
        guard
            let returningClazz = JClass.load(Insets.className),
            let global = object.callObjectMethod(name: "getWaterfallInsets", returningClass: returningClazz)
        else { return nil }
        return Insets(global)
    }
}

/// A class representing the shape of a display.
/// It provides a `Path` of the display shape of the display shape.
/// `DisplayShape` is immutable.
///
/// [Learn more](https://developer.android.com/reference/android/view/DisplayShape)
@MainActor
public final class DisplayShape: JObjectable, @unchecked Sendable {
    /// The JNI class name
    public static let className: JClassName = "android/view/DisplayShape"

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    /// Returns a Path of the display shape.
    public func path() -> Path? {
        guard
            let returningClazz = JClass.load(Path.className),
            let global = object.callObjectMethod(name: "getPath", returningClass: returningClazz)
        else { return nil }
        return Path(global)
    }
}

/// Represents a rounded corner of the display.
///
/// [Learn more](https://developer.android.com/reference/android/view/RoundedCorner)
@MainActor
public final class RoundedCorner: JObjectable, @unchecked Sendable {
    /// The JNI class name
    public static let className: JClassName = "android/view/RoundedCorner"

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public enum Position: Int32 {
        /// The rounded corner is at the bottom-left of the screen.
        case bottomLeft = 3
        /// The rounded corner is at the bottom-right of the screen.
        case bottomRight = 2
        /// The rounded corner is at the top-left of the screen.
        case topLeft = 0
        /// The rounded corner is at the top-right of the screen.
        case topRight = 1
    }

    /// Returns the circle center of a quarter circle approximation of this `RoundedCorner`.
    public func center() -> Point? {
        guard
            let returningClazz = JClass.load(Point.className),
            let global = object.callObjectMethod(name: "getCenter", returningClass: returningClazz)
        else { return nil }
        return Point(global)
    }

    /// Get the position of this RoundedCorner.
    public func position() -> Position {
        Position(rawValue: object.intField(name: "position") ?? 0) ?? .topLeft
    }

    /// Returns the radius of a quarter circle approximation of this RoundedCorner.
    public func radius(_ unit: DimensionUnit = .dp) -> Int {
        guard let radius = object.callIntMethod(name: "getRadius") else { return 0 }
        return unit.fromPixels(radius)
    }

    // TODO: writeToParcel
}