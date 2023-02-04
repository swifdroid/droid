//
//  DroidApp+Application.swift
//  
//
//  Created by Mihael Isaev on 21.04.2022.
//

extension DroidApp {
	/// The declaration of the application.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element)
	public class Application: ManifestTag {
		static var name: String { "application" }
		var params: [ManifestTagParam] = []
		var items: [ManifestTag] = []
		
		required init() {}
		
		// MARK: -
		
		/// Whether or not activities that the application defines can move from the task
		/// that started them to the task they have an affinity for when that task is next brought
		/// to the front — "true" if they can move, and "false" if they must remain with the task where they started.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#reparent)
		public func allowTaskReparenting(_ value: Bool = true) -> Self {
			params.append(.init(.androidAllowTaskReparenting, value))
			return self
		}
		
		/// Whether or not activities that the application defines can move from the task
		/// that started them to the task they have an affinity for when that task is next brought
		/// to the front — "true" if they can move, and "false" if they must remain with the task where they started.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#reparent)
		public static func allowTaskReparenting(_ value: Bool = true) -> Self {
			Self().allowTaskReparenting(value)
		}
		
		// MARK: -
		
		/// Whether to allow the application to participate in the backup and restore infrastructure.
		///
		/// If this attribute is set to false, no backup or restore of the application will ever be performed,
		/// even by a full-system backup that would otherwise cause all application data to be saved via adb. The default value of this attribute is true.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#allowbackup)
		public func allowBackup(_ value: Bool = true) -> Self {
			params.append(.init(.androidAllowBackup, value))
			return self
		}
		
		/// Whether to allow the application to participate in the backup and restore infrastructure.
		///
		/// If this attribute is set to false, no backup or restore of the application will ever be performed,
		/// even by a full-system backup that would otherwise cause all application data to be saved via adb. The default value of this attribute is true.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#allowbackup)
		public static func allowBackup(_ value: Bool = true) -> Self {
			Self().allowBackup(value)
		}
		
		// MARK: -
		
		/// Whether to allow the application to reset user data.
		///
		/// This data includes flags—such as whether the user has seen introductory tooltips—as well as user-customizable settings and preferences.
		///
		/// The default value of this attribute is true.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#allowClearUserData)
		public func allowClearUserData(_ value: Bool = true) -> Self {
			params.append(.init(.androidAllowClearUserData, value))
			return self
		}
		
		/// Whether to allow the application to reset user data.
		///
		/// This data includes flags—such as whether the user has seen introductory tooltips—as well as user-customizable settings and preferences.
		///
		/// The default value of this attribute is true.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#allowClearUserData)
		public static func allowClearUserData(_ value: Bool = true) -> Self {
			Self().allowClearUserData(value)
		}
		
		// MARK: -
		
		/// Whether or not the app has the Heap pointer tagging feature enabled.
		///
		/// The default value of this attribute is true.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#allowNativeHeapPointerTagging)
		public func allowNativeHeapPointerTagging(_ value: Bool = true) -> Self {
			params.append(.init(.androidAllowNativeHeapPointerTagging, value))
			return self
		}
		
		/// Whether or not the app has the Heap pointer tagging feature enabled.
		///
		/// The default value of this attribute is true.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#allowNativeHeapPointerTagging)
		public static func allowNativeHeapPointerTagging(_ value: Bool = true) -> Self {
			Self().allowNativeHeapPointerTagging(value)
		}
		
		// MARK: -
		
		/// The name of the class that implements the application's backup agent, a subclass of BackupAgent.
		///
		/// The attribute value should be a fully qualified class name (such as, "com.example.project.MyBackupAgent").
		///
		/// However, as a shorthand, if the first character of the name is a period (for example, ".MyBackupAgent"), it is appended to the package name specified in the <manifest> element.
		///
		/// There is no default. **The name must be specified.**
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#agent)
		public func backupAgent(_ value: String) -> Self {
			params.append(.init(.androidBackupAgent, value))
			return self
		}
		
		/// The name of the class that implements the application's backup agent, a subclass of BackupAgent.
		///
		/// The attribute value should be a fully qualified class name (such as, "com.example.project.MyBackupAgent").
		///
		/// However, as a shorthand, if the first character of the name is a period (for example, ".MyBackupAgent"), it is appended to the package name specified in the <manifest> element.
		///
		/// There is no default. **The name must be specified.**
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#agent)
		public static func backupAgent(_ value: String) -> Self {
			Self().backupAgent(value)
		}
		
