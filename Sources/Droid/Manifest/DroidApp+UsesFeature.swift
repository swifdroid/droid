//
//  DroidApp+UsesFeature.swift
//  Droid
//
//  Created by Mihael Isaev on 18.09.2025.
//

extension DroidApp {
	/// Declares a single hardware or software feature that is used by the application.
	///
	/// The purpose of a `<uses-feature>` declaration is to inform any external entity of the set
	/// of hardware and software features your application depends on.
	/// 
	/// The element offers a required attribute that lets you specify whether your application requires
	/// and can't function without the declared feature or prefers to have the feature but can function without it.
	/// 
	/// Because feature support can vary across Android devices, the `<uses-feature>` element serves
	/// an important role in letting an application describe the device-variable features that it uses.
	/// 
	/// The set of available features that your application declares corresponds to the set of feature constants
	/// made available by the Android PackageManager. Feature constants are listed in the Features reference section in this document.
	/// 
	/// You must specify each feature in a separate `<uses-feature>` element, so if your application requires multiple features,
	/// it declares multiple `<uses-feature>` elements. For example, an application that requires both Bluetooth
	/// and camera features in the device declares these two elements:
	///
	/// ```
	///  UsesFeature(.hardwareBluetooth, required: true)
	///  UsesFeature(.hardwareCameraAny, required: true)
	/// ```
	/// 
	/// In general, always declare `<uses-feature>` elements for all the features that your application requires.
	/// 
	/// Declared `<uses-feature>` elements are informational only, meaning that the Android system itself
	/// doesn't check for matching feature support on the device before installing an application.
	/// 
	/// However, other services, such as Google Play, and applications can check your application's `<uses-feature>` declarations
	/// as part of handling or interacting with your application. For this reason,
	/// it's very important that you declare all of the features that your application uses.
	/// 
	/// For some features, there might be a specific attribute that lets you define a version of the feature,
	/// such as the version of Open GL used (declared with glEsVersion).
	/// 
	/// Other features that either do or don't exist for a device, such as a camera, are declared using the name attribute.
	/// 
	/// Although the `<uses-feature>` element is only activated for devices running API Level 4 or higher,
	/// include these elements for all applications, even if the minSdkVersion is 3 or lower.
	/// 
	/// Devices running older versions of the platform ignore the element.
	///
	/// **Note**: When declaring a feature, remember that you must also request permissions as appropriate.
	/// For example, you need to request the `CAMERA` permission before your application can access the camera API.
	/// Requesting the permission grants your application access to the appropriate hardware and software.
	/// Declaring the features used by your application helps ensure proper device compatibility.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-feature-element)
	public class UsesFeature: ManifestTag {
        override class var name: String { "uses-feature" }
		
        override var order: Int { 0 }
        
        required override init() {
            super.init()
        }
        
        override func uniqueParams() -> [ManifestTagParamName] {
            [.androidName]
        }
		
		// MARK: Name
		
		/// Specifies a single hardware or software feature used by the application as a descriptor string.
		/// 
		/// Valid attribute values are listed in the Hardware features and Software features sections.
		/// 
		/// These attribute values are case-sensitive.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-feature-element)
		public func name(_ value: ManifestFeature) -> Self {
			params[.androidName] = ManifestTagParamValue(value.value).value
			return self
		}
		
		/// Specifies a single hardware or software feature used by the application as a descriptor string.
		/// 
		/// Valid attribute values are listed in the Hardware features and Software features sections.
		/// 
		/// These attribute values are case-sensitive.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-feature-element)
		public static func name(_ value: ManifestFeature) -> Self {
			Self().name(value)
		}
		
		// MARK: - Required
		
		/// Boolean value that indicates whether the application requires the feature specified in android:name.
		/// 
		/// - Declaring "true" for a feature indicates that the application can't function,
		/// or isn't designed to function, when the specified feature isn't present on the device.
		/// - Declaring "false" for a feature indicates that the application uses the feature if present on the device,
		/// but that it is designed to function without the specified feature if necessary.
		/// 
		/// The default value for android:required is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-feature-element)
		public func required(_ value: Bool) -> Self {
			params[.androidRequired] = value ? "true" : "false"
			return self
		}
		
		/// Boolean value that indicates whether the application requires the feature specified in android:name.
		/// 
		/// - Declaring "true" for a feature indicates that the application can't function,
		/// or isn't designed to function, when the specified feature isn't present on the device.
		/// - Declaring "false" for a feature indicates that the application uses the feature if present on the device,
		/// but that it is designed to function without the specified feature if necessary.
		/// 
		/// The default value for android:required is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-feature-element)
		public static func required(_ value: Bool) -> Self {
			Self().required(value)
		}
		
		// MARK: - GL ES Version
		
		/// The OpenGL ES version required by the application.
		/// 
		/// The higher 16 bits represent the major number and the lower 16 bits represent the minor number.
		/// For example, to specify OpenGL ES version 2.0, you set the value as "0x00020000",
		/// or to specify OpenGL ES 3.2, you set the value as "0x00030002".
		/// 
		/// An application specifies at most one android:glEsVersion attribute in its manifest.
		/// If it specifies more than one, the android:glEsVersion with the numerically highest value is used and any other values are ignored.
		/// 
		/// If an application doesn't specify an android:glEsVersion attribute,
		/// then it is assumed that the application requires only OpenGL ES 1.0, which is supported by all Android-powered devices.
		/// 
		/// An application can assume that if a platform supports a given OpenGL ES version,
		/// it also supports all numerically lower OpenGL ES versions. Therefore, for an application that
		/// requires both OpenGL ES 1.0 and OpenGL ES 2.0, specify that it requires OpenGL ES 2.0.
		/// 
		/// For an application that can work with any of several OpenGL ES versions, only specify
		/// the numerically lowest version of OpenGL ES that it requires. It can check at runtime whether a higher level of OpenGL ES is available.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-feature-element)
		public func glEsVersion(_ value: String) -> Self { // TODO: drawable resource
			params[.androidGlEsVersion] = value
			return self
		}
		
		/// The OpenGL ES version required by the application.
		/// 
		/// The higher 16 bits represent the major number and the lower 16 bits represent the minor number.
		/// For example, to specify OpenGL ES version 2.0, you set the value as "0x00020000",
		/// or to specify OpenGL ES 3.2, you set the value as "0x00030002".
		/// 
		/// An application specifies at most one android:glEsVersion attribute in its manifest.
		/// If it specifies more than one, the android:glEsVersion with the numerically highest value is used and any other values are ignored.
		/// 
		/// If an application doesn't specify an android:glEsVersion attribute,
		/// then it is assumed that the application requires only OpenGL ES 1.0, which is supported by all Android-powered devices.
		/// 
		/// An application can assume that if a platform supports a given OpenGL ES version,
		/// it also supports all numerically lower OpenGL ES versions. Therefore, for an application that
		/// requires both OpenGL ES 1.0 and OpenGL ES 2.0, specify that it requires OpenGL ES 2.0.
		/// 
		/// For an application that can work with any of several OpenGL ES versions, only specify
		/// the numerically lowest version of OpenGL ES that it requires. It can check at runtime whether a higher level of OpenGL ES is available.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-feature-element)
		public static func glEsVersion(_ value: String) -> Self {
			Self().glEsVersion(value)
		}
	}
}
