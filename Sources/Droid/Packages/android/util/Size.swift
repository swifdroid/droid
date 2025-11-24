//
//  Size.swift
//  Droid
//
//  Created by Mihael Isaev on 20.11.2025.
//

/// Immutable class for describing width and height dimensions in pixels.
/// 
/// [Learn more](https://developer.android.com/reference/android/util/Size)
@MainActor
open class Size: JObjectable, @unchecked Sendable {
    /// The JNI class name
    nonisolated public static let className: JClassName = "android/util/Size"

    /// JNI Object
    public let object: JObject
    private var _width: Int32?
    private var _height: Int32?
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    /// Create a new immutable Size instance.
    public init? (width: Int, height: Int, _ unit: DimensionUnit = .dp) {
        guard
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(args: unit.toPixels(Int32(width)), unit.toPixels(Int32(height)))
        else { return nil }
        self.object = global
    }

    /// Get the height of the size.
    public func height(_ unit: DimensionUnit = .dp) -> Int {
        if let _height {
            return unit.fromPixels(_height)
        }
        guard let height = object.callIntMethod(name: "getHeight") else { return 0 }
        _height = height
        return unit.fromPixels(height)
    }

    /// Get the width of the size.
    public func width(_ unit: DimensionUnit = .dp) -> Int {
        if let _width {
            return unit.fromPixels(_width)
        }
        guard let width = object.callIntMethod(name: "getWidth") else { return 0 }
        _width = width
        return unit.fromPixels(width)
    }

    /// Parses the specified string as a size value.
    ///
    /// The ASCII characters \u002a ('*') and \u0078 ('x')
    /// are recognized as separators between the width and height.
    ///
    /// For any Size s: Size.parseSize(s.toString()).equals(s).
    /// However, the method also handles sizes expressed in the following forms:
    ///
    /// "widthxheight" or "width*height" => new Size(width, height),
    /// where width and height are string integers potentially containing a sign, such as "-10", "+7" or "5".
    public static func parseSize(_ string: String) -> Size? {
        guard
            let clazz = JClass.load(Self.className),
            let global = clazz.staticObjectMethod(name: "parseSize", args: string, returningClass: clazz)
        else { return nil }
        return Size(global)
    }
}