		// MARK: -
		
		/// Indicates that Auto Backup operations may be performed on this app even if the app is in a foreground-equivalent state.
		///
		/// The system shuts down an app during auto backup operation, so use this attribute with caution.
		///
		/// Setting this flag to true can impact app behavior while the app is active.
		///
		/// The default value is false, which means that the OS will avoid backing up the app while it
		/// is running in the foreground (such as a music app that is actively playing music via a service in the startForeground() state).
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#backupInForeground)
		public func backupInForeground(_ value: Bool = true) -> Self {
			params.append(.init(.androidBackupInForeground, value))
			return self
		}
		
		/// Indicates that Auto Backup operations may be performed on this app even if the app is in a foreground-equivalent state.
		///
		/// The system shuts down an app during auto backup operation, so use this attribute with caution.
		///
		/// Setting this flag to true can impact app behavior while the app is active.
		///
		/// The default value is false, which means that the OS will avoid backing up the app while it
		/// is running in the foreground (such as a music app that is actively playing music via a service in the startForeground() state).
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#backupInForeground)
		public static func backupInForeground(_ value: Bool = true) -> Self {
			Self().backupInForeground(value)
		}
		
		// MARK: -
		
		/// A drawable resource providing an extended graphical banner for its associated item.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#banner)
		public func banner(_ value: String) -> Self {
			params.append(.init(.androidBanner, value))
			return self
		}
		
		/// A drawable resource providing an extended graphical banner for its associated item.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#banner)
		public static func banner(_ value: String) -> Self {
			Self().banner(value)
		}
		
		// MARK: -
		
		/// Applications can set this attribute to an XML resource where they specified the rules determining
		/// which files and directories you can copy from the device as part of backup or transfer operations.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#dataExtractionRules)
		public func dataExtractionRules(_ value: String) -> Self {
			params.append(.init(.androidDataExtractionRules, value))
			return self
		}
		
		/// Applications can set this attribute to an XML resource where they specified the rules determining
		/// which files and directories you can copy from the device as part of backup or transfer operations.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#dataExtractionRules)
		public static func dataExtractionRules(_ value: String) -> Self {
			Self().dataExtractionRules(value)
		}
		
		// MARK: -
		
		/// Whether or not the application can be debugged, even when running on a device
		/// in user mode — "true" if it can be, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#debug)
		public func debuggable(_ value: Bool = true) -> Self {
			params.append(.init(.androidDebuggable, value))
			return self
		}
		
		/// Whether or not the application can be debugged, even when running on a device
		/// in user mode — "true" if it can be, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#debug)
		public static func debuggable(_ value: Bool = true) -> Self {
			Self().debuggable(value)
		}
		
		// MARK: -
		
		/// User-readable text about the application, longer and more descriptive than the application label.
		///
		/// The value must be set as a reference to a string resource. Unlike the label, it cannot be a raw string.
		///
		/// There is no default value.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#desc)
		public func description(_ value: String) -> Self {
			params.append(.init(.androidDescription, value))
			return self
		}
		
		/// User-readable text about the application, longer and more descriptive than the application label.
		///
		/// The value must be set as a reference to a string resource. Unlike the label, it cannot be a raw string.
		///
		/// There is no default value.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#desc)
		public static func description(_ value: String) -> Self {
			Self().description(value)
		}
		
		// MARK: -
		
		/// Whether or not the Android system can instantiate components of the application — "true" if it can, and "false" if not.
		///
		/// If the value is "true", each component's enabled attribute determines whether that component is enabled or not.
		///
		/// If the value is "false", it overrides the component-specific values; all components are disabled.
		///
		/// The default value is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#enabled)
		public func enabled(_ value: Bool = true) -> Self {
			params.append(.init(.androidEnabled, value))
			return self
		}
		
		/// Whether or not the Android system can instantiate components of the application — "true" if it can, and "false" if not.
		///
		/// If the value is "true", each component's enabled attribute determines whether that component is enabled or not.
		///
		/// If the value is "false", it overrides the component-specific values; all components are disabled.
		///
		/// The default value is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#enabled)
		public static func enabled(_ value: Bool = true) -> Self {
			Self().enabled(value)
		}
		
		// MARK: -
		
