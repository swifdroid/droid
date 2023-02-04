//
//  DroidApp+MetaData.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// A name-value pair for an item of additional, arbitrary data that can be supplied to the parent component.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element)
	public class MetaData: ManifestTag {
		static var name: String { "meta-data" }
		
		var params: [ManifestTagParam] = []
		var items: [ManifestTag] = []
		
		required init() {}
		
		// MARK: -
		
		/// A unique name for the item. To ensure that the name is unique,
		/// use a Java-style naming convention — for example, "com.example.project.activity.fred".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element#nm)
		public func name(_ value: String) -> Self {
			params.append(.init(.androidName, value))
			return self
		}
		
		/// A unique name for the item. To ensure that the name is unique,
		/// use a Java-style naming convention — for example, "com.example.project.activity.fred".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element#nm)
		public static func name(_ value: String) -> Self {
			Self().name(value)
		}
		
		// MARK: -
		
		/// A reference to a resource.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element#rsrc)
		public func resource(_ value: String) -> Self { // TODO: resource specification
			params.append(.init(.androidResource, value))
			return self
		}
		
		/// A reference to a resource.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element#rsrc)
		public static func resource(_ value: String) -> Self {
			Self().resource(value)
		}
		
		// MARK: -
		
		/// The value assigned to the item.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element#val)
		public func value(_ value: String) -> Self {
			params.append(.init(.androidValue, value))
			return self
		}
		
		/// The value assigned to the item.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element#val)
		public static func value(_ value: String) -> Self {
			Self().value(value)
		}
	}
}

