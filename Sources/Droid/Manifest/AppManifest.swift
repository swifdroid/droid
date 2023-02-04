//
//  AppManifest.swift
//  
//
//  Created by Mihael Isaev on 20.04.2022.
//

import Foundation

public class AppManifest: ManifestTag {
	static var name: String { "manifest" }
	
	var params: [ManifestTagParam] = []
	var items: [ManifestTag] = []
	
	required init () {
		params.append(.init(.xmlnsAndroid, "http://schemas.android.com/apk/res/android"))
	}
	
	// MARK: -
	
	/// A full Java-language-style package name for the Android app.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#package)
	public func package(_ value: String) -> Self {
		params.append(.init(.package, value))
		return self
	}
	
	/// A full Java-language-style package name for the Android app.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#package)
	public static func package(_ value: String) -> Self {
		Self().package(value)
	}

	// MARK: -
	
	/// The name of a Linux user ID that will be shared with other apps.
	///
	/// By default, Android assigns each app its own unique user ID.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#uid)
	public func sharedUserId(_ value: String) -> Self {
		params.append(.init(.androidSharedUserId, value))
		return self
	}
	
	/// The name of a Linux user ID that will be shared with other apps.
	///
	/// By default, Android assigns each app its own unique user ID.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#uid)
	public static func sharedUserId(_ value: String) -> Self {
		Self().sharedUserId(value)
	}
	
	// MARK: -
	
	/// A user-readable label for the shared user ID.
	///
	/// The label must be set as a reference to a string resource; it cannot be a raw string.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#uidlabel)
	public func sharedUserLabel(_ value: String) -> Self { // TODO: string resource
		params.append(.init(.androidSharedUserLabel, value))
		return self
	}
	
	/// A user-readable label for the shared user ID.
	///
	/// The label must be set as a reference to a string resource; it cannot be a raw string.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#uidlabel)
	public static func sharedUserLabel(_ value: String) -> Self {
		Self().sharedUserLabel(value)
	}
	
	// MARK: -
	
	/// An internal version number.
	///
	/// This number is used only to determine whether one version is more recent than another,
	/// with higher numbers indicating more recent versions.
	///
	/// This is not the version number shown to users; that number is set by the versionName attribute.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#vcode)
	public func versionCode(_ value: Int) -> Self {
		params.append(.init(.androidVersionCode, value))
		return self
	}
	
	/// An internal version number.
	///
	/// This number is used only to determine whether one version is more recent than another,
	/// with higher numbers indicating more recent versions.
	///
	/// This is not the version number shown to users; that number is set by the versionName attribute.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#vcode)
	public static func versionCode(_ value: Int) -> Self {
		Self().versionCode(value)
	}
	
	// MARK: -
	
	/// The version number shown to users.
	///
	/// This attribute can be set as a raw string or as a reference to a string resource.
	/// The string has no other purpose than to be displayed to users.
	/// The versionCode attribute holds the significant version number used internally.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#vname)
	public func versionName(_ value: String) -> Self {
		params.append(.init(.androidVersionName, value))
		return self
	}
	
	/// The version number shown to users.
	///
	/// This attribute can be set as a raw string or as a reference to a string resource.
	/// The string has no other purpose than to be displayed to users.
	/// The versionCode attribute holds the significant version number used internally.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#vname)
	public static func versionName(_ value: String) -> Self {
		Self().versionName(value)
	}
	
	// MARK: -
	
	var installLocation: InstallLocation = .internalOnly
	
	/// The default install location for the app.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#install)
	public func installLocation(_ value: InstallLocation) -> Self {
		params.append(.init(.androidInstallLocation, value))
		return self
	}
	
	/// The default install location for the app.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#install)
	public static func installLocation(_ value: InstallLocation) -> Self {
		Self().installLocation(value)
	}
	
	func missingParams() -> [String] {
		var missing: [ManifestTagParamName] = []
		if !params.contains(.package) {
			missing.append(.package)
		}
		if !params.contains(.androidVersionCode) {
			missing.append(.androidVersionCode)
		}
		if !params.contains(.androidVersionName) {
			missing.append(.androidVersionName)
		}
		return missing.map { $0.value }
	}
	
    // MARK: - Items
	
	// MARK: -
	
	/// Specifies each screen configuration with which the application is compatible.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/compatible-screens-element)
	public func compatibleScreen(_ handler: () -> DroidApp.Screen) -> Self {
		items.append(handler())
		return self
	}
	
	/// Specifies each screen configuration with which the application is compatible.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/compatible-screens-element)
	public static func compatibleScreen(_ handler: @escaping () -> DroidApp.Screen) -> Self {
		Self().compatibleScreen(handler)
	}
	
	// MARK: -
	
	/// Specifies each screen configuration with which the application is compatible.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/compatible-screens-element)
	public func instrumentation(_ handler: () -> DroidApp.Instrumentation) -> Self {
		items.append(handler())
		return self
	}
	
	/// Specifies each screen configuration with which the application is compatible.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/compatible-screens-element)
	public static func instrumentation(_ handler: @escaping () -> DroidApp.Instrumentation) -> Self {
		Self().instrumentation(handler)
	}
	
	// MARK: -
	
	/// Declares a security permission that can be used to limit access
	/// to specific components or features of this or other applications.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element)
	public func permission(_ handler: () -> DroidApp.Permission) -> Self {
		items.append(handler())
		return self
	}
	
	/// Declares a security permission that can be used to limit access
	/// to specific components or features of this or other applications.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element)
	public static func permission(_ handler: @escaping () -> DroidApp.Permission) -> Self {
		Self().permission(handler)
	}
	
	// MARK: -
	
	/// Declares a name for a logical grouping of related permissions.
	///
	/// Individual permission join the group through the permissionGroup attribute of the `<permission>` element.
	/// Members of a group are presented together in the user interface.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element)
	public func permissionGroup(_ handler: () -> DroidApp.PermissionGroup) -> Self {
		items.append(handler())
		return self
	}
	
	/// Declares a name for a logical grouping of related permissions.
	///
	/// Individual permission join the group through the permissionGroup attribute of the `<permission>` element.
	/// Members of a group are presented together in the user interface.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element)
	public static func permissionGroup(_ handler: @escaping () -> DroidApp.PermissionGroup) -> Self {
		Self().permissionGroup(handler)
	}
	
	// MARK: -
	
	/// Declares the base name for a tree of permissions.
	///
	/// The application takes ownership of all names within the tree.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-tree-element)
	public func permissionTree(_ handler: () -> DroidApp.PermissionTree) -> Self {
		items.append(handler())
		return self
	}
	
	/// Declares the base name for a tree of permissions.
	///
	/// The application takes ownership of all names within the tree.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-tree-element)
	public static func permissionTree(_ handler: @escaping () -> DroidApp.PermissionTree) -> Self {
		Self().permissionTree(handler)
	}
	
	// MARK: -
	
	public func application(_ handler: () -> DroidApp.Application) -> Self {
		items.append(handler())
		return self
	}
	
	public static func application(_ handler: @escaping () -> DroidApp.Application) -> Self {
		Self().application(handler)
	}
	
	func missingItems() -> [String] {
		var missing: [ManifestTag.Type] = []
		if !items.contains(DroidApp.Application.self) {
			missing.append(DroidApp.Application.self)
		}
		return missing.map { $0.name }
	}
}