		/// This attribute indicates whether or not the package installer extracts native libraries from the APK to the file system.
		///
		/// If set to "false", your native libraries are stored uncompressed in the APK.
		///
		/// Although your APK might be larger, your application should load faster because the libraries are directly loaded from the APK at runtime.
		///
		/// The default value of extractNativeLibs depends on minSdkVersion and the version of AGP you're using.
		/// In most cases, the default behavior is probably what you want, and you don't have to set this attribute explicitly.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#extractNativeLibs)
		public func extractNativeLibs(_ value: Bool = true) -> Self {
			params.append(.init(.androidExtractNativeLibs, value))
			return self
		}
		
		/// This attribute indicates whether or not the package installer extracts native libraries from the APK to the file system.
		///
		/// If set to "false", your native libraries are stored uncompressed in the APK.
		///
		/// Although your APK might be larger, your application should load faster because the libraries are directly loaded from the APK at runtime.
		///
		/// The default value of extractNativeLibs depends on minSdkVersion and the version of AGP you're using.
		/// In most cases, the default behavior is probably what you want, and you don't have to set this attribute explicitly.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#extractNativeLibs)
		public static func extractNativeLibs(_ value: Bool = true) -> Self {
			Self().extractNativeLibs(value)
		}
		
		// MARK: -
		
		/// This attribute points to an XML file that contains full backup rules for
		/// [Auto Backup](https://developer.android.com/guide/topics/data/autobackup).
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#fullBackupContent)
		public func fullBackupContent(_ value: String) -> Self {
			params.append(.init(.androidFullBackupContent, value))
			return self
		}
		
		/// This attribute points to an XML file that contains full backup rules for
		/// [Auto Backup](https://developer.android.com/guide/topics/data/autobackup).
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#fullBackupContent)
		public static func fullBackupContent(_ value: String) -> Self {
			Self().fullBackupContent(value)
		}
		
		// MARK: -
		
		/// This attribute indicates whether or not to use Auto Backup on devices where it is available.
		///
		/// If set to true, then your app performs Auto Backup when installed on a device running Android 6.0 (API level 23) or higher.
		///
		/// On older devices, your app ignores this attribute and performs Key/Value Backups.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#fullBackupOnly)
		public func fullBackupOnly(_ value: Bool = true) -> Self {
			params.append(.init(.androidFullBackupOnly, value))
			return self
		}
		
		/// This attribute indicates whether or not to use Auto Backup on devices where it is available.
		///
		/// If set to true, then your app performs Auto Backup when installed on a device running Android 6.0 (API level 23) or higher.
		///
		/// On older devices, your app ignores this attribute and performs Key/Value Backups.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#fullBackupOnly)
		public static func fullBackupOnly(_ value: Bool = true) -> Self {
			Self().fullBackupOnly(value)
		}
		
		// MARK: -
		
		/// This attribute indicates whether or not to use GWP-ASan, which is a native memory allocator feature
		/// that helps find use-after-free and heap-buffer-overflow bugs.
		///
		/// The default value is "never".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#gwpAsanMode)
		public func gwpAsanMode(_ value: GWPAsanMode) -> Self {
			params.append(.init(.androidGWPAsanMode, value))
			return self
		}
		
		/// This attribute indicates whether or not to use GWP-ASan, which is a native memory allocator feature
		/// that helps find use-after-free and heap-buffer-overflow bugs.
		///
		/// The default value is "never".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#gwpAsanMode)
		public static func gwpAsanMode(_ value: GWPAsanMode) -> Self {
			Self().gwpAsanMode(value)
		}
		
		// MARK: -
		
		/// Whether or not the application contains any code — "true" if it does, and "false" if not.
		///
		/// When the value is "false", the system does not try to load any application code when launching components.
		///
		/// The default value is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#code)
		public func hasCode(_ value: Bool = true) -> Self {
			params.append(.init(.androidHasCode, value))
			return self
		}
		
		/// Whether or not the application contains any code — "true" if it does, and "false" if not.
		///
		/// When the value is "false", the system does not try to load any application code when launching components.
		///
		/// The default value is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#code)
		public static func hasCode(_ value: Bool = true) -> Self {
			Self().hasCode(value)
		}
		
		// MARK: -
		
		/// When the user uninstalls an app, whether or not to show the user a prompt to keep the app's data.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#fragileuserdata)
		public func hasFragileUserData(_ value: Bool = true) -> Self {
			params.append(.init(.androidHasFragileUserData, value))
			return self
		}
		
