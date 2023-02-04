//
//  MimeType.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

public struct MimeType: ExpressibleByStringLiteral {
	let value: String
	
	public init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
	
	public static var applicationAny: Self { "application/*" }
	public static var applicationJSON: Self { "application/json" }
	public static var applicationXML: Self { "application/xml" }
	public static var applicationPDF: Self { "application/pdf" }
	public static var applicationZIP: Self { "application/zip" }
	public static var applicationXTAR: Self { "application/x-tar" }
	public static var applicationXGZIP: Self { "application/x-gzip" }
	public static var applicationXBZIP2: Self { "application/x-bzip2" }
	public static var imageAny: Self { "image/*" }
	public static var imageGIF: Self { "image/gif" }
	public static var imageJPEG: Self { "image/jpeg" }
	public static var imagePNG: Self { "image/png" }
	public static var imageSVG: Self { "image/svg+xml" }
	public static var audioAny: Self { "audio/*" }
	public static var audioBasic: Self { "audio/basic" }
	public static var audioXMIDI: Self { "audio/x-midi" }
	public static var audioMPEG: Self { "audio/mpeg" }
	public static var audioWAV: Self { "audio/wav" }
	public static var audioVORBIS: Self { "audio/vorbis" }
	public static var videoAny: Self { "video/*" }
	public static var videoAVI: Self { "video/avi" }
	public static var videoMPEG: Self { "video/mpeg" }
}
