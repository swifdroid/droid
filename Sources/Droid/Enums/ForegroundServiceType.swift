//
//  ForegroundServiceType.swift
//  
//
//  Created by Mihael Isaev on 24.04.2022.
//

/// [Learn more](https://developer.android.com/guide/topics/manifest/service-element#foregroundservicetype)
public struct ForegroundServiceType: ExpressibleByStringLiteral, StringValuable {
	let value: String
	
	public init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
	
	public static var camera: Self { "camera" }
	public static var connectedDevice: Self { "connectedDevice" }
	public static var dataSync: Self { "dataSync" }
	public static var location: Self { "location" }
	public static var mediaPlayback: Self { "mediaPlayback" }
	public static var mediaProjection: Self { "mediaProjection" }
	public static var microphone: Self { "microphone" }
	public static var phoneCall: Self { "phoneCall" }
}
