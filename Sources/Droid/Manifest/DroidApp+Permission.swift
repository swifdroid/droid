//
//  DroidApp+Permission.swift
//  
//
//  Created by Mihael Isaev on 21.04.2022.
//

extension DroidApp {
	public class Permission: ManifestTag {
        override class var name: String { "permission" }
		
        override var order: Int { 0 }
        
        required override init() {
            super.init()
        }
        
        override func uniqueParams() -> [ManifestTagParamName] {
            [.androidName]
        }
		
		// MARK: -
		
		/// The name of the permission.
		///
		/// This is the name that will be used in code to refer to the permission — for example,
		/// in a `<uses-permission>` element and the permission attributes of application components.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#nm)
		public func name(_ value: ManifestPermission) -> Self {
			params[.androidName] = ManifestTagParamValue(value.value).value
			return self
		}
		
		/// The name of the permission.
		///
		/// This is the name that will be used in code to refer to the permission — for example,
		/// in a `<uses-permission>` element and the permission attributes of application components.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#nm)
		public static func name(_ value: ManifestPermission) -> Self {
			Self().name(value)
		}
		
		// MARK: -
		
		/// A user-readable description of the permission, longer and more informative than the label.
		///
		/// It may be displayed to explain the permission to the user.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#desc)
		public func description(_ value: String) -> Self {
			params[.androidDescription] = value
			return self
		}
		
		/// A user-readable description of the permission, longer and more informative than the label.
		///
		/// It may be displayed to explain the permission to the user.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#desc)
		public static func description(_ value: String) -> Self {
			Self().description(value)
		}
		
		// MARK: -
		
		/// A reference to a drawable resource for an icon that represents the permission.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#icon)
		public func icon(_ value: String) -> Self { // TODO: drawable resource
			params[.androidIcon] = value
			return self
		}
		
		/// A reference to a drawable resource for an icon that represents the permission.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#icon)
		public static func icon(_ value: String) -> Self {
			Self().icon(value)
		}
		
		// MARK: -
		
		/// A name for the permission, one that can be displayed to users.
		///
		/// As a convenience, the label can be directly set as a raw string while you're developing the application.
		///
		/// However, when the application is ready to be published, it should be set as a reference to a string resource,
		/// so that it can be localized like other strings in the user interface.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#label)
		public func label(_ value: String) -> Self { // TODO: string or string resource
			params[.androidLabel] = value
			return self
		}
		
		/// A name for the permission, one that can be displayed to users.
		///
		/// As a convenience, the label can be directly set as a raw string while you're developing the application.
		///
		/// However, when the application is ready to be published, it should be set as a reference to a string resource,
		/// so that it can be localized like other strings in the user interface.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#label)
		public static func label(_ value: String) -> Self {
			Self().label(value)
		}
		
		// MARK: -
		
		/// Assigns this permission to a group.
		///
		/// The value of this attribute is the name of the group, which must be declared
		/// with the `<permission-group>` element in this or another application.
		///
		/// If this attribute is not set, the permission does not belong to a group.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#pgroup)
		public func permissionGroup(_ value: ManifestPermissionGroup) -> Self {
			params[.androidPermissionGroup] = value.value
			return self
		}
		
		/// Assigns this permission to a group.
		///
		/// The value of this attribute is the name of the group, which must be declared
		/// with the `<permission-group>` element in this or another application.
		///
		/// If this attribute is not set, the permission does not belong to a group.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#pgroup)
		public static func permissionGroup(_ value: ManifestPermissionGroup) -> Self {
			Self().permissionGroup(value)
		}
		
		// MARK: -
		
		/// Characterizes the potential risk implied in the permission and indicates
		/// the procedure the system should follow when determining whether or not
		/// to grant the permission to an application requesting it.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#plevel)
		public func protectionLevel(_ value: ProtectionLevel) -> Self {
			params[.androidProtectionLevel] = ManifestTagParamValue(value).value
			return self
		}
		
		/// Characterizes the potential risk implied in the permission and indicates
		/// the procedure the system should follow when determining whether or not
		/// to grant the permission to an application requesting it.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#plevel)
		public static func protectionLevel(_ value: ProtectionLevel) -> Self {
			Self().protectionLevel(value)
		}
	}
}