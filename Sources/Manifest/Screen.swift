//
//  Screen.swift
//  Manifest
//
//  Created by Mihael Isaev on 29.07.2021.
//

import FoundationEssentials

/// Specifies each screen configuration with which the application is compatible.
///
/// [Learn more](https://developer.android.com/guide/topics/manifest/compatible-screens-element)
public class Screen {
    /// Specifies the screen size for this screen configuration.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/compatible-screens-element#screenSize)
    public enum Size: String, Codable {
        case small, normal, large, xlarge
    }
    
    let size: Size
    
    /// Specifies the screen density for the screen configuration.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/compatible-screens-element#screenDensity)
    public class Density: ExpressibleByIntegerLiteral {
        let value: String
        
        init (_ value: String) {
            self.value = value
        }
        
        public required init(integerLiteral value: Int) {
            self.value = "\(value)"
        }
        
        public static var ldpi: Density { .init("ldpi") }
        public static var mdpi: Density { .init("mdpi") }
        public static var hdpi: Density { .init("hdpi") }
        public static var xhdpi: Density { .init("xhdpi") }
    }
    
    let density: Density
    
    public init (_ size: Size, _ density: Density) {
        self.size = size
        self.density = density
    }
}
