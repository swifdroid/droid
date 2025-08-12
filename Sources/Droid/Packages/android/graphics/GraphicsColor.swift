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
public struct GraphicsColor: ExpressibleByIntegerLiteral, Hashable, JValuable, Sendable {
    /// The final 32-bit ARGB color value.
    public let value: Int64

    #if os(Android)
    public var jValue: jvalue { value.jValue }
    #endif

    /// Initialize from an integer literal.
    /// Accepts various color formats:
    /// - 0xRGB (12-bit)
    /// - 0xARGB (16-bit)
    /// - 0xRRGGBB (24-bit)
    /// - 0xAARRGGBB (32-bit)
    public init(integerLiteral value: Int64) {
        self.value = Self.fromHex(value)
    }

    /// Converts a hex color to 32-bit ARGB format.
    ///
    /// Supports the following input formats:
    /// - 0xRGB       (12-bit, e.g., `0xF0A`)
    /// - 0xARGB      (16-bit, e.g., `0x8F0A`)
    /// - 0xRRGGBB    (24-bit, e.g., `0xFFCC00`)
    /// - 0xAARRGGBB  (32-bit, e.g., `0xFFFFCC00`)
    public static func fromHex(_ hexValue: Int64) -> Int64 {
        let hex = UInt64(bitPattern: hexValue)
        
        if hex <= 0xFFF {
            // 0xRGB (12-bit)
            let r = Int64((hex & 0xF00) >> 8)
            let g = Int64((hex & 0x0F0) >> 4)
            let b = Int64(hex & 0x00F)
            return from(
                red: r << 4 | r,
                green: g << 4 | g,
                blue: b << 4 | b
            )
        } else if hex <= 0xFFFF {
            // 0xARGB (16-bit)
            let a = Int64((hex & 0xF000) >> 12)
            let r = Int64((hex & 0x0F00) >> 8)
            let g = Int64((hex & 0x00F0) >> 4)
            let b = Int64(hex & 0x000F)
            return from(
                red: r << 4 | r,
                green: g << 4 | g,
                blue: b << 4 | b,
                alpha: a << 4 | a
            )
        } else if hex <= 0xFFFFFF {
            // 0xRRGGBB (24-bit)
            return from(
                red: Int64((hex & 0xFF0000) >> 16),
                green: Int64((hex & 0x00FF00) >> 8),
                blue: Int64(hex & 0x0000FF)
            )
        } else {
            // 0xAARRGGBB (32-bit)
            return Int64(bitPattern: hex)
        }
    }

    /// Creates an ARGB 32-bit color value from components.
    ///
    /// - Parameters:
    ///   - red:   Red component (0-255)
    ///   - green: Green component (0-255)
    ///   - blue:  Blue component (0-255)
    ///   - alpha: Alpha component (0-255), default is 255 (opaque)
    public static func from(red: Int64, green: Int64, blue: Int64, alpha: Int64 = 255) -> Int64 {
        #if DEBUG
        assert([red, green, blue, alpha].allSatisfy { 0...255 ~= $0 }, "Components must be 0-255")
        #endif
        return (alpha << 24) | (red << 16) | (green << 8) | blue
    }

    // MARK: - Standard Android Color Constants

    public static let transparent: Self = 0x00000000
    public static let black: Self = 0xFF000000
    public static let white: Self = 0xFFFFFFFF
    public static let red: Self = 0xFFFF0000
    public static let green: Self = 0xFF00FF00
    public static let blue: Self = 0xFF0000FF
    public static let yellow: Self = 0xFFFFFF00
    public static let cyan: Self = 0xFF00FFFF
    public static let magenta: Self = 0xFFFF00FF
    public static let gray: Self = 0xFF808080
    public static let darkGray: Self = 0xFF444444
    public static let lightGray: Self = 0xFFCCCCCC
    public static let maroon: Self = 0xFF800000
    public static let olive: Self = 0xFF808000
    public static let navy: Self = 0xFF000080
    public static let teal: Self = 0xFF008080
    public static let purple: Self = 0xFF800080
    public static let silver: Self = 0xFFC0C0C0
    public static let lime: Self = 0xFF00FF00
    public static let aqua: Self = 0xFF00FFFF
    public static let fuchsia: Self = 0xFFFF00FF
    public static let orange: Self = 0xFFFFA500
    public static let brown: Self = 0xFFA52A2A
    public static let gold: Self = 0xFFFFD700
    public static let indigo: Self = 0xFF4B0082
    public static let violet: Self = 0xFF8A2BE2
    public static let pink: Self = 0xFFFFC0CB
}
