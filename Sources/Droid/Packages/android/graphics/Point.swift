//
//  Point.swift
//  Droid
//
//  Created by Mihael Isaev on 20.11.2025.
//

/// Point holds two integer coordinates
/// 
/// [Learn more](https://developer.android.com/reference/android/graphics/Point)
@MainActor
open class Point: JObjectable, @unchecked Sendable {
    /// The JNI class name
    nonisolated public static let className: JClassName = "android/graphics/Point"

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? (_ x: Int, _ y: Int, _ unit: DimensionUnit = .dp) {
        guard
            let clazz = JClass.load(Self.className),
            let obj = clazz.newObject(args: unit.toPixels(Int32(x)), unit.toPixels(Int32(y)))
        else { return nil }
        self.object = obj
    }

    public func x(_ unit: DimensionUnit = .dp) -> Int32 { unit.toPixels(intField(name: "x")) }
    public func y(_ unit: DimensionUnit = .dp) -> Int32 { unit.toPixels(intField(name: "y")) }

    /// Negate the point's coordinates
    public func negate() {
        object.callVoidMethod(name: "negate")
    }

    /// Offset the point's coordinates by dx, dy
    public func offset(_ dx: Int, _ dy: Int, _ unit: DimensionUnit = .dp) {
        object.callVoidMethod(name: "offset", args: unit.toPixels(Int32(dx)), unit.toPixels(Int32(dy)))
    }

    // TODO: readFromParcel

    /// Set the point's x and y coordinates
    public func set(_ x: Int, _ y: Int, _ unit: DimensionUnit = .dp) {
        object.callVoidMethod(name: "set", args: unit.toPixels(Int32(x)), unit.toPixels(Int32(y)))
    }

    // TODO: writeToParcel
}