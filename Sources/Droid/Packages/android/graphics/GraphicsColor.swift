//
//  GraphicsColor.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

#if os(Android)
import Android
#endif

extension AndroidPackage.GraphicsPackage {
    public class ColorClass: JClassName, @unchecked Sendable {}
    
    public var Color: ColorClass { .init(parent: self, name: "Color") }
}

/// A structure representing an ARGB color, supporting multiple hex color formats.
/// Compatible with Android-style `0xAARRGGBB` encoding.
///
/// [Learn more](https://developer.android.com/reference/android/graphics/Color)
public struct GraphicsColor: ExpressibleByIntegerLiteral, Hashable, JValuable, Sendable {
    /// The final 32-bit ARGB color value.
    public let value: Int32

    #if os(Android)
    public var jValue: jvalue { value.jValue }
    #endif

    /// Initialize from an integer literal.
    /// Accepts various color formats:
    /// - 0xRGB (12-bit)
    /// - 0xARGB (16-bit)
    /// - 0xRRGGBB (24-bit)
    /// - 0xAARRGGBB (32-bit)
    public init(integerLiteral value: Int32) {
        self.value = value
    }

    /// Converts a hex color to 32-bit ARGB format.
    ///
    /// Supports the following input formats:
    /// - 0xRGB       (12-bit, e.g., `0xF0A`)
    /// - 0xARGB      (16-bit, e.g., `0x8F0A`)
    /// - 0xRRGGBB    (24-bit, e.g., `0xFFCC00`)
    /// - 0xAARRGGBB  (32-bit, e.g., `0xFFFFCC00`)
    public static func fromHex(_ hexValue: Int64) -> GraphicsColor {
        let hex = UInt64(bitPattern: hexValue)
        if hex <= 0xFFF {
            InnerLog.c("graphics color 12 bit")
            // 0xRGB (12-bit)
            let r = (hex & 0xF00) >> 8
            let g = (hex & 0x0F0) >> 4
            let b = hex & 0x00F
            return from(
                red: Int32(r << 4 | r),
                green: Int32(g << 4 | g),
                blue: Int32(b << 4 | b)
            )
        } else if hex <= 0xFFFF {
            InnerLog.c("graphics color 16 bit")
            // 0xARGB (16-bit)
            let a = (hex & 0xF000) >> 12
            let r = (hex & 0x0F00) >> 8
            let g = (hex & 0x00F0) >> 4
            let b = hex & 0x000F
            return from(
                red: Int32(r << 4 | r),
                green: Int32(g << 4 | g),
                blue: Int32(b << 4 | b),
                alpha: Int32(a << 4 | a)
            )
        } else if hex <= 0xFFFFFF {
            InnerLog.c("graphics color 24 bit")
            // 0xRRGGBB (24-bit)
            return from(
                red: Int32((hex & 0xFF0000) >> 16),
                green: Int32((hex & 0x00FF00) >> 8),
                blue: Int32(hex & 0x0000FF)
            )
        } else {
            InnerLog.c("graphics color 32 bit")
            // 0xAARRGGBB (32-bit)
            return .init(integerLiteral: Int32(truncatingIfNeeded: hex))
        }
    }

    /// Creates an ARGB 32-bit color value from components.
    ///
    /// - Parameters:
    ///   - red:   Red component (0-255)
    ///   - green: Green component (0-255)
    ///   - blue:  Blue component (0-255)
    ///   - alpha: Alpha component (0-255), default is 255 (opaque)
    public static func from(red: Int32, green: Int32, blue: Int32, alpha: Int32 = 255) -> GraphicsColor {
        #if DEBUG
        assert([red, green, blue, alpha].allSatisfy { 0...255 ~= $0 }, "Components must be 0-255")
        #endif
        return .init(integerLiteral: (alpha << 24) | (red << 16) | (green << 8) | blue)
    }

    // MARK: - Standard Android Color Constants

    public static let transparent: Self = .fromHex(0x00000000)
    public static let black: Self = .fromHex(0xFF000000)
    public static let white: Self = .fromHex(0xFFFFFFFF)
    public static let red: Self = .fromHex(0xFFFF0000)
    public static let green: Self = .fromHex(0xFF00FF00)
    public static let blue: Self = .fromHex(0xFF0000FF)
    public static let yellow: Self = .fromHex(0xFFFFFF00)
    public static let cyan: Self = .fromHex(0xFF00FFFF)
    public static let magenta: Self = .fromHex(0xFFFF00FF)
    public static let gray: Self = .fromHex(0xFF808080)
    public static let darkGray: Self = .fromHex(0xFF444444)
    public static let lightGray: Self = .fromHex(0xFFCCCCCC)
    public static let maroon: Self = .fromHex(0xFF800000)
    public static let olive: Self = .fromHex(0xFF808000)
    public static let navy: Self = .fromHex(0xFF000080)
    public static let teal: Self = .fromHex(0xFF008080)
    public static let purple: Self = .fromHex(0xFF800080)
    public static let silver: Self = .fromHex(0xFFC0C0C0)
    public static let lime: Self = .fromHex(0xFF00FF00)
    public static let aqua: Self = .fromHex(0xFF00FFFF)
    public static let fuchsia: Self = .fromHex(0xFFFF00FF)
    public static let orange: Self = .fromHex(0xFFFFA500)
    public static let brown: Self = .fromHex(0xFFA52A2A)
    public static let gold: Self = .fromHex(0xFFFFD700)
    public static let indigo: Self = .fromHex(0xFF4B0082)
    public static let violet: Self = .fromHex(0xFF8A2BE2)
    public static let pink: Self = .fromHex(0xFFFFC0CB)
}