		/// When the user uninstalls an app, whether or not to show the user a prompt to keep the app's data.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#fragileuserdata)
		public static func hasFragileUserData(_ value: Bool = true) -> Self {
			Self().hasFragileUserData(value)
		}
		
		// MARK: -
		
		/// Whether or not hardware-accelerated rendering should be enabled for all activities
		/// and views in this application — "true" if it should be enabled, and "false" if not.
		///
		/// The default value is "true" if you've set either minSdkVersion or targetSdkVersion to "14" or higher; otherwise, it's "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#hwaccel)
		public func hardwareAccelerated(_ value: Bool = true) -> Self {
			params.append(.init(.androidHardwareAccelerated, value))
			return self
		}
		
		/// Whether or not hardware-accelerated rendering should be enabled for all activities
		/// and views in this application — "true" if it should be enabled, and "false" if not.
		///
		/// The default value is "true" if you've set either minSdkVersion or targetSdkVersion to "14" or higher; otherwise, it's "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#hwaccel)
		public static func hardwareAccelerated(_ value: Bool = true) -> Self {
			Self().hardwareAccelerated(value)
		}
		
		// MARK: -
		
		/// An icon for the application as whole, and the default icon for each of the application's components.
		///
		/// See the individual icon attributes for `<activity>`, `<activity-alias>`, `<service>`, `<receiver>`, and `<provider>` elements.
		///
		/// This attribute must be set as a reference to a drawable resource containing the image (for example "@drawable/icon"). There is no default icon.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#icon)
		public func icon(_ value: String) -> Self {
			params.append(.init(.androidIcon, value))
			return self
		}
		
		/// An icon for the application as whole, and the default icon for each of the application's components.
		///
		/// See the individual icon attributes for `<activity>`, `<activity-alias>`, `<service>`, `<receiver>`, and `<provider>` elements.
		///
		/// This attribute must be set as a reference to a drawable resource containing the image (for example "@drawable/icon"). There is no default icon.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#icon)
		public static func icon(_ value: String) -> Self {
			Self().icon(value)
		}
		
		// MARK: -
		
		/// Whether or not the application is a game.
		///
		/// The system may group together applications classifed as games or display them separately from other applications.
		///
		/// The default is false.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#isGame)
		public func isGame(_ value: Bool = true) -> Self {
			params.append(.init(.androidIsGame, value))
			return self
		}
		
		/// Whether or not the application is a game.
		///
		/// The system may group together applications classifed as games or display them separately from other applications.
		///
		/// The default is false.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#isGame)
		public static func isGame(_ value: Bool = true) -> Self {
			Self().isGame(value)
		}
		
		// MARK: -
		
		/// Whether the application in question should be terminated after its settings have been restored during a full-system restore operation.
		///
		/// Single-package restore operations will never cause the application to be shut down.
		/// Full-system restore operations typically only occur once, when the phone is first set up. Third-party applications will not normally need to use this attribute.
		///
		/// The default is true, which means that after the application has finished processing its data during a full-system restore, it will be terminated.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#killrst)
		public func killAfterRestore(_ value: Bool = true) -> Self {
			params.append(.init(.androidKillAfterRestore, value))
			return self
		}
		
		/// Whether the application in question should be terminated after its settings have been restored during a full-system restore operation.
		///
		/// Single-package restore operations will never cause the application to be shut down.
		/// Full-system restore operations typically only occur once, when the phone is first set up. Third-party applications will not normally need to use this attribute.
		///
		/// The default is true, which means that after the application has finished processing its data during a full-system restore, it will be terminated.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#killrst)
		public static func killAfterRestore(_ value: Bool = true) -> Self {
			Self().killAfterRestore(value)
		}
		
		// MARK: -
		
		/// Whether your application's processes should be created with a large Dalvik heap.
		///
		/// This applies to all processes created for the application.
		///
		/// It only applies to the first application loaded into a process; if you're using a shared user ID
		/// to allow multiple applications to use a process, they all must use this option consistently
		/// or they will have unpredictable results.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#largeHeap)
		public func largeHeap(_ value: Bool = true) -> Self {
			params.append(.init(.androidLargeHeap, value))
			return self
		}
		
