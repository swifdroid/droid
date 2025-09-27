//
//  DroidApp+PermissionGroup.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Declares a name for a logical grouping of related permissions.
	///
	/// Individual permission join the group through the permissionGroup attribute of the `<permission>` element.
	/// Members of a group are presented together in the user interface.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element)
	public class PermissionGroup: ManifestTag {
        override class var name: String { "permission-group" }
		
		required override init() {
            super.init()
        }
        
        override func uniqueParams() -> [ManifestTagParamName] {
            [.androidName]
        }
		
		// MARK: -
		
		/// User-readable text that describes the group.
		///
		/// The text should be longer and more explanatory than the label.
		///
		/// This attribute must be set as a reference to a string resource.
		/// Unlike the label attribute, it cannot be a raw string.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element#desc)
		public func description(_ value: String) -> Self { // TODO: string resource
			params[.androidDescription] = value
			return self
		}
		
		/// User-readable text that describes the group.
		///
		/// The text should be longer and more explanatory than the label.
		///
		/// This attribute must be set as a reference to a string resource.
		/// Unlike the label attribute, it cannot be a raw string.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element#desc)
		public static func description(_ value: String) -> Self {
			Self().description(value)
		}
		
		// MARK: -
		
		/// An icon representing the permission.
		///
		/// This attribute must be set as a reference to a drawable resource containing the image definition.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element#icon)
		public func icon(_ value: String) -> Self { // TODO: drawable resource
			params[.androidIcon] = value
			return self
		}
		
		/// An icon representing the permission.
		///
		/// This attribute must be set as a reference to a drawable resource containing the image definition.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element#icon)
		public static func icon(_ value: String) -> Self {
			Self().icon(value)
		}
		
		// MARK: -
		
		/// A user-readable name for the group.
		///
		/// As a convenience, the label can be directly set as a raw string while you're developing the application.
		///
		/// However, when the application is ready to be published, it should be set as a reference to a string resource,
		/// so that it can be localized like other strings in the user interface.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element#label)
		public func label(_ value: String) -> Self { // TODO: string or string resource
			params[.androidLabel] = value
			return self
		}
		
		/// A user-readable name for the group.
		///
		/// As a convenience, the label can be directly set as a raw string while you're developing the application.
		///
		/// However, when the application is ready to be published, it should be set as a reference to a string resource,
		/// so that it can be localized like other strings in the user interface.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element#label)
		public static func label(_ value: String) -> Self {
			Self().label(value)
		}
		
		// MARK: -
		
		/// The name of the group.
		///
		/// This is the name that can be assigned to a `<permission>` element's `<permissionGroup>` attribute.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element#nm)
		public func name(_ value: ManifestPermissionGroup) -> Self {
			params[.androidName] = value.value
			return self
		}
		
		/// The name of the group.
		///
		/// This is the name that can be assigned to a `<permission>` element's `<permissionGroup>` attribute.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element#nm)
		public static func name(_ value: ManifestPermissionGroup) -> Self {
			Self().name(value)
		}
	}
}
