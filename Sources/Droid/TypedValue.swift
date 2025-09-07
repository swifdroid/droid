public final class TypedValue: JObjectable, Sendable {
    /// The JNI class name
    public class var className: JClassName { "android/util/TypedValue" }

    /// Object wrapper
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    public convenience init? () {
        #if os(Android)
        guard let env = JEnv.current() else { return nil }
        self.init(env)
        #else
        return nil
        #endif
    }

    public init? (_ env: JEnv) {
        #if os(Android)
        guard
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env)
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }

    public var data: Int32 {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let fieldId = clazz.fieldId(name: "data", signature: .int)
        else {
            return 0
        }
        return env.getIntField(object, fieldId)
        #else
        return 0
        #endif
    }

    /// Converts a complex `data` value representing a dimension (from Android XML attributes)
    /// into an actual pixel size using the current screen's density configuration.
    ///
    /// This method mimics Android's `TypedValue.complexToDimensionPixelSize(int data, DisplayMetrics metrics)`.
    /// It interprets the bitwise-encoded `data` value (typically obtained from `TypedValue.data` after resolving an attribute),
    /// extracts the unit type, radix, and mantissa, applies the correct scaling factor, and converts it to pixels.
    ///
    /// - Parameter data: A 32-bit packed integer containing the complex dimension value. This is typically the `data` field
    ///   of a resolved `TypedValue` in Android's resource system.
    ///
    /// - Returns: The dimension in pixels, rounded to the nearest whole number using "round half away from zero" rule.
    public static func complexToDimensionPixelSize(_ data: Int32) -> Int32 {
        let COMPLEX_UNIT_SHIFT: Int64 = 0
        let COMPLEX_UNIT_MASK: Int64 = 0xF

        let COMPLEX_RADIX_SHIFT: Int64 = 4
        let COMPLEX_RADIX_MASK: Int64 = 0x3

        let COMPLEX_MANTISSA_MASK: Int64 = 0xFFFFFF00
        let COMPLEX_MANTISSA_SHIFT: Int64 = 8

        let unit = (Int64(data) >> COMPLEX_UNIT_SHIFT) & COMPLEX_UNIT_MASK
        let radix = (Int64(data) >> COMPLEX_RADIX_SHIFT) & COMPLEX_RADIX_MASK
        let mantissa = (Int64(data) & COMPLEX_MANTISSA_MASK) >> COMPLEX_MANTISSA_SHIFT

        let RADIX_MULTS: [Float] = [
            Float(1.0) / Float(1 << 0),
            Float(1.0) / Float(1 << 7),
            Float(1.0) / Float(1 << 15),
            Float(1.0) / Float(1 << 23)
        ]

        let value = Float(mantissa) * RADIX_MULTS[Int(radix)]

        let px: Float
        switch unit {
        case 1:
            px = value * DroidApp.shared.configuration.displayMetricsDensity // DIP
        case 2:
            px = value * DroidApp.shared.configuration.displayMetricsScaledDensity // SP
        case 3, 4, 5:
            px = value // PT, IN, MM
        default:
            px = value // fallback
        }

        return Int32(px.rounded(.toNearestOrAwayFromZero))
    }
}