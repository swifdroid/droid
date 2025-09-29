//
//  DroidApp+UsesPermission.swift
//  Droid
//
//  Created by Mihael Isaev on 18.09.2025.
//

extension DroidApp {
    /// Specifies a system permission that the user must grant for the app to operate correctly.
    /// 
    /// The user grants permissions when the application installs, on devices running Android 5.1 and lower,
    /// or while the app runs, on devices running Android 6.0 and higher.
    ///
    /// **Note**: In some cases, the permissions that you request through `<uses-permission>`
    /// can affect how Google Play filters your application.
    /// 
    /// If you request a hardware-related permission, such as `CAMERA`,
    /// Google Play assumes that your application requires the underlying hardware feature
    /// and filters the application from devices that don't offer it.
    ///
    /// To control filtering, always explicitly declare hardware features in `<uses-feature>` elements,
    /// rather than relying on Google Play to "discover" the requirements in `<uses-permission>` elements.
    /// Then, if you want to disable filtering for a particular feature,
    /// you can add a `android:required="false"` attribute to the `<uses-feature>` declaration.
    ///
    /// For a list of permissions that imply hardware features, see the documentation for the `<uses-feature>` element.
	public class UsesPermission: ManifestTag {
        override class var name: String { "uses-permission" }
		
        override var order: Int { 0 }
        
        required override init() {
            super.init()
        }
        
        override func uniqueParams() -> [ManifestTagParamName] {
            [.androidName]
        }
		
		// MARK: Name
		
		/// The name of the permission.
        /// 
        /// It can be a permission defined by the application with the <permission> element,
        /// a permission defined by another application, or one of the standard system permissions,
        /// such as "android.permission.CAMERA" or "android.permission.READ_CONTACTS".
        /// 
        /// As these examples show, a permission name typically includes the package name as a prefix.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-permission-element)
		public func name(_ value: ManifestPermission) -> Self {
			params[.androidName] = ManifestTagParamValue(value.value).value
			return self
		}
		
		/// The name of the permission.
        /// 
        /// It can be a permission defined by the application with the <permission> element,
        /// a permission defined by another application, or one of the standard system permissions,
        /// such as "android.permission.CAMERA" or "android.permission.READ_CONTACTS".
        /// 
        /// As these examples show, a permission name typically includes the package name as a prefix.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-permission-element)
		public static func name(_ value: ManifestPermission) -> Self {
			Self().name(value)
		}
		
		// MARK: - Max SDK Version
		
        /// The highest API level at which this permission is granted to your app.
        /// 
        /// If the app installs on a device with a later API level, the app isn't granted the permission and can't use any related functionality.
        /// 
		/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-permission-element)
		public func maxSdkVersion(_ value: Int) -> Self {
			params[.androidMaxSDKVersion] = "\(value)"
			return self
		}
		
		/// The highest API level at which this permission is granted to your app.
        /// 
        /// If the app installs on a device with a later API level, the app isn't granted the permission and can't use any related functionality.
        /// 
		/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-permission-element)
		public static func maxSdkVersion(_ value: Int) -> Self {
			Self().maxSdkVersion(value)
		}
	}
}
