//
//  ScreenDensity.swift
//  
//
//  Created by Mihael Isaev on 21.04.2022.
//

public enum ScreenDensity: RawRepresentable {
	case ldpi, mdpi, hdpi, xhdpi
	case custom(Int)
	
	public init?(rawValue: String) {
		if let density = Int(rawValue) {
			self = .custom(density)
		} else {
			switch rawValue {
			case "ldpi": self = .ldpi
			case "mdpi": self = .mdpi
			case "hdpi": self = .hdpi
			case "xhdpi": self = .xhdpi
			default: return nil
			}
		}
	}
	
	public var rawValue: String {
		switch self {
		case .ldpi: return "ldpi"
		case .mdpi: return "mdpi"
		case .hdpi: return "hdpi"
		case .xhdpi: return "xhdpi"
		case .custom(let value): return "\(value)"
		}
	}
}
