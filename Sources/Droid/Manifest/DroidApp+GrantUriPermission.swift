//
//  DroidApp+GrantUriPermission.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Specifies the subsets of app data that the parent content provider has permission to access.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/grant-uri-permission-element)
	public class GrantUriPermission: ManifestTag {
        class override var name: String { "grant-uri-permission" }
		
		required override init() {
            super.init()
        }
		
		// MARK: -
		
		/// A path identifying the data subset or subsets that permission can be granted for.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/grant-uri-permission-element#path)
		public func path(_ value: String) -> Self {
			params[.androidPath] = value
			return self
		}
		
		/// A path identifying the data subset or subsets that permission can be granted for.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/grant-uri-permission-element#path)
		public static func path(_ value: String) -> Self {
			Self().path(value)
		}
		
		// MARK: -
		
		/// A path identifying the data subset or subsets that permission can be granted for.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/grant-uri-permission-element#path)
		public func pathPattern(_ value: String) -> Self {
			params[.androidPathPattern] = value
			return self
		}
		
		/// A path identifying the data subset or subsets that permission can be granted for.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/grant-uri-permission-element#path)
		public static func pathPattern(_ value: String) -> Self {
			Self().pathPattern(value)
		}
		
		// MARK: -
		
		/// A path identifying the data subset or subsets that permission can be granted for.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/grant-uri-permission-element#path)
		public func pathPrefix(_ value: String) -> Self {
			params[.androidPathPrefix] = value
			return self
		}
		
		/// A path identifying the data subset or subsets that permission can be granted for.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/grant-uri-permission-element#path)
		public static func pathPrefix(_ value: String) -> Self {
			Self().pathPrefix(value)
		}
	}
}

