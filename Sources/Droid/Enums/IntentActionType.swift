//
//  IntentActionType.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

public struct IntentActionType: ExpressibleByStringLiteral {
	let value: String
	
	public init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
	
	/// Broadcast Action: The user has switched the phone into or out of Airplane Mode.
	/// One or more radios have been turned off or on.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_AIRPLANE_MODE_CHANGED)
	public static var AIRPLANE_MODE_CHANGED: Self { "android.intent.action.AIRPLANE_MODE_CHANGED" }
	
	/// Activity Action: List all available applications.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_ALL_APPS)
	public static var ALL_APPS: Self { "android.intent.action.ALL_APPS" }
	
	/// Activity Action: Handle an incoming phone call.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_ANSWER)
	public static var ANSWER: Self { "android.intent.action.ANSWER" }
	
	/// Broadcast Action: Locale of a particular app has changed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_APPLICATION_LOCALE_CHANGED)
	public static var APPLICATION_LOCALE_CHANGED: Self { "android.intent.action.APPLICATION_LOCALE_CHANGED" }
	
	/// An activity that provides a user interface for adjusting application preferences.
	///
	/// Optional but recommended settings for all applications which have settings.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_APPLICATION_PREFERENCES)
	public static var PREFERENCES: Self { "android.intent.action.PREFERENCES" }
	
	/// Broadcast Action: Sent after application restrictions are changed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_APPLICATION_RESTRICTIONS_CHANGED)
	public static var APPLICATION_RESTRICTIONS_CHANGED: Self { "android.intent.action.APPLICATION_RESTRICTIONS_CHANGED" }
	
	/// Activity Action: The user pressed the "Report" button in the crash/ANR dialog.
	///
	/// This intent is delivered to the package which installed the application, usually Google Play.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_APP_ERROR)
	public static var APP_ERROR: Self { "android.intent.action.APP_ERROR" }
	
	/// Activity Action: Perform assist action.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_ASSIST)
	public static var ASSIST: Self { "android.intent.action.ASSIST" }
	
	/// Used to indicate that some piece of data should be attached to some other place.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_ATTACH_DATA)
	public static var ATTACH_DATA: Self { "android.intent.action.ATTACH_DATA" }
	