		/// Whether your application's processes should be created with a large Dalvik heap.
		///
		/// This applies to all processes created for the application.
		///
		/// It only applies to the first application loaded into a process; if you're using a shared user ID
		/// to allow multiple applications to use a process, they all must use this option consistently
		/// or they will have unpredictable results.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#largeHeap)
		public static func largeHeap(_ value: Bool = true) -> Self {
			Self().largeHeap(value)
		}
		
		// MARK: -
		
		/// A user-readable label for the application as a whole, and a default label for each of the application's components.
		///
		/// See the individual label attributes for `<activity>`, `<activity-alias>`, `<service>`, `<receiver>`, and `<provider>` elements.
		///
		/// The label should be set as a reference to a string resource, so that it can be localized like other strings in the user interface.
		/// However, as a convenience while you're developing the application, it can also be set as a raw string.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#label)
		public func label(_ value: String) -> Self {
			params.append(.init(.androidLabel, value))
			return self
		}
		
		/// A user-readable label for the application as a whole, and a default label for each of the application's components.
		///
		/// See the individual label attributes for `<activity>`, `<activity-alias>`, `<service>`, `<receiver>`, and `<provider>` elements.
		///
		/// The label should be set as a reference to a string resource, so that it can be localized like other strings in the user interface.
		/// However, as a convenience while you're developing the application, it can also be set as a raw string.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#label)
		public static func label(_ value: String) -> Self {
			Self().label(value)
		}
		
		// MARK: -
		
		/// A logo for the application as whole, and the default logo for activities.
		///
		/// This attribute must be set as a reference to a drawable resource containing the image (for example "@drawable/logo"). There is no default logo.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#logo)
		public func logo(_ value: String) -> Self {
			params.append(.init(.androidLogo, value))
			return self
		}
		
		/// A logo for the application as whole, and the default logo for activities.
		///
		/// This attribute must be set as a reference to a drawable resource containing the image (for example "@drawable/logo"). There is no default logo.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#logo)
		public static func logo(_ value: String) -> Self {
			Self().logo(value)
		}
		
		// MARK: -
		
		/// The fully qualified name of an Activity subclass that the system can launch to let users manage
		/// the memory occupied by the application on the device.
		///
		/// The activity should also be declared with an `<activity>` element.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#space)
		public func manageSpaceActivity(_ value: String) -> Self {
			params.append(.init(.androidManageSpaceActivity, value))
			return self
		}
		
		/// The fully qualified name of an Activity subclass that the system can launch to let users manage
		/// the memory occupied by the application on the device.
		///
		/// The activity should also be declared with an `<activity>` element.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#space)
		public static func manageSpaceActivity(_ value: String) -> Self {
			Self().manageSpaceActivity(value)
		}
		
		// MARK: -
		
		/// The fully qualified name of an Application subclass implemented for the application.
		///
		/// When the application process is started, this class is instantiated before any of the application's components.
		///
		/// The subclass is optional; most applications won't need one.
		/// In the absence of a subclass, Android uses an instance of the base Application class.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#nm)
		public func name(_ value: String) -> Self {
			params.append(.init(.androidName, value))
			return self
		}
		
		/// The fully qualified name of an Application subclass implemented for the application.
		///
		/// When the application process is started, this class is instantiated before any of the application's components.
		///
		/// The subclass is optional; most applications won't need one.
		/// In the absence of a subclass, Android uses an instance of the base Application class.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#nm)
		public static func name(_ value: String) -> Self {
			Self().name(value)
		}
		
		// MARK: -
		
		/// Specifies the name of the XML file that contains your application's
		/// [Network Security Configuration](https://developer.android.com/training/articles/security-config).
		///
		/// The value must be a reference to the XML resource file containing the configuration.
		///
		/// This attribute was added in API level 24.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#networkSecurityConfig)
		public func networkSecurityConfig(_ value: String) -> Self {
			params.append(.init(.androidNetworkSecurityConfig, value))
			return self
		}
		
		/// Specifies the name of the XML file that contains your application's
		/// [Network Security Configuration](https://developer.android.com/training/articles/security-config).
		///
		/// The value must be a reference to the XML resource file containing the configuration.
		///
		/// This attribute was added in API level 24.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#networkSecurityConfig)
		public static func networkSecurityConfig(_ value: String) -> Self {
			Self().networkSecurityConfig(value)
		}
		
		// MARK: -
		
