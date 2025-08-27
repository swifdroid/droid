//
//  DimensionUnit.swift
//  
//
//  Created by Mihael Isaev on 15.06.2025.
//

#if canImport(Android)
import Android
#endif

public enum DimensionUnit: Sendable {
    case px
    case dp
    case sp
    case pt
    case inch
    case mm
    
    public func toPixels(_ value: Float) -> Float {
        switch self {
        case .px:
            return value
        case .dp:
            return value * DroidApp.shared.configuration.displayMetricsDensity
        case .sp:
            return value * DroidApp.shared.configuration.displayMetricsScaledDensity
        case .pt:
            return value * DroidApp.shared.configuration.displayMetricsXdpi * (1.0 / 72)
        case .inch:
            return value * DroidApp.shared.configuration.displayMetricsXdpi
        case .mm:
            return value * DroidApp.shared.configuration.displayMetricsXdpi * (1.0 / 25.4)
        }
    }
    
    public func toPixels(_ value: Int32) -> Int32 {
        #if canImport(Android)
        return Int32(round(toPixels(Float(value))))
        #else
        return Int32(toPixels(Float(value)))
        #endif
    }
    
    /// Converts a pixel value into the current dimension unit.
    public func from(_ pixels: Float) -> Float {
        switch self {
        case .px:
            return pixels
        case .dp:
            return pixels / DroidApp.shared.configuration.displayMetricsDensity
        case .sp:
            return pixels / DroidApp.shared.configuration.displayMetricsScaledDensity
        case .pt:
            return pixels / (DroidApp.shared.configuration.displayMetricsXdpi * (1.0 / 72))
        case .inch:
            return pixels / DroidApp.shared.configuration.displayMetricsXdpi
        case .mm:
            return pixels / (DroidApp.shared.configuration.displayMetricsXdpi * (1.0 / 25.4))
        }
    }
    
    /// Converts a pixel value into the current dimension unit.
    public func from(_ pixels: Int32) -> Int {
        #if canImport(Android)
        return Int(round(from(Float(pixels))))
        #else
        return Int(from(Float(pixels)))
        #endif
    }
}