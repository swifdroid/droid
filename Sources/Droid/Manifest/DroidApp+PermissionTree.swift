//
//  DroidApp+PermissionTree.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Declares the base name for a tree of permissions.
	///
	/// The application takes ownership of all names within the tree.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-tree-element)
	public class PermissionTree: ManifestTag {
		static var name: String { "permission-tree" }
		
		var params: [ManifestTagParam] = []
		var items: [ManifestTag] = []
		
		required init() {}
		
		// MARK: -
		
		/// An icon representing all the permissions in the tree.
		///
		/// This attribute must be set as a reference to a drawable resource containing the image definition.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-tree-element#icon)
		public func icon(_ value: String) -> Self { // TODO: drawable resource
			params.append(.init(.androidIcon, value))
			return self
		}
		
		/// An icon representing all the permissions in the tree.
		///
		/// This attribute must be set as a reference to a drawable resource containing the image definition.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-tree-element#icon)
		public static func icon(_ value: String) -> Self {
			Self().icon(value)
		}
		
		// MARK: -
		
		/// A user-readable name for the group.
		///
		/// As a convenience, the label can be directly set as a raw string for quick and dirty programming.
		///
		/// However, when the application is ready to be published, it should be set as a reference to a string resource,
		/// so that it can be localized like other strings in the user interface.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-tree-element#label)
		public func label(_ value: String) -> Self { // TODO: string or string resource
			params.append(.init(.androidLabel, value))
			return self
		}
		
		/// A user-readable name for the group.
		///
		/// As a convenience, the label can be directly set as a raw string for quick and dirty programming.
		///
		/// However, when the application is ready to be published, it should be set as a reference to a string resource,
		/// so that it can be localized like other strings in the user interface.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-tree-element#label)
		public static func label(_ value: String) -> Self {
			Self().label(value)
		}
		
		// MARK: -
		
		/// The name that's at the base of the permission tree.
		///
		/// It serves as a prefix to all permission names in the tree.
		/// Java-style scoping should be used to ensure that the name is unique.
		///
		/// The name must have more than two period-separated segments
		/// in its path — for example, com.example.base is OK, but com.example is not.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-tree-element#nm)
		public func name(_ value: String) -> Self {
			params.append(.init(.androidName, value))
			return self
		}
		
		/// The name that's at the base of the permission tree.
		///
		/// It serves as a prefix to all permission names in the tree.
		/// Java-style scoping should be used to ensure that the name is unique.
		///
		/// The name must have more than two period-separated segments
		/// in its path — for example, com.example.base is OK, but com.example is not.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-tree-element#nm)
		public static func name(_ value: String) -> Self {
			Self().name(value)
		}
	}
}

