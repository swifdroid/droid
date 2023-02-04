//
//  DroidApp+Data.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Adds a data specification to an intent filter.
	///
	/// The specification can be just a data type (the mimeType attribute),
	/// just a URI, or both a data type and a URI.
	/// A URI is specified by separate attributes for each of its parts:
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element)
	public class Data: ManifestTag {
		static var name: String { "data" }
		
		var params: [ManifestTagParam] = []
		var items: [ManifestTag] = []
		
		required init() {}
		
		// MARK: -
		
		/// A MIME media type, such as image/jpeg or audio/mpeg4-generic.
		///
		/// The subtype can be the asterisk wildcard (*) to indicate that any subtype matches.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#mime)
		public func mimeType(_ value: MimeType) -> Self {
			params.append(.init(.androidMimeType, value.value))
			return self
		}
		
		/// A MIME media type, such as image/jpeg or audio/mpeg4-generic.
		///
		/// The subtype can be the asterisk wildcard (*) to indicate that any subtype matches.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#mime)
		public static func mimeType(_ value: MimeType) -> Self {
			Self().mimeType(value)
		}
		
		// MARK: -
		
		/// The scheme part of a URI.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#scheme)
		public func scheme(_ value: String) -> Self {
			params.append(.init(.androidScheme, value))
			return self
		}
		
		/// The scheme part of a URI.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#scheme)
		public static func scheme(_ value: String) -> Self {
			Self().scheme(value)
		}
		
		// MARK: -
		
		/// The host part of a URI authority.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#host)
		public func host(_ value: String) -> Self {
			params.append(.init(.androidHost, value))
			return self
		}
		
		/// The host part of a URI authority.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#host)
		public static func host(_ value: String) -> Self {
			Self().host(value)
		}
		
		// MARK: -
		
		/// The port part of a URI authority.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#port)
		public func port(_ value: String) -> Self {
			params.append(.init(.androidPort, value))
			return self
		}
		
		/// The port part of a URI authority.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#port)
		public static func port(_ value: String) -> Self {
			Self().port(value)
		}
		
		// MARK: -
		
		/// The path part of a URI which must begin with a /.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#path)
		public func path(_ value: String) -> Self {
			params.append(.init(.androidPath, value))
			return self
		}
		
		/// The path part of a URI which must begin with a /.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#path)
		public static func path(_ value: String) -> Self {
			Self().path(value)
		}
		
		// MARK: -
		
		/// The path part of a URI which must begin with a /.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#path)
		public func pathPattern(_ value: String) -> Self {
			params.append(.init(.androidPathPattern, value))
			return self
		}
		
		/// The path part of a URI which must begin with a /.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#path)
		public static func pathPattern(_ value: String) -> Self {
			Self().pathPattern(value)
		}
		
		// MARK: -
		
		/// The path part of a URI which must begin with a /.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#path)
		public func pathPrefix(_ value: String) -> Self {
			params.append(.init(.androidPathPrefix, value))
			return self
		}
		
		/// The path part of a URI which must begin with a /.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element#path)
		public static func pathPrefix(_ value: String) -> Self {
			Self().pathPrefix(value)
		}
	}
}