		/// The name of a permission that clients must have in order to interact with the application.
		///
		/// This attribute is a convenient way to set a permission that applies to all of the application's components.
		/// It can be overwritten by setting the permission attributes of individual components.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#prmsn)
		public func permission(_ value: String) -> Self {
			params.append(.init(.androidPermission, value))
			return self
		}
		
		/// The name of a permission that clients must have in order to interact with the application.
		///
		/// This attribute is a convenient way to set a permission that applies to all of the application's components.
		/// It can be overwritten by setting the permission attributes of individual components.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#prmsn)
		public static func permission(_ value: String) -> Self {
			Self().permission(value)
		}
		
		// MARK: -
		
		/// Whether or not the application should remain running at all times — "true" if it should, and "false" if not.
		///
		/// The default value is "false". Applications should not normally set this flag;
		/// persistence mode is intended only for certain system applications.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#persistent)
		public func persistent(_ value: Bool = true) -> Self {
			params.append(.init(.androidPersistent, value))
			return self
		}
		
		/// Whether or not the application should remain running at all times — "true" if it should, and "false" if not.
		///
		/// The default value is "false". Applications should not normally set this flag;
		/// persistence mode is intended only for certain system applications.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#persistent)
		public static func persistent(_ value: Bool = true) -> Self {
			Self().persistent(value)
		}
		
		// MARK: -
		
		/// The name of a process where all components of the application should run.
		/// Each component can override this default by setting its own process attribute.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#proc)
		public func process(_ value: String) -> Self {
			params.append(.init(.androidProcess, value))
			return self
		}
		
		/// The name of a process where all components of the application should run.
		/// Each component can override this default by setting its own process attribute.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#proc)
		public static func process(_ value: String) -> Self {
			Self().process(value)
		}
		
		// MARK: -
		
		/// Indicates that the application is prepared to attempt a restore of any backed-up data set,
		/// even if the backup was stored by a newer version of the application than is currently installed on the device.
		///
		/// Setting this attribute to true will permit the Backup Manager to attempt restore even
		///  when a version mismatch suggests that the data are incompatible. Use with caution!
		///
		/// The default value of this attribute is false.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#restoreany)
		public func restoreAnyVersion(_ value: Bool = true) -> Self {
			params.append(.init(.androidRestoreAnyVersion, value))
			return self
		}
		
		/// Indicates that the application is prepared to attempt a restore of any backed-up data set,
		/// even if the backup was stored by a newer version of the application than is currently installed on the device.
		///
		/// Setting this attribute to true will permit the Backup Manager to attempt restore even
		///  when a version mismatch suggests that the data are incompatible. Use with caution!
		///
		/// The default value of this attribute is false.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#restoreany)
		public static func restoreAnyVersion(_ value: Bool = true) -> Self {
			Self().restoreAnyVersion(value)
		}
		
		// MARK: -
		
		/// Whether or not the application wants to opt out of scoped storage.
		///
		/// Note: Depending on changes related to policy or app compatibility, the system might not honor this opt-out request.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#requestLegacyExternalStorage)
		public func requestLegacyExternalStorage(_ value: Bool = true) -> Self {
			params.append(.init(.androidRequestLegacyExternalStorage, value))
			return self
		}
		
		/// Whether or not the application wants to opt out of scoped storage.
		///
		/// Note: Depending on changes related to policy or app compatibility, the system might not honor this opt-out request.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#requestLegacyExternalStorage)
		public static func requestLegacyExternalStorage(_ value: Bool = true) -> Self {
			Self().requestLegacyExternalStorage(value)
		}
		
		// MARK: -
		
		/// Specifies the account type required by the application in order to function.
		///
		/// If your app requires an Account, the value for this attribute must correspond
		/// to the account authenticator type used by your app (as defined by AuthenticatorDescription), such as "com.google".
		///
		/// The default value is null and indicates that the application can work without any accounts.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#requiredAccountType)`
		public func requiredAccountType(_ value: String) -> Self {
			params.append(.init(.androidRequiredAccountType, value))
			return self
		}
		
		/// Specifies the account type required by the application in order to function.
		///
		/// If your app requires an Account, the value for this attribute must correspond
		/// to the account authenticator type used by your app (as defined by AuthenticatorDescription), such as "com.google".
		///
		/// The default value is null and indicates that the application can work without any accounts.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#requiredAccountType)`
		public static func requiredAccountType(_ value: String) -> Self {
			Self().requiredAccountType(value)
		}
		
