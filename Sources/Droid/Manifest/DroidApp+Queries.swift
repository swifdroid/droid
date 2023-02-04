//
//  DroidApp+Queries.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Specifies the set of other apps that an app intends to interact with.
	///
	/// These other apps can be specified by package name, by intent signature,
	/// or by provider authority, as described in later sections on this page.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/queries-element)
	public class Queries: ManifestTag {
		static var name: String { "queries" }
		
		var params: [ManifestTagParam] = []
		var items: [ManifestTag] = []
		
		required init() {}
		
		// MARK: -
		
		/// Specifies a single app that your app intends to access.
		///
		/// This other app might integrate with your app, or your app might use services that the other app provides.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/queries-element#package)
		public func package(_ name: String) -> Self {
			items.append(Package(name))
			return self
		}
		
		/// Specifies a single app that your app intends to access.
		///
		/// This other app might integrate with your app, or your app might use services that the other app provides.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/queries-element#package)
		public static func package(_ package: String) -> Self {
			Self().package(package)
		}
		
		// MARK: -
		
		/// [Learn more](https://developer.android.com/guide/topics/manifest/queries-element#intent)
		public func intent(_ handler: () -> DroidApp.Intent) -> Self {
			items.append(handler())
			return self
		}
		
		/// [Learn more](https://developer.android.com/guide/topics/manifest/queries-element#intent)
		public static func intent(_ handler: @escaping () -> DroidApp.Intent) -> Self {
			Self().intent(handler)
		}
		
		// MARK: -
		
		/// Specifies one or more content provider authorities.
		///
		/// Your app can discover other apps whose content providers use the specified authorities.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/queries-element#provider)
		public func provider(_ handler: () -> DroidApp.Provider) -> Self {
			items.append(handler())
			return self
		}
		
		/// Specifies one or more content provider authorities.
		///
		/// Your app can discover other apps whose content providers use the specified authorities.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/queries-element#provider)
		public static func provider(_ handler: @escaping () -> DroidApp.Provider) -> Self {
			Self().provider(handler)
		}
	}
}