	/// Activity action: Launch UI to manage auto-revoke state. This is equivalent to `APPLICATION_DETAILS_SETTINGS`
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_AUTO_REVOKE_PERMISSIONS)
	public static var AUTO_REVOKE_PERMISSIONS: Self { "android.intent.action.AUTO_REVOKE_PERMISSIONS" }
	
	/// Broadcast Action: This is a sticky broadcast containing the charging state, level, and other information about the battery.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_BATTERY_CHANGED)
	public static var BATTERY_CHANGED: Self { "android.intent.action.BATTERY_CHANGED" }
	
	/// Broadcast Action: Indicates low battery condition on the device.
	///
	/// This broadcast corresponds to the "Low battery warning" system dialog.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_BATTERY_LOW)
	public static var BATTERY_LOW: Self { "android.intent.action.BATTERY_LOW" }
	
	/// Broadcast Action: Indicates the battery is now okay after being low.
	///
	/// This will be sent after **ACTION_BATTERY_LOW** once the battery has gone back up to an okay state.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_BATTERY_OKAY)
	public static var BATTERY_OKAY: Self { "android.intent.action.BATTERY_OKAY" }
	
	/// Broadcast Action: This is broadcast once, after the user has finished booting.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_BOOT_COMPLETED)
	public static var BOOT_COMPLETED: Self { "android.intent.action.BOOT_COMPLETED" }
	
	/// Activity Action: Show activity for reporting a bug.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_BUG_REPORT)
	public static var BUG_REPORT: Self { "android.intent.action.BUG_REPORT" }
	
	/// Activity Action: Perform a call to someone specified by the data.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_CALL)
	public static var CALL: Self { "android.intent.action.CALL" }
	
	/// Activity Action: The user pressed the "call" button to go to the dialer or other appropriate UI for placing a call.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_CALL_BUTTON)
	public static var CALL_BUTTON: Self { "android.intent.action.CALL_BUTTON" }
	
	/// Broadcast Action: The "Camera Button" was pressed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_CAMERA_BUTTON)
	public static var CAMERA_BUTTON: Self { "android.intent.action.CAMERA_BUTTON" }
	
	/// Activity Action: Main entry point for carrier setup apps.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_CARRIER_SETUP)
	public static var CARRIER_SETUP: Self { "android.intent.action.CARRIER_SETUP" }
	
	/// Activity Action: Display an activity chooser, allowing the user to pick what they want to before proceeding.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_CHOOSER)
	public static var CHOOSER: Self { "android.intent.action.CHOOSER" }
	
	/// Broadcast Action: This is broadcast when a user action should request a temporary system dialog to dismiss.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_CLOSE_SYSTEM_DIALOGS)
	public static var CLOSE_SYSTEM_DIALOGS: Self { "android.intent.action.CLOSE_SYSTEM_DIALOGS" }
	
	/// Broadcast Action: The current device Configuration (orientation, locale, etc) has changed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_CONFIGURATION_CHANGED)
	public static var CONFIGURATION_CHANGED: Self { "android.intent.action.CONFIGURATION_CHANGED" }
	
	/// Activity Action: Allow the user to create a new document.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_CREATE_DOCUMENT)
	public static var CREATE_DOCUMENT: Self { "android.intent.action.CREATE_DOCUMENT" }
	
	/// Activity Action: Creates a reminder.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_CREATE_REMINDER)
	public static var CREATE_REMINDER: Self { "android.intent.action.CREATE_REMINDER" }
	
	/// Activity Action: Creates a shortcut.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_CREATE_SHORTCUT)
	public static var CREATE_SHORTCUT: Self { "android.intent.action.CREATE_SHORTCUT" }
	
	/// Broadcast Action: The date has changed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_DATE_CHANGED)
	public static var DATE_CHANGED: Self { "android.intent.action.DATE_CHANGED" }
	
	/// A synonym for ACTION_VIEW, the "standard" action that is performed on a piece of data.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_DEFAULT)
	public static var DEFAULT: Self { "android.intent.action.VIEW" }
	
	/// Activity Action: Define the meaning of the selected word(s).
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_DEFINE)
	public static var DEFINE: Self { "android.intent.action.DEFINE" }
	
	/// Activity Action: Delete the given data from its container.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_DELETE)
	public static var DELETE: Self { "android.intent.action.DELETE" }
	
	/// Broadcast Action: A sticky broadcast that indicates low storage space condition on the device
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_DEVICE_STORAGE_LOW)
	public static var DEVICE_STORAGE_LOW: Self { "android.intent.action.DEVICE_STORAGE_LOW" }
	
	/// Broadcast Action: Indicates low storage space condition on the device no longer exists
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_DEVICE_STORAGE_OK)
	public static var DEVICE_STORAGE_OK: Self { "android.intent.action.DEVICE_STORAGE_OK" }
	
	/// Activity Action: Dial a number as specified by the data.
	///
	/// This shows a UI with the number being dialed, allowing the user to explicitly initiate the call.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_DIAL)
	public static var DIAL: Self { "android.intent.action.DIAL" }
	
	/// Broadcast Action: A sticky broadcast for changes in the physical docking state of the device.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_DOCK_EVENT)
	public static var DOCK_EVENT: Self { "android.intent.action.DOCK_EVENT" }
	
	/// Broadcast Action: Sent after the system starts dreaming.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_DREAMING_STARTED)
	public static var DREAMING_STARTED: Self { "android.intent.action.DREAMING_STARTED" }
	
	/// Broadcast Action: Sent after the system stops dreaming.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_DREAMING_STOPPED)
	public static var DREAMING_STOPPED: Self { "android.intent.action.DREAMING_STOPPED" }
	
	/// Activity Action: Provide explicit editable access to the given data.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_EDIT)
	public static var EDIT: Self { "android.intent.action.EDIT" }
	
	/// Broadcast Action: Resources for a set of packages (which were previously unavailable)
	/// are currently available since the media on which they exist is available.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_EXTERNAL_APPLICATIONS_AVAILABLE)
	public static var EXTERNAL_APPLICATIONS_AVAILABLE: Self { "android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE" }
	
	/// Broadcast Action: Resources for a set of packages are currently unavailable since the media on which they exist is unavailable.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_EXTERNAL_APPLICATIONS_UNAVAILABLE)
	public static var EXTERNAL_APPLICATIONS_UNAVAILABLE: Self { "android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE" }
	
	/// Activity Action: Main entry point for factory tests. Only used when the device is booting in factory test node.
	///
	/// The implementing package must be installed in the system image.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_FACTORY_TEST)
	public static var FACTORY_TEST: Self { "android.intent.action.FACTORY_TEST" }
	
	/// Activity Action: Allow the user to select a particular kind of data and return it.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_GET_CONTENT)
	public static var GET_CONTENT: Self { "android.intent.action.GET_CONTENT" }
	
	/// Broadcast to a specific application to query any supported restrictions to impose on restricted users.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_GET_RESTRICTION_ENTRIES)
	public static var GET_RESTRICTION_ENTRIES: Self { "android.intent.action.GET_RESTRICTION_ENTRIES" }
	
	/// Broadcast Action: A GTalk connection has been established.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_GTALK_SERVICE_CONNECTED)
	public static var GTALK_SERVICE_CONNECTED: Self { "android.intent.action.GTALK_SERVICE_CONNECTED" }
	
	/// Broadcast Action: A GTalk connection has been disconnected.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_GTALK_SERVICE_DISCONNECTED)
	public static var GTALK_SERVICE_DISCONNECTED: Self { "android.intent.action.GTALK_SERVICE_DISCONNECTED" }
	
	/// Broadcast Action: Wired Headset plugged in or unplugged.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_HEADSET_PLUG)
	public static var HEADSET_PLUG: Self { "android.intent.action.HEADSET_PLUG" }
	
	/// Broadcast Action: An input method has been changed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_INPUT_METHOD_CHANGED)
	public static var INPUT_METHOD_CHANGED: Self { "android.intent.action.INPUT_METHOD_CHANGED" }
	
	/// Activity Action: Insert an empty item into the given container.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_INSERT)
	public static var INSERT: Self { "android.intent.action.INSERT" }
	
	/// Activity Action: Pick an existing item, or insert a new item, and then edit it.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_INSERT_OR_EDIT)
	public static var INSERT_OR_EDIT: Self { "android.intent.action.INSERT_OR_EDIT" }
	
	/// Activity Action: Activity to handle split installation failures.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_INSTALL_FAILURE)
	public static var INSTALL_FAILURE: Self { "android.intent.action.INSTALL_FAILURE" }
	
	/// Activity Action: Launch application installer.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_INSTALL_PACKAGE)
	public static var INSTALL_PACKAGE: Self { "android.intent.action.INSTALL_PACKAGE" }
	
	/// Broadcast Action: The receiver's effective locale has changed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_LOCALE_CHANGED)
	public static var LOCALE_CHANGED: Self { "android.intent.action.LOCALE_CHANGED" }
	
	/// Broadcast Action: This is broadcast once, after the user has finished booting, but while still in the "locked" state.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_LOCKED_BOOT_COMPLETED)
	public static var LOCKED_BOOT_COMPLETED: Self { "android.intent.action.LOCKED_BOOT_COMPLETED" }
	
	/// Activity Action: Start as a main entry point, does not expect to receive data.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MAIN)
	public static var MAIN: Self { "android.intent.action.MAIN" }
	
	/// Broadcast sent to the primary user when an associated managed profile is added (the profile was created and is ready to be used).
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MANAGED_PROFILE_ADDED)
	public static var MANAGED_PROFILE_ADDED: Self { "android.intent.action.MANAGED_PROFILE_ADDED" }
	
	/// Broadcast sent to the primary user when an associated managed profile has become available.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MANAGED_PROFILE_AVAILABLE)
	public static var MANAGED_PROFILE_AVAILABLE: Self { "android.intent.action.MANAGED_PROFILE_AVAILABLE" }
	
	/// Broadcast sent to the primary user when an associated managed profile is removed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MANAGED_PROFILE_REMOVED)
	public static var MANAGED_PROFILE_REMOVED: Self { "android.intent.action.MANAGED_PROFILE_REMOVED" }
	
	/// Broadcast sent to the primary user when an associated managed profile has become unavailable.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MANAGED_PROFILE_UNAVAILABLE)
	public static var MANAGED_PROFILE_UNAVAILABLE: Self { "android.intent.action.MANAGED_PROFILE_UNAVAILABLE" }
	
	/// Broadcast sent to the primary user when the credential-encrypted private storage for an associated managed profile is unlocked.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MANAGED_PROFILE_UNLOCKED)
	public static var MANAGED_PROFILE_UNLOCKED: Self { "android.intent.action.MANAGED_PROFILE_UNLOCKED" }
	
	/// Activity Action: Show settings for managing network data usage of a specific application.
	///
	/// Applications should define an activity that offers options to control data usage.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MANAGE_NETWORK_USAGE)
	public static var MANAGE_NETWORK_USAGE: Self { "android.intent.action.MANAGE_NETWORK_USAGE" }
	
	/// Broadcast Action: Indicates low memory condition notification acknowledged by user and package management should be started.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MANAGE_PACKAGE_STORAGE)
	public static var MANAGE_PACKAGE_STORAGE: Self { "android.intent.action.MANAGE_PACKAGE_STORAGE" }
	
	/// Activity action: Launch UI to manage unused apps (hibernated apps).
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MANAGE_UNUSED_APPS)
	public static var MANAGE_UNUSED_APPS: Self { "android.intent.action.MANAGE_UNUSED_APPS" }
	
	/// Broadcast Action: External media was removed from SD card slot, but mount point was not unmounted.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_BAD_REMOVAL)
	public static var MEDIA_BAD_REMOVAL: Self { "android.intent.action.MEDIA_BAD_REMOVAL" }
	
	/// Broadcast Action: The "Media Button" was pressed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_BUTTON)
	public static var MEDIA_BUTTON: Self { "android.intent.action.MEDIA_BUTTON" }
	
	/// Broadcast Action: External media is present, and being disk-checked.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_CHECKING)
	public static var MEDIA_CHECKING: Self { "android.intent.action.MEDIA_CHECKING" }
	
	/// Broadcast Action: User has expressed the desire to remove the external storage media.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_EJECT)
	public static var MEDIA_EJECT: Self { "android.intent.action.MEDIA_EJECT" }
	
	/// Broadcast Action: External media is present and mounted at its mount point.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_MOUNTED)
	public static var MEDIA_MOUNTED: Self { "android.intent.action.MEDIA_MOUNTED" }
	
	/// Broadcast Action: External media is present, but is using an incompatible fs (or is blank).
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_NOFS)
	public static var MEDIA_NOFS: Self { "android.intent.action.MEDIA_NOFS" }
	
	/// Broadcast Action: External media has been removed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_REMOVED)
	public static var MEDIA_REMOVED: Self { "android.intent.action.MEDIA_REMOVED" }
	
	/// Broadcast Action: The media scanner has finished scanning a directory.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_SCANNER_FINISHED)
	public static var MEDIA_SCANNER_FINISHED: Self { "android.intent.action.MEDIA_SCANNER_FINISHED" }
	
	/// Broadcast Action: Request the media scanner to scan a file and add it to the media database.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_SCANNER_SCAN_FILE)
	public static var MEDIA_SCANNER_SCAN_FILE: Self { "android.intent.action.MEDIA_SCANNER_SCAN_FILE" }
	
	/// Broadcast Action: The media scanner has started scanning a directory.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_SCANNER_STARTED)
	public static var MEDIA_SCANNER_STARTED: Self { "android.intent.action.MEDIA_SCANNER_STARTED" }
	
	/// Broadcast Action: External media is unmounted because it is being shared via USB mass storage.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_SHARED)
	public static var MEDIA_SHARED: Self { "android.intent.action.MEDIA_SHARED" }
	
	/// Broadcast Action: External media is present but cannot be mounted.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_UNMOUNTABLE)
	public static var MEDIA_UNMOUNTABLE: Self { "android.intent.action.MEDIA_UNMOUNTABLE" }
	
	/// Broadcast Action: External media is present, but not mounted at its mount point.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MEDIA_UNMOUNTED)
	public static var MEDIA_UNMOUNTED: Self { "android.intent.action.MEDIA_UNMOUNTED" }
	
	/// Broadcast Action: A new version of your application has been installed over an existing one.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MY_PACKAGE_REPLACED)
	public static var MY_PACKAGE_REPLACED: Self { "android.intent.action.MY_PACKAGE_REPLACED" }
	
	/// Broadcast Action: Sent to a package that has been suspended by the system.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MY_PACKAGE_SUSPENDED)
	public static var MY_PACKAGE_SUSPENDED: Self { "android.intent.action.MY_PACKAGE_SUSPENDED" }
	
	/// Broadcast Action: Sent to a package that has been unsuspended.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_MY_PACKAGE_UNSUSPENDED)
	public static var MY_PACKAGE_UNSUSPENDED: Self { "android.intent.action.MY_PACKAGE_UNSUSPENDED" }
	
	/// Broadcast Action: An outgoing call is about to be placed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_NEW_OUTGOING_CALL)
	public static var NEW_OUTGOING_CALL: Self { "android.intent.action.NEW_OUTGOING_CALL" }
	
	/// Activity Action: Allow the user to select and return one or more existing documents.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_OPEN_DOCUMENT)
	public static var OPEN_DOCUMENT: Self { "android.intent.action.OPEN_DOCUMENT" }
	
	/// Activity Action: Allow the user to pick a directory subtree.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_OPEN_DOCUMENT_TREE)
	public static var OPEN_DOCUMENT_TREE: Self { "android.intent.action.OPEN_DOCUMENT_TREE" }
	
	/// Broadcast Action: Packages have been suspended.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGES_SUSPENDED)
	public static var PACKAGES_SUSPENDED: Self { "android.intent.action.PACKAGES_SUSPENDED" }
	
	/// Broadcast Action: Packages have been unsuspended.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGES_UNSUSPENDED)
	public static var PACKAGES_UNSUSPENDED: Self { "android.intent.action.PACKAGES_UNSUSPENDED" }
	
	/// Broadcast Action: A new application package has been installed on the device.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGE_ADDED)
	public static var PACKAGE_ADDED: Self { "android.intent.action.PACKAGE_ADDED" }
	
	/// Broadcast Action: An existing application package has been changed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGE_CHANGED)
	public static var PACKAGE_CHANGED: Self { "android.intent.action.PACKAGE_CHANGED" }
	
	/// Broadcast Action: The user has cleared the data of a package.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGE_DATA_CLEARED)
	public static var PACKAGE_DATA_CLEARED: Self { "android.intent.action.PACKAGE_DATA_CLEARED" }
	
	/// Broadcast Action: Sent to the installer package of an application
	/// when that application is first launched (that is the first time it is moved out of the stopped state).
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGE_FIRST_LAUNCH)
	public static var PACKAGE_FIRST_LAUNCH: Self { "android.intent.action.PACKAGE_FIRST_LAUNCH" }
	
	/// Broadcast Action: An existing application package has been completely removed from the device.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGE_FULLY_REMOVED)
	public static var PACKAGE_FULLY_REMOVED: Self { "android.intent.action.PACKAGE_FULLY_REMOVED" }
	
	/// Broadcast Action: Trigger the download and eventual installation of a package.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGE_INSTALL)
	public static var PACKAGE_INSTALL: Self { "android.intent.action.PACKAGE_INSTALL" }
	
	/// Broadcast Action: Sent to the system package verifier when a package needs to be verified.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGE_NEEDS_VERIFICATION)
	public static var PACKAGE_NEEDS_VERIFICATION: Self { "android.intent.action.PACKAGE_NEEDS_VERIFICATION" }
	
	/// Broadcast Action: An existing application package has been removed from the device.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGE_REMOVED)
	public static var PACKAGE_REMOVED: Self { "android.intent.action.PACKAGE_REMOVED" }
	
	/// Broadcast Action: A new version of an application package has been installed, replacing an existing version that was previously installed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGE_REPLACED)
	public static var PACKAGE_REPLACED: Self { "android.intent.action.PACKAGE_REPLACED" }
	
	/// Broadcast Action: The user has restarted a package, and all of its processes have been killed.
	///
	/// All runtime state associated with it (processes, alarms, notifications, etc) should be removed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGE_RESTARTED)
	public static var PACKAGE_RESTARTED: Self { "android.intent.action.PACKAGE_RESTARTED" }
	
	/// Broadcast Action: Sent to the system package verifier when a package is verified.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PACKAGE_VERIFIED)
	public static var PACKAGE_VERIFIED: Self { "android.intent.action.PACKAGE_VERIFIED" }
	
	/// Activity Action: Create a new item in the given container, initializing it from the current contents of the clipboard.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PASTE)
	public static var PASTE: Self { "android.intent.action.PASTE" }
	
	/// Activity Action: Pick an item from the data, returning what was selected.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PICK)
	public static var PICK: Self { "android.intent.action.PICK" }
	
	/// Activity Action: Pick an activity given an intent, returning the class selected.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PICK_ACTIVITY)
	public static var PICK_ACTIVITY: Self { "android.intent.action.PICK_ACTIVITY" }
	
	/// Broadcast Action: External power has been connected to the device.
	///
	/// This is intended for applications that wish to register specifically to this notification.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_POWER_CONNECTED)
	public static var POWER_CONNECTED: Self { "android.intent.action.POWER_CONNECTED" }
	
	/// Broadcast Action: External power has been removed from the device.
	///
	/// This is intended for applications that wish to register specifically to this notification.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_POWER_DISCONNECTED)
	public static var POWER_DISCONNECTED: Self { "android.intent.action.POWER_DISCONNECTED" }
	
	/// Activity Action: Show power usage information to the user.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_POWER_USAGE_SUMMARY)
	public static var POWER_USAGE_SUMMARY: Self { "android.intent.action.POWER_USAGE_SUMMARY" }
	
	/// Activity Action: Process a piece of text.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PROCESS_TEXT)
	public static var PROCESS_TEXT: Self { "android.intent.action.PROCESS_TEXT" }
	
	/// Broadcast sent to the parent user when an associated profile has been started and unlocked.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PROFILE_ACCESSIBLE)
	public static var PROFILE_ACCESSIBLE: Self { "android.intent.action.PROFILE_ACCESSIBLE" }
	
	/// Broadcast sent to the parent user when an associated profile has stopped.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PROFILE_INACCESSIBLE)
	public static var PROFILE_INACCESSIBLE: Self { "android.intent.action.PROFILE_INACCESSIBLE" }
	
	/// Broadcast Action: Some content providers have parts of their namespace
	/// where they publish new events or items that the user may be especially interested in.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_PROVIDER_CHANGED)
	public static var PROVIDER_CHANGED: Self { "android.intent.action.PROVIDER_CHANGED" }
	
	/// Sent when the user taps on the clock widget in the system's "quick settings" area.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_QUICK_CLOCK)
	public static var QUICK_CLOCK: Self { "android.intent.action.QUICK_CLOCK" }
	
	/// Activity Action: Quick view the data. Launches a quick viewer for a URI or a list of URIs.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_QUICK_VIEW)
	public static var QUICK_VIEW: Self { "android.intent.action.QUICK_VIEW" }
	
	/// Broadcast Action: Have the device reboot. This is only for use by system code.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_REBOOT)
	public static var REBOOT: Self { "android.intent.action.REBOOT" }
	
	/// Activity Action: Run the data, whatever that means.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_RUN)
	public static var RUN: Self { "android.intent.action.RUN" }
	
	/// Activity action: Launch UI to open the Safety Center, which highlights the user's security and privacy status.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SAFETY_CENTER)
	public static var SAFETY_CENTER: Self { "android.intent.action.SAFETY_CENTER" }
	
	/// Broadcast Action: Sent when the device goes to sleep and becomes non-interactive.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SCREEN_OFF)
	public static var SCREEN_OFF: Self { "android.intent.action.SCREEN_OFF" }
	
	/// Broadcast Action: Sent when the device wakes up and becomes interactive.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SCREEN_ON)
	public static var SCREEN_ON: Self { "android.intent.action.SCREEN_ON" }
	
	/// Activity Action: Perform a search.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SEARCH)
	public static var SEARCH: Self { "android.intent.action.SEARCH" }
	
	/// Activity Action: Start action associated with long pressing on the search key.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SEARCH_LONG_PRESS)
	public static var SEARCH_LONG_PRESS: Self { "android.intent.action.SEARCH_LONG_PRESS" }
	
	/// Activity Action: Deliver some data to someone else.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SEND)
	public static var SEND: Self { "android.intent.action.SEND" }
	
	/// Activity Action: Send a message to someone specified by the data.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SENDTO)
	public static var SENDTO: Self { "android.intent.action.SENDTO" }
	
	/// Activity Action: Deliver multiple data to someone else.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SEND_MULTIPLE)
	public static var SEND_MULTIPLE: Self { "android.intent.action.SEND_MULTIPLE" }
	
	/// Activity Action: Show settings for choosing wallpaper.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SET_WALLPAPER)
	public static var SET_WALLPAPER: Self { "android.intent.action.SET_WALLPAPER" }
	
	/// Activity Action: Launch an activity showing the app information.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SHOW_APP_INFO)
	public static var SHOW_APP_INFO: Self { "android.intent.action.SHOW_APP_INFO" }
	
	/// Activity Action: Action to show the list of all work apps in the launcher.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SHOW_WORK_APPS)
	public static var SHOW_WORK_APPS: Self { "android.intent.action.SHOW_WORK_APPS" }
	
	/// Broadcast Action: Device is shutting down.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SHUTDOWN)
	public static var SHUTDOWN: Self { "android.intent.action.SHUTDOWN" }
	
	/// Activity Action: Perform a data synchronization.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SYNC)
	public static var SYNC: Self { "android.intent.action.SYNC" }
	
	/// Activity Action: Start the platform-defined tutorial
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_SYSTEM_TUTORIAL)
	public static var SYSTEM_TUTORIAL: Self { "android.intent.action.SYSTEM_TUTORIAL" }
	
	/// Broadcast Action: The timezone has changed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_TIMEZONE_CHANGED)
	public static var TIMEZONE_CHANGED: Self { "android.intent.action.TIMEZONE_CHANGED" }
	
	/// Broadcast Action: The time was set.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_TIME_CHANGED)
	public static var TIME_CHANGED: Self { "android.intent.action.TIME_CHANGED" }
	
	/// Broadcast Action: The current time has changed. Sent every minute.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_TIME_TICK)
	public static var TIME_TICK: Self { "android.intent.action.TIME_TICK" }
	
	/// Activity Action: Perform text translation.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_TRANSLATE)
	public static var TRANSLATE: Self { "android.intent.action.TRANSLATE" }
	
	/// Broadcast Action: A uid has been removed from the system.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_UID_REMOVED)
	public static var UID_REMOVED: Self { "android.intent.action.UID_REMOVED" }
	
	/// Broadcast Action: The device has entered USB Mass Storage mode.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_UMS_CONNECTED)
	public static var UMS_CONNECTED: Self { "android.intent.action.UMS_CONNECTED" }
	
	/// Broadcast Action: The device has exited USB Mass Storage mode.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_UMS_DISCONNECTED)
	public static var UMS_DISCONNECTED: Self { "android.intent.action.UMS_DISCONNECTED" }
	
	/// Activity Action: Launch application uninstaller.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_UNINSTALL_PACKAGE)
	public static var UNINSTALL_PACKAGE: Self { "android.intent.action.UNINSTALL_PACKAGE" }
	
	/// Sent when a user switch is happening, causing the process's user to be sent to the background.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_USER_BACKGROUND)
	public static var USER_BACKGROUND: Self { "android.intent.action.USER_BACKGROUND" }
	
	/// Sent when a user switch is happening, causing the process's user to be brought to the foreground.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_USER_FOREGROUND)
	public static var USER_FOREGROUND: Self { "android.intent.action.USER_FOREGROUND" }
	
	/// Sent the first time a user is starting, to allow system apps to perform one time initialization.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_USER_INITIALIZE)
	public static var USER_INITIALIZE: Self { "android.intent.action.USER_INITIALIZE" }
	
	/// Broadcast Action: Sent when the user is present after device wakes up (e.g when the keyguard is gone).
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_USER_PRESENT)
	public static var USER_PRESENT: Self { "android.intent.action.USER_PRESENT" }
	
	/// Broadcast Action: Sent when the credential-encrypted private storage has become unlocked for the target user.
	///
	/// This is only sent to registered receivers, not manifest receivers.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_USER_UNLOCKED)
	public static var USER_UNLOCKED: Self { "android.intent.action.USER_UNLOCKED" }
	
	/// Activity Action: Display the data to the user.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_VIEW)
	public static var VIEW: Self { "android.intent.action.VIEW" }
	
	/// Activity Action: Display an activity state associated with an unique LocusId.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_VIEW_LOCUS)
	public static var VIEW_LOCUS: Self { "android.intent.action.VIEW_LOCUS" }
	
	/// Activity action: Launch UI to show information about the usage of a given permission group.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_VIEW_PERMISSION_USAGE)
	public static var VIEW_PERMISSION_USAGE: Self { "android.intent.action.VIEW_PERMISSION_USAGE" }
	
	/// Activity action: Launch UI to show information about the usage of a given permission group in a given period.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_VIEW_PERMISSION_USAGE_FOR_PERIOD)
	public static var VIEW_PERMISSION_USAGE_FOR_PERIOD: Self { "android.intent.action.VIEW_PERMISSION_USAGE_FOR_PERIOD" }
	
	/// Activity action: Launch the Safety Hub UI.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_VIEW_SAFETY_HUB)
	public static var VIEW_SAFETY_HUB: Self { "android.intent.action.VIEW_SAFETY_HUB" }
	
	/// Activity Action: Start Voice Command.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_VOICE_COMMAND)
	public static var VOICE_COMMAND: Self { "android.intent.action.VOICE_COMMAND" }
	
	/// Broadcast Action: The current system wallpaper has changed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_WALLPAPER_CHANGED)
	public static var WALLPAPER_CHANGED: Self { "android.intent.action.WALLPAPER_CHANGED" }
	
	/// Activity Action: Perform a web search.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#ACTION_WEB_SEARCH)
	public static var WEB_SEARCH: Self { "android.intent.action.WEB_SEARCH" }
}