		// MARK: -
		
		/// Specifies whether the app supports multi-window mode. You can set this attribute in either the `<activity>` or `<application>` element.
		///
		/// If you set this attribute to true, the user can launch the activity in split-screen and free-form modes.
		///
		/// If you set the attribute to false, the app can't be tested or optimized for a multi-window environment.
		///
		/// The system could still put the activity in multi-window mode with compatibility mode applied.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#resizeableActivity)
		public func resizeableActivity(_ value: Bool = true) -> Self {
			params.append(.init(.androidResizeableActivity, value))
			return self
		}
		
		/// Specifies whether the app supports multi-window mode. You can set this attribute in either the `<activity>` or `<application>` element.
		///
		/// If you set this attribute to true, the user can launch the activity in split-screen and free-form modes.
		///
		/// If you set the attribute to false, the app can't be tested or optimized for a multi-window environment.
		///
		/// The system could still put the activity in multi-window mode with compatibility mode applied.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#resizeableActivity)
		public static func resizeableActivity(_ value: Bool = true) -> Self {
			Self().resizeableActivity(value)
		}
		
		// MARK: -
		
		/// Specifies the account type required by this application and indicates that restricted profiles
		/// are allowed to access such accounts that belong to the owner user. If your app requires an Account
		/// and restricted profiles are allowed to access the primary user's accounts, the value for this attribute
		/// must correspond to the account authenticator type used by your app (as defined by AuthenticatorDescription), such as "com.google".
		///
		/// The default value is null and indicates that the application can work without any accounts.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#restrictedAccountType)
		public func restrictedAccountType(_ value: String) -> Self {
			params.append(.init(.androidRestrictedAccountType, value))
			return self
		}
		
		/// Specifies the account type required by this application and indicates that restricted profiles
		/// are allowed to access such accounts that belong to the owner user. If your app requires an Account
		/// and restricted profiles are allowed to access the primary user's accounts, the value for this attribute
		/// must correspond to the account authenticator type used by your app (as defined by AuthenticatorDescription), such as "com.google".
		///
		/// The default value is null and indicates that the application can work without any accounts.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#restrictedAccountType)
		public static func restrictedAccountType(_ value: String) -> Self {
			Self().restrictedAccountType(value)
		}
		
		// MARK: -
		
		/// Declares whether your application is willing to support right-to-left (RTL) layouts.
		///
		/// The default value of this attribute is false.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#supportsrtl)
		public func supportsRTL(_ value: Bool = true) -> Self {
			params.append(.init(.androidSupportsRTL, value))
			return self
		}
		
		/// Declares whether your application is willing to support right-to-left (RTL) layouts.
		///
		/// The default value of this attribute is false.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#supportsrtl)
		public static func supportsRTL(_ value: Bool = true) -> Self {
			Self().supportsRTL(value)
		}
		
		// MARK: -
		
		/// An affinity name that applies to all activities within the application, except for those that set a different affinity
		/// with their own [taskAffinity](https://developer.android.com/guide/topics/manifest/activity-element#aff) attributes.
		///
		/// By default, all activities within an application share the same affinity.
		/// The name of that affinity is the same as the package name set by the `<manifest>` element.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#aff)
		public func taskAffinity(_ value: String) -> Self {
			params.append(.init(.androidTaskAffinity, value))
			return self
		}
		
		/// An affinity name that applies to all activities within the application, except for those that set a different affinity
		/// with their own [taskAffinity](https://developer.android.com/guide/topics/manifest/activity-element#aff) attributes.
		///
		/// By default, all activities within an application share the same affinity.
		/// The name of that affinity is the same as the package name set by the `<manifest>` element.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#aff)
		public static func taskAffinity(_ value: String) -> Self {
			Self().taskAffinity(value)
		}
		
		// MARK: -
		
		/// Indicates whether this application is only for testing purposes.
		///
		/// For example, it may expose functionality or data outside of itself
		/// that would cause a security hole, but is useful for testing.
		///
		/// This kind of APK can be installed only through adb—you cannot publish it to Google Play.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#testOnly)
		public func testOnly(_ value: Bool = true) -> Self {
			params.append(.init(.androidTestOnly, value))
			return self
		}
		
