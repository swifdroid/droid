//
//  DroidApp+Provider.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Declares a content provider component.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element)
	public class Provider: ManifestTag {
        override class var name: String { "provider" }
		
		required override init() {
            super.init()
        }
        
        override func uniqueParams() -> [ManifestTagParamName] {
            [.androidName]
        }
		
		// MARK: -
		
		/// A list of one or more URI authorities that identify data offered by the content provider.
		/// To avoid conflicts, authority names should use a Java-style naming convention (such as com.example.provider.cartoonprovider).
		///
		/// There is no default. At least one authority must be specified.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#auth)
		public func authorities(_ value: [String]) -> Self {
            params[.androidAuthorities] = ManifestTagParamValue(value.joined(separator: ";")).value
			return self
		}
		
		/// A list of one or more URI authorities that identify data offered by the content provider.
		/// To avoid conflicts, authority names should use a Java-style naming convention (such as com.example.provider.cartoonprovider).
		///
		/// There is no default. At least one authority must be specified.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#auth)
		public func authorities(_ value: String...) -> Self {
			authorities(value)
		}
		
		/// A list of one or more URI authorities that identify data offered by the content provider.
		/// To avoid conflicts, authority names should use a Java-style naming convention (such as com.example.provider.cartoonprovider).
		///
		/// There is no default. At least one authority must be specified.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#auth)
		public static func authorities(_ value: [String]) -> Self {
			Self().authorities(value)
		}
		
		/// A list of one or more URI authorities that identify data offered by the content provider.
		/// To avoid conflicts, authority names should use a Java-style naming convention (such as com.example.provider.cartoonprovider).
		///
		/// There is no default. At least one authority must be specified.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#auth)
		public static func authorities(_ value: String...) -> Self {
			Self().authorities(value)
		}
		
		// MARK: -
		
		/// Whether or not the content provider can be instantiated by the system — "true" if it can be, and "false" if not.
		///
		/// The default value is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#directBootAware)
		public func enabled(_ value: Bool = true) -> Self {
			params[.androidEnabled] = ManifestTagParamValue(value).value
			return self
		}
		
		/// Whether or not the content provider can be instantiated by the system — "true" if it can be, and "false" if not.
		///
		/// The default value is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#directBootAware)
		public static func enabled(_ value: Bool = true) -> Self {
			Self().enabled(value)
		}
		
		// MARK: -
		
		/// Whether or not the content provider is direct-boot aware; that is, whether or not it can run before the user unlocks the device.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#enabled)
		public func directBootAware(_ value: Bool = true) -> Self {
			params[.androidDirectBootAware] = ManifestTagParamValue(value).value
			return self
		}
		
		/// Whether or not the content provider is direct-boot aware; that is, whether or not it can run before the user unlocks the device.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#enabled)
		public static func directBootAware(_ value: Bool = true) -> Self {
			Self().directBootAware(value)
		}
		
		// MARK: -
		
		/// Whether the content provider is available for other applications to use:
		///
		/// - true: The provider is available to other applications.
		/// Any application can use the provider's content URI to access it, subject to the permissions specified for the provider.
		///
		/// - false: The provider is not available to other applications.
		/// Set android:exported="false" to limit access to the provider to your applications.
		/// Only applications that have the same user ID (UID) as the provider, or applications
		/// that have been temporarily granted access to the provider through the android:grantUriPermissions element, have access to it.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#exported)
		public func exported(_ value: Bool = true) -> Self {
			params[.androidExported] = ManifestTagParamValue(value).value
			return self
		}
		
		/// Whether the content provider is available for other applications to use:
		///
		/// - true: The provider is available to other applications.
		/// Any application can use the provider's content URI to access it, subject to the permissions specified for the provider.
		///
		/// - false: The provider is not available to other applications.
		/// Set android:exported="false" to limit access to the provider to your applications.
		/// Only applications that have the same user ID (UID) as the provider, or applications
		/// that have been temporarily granted access to the provider through the android:grantUriPermissions element, have access to it.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#exported)
		public static func exported(_ value: Bool = true) -> Self {
			Self().exported(value)
		}
		
		// MARK: -
		
		/// Whether or not those who ordinarily would not have permission to access
		/// the content provider's data can be granted permission to do so, temporarily overcoming
		/// the restriction imposed by the `readPermission`, `writePermission`, `permission`,
		/// and exported attributes — "true" if permission can be granted, and "false" if not.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#gprmsn)
		public func grantUriPermissions(_ value: Bool = true) -> Self {
			params[.androidGrantUriPermissions] = ManifestTagParamValue(value).value
			return self
		}
		
		/// Whether or not those who ordinarily would not have permission to access
		/// the content provider's data can be granted permission to do so, temporarily overcoming
		/// the restriction imposed by the `readPermission`, `writePermission`, `permission`,
		/// and exported attributes — "true" if permission can be granted, and "false" if not.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#gprmsn)
		public static func grantUriPermissions(_ value: Bool = true) -> Self {
			Self().grantUriPermissions(value)
		}
		
		// MARK: -
		
		/// An icon representing the content provider.
		///
		/// This attribute must be set as a reference to a drawable resource containing the image definition.
		/// If it is not set, the icon specified for the application as a whole is used instead
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#icon)
		public func icon(_ value: String) -> Self { // TODO: drawable resource
			params[.androidIcon] = value
			return self
		}
		
		/// An icon representing the content provider.
		///
		/// This attribute must be set as a reference to a drawable resource containing the image definition.
		/// If it is not set, the icon specified for the application as a whole is used instead
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#icon)
		public static func icon(_ value: String) -> Self {
			Self().icon(value)
		}
		
		// MARK: -
		
		/// The order in which the content provider should be instantiated, relative to other content providers hosted by the same process.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#init)
		public func initOrder(_ value: Int) -> Self {
			params[.androidInitOrder] = ManifestTagParamValue(value).value
			return self
		}
		
		/// The order in which the content provider should be instantiated, relative to other content providers hosted by the same process.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#init)
		public static func initOrder(_ value: Int) -> Self {
			Self().initOrder(value)
		}
		
		// MARK: -
		
		/// A user-readable label for the content provided.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#label)
		public func label(_ value: String) -> Self { // TODO: string or string resource
			params[.androidLabel] = value
			return self
		}
		
		/// A user-readable label for the content provided.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#label)
		public static func label(_ value: String) -> Self {
			Self().label(value)
		}
		
		// MARK: -
		
		/// If the app runs in multiple processes, this attribute determines whether
		/// multiple instances of the content provider are created.
		///
		/// If true, each of the app's processes has its own content provider object.
		///
		/// If false, the app's processes share only one content provider object.
		///
		/// The default value is false.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#multi)
		public func multiprocess(_ value: Bool = true) -> Self {
			params[.androidMultiprocess] = ManifestTagParamValue(value).value
			return self
		}
		
		/// If the app runs in multiple processes, this attribute determines whether
		/// multiple instances of the content provider are created.
		///
		/// If true, each of the app's processes has its own content provider object.
		///
		/// If false, the app's processes share only one content provider object.
		///
		/// The default value is false.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#multi)
		public static func multiprocess(_ value: Bool = true) -> Self {
			Self().multiprocess(value)
		}
		
		// MARK: -
		
		/// The name of the class that implements the content provider, a subclass of ContentProvider.
		///
		/// This should be a fully qualified class name (such as, "com.example.project.TransportationProvider").
		/// However, as a shorthand, if the first character of the name is a period,
		/// it is appended to the package name specified in the `<manifest>` element.
		///
		/// There is no default. The name must be specified.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#nm)
		public func name(_ value: String) -> Self {
			params[.androidName] = value
			return self
		}
		
		/// The name of the class that implements the content provider, a subclass of ContentProvider.
		///
		/// This should be a fully qualified class name (such as, "com.example.project.TransportationProvider").
		/// However, as a shorthand, if the first character of the name is a period,
		/// it is appended to the package name specified in the `<manifest>` element.
		///
		/// There is no default. The name must be specified.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#nm)
		public static func name(_ value: String) -> Self {
			Self().name(value)
		}
		
		// MARK: -
		
		/// The name of a permission that clients must have to read or write the content provider's data.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#prmsn)
		public func permission(_ value: String) -> Self {
			params[.androidPermission] = value
			return self
		}
		
		/// The name of a permission that clients must have to read or write the content provider's data.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#prmsn)
		public static func permission(_ value: String) -> Self {
			Self().permission(value)
		}
		
		// MARK: -
		
		/// The name of the process in which the content provider should run.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#proc)
		public func process(_ value: String) -> Self {
			params[.androidProcess] = value
			return self
		}
		
		/// The name of the process in which the content provider should run.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#proc)
		public static func process(_ value: String) -> Self {
			Self().process(value)
		}
		
		// MARK: -
		
		/// A permission that clients must have to query the content provider.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#rprmsn)
		public func readPermission(_ value: String) -> Self {
			params[.androidReadPermission] = value
			return self
		}
		
		/// A permission that clients must have to query the content provider.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#rprmsn)
		public static func readPermission(_ value: String) -> Self {
			Self().readPermission(value)
		}
		
		// MARK: -
		
		/// Whether or not the data under the content provider's control is to be synchronized
		/// with data on a server — "true" if it is to be synchronized, and "false" if not.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#sync)
		public func syncable(_ value: Bool = true) -> Self {
			params[.androidSyncable] = ManifestTagParamValue(value).value
			return self
		}
		
		/// Whether or not the data under the content provider's control is to be synchronized
		/// with data on a server — "true" if it is to be synchronized, and "false" if not.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#sync)
		public static func syncable(_ value: Bool = true) -> Self {
			Self().syncable(value)
		}
		
		// MARK: -
		
		/// A permission that clients must have to make changes to the data controlled by the content provider.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#wprmsn)
		public func writePermission(_ value: String) -> Self {
			params[.androidWritePermission] = value
			return self
		}
		
		/// A permission that clients must have to make changes to the data controlled by the content provider.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/provider-element#wprmsn)
		public static func writePermission(_ value: String) -> Self {
			Self().writePermission(value)
		}
		
		// MARK: -
		
		/// A name-value pair for an item of additional, arbitrary data that can be supplied to the parent component.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element)
		public func metaData(_ handler: () -> DroidApp.MetaData) -> Self {
			items.append(handler())
			return self
		}
		
		/// A name-value pair for an item of additional, arbitrary data that can be supplied to the parent component.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element)
		public static func metaData(_ handler: @escaping () -> DroidApp.MetaData) -> Self {
			Self().metaData(handler)
		}
		
		// MARK: -
		
		/// Specifies the subsets of app data that the parent content provider has permission to access.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/grant-uri-permission-element)
		public func grantUriPermission(_ handler: () -> DroidApp.GrantUriPermission) -> Self {
			items.append(handler())
			return self
		}
		
		/// Specifies the subsets of app data that the parent content provider has permission to access.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/grant-uri-permission-element)
		public static func grantUriPermission(_ handler: @escaping () -> DroidApp.GrantUriPermission) -> Self {
			Self().grantUriPermission(handler)
		}
		
		// MARK: -
		
		/// Specifies the types of intents that an activity, service, or broadcast receiver can respond to.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element)
		public func intentFilter(_ handler: () -> DroidApp.IntentFilter) -> Self {
			items.append(handler())
			return self
		}
		
		/// Specifies the types of intents that an activity, service, or broadcast receiver can respond to.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element)
		public static func intentFilter(_ handler: @escaping () -> DroidApp.IntentFilter) -> Self {
			Self().intentFilter(handler)
		}
		
		// MARK: -
		
		/// Defines the path and required permissions for a specific subset of data within a content provider.
		/// This element can be specified multiple times to supply multiple paths.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element)
		public func pathPermission(_ handler: () -> DroidApp.PathPermission) -> Self {
			items.append(handler())
			return self
		}
		
		/// Defines the path and required permissions for a specific subset of data within a content provider.
		/// This element can be specified multiple times to supply multiple paths.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/path-permission-element)
		public static func pathPermission(_ handler: @escaping () -> DroidApp.PathPermission) -> Self {
			Self().pathPermission(handler)
		}
		
        override func missingParams() -> [String] {
			var missing: [ManifestTagParamName] = []
            if !params.keys.contains(.androidName) {
				missing.append(.androidName)
			}
            if !params.keys.contains(.androidAuthorities) {
				missing.append(.androidAuthorities)
			}
			return missing.map { $0.value }
		}
	}
}

