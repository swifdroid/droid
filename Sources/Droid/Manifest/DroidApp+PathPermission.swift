//
//  DroidApp+PathPermission.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Defines the path and required permissions for a specific subset of data within a content provider.
	/// This element can be specified multiple times to supply multiple paths.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element)
	public class PathPermission: ManifestTag {
        class override var name: String { "path-permission" }
		
		required override init() {
            super.init()
        }
		
		// MARK: -
		
		/// A complete URI path for a subset of content provider data.
		///
		/// Permission can be granted only to the particular data identified by this path.
		/// When used to provide search suggestion content, it must be appended with "/search_suggest_query".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#path)
		public func path(_ value: String) -> Self {
			params[.androidPath] = value
			return self
		}
		
		/// A complete URI path for a subset of content provider data.
		///
		/// Permission can be granted only to the particular data identified by this path.
		/// When used to provide search suggestion content, it must be appended with "/search_suggest_query".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#path)
		public static func path(_ value: String) -> Self {
			Self().path(value)
		}
		
		// MARK: -
		
		/// The initial part of a URI path for a subset of content provider data.
		///
		/// Permission can be granted to all data subsets with paths that share this initial part.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#pathPrefix)
		public func pathPrefix(_ value: String) -> Self {
			params[.androidPathPrefix] = value
			return self
		}
		
		/// The initial part of a URI path for a subset of content provider data.
		///
		/// Permission can be granted to all data subsets with paths that share this initial part.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#pathPrefix)
		public static func pathPrefix(_ value: String) -> Self {
			Self().pathPrefix(value)
		}
		
		// MARK: -
		
		/// A complete URI path for a subset of content provider data.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#pathPattern)
		public func pathPattern(_ value: String) -> Self {
			params[.androidPathPattern] = value
			return self
		}
		
		/// A complete URI path for a subset of content provider data.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#pathPattern)
		public static func pathPattern(_ value: String) -> Self {
			Self().pathPattern(value)
		}
		
		// MARK: -
		
		/// The name of a permission that clients must have in order to read or write the content provider's data.
		///
		/// This attribute is a convenient way of setting a single permission for both reading and writing.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#permission)
		public func permission(_ value: String) -> Self {
			params[.androidPermission] = value
			return self
		}
		
		/// The name of a permission that clients must have in order to read or write the content provider's data.
		///
		/// This attribute is a convenient way of setting a single permission for both reading and writing.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#permission)
		public static func permission(_ value: String) -> Self {
			Self().permission(value)
		}
		
		// MARK: -
		
		/// A permission that clients must have in order to query the content provider.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#readPermission)
		public func readPermission(_ value: String) -> Self {
			params[.androidReadPermission] = value
			return self
		}
		
		/// A permission that clients must have in order to query the content provider.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#readPermission)
		public static func readPermission(_ value: String) -> Self {
			Self().readPermission(value)
		}
		
		// MARK: -
		
		/// A permission that clients must have in order to make changes to the data controlled by the content provider.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#writePermission)
		public func writePermission(_ value: String) -> Self {
			params[.androidWritePermission] = value
			return self
		}
		
		/// A permission that clients must have in order to make changes to the data controlled by the content provider.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element#writePermission)
		public static func writePermission(_ value: String) -> Self {
			Self().writePermission(value)
		}
	}
}