		/// Indicates whether this application is only for testing purposes.
		///
		/// For example, it may expose functionality or data outside of itself
		/// that would cause a security hole, but is useful for testing.
		///
		/// This kind of APK can be installed only through adb—you cannot publish it to Google Play.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#testOnly)
		public static func testOnly(_ value: Bool = true) -> Self {
			Self().testOnly(value)
		}
		
		// MARK: -
		
		/// A reference to a style resource defining a default theme for all activities in the application.
		///
		/// Individual activities can override the default by setting their own
		/// [theme](https://developer.android.com/guide/topics/manifest/activity-element#theme) attributes.
		///
		/// For more information, see the [Styles and Themes](https://developer.android.com/guide/topics/ui/themes) developer guide.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#theme)
		public func theme(_ value: String) -> Self {
			params.append(.init(.androidTheme, value))
			return self
		}
		
		/// A reference to a style resource defining a default theme for all activities in the application.
		///
		/// Individual activities can override the default by setting their own
		/// [theme](https://developer.android.com/guide/topics/manifest/activity-element#theme) attributes.
		///
		/// For more information, see the [Styles and Themes](https://developer.android.com/guide/topics/ui/themes) developer guide.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#theme)
		public static func theme(_ value: String) -> Self {
			Self().theme(value)
		}
		
		// MARK: -
		
		/// Extra options for an activity's UI.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#uioptions)
		public func uiOptions(_ value: ApplicationUIOptions) -> Self {
			params.append(.init(.androidUIOptions, value))
			return self
		}
		
		/// Extra options for an activity's UI.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#uioptions)
		public static func uiOptions(_ value: ApplicationUIOptions) -> Self {
			Self().uiOptions(value)
		}
		
		// MARK: -
		
		/// Indicates whether the app intends to use cleartext network traffic, such as cleartext HTTP.
		///
		/// The default value for apps that target API level 27 or lower is "true".
		/// Apps that target API level 28 or higher default to "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#usesCleartextTraffic)
		public func usesCleartextTraffic(_ value: Bool = true) -> Self {
			params.append(.init(.androidUsesCleartextTraffic, value))
			return self
		}
		
		/// Indicates whether the app intends to use cleartext network traffic, such as cleartext HTTP.
		///
		/// The default value for apps that target API level 27 or lower is "true".
		/// Apps that target API level 28 or higher default to "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#usesCleartextTraffic)
		public static func usesCleartextTraffic(_ value: Bool = true) -> Self {
			Self().usesCleartextTraffic(value)
		}
		
		// MARK: -
		
		/// Indicates whether the app would like the virtual machine (VM) to operate in safe mode.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#vmSafeMode)
		public func vmSafeMode(_ value: Bool = true) -> Self {
			params.append(.init(.androidVMSafeMode, value))
			return self
		}
		
		/// Indicates whether the app would like the virtual machine (VM) to operate in safe mode.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#vmSafeMode)
		public static func vmSafeMode(_ value: Bool = true) -> Self {
			Self().vmSafeMode(value)
		}
		
		func missingParams() -> [String] {
			var missing: [ManifestTagParamName] = []
			if !params.contains(.androidName) {
				missing.append(.androidName)
			}
			return missing.map { $0.value }
		}
		
		// MARK: -
		
		/// Declares an activity (an Activity subclass) that implements part of the application's visual user interface.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element)
		public func activity(_ handler: () -> DroidApp.Activity) -> Self {
			items.append(handler())
			return self
		}
		
		/// Declares an activity (an Activity subclass) that implements part of the application's visual user interface.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element)
		public static func activity(_ handler: @escaping () -> DroidApp.Activity) -> Self {
			Self().activity(handler)
		}
		
		// MARK: -
		
		/// An alias for an activity, named by the targetActivity attribute.
		///
		/// The target must be in the same application as the alias and it must be declared before the alias in the manifest.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element)
		public func activityAlias(_ handler: () -> DroidApp.ActivityAlias) -> Self {
			items.append(handler())
			return self
		}
		
		/// An alias for an activity, named by the targetActivity attribute.
		///
		/// The target must be in the same application as the alias and it must be declared before the alias in the manifest.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element)
		public static func activityAlias(_ handler: @escaping () -> DroidApp.ActivityAlias) -> Self {
			Self().activityAlias(handler)
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
		
		func missingItems() -> [String] {
			return [] // TODO: check for activity
		}
	}
}
