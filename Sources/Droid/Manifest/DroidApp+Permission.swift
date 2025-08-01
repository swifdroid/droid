//
//  DroidApp+Permission.swift
//  
//
//  Created by Mihael Isaev on 21.04.2022.
//

extension DroidApp {
	public class Permission: ManifestTag {
        override class var name: String { "uses-permission" }
		
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
		public func name(_ value: PermissionName) -> Self {
			params[.androidName] = ManifestTagParamValue(value).value
			return self
		}
		
		/// The name of the permission.
		///
		/// This is the name that will be used in code to refer to the permission — for example,
		/// in a `<uses-permission>` element and the permission attributes of application components.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#nm)
		public static func name(_ value: PermissionName) -> Self {
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
		public func permissionGroup(_ value: String) -> Self {
			params[.androidPermissionGroup] = value
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
		public static func permissionGroup(_ value: String) -> Self {
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

extension DroidApp.Permission {
	public struct PermissionName: ExpressibleByStringLiteral, StringValuable {
		public let value: String
		
		public init(stringLiteral value: StringLiteralType) {
			self.value = value
		}
		
		/// Allows a calling app to continue a call which was started in another app.
		public static var ACCEPT_HANDOVER: PermissionName { "android.permission.ACCEPT_HANDOVER" }
		
		/// Allows an app to access location in the background.
		public static var ACCESS_BACKGROUND_LOCATION: PermissionName { "android.permission.ACCESS_BACKGROUND_LOCATION" }
		
		/// Allows an application to access data blobs across users.
		public static var ACCESS_BLOBS_ACROSS_USERS: PermissionName { "android.permission.ACCESS_BLOBS_ACROSS_USERS" }
		
		/// Allows read/write access to the "properties" table in the checkin database, to change values that get uploaded.
		public static var ACCESS_CHECKIN_PROPERTIES: PermissionName { "android.permission.ACCESS_CHECKIN_PROPERTIES" }
		
		/// Allows an app to access approximate location.
		public static var ACCESS_COARSE_LOCATION: PermissionName { "android.permission.ACCESS_COARSE_LOCATION" }
		
		/// Allows an app to access precise location.
		public static var ACCESS_FINE_LOCATION: PermissionName { "android.permission.ACCESS_FINE_LOCATION" }
		
		/// Allows an application to access extra location provider commands.
		public static var ACCESS_LOCATION_EXTRA_COMMANDS: PermissionName { "android.permission.ACCESS_LOCATION_EXTRA_COMMANDS" }
		
		/// Allows an application to access any geographic locations persisted in the user's shared collection.
		public static var ACCESS_MEDIA_LOCATION: PermissionName { "android.permission.ACCESS_MEDIA_LOCATION" }
		
		/// Allows applications to access information about networks.
		public static var ACCESS_NETWORK_STATE: PermissionName { "android.permission.ACCESS_NETWORK_STATE" }
		
		/// Marker permission for applications that wish to access notification policy.
		public static var ACCESS_NOTIFICATION_POLICY: PermissionName { "android.permission.ACCESS_NOTIFICATION_POLICY" }
		 
		public static var ACCESS_SUPPLEMENTAL_APIS: PermissionName { "android.permission.ACCESS_SUPPLEMENTAL_APIS" }
		
		/// Allows applications to access information about Wi-Fi networks.
		public static var ACCESS_WIFI_STATE: PermissionName { "android.permission.ACCESS_WIFI_STATE" }
		
		/// Allows applications to call into AccountAuthenticators.
		public static var ACCOUNT_MANAGER: PermissionName { "android.permission.ACCOUNT_MANAGER" }
		
		/// Allows an application to recognize physical activity.
		public static var ACTIVITY_RECOGNITION: PermissionName { "android.permission.ACTIVITY_RECOGNITION" }
		
		/// Allows an application to add voicemails into the system.
		public static var ADD_VOICEMAIL: PermissionName { "android.permission.ADD_VOICEMAIL" }
		
		/// Allows the app to answer an incoming phone call.
		public static var ANSWER_PHONE_CALLS: PermissionName { "android.permission.ANSWER_PHONE_CALLS" }
		
		/// Allows an application to collect battery statistics
		///
		/// Protection level: signature|privileged|development
		public static var BATTERY_STATS: PermissionName { "android.permission.BATTERY_STATS" }
		
		/// Must be required by an AccessibilityService, to ensure that only the system can bind to it.
		public static var BIND_ACCESSIBILITY_SERVICE: PermissionName { "android.permission.BIND_ACCESSIBILITY_SERVICE" }
		
		/// Allows an application to tell the AppWidget service which application can access AppWidget's data.
		public static var BIND_APPWIDGET: PermissionName { "android.permission.BIND_APPWIDGET" }
		
		/// Must be required by a AutofillService, to ensure that only the system can bind to it.
		public static var BIND_AUTOFILL_SERVICE: PermissionName { "android.permission.BIND_AUTOFILL_SERVICE" }
		
		/// Must be required by a CallRedirectionService, to ensure that only the system can bind to it.
		public static var BIND_CALL_REDIRECTION_SERVICE: PermissionName { "android.permission.BIND_CALL_REDIRECTION_SERVICE" }
		
		/// A subclass of CarrierMessagingClientService must be protected with this permission.
		public static var BIND_CARRIER_MESSAGING_CLIENT_SERVICE: PermissionName { "android.permission.BIND_CARRIER_MESSAGING_CLIENT_SERVICE" }
		
		/// This constant was deprecated in API level 23. Use BIND_CARRIER_SERVICES instead
		public static var BIND_CARRIER_MESSAGING_SERVICE: PermissionName { "android.permission.BIND_CARRIER_MESSAGING_SERVICE" }
		
		/// The system process that is allowed to bind to services in carrier apps will have this permission.
		public static var BIND_CARRIER_SERVICES: PermissionName { "android.permission.BIND_CARRIER_SERVICES" }
		
		/// This constant was deprecated in API level 30.
		///
		/// For publishing direct share targets, please follow the instructions
		/// [here](https://developer.android.com/training/sharing/receive.html#providing-direct-share-targets) instead.
		public static var BIND_CHOOSER_TARGET_SERVICE: PermissionName { "android.permission.BIND_CHOOSER_TARGET_SERVICE" }
		
		/// Must be required by any CompanionDeviceServices to ensure that only the system can bind to it.
		public static var BIND_COMPANION_DEVICE_SERVICE: PermissionName { "android.permission.BIND_COMPANION_DEVICE_SERVICE" }
		
		/// Must be required by a ConditionProviderService, to ensure that only the system can bind to it.
		public static var BIND_CONDITION_PROVIDER_SERVICE: PermissionName { "android.permission.BIND_CONDITION_PROVIDER_SERVICE" }
		
		/// Allows SystemUI to request third party controls.
		public static var BIND_CONTROLS: PermissionName { "android.permission.BIND_CONTROLS" }
		
		/// Must be required by device administration receiver, to ensure that only the system can interact with it.
		public static var BIND_DEVICE_ADMIN: PermissionName { "android.permission.BIND_DEVICE_ADMIN" }
		
		/// Must be required by an DreamService, to ensure that only the system can bind to it.
		public static var BIND_DREAM_SERVICE: PermissionName { "android.permission.BIND_DREAM_SERVICE" }
		
		/// Must be required by a InCallService, to ensure that only the system can bind to it.
		public static var BIND_INCALL_SERVICE: PermissionName { "android.permission.BIND_INCALL_SERVICE" }
		
		/// Must be required by an InputMethodService, to ensure that only the system can bind to it.
		public static var BIND_INPUT_METHOD: PermissionName { "android.permission.BIND_INPUT_METHOD" }
		
		/// Must be required by an MidiDeviceService, to ensure that only the system can bind to it.
		public static var BIND_MIDI_DEVICE_SERVICE: PermissionName { "android.permission.BIND_MIDI_DEVICE_SERVICE" }
		
		/// Must be required by a HostApduService or OffHostApduService to ensure that only the system can bind to it.
		public static var BIND_NFC_SERVICE: PermissionName { "android.permission.BIND_NFC_SERVICE" }
		
		/// Must be required by an NotificationListenerService, to ensure that only the system can bind to it.
		public static var BIND_NOTIFICATION_LISTENER_SERVICE: PermissionName { "android.permission.BIND_NOTIFICATION_LISTENER_SERVICE" }
		
		/// Must be required by a PrintService, to ensure that only the system can bind to it.
		public static var BIND_PRINT_SERVICE: PermissionName { "android.permission.BIND_PRINT_SERVICE" }
		
		/// Must be required by a QuickAccessWalletService to ensure that only the system can bind to it.
		public static var BIND_QUICK_ACCESS_WALLET_SERVICE: PermissionName { "android.permission.BIND_QUICK_ACCESS_WALLET_SERVICE" }
		
		/// Allows an application to bind to third party quick settings tiles.
		public static var BIND_QUICK_SETTINGS_TILE: PermissionName { "android.permission.BIND_QUICK_SETTINGS_TILE" }
		
		/// Must be required by a RemoteViewsService, to ensure that only the system can bind to it.
		public static var BIND_REMOTEVIEWS: PermissionName { "android.permission.BIND_REMOTEVIEWS" }
		
		/// Must be required by a CallScreeningService, to ensure that only the system can bind to it.
		public static var BIND_SCREENING_SERVICE: PermissionName { "android.permission.BIND_SCREENING_SERVICE" }
		
		/// Must be required by a ConnectionService, to ensure that only the system can bind to it.
		public static var BIND_TELECOM_CONNECTION_SERVICE: PermissionName { "android.permission.BIND_TELECOM_CONNECTION_SERVICE" }
		
		/// Must be required by a TextService (e.g. SpellCheckerService) to ensure that only the system can bind to it.
		public static var BIND_TEXT_SERVICE: PermissionName { "android.permission.BIND_TEXT_SERVICE" }
		
		/// Must be required by a TvInputService to ensure that only the system can bind to it.
		public static var BIND_TV_INPUT: PermissionName { "android.permission.BIND_TV_INPUT" }
		
		/// Must be required by a TvInteractiveAppService to ensure that only the system can bind to it.
		public static var BIND_TV_INTERACTIVE_APP: PermissionName { "android.permission.BIND_TV_INTERACTIVE_APP" }
		
		/// Must be required by a link VisualVoicemailService to ensure that only the system can bind to it.
		public static var BIND_VISUAL_VOICEMAIL_SERVICE: PermissionName { "android.permission.BIND_VISUAL_VOICEMAIL_SERVICE" }
		
		/// Must be required by a VoiceInteractionService, to ensure that only the system can bind to it.
		public static var BIND_VOICE_INTERACTION: PermissionName { "android.permission.BIND_VOICE_INTERACTION" }
		
		/// Must be required by a VpnService, to ensure that only the system can bind to it.
		public static var BIND_VPN_SERVICE: PermissionName { "android.permission.BIND_VPN_SERVICE" }
		
		/// Must be required by an VrListenerService, to ensure that only the system can bind to it.
		public static var BIND_VR_LISTENER_SERVICE: PermissionName { "android.permission.BIND_VR_LISTENER_SERVICE" }
		
		/// Must be required by a WallpaperService, to ensure that only the system can bind to it.
		public static var BIND_WALLPAPER: PermissionName { "android.permission.BIND_WALLPAPER" }
		
		/// Allows applications to connect to paired bluetooth devices.
		public static var BLUETOOTH: PermissionName { "android.permission.BLUETOOTH" }
		
		/// Allows applications to discover and pair bluetooth devices.
		public static var BLUETOOTH_ADMIN: PermissionName { "android.permission.BLUETOOTH_ADMIN" }
		
		/// Required to be able to advertise to nearby Bluetooth devices.
		public static var BLUETOOTH_ADVERTISE: PermissionName { "android.permission.BLUETOOTH_ADVERTISE" }
		
		/// Required to be able to connect to paired Bluetooth devices.
		public static var BLUETOOTH_CONNECT: PermissionName { "android.permission.BLUETOOTH_CONNECT" }
		
		/// Allows applications to pair bluetooth devices without user interaction, and to allow or disallow phonebook access or message access.
		public static var BLUETOOTH_PRIVILEGED: PermissionName { "android.permission.BLUETOOTH_PRIVILEGED" }
		
		/// Required to be able to discover and pair nearby Bluetooth devices.
		public static var BLUETOOTH_SCAN: PermissionName { "android.permission.BLUETOOTH_SCAN" }
		
		/// Allows an application to access data from sensors that the user uses to measure what is happening inside their body, such as heart rate.
		public static var BODY_SENSORS: PermissionName { "android.permission.BODY_SENSORS" }
		
		/// Allows an application to access data from sensors that the user uses to measure what is happening inside their body, such as heart rate.
		public static var BODY_SENSORS_BACKGROUND: PermissionName { "android.permission.BODY_SENSORS_BACKGROUND" }
		
		/// Allows an application to broadcast a notification that an application package has been removed.
		public static var BROADCAST_PACKAGE_REMOVED: PermissionName { "android.permission.BROADCAST_PACKAGE_REMOVED" }
		
		/// Allows an application to broadcast an SMS receipt notification.
		public static var BROADCAST_SMS: PermissionName { "android.permission.BROADCAST_SMS" }
		
		/// Allows an application to broadcast sticky intents.
		public static var BROADCAST_STICKY: PermissionName { "android.permission.BROADCAST_STICKY" }
		
		/// Allows an application to broadcast a WAP PUSH receipt notification.
		public static var BROADCAST_WAP_PUSH: PermissionName { "android.permission.BROADCAST_WAP_PUSH" }
		
		/// Allows an app which implements the InCallService API to be eligible to be enabled as a calling companion app.
		public static var CALL_COMPANION_APP: PermissionName { "android.permission.CALL_COMPANION_APP" }
		
		/// Allows an application to initiate a phone call without going through the Dialer user interface for the user to confirm the call.
		public static var CALL_PHONE: PermissionName { "android.permission.CALL_PHONE" }
		
		/// Allows an application to call any phone number, including emergency numbers,
		/// without going through the Dialer user interface for the user to confirm the call being placed.
		public static var CALL_PRIVILEGED: PermissionName { "android.permission.CALL_PRIVILEGED" }
		
		/// Required to be able to access the camera device.
		public static var CAMERA: PermissionName { "android.permission.CAMERA" }
		
		/// Allows an application to capture audio output.
		public static var CAPTURE_AUDIO_OUTPUT: PermissionName { "android.permission.CAPTURE_AUDIO_OUTPUT" }
		
		/// Allows an application to change whether an application component (other than its own) is enabled or not.
		public static var CHANGE_COMPONENT_ENABLED_STATE: PermissionName { "android.permission.CHANGE_COMPONENT_ENABLED_STATE" }
		
		/// Allows an application to modify the current configuration, such as locale.
		public static var CHANGE_CONFIGURATION: PermissionName { "android.permission.CHANGE_CONFIGURATION" }
		
		/// Allows applications to change network connectivity state.
		public static var CHANGE_NETWORK_STATE: PermissionName { "android.permission.CHANGE_NETWORK_STATE" }
		
		/// Allows applications to enter Wi-Fi Multicast mode.
		public static var CHANGE_WIFI_MULTICAST_STATE: PermissionName { "android.permission.CHANGE_WIFI_MULTICAST_STATE" }
		
		/// Allows applications to change Wi-Fi connectivity state.
		public static var CHANGE_WIFI_STATE: PermissionName { "android.permission.CHANGE_WIFI_STATE" }
		
		/// Allows an application to clear the caches of all installed applications on the device.
		public static var CLEAR_APP_CACHE: PermissionName { "android.permission.CLEAR_APP_CACHE" }
		
		/// Allows enabling/disabling location update notifications from the radio.
		public static var CONTROL_LOCATION_UPDATES: PermissionName { "android.permission.CONTROL_LOCATION_UPDATES" }
		
		/// Old permission for deleting an app's cache files, no longer used,
		/// but signals for us to quietly ignore calls instead of throwing an exception.
		public static var DELETE_CACHE_FILES: PermissionName { "android.permission.DELETE_CACHE_FILES" }
		
		/// Allows an application to delete packages.
		public static var DELETE_PACKAGES: PermissionName { "android.permission.DELETE_PACKAGES" }
		
		/// Allows an application to deliver companion messages to system
		public static var DELIVER_COMPANION_MESSAGES: PermissionName { "android.permission.DELIVER_COMPANION_MESSAGES" }
		
		/// Allows applications to RW to diagnostic resources.
		public static var DIAGNOSTIC: PermissionName { "android.permission.DIAGNOSTIC" }
		
		/// Allows applications to disable the keyguard if it is not secure.
		public static var DISABLE_KEYGUARD: PermissionName { "android.permission.DISABLE_KEYGUARD" }
		
		/// Allows an application to retrieve state dump information from system services.
		public static var DUMP: PermissionName { "android.permission.DUMP" }
		
		/// Allows an application to expand or collapse the status bar.
		public static var EXPAND_STATUS_BAR: PermissionName { "android.permission.EXPAND_STATUS_BAR" }
		
		/// Run as a manufacturer test application, running as the root user.
		public static var FACTORY_TEST: PermissionName { "android.permission.FACTORY_TEST" }
		
		/// Allows a regular application to use Service.startForeground.
		public static var FOREGROUND_SERVICE: PermissionName { "android.permission.FOREGROUND_SERVICE" }
		
		/// Allows access to the list of accounts in the Accounts Service.
		public static var GET_ACCOUNTS: PermissionName { "android.permission.GET_ACCOUNTS" }
		
		/// Allows access to the list of accounts in the Accounts Service.
		public static var GET_ACCOUNTS_PRIVILEGED: PermissionName { "android.permission.GET_ACCOUNTS_PRIVILEGED" }
		
		/// Allows an application to find out the space used by any package.
		public static var GET_PACKAGE_SIZE: PermissionName { "android.permission.GET_PACKAGE_SIZE" }
		
		/// This constant was deprecated in API level 21. No longer enforced.
		public static var GET_TASKS: PermissionName { "android.permission.GET_TASKS" }
		
		/// This permission can be used on content providers to allow the global search system to access their data.
		public static var GLOBAL_SEARCH: PermissionName { "android.permission.GLOBAL_SEARCH" }
		
		/// Allows an app to prevent non-system-overlay windows from being drawn on top of it
		public static var HIDE_OVERLAY_WINDOWS: PermissionName { "android.permission.HIDE_OVERLAY_WINDOWS" }
		
		/// Allows an app to access sensor data with a sampling rate greater than 200 Hz.
		public static var HIGH_SAMPLING_RATE_SENSORS: PermissionName { "android.permission.HIGH_SAMPLING_RATE_SENSORS" }
		
		/// Allows an application to install a location provider into the Location Manager.
		public static var INSTALL_LOCATION_PROVIDER: PermissionName { "android.permission.INSTALL_LOCATION_PROVIDER" }
		
		/// Allows an application to install packages.
		public static var INSTALL_PACKAGES: PermissionName { "android.permission.INSTALL_PACKAGES" }
		
		/// Allows an application to install a shortcut in Launcher.
		public static var INSTALL_SHORTCUT: PermissionName { "android.permission.INSTALL_SHORTCUT" }
		
		/// Allows an instant app to create foreground services.
		public static var INSTANT_APP_FOREGROUND_SERVICE: PermissionName { "android.permission.INSTANT_APP_FOREGROUND_SERVICE" }
		
		/// Allows interaction across profiles in the same profile group.
		public static var INTERACT_ACROSS_PROFILES: PermissionName { "android.permission.INTERACT_ACROSS_PROFILES" }
		
		/// Allows applications to open network sockets.
		public static var INTERNET: PermissionName { "android.permission.INTERNET" }
		
		/// Allows an application to call ActivityManager.killBackgroundProcesses(String).
		public static var KILL_BACKGROUND_PROCESSES: PermissionName { "android.permission.KILL_BACKGROUND_PROCESSES" }
		
		/// An application needs this permission for Settings.ACTION_SETTINGS_EMBED_DEEP_LINK_ACTIVITY to show its Activity embedded in Settings app.
		public static var LAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK: PermissionName { "android.permission.LAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK" }
		
		/// Allows a data loader to read a package's access logs.
		public static var LOADER_USAGE_STATS: PermissionName { "android.permission.LOADER_USAGE_STATS" }
		
		/// Allows an application to use location features in hardware, such as the geofencing api.
		public static var LOCATION_HARDWARE: PermissionName { "android.permission.LOCATION_HARDWARE" }
		
		/// Allows an application to manage access to documents, usually as part of a document picker.
		public static var MANAGE_DOCUMENTS: PermissionName { "android.permission.MANAGE_DOCUMENTS" }
		
		/// Allows an application a broad access to external storage in scoped storage.
		public static var MANAGE_EXTERNAL_STORAGE: PermissionName { "android.permission.MANAGE_EXTERNAL_STORAGE" }
		
		/// Allows an application to modify and delete media files on this device or any connected storage device without user confirmation.
		public static var MANAGE_MEDIA: PermissionName { "android.permission.MANAGE_MEDIA" }
		
		/// Allows to query ongoing call details and manage ongoing calls
		///
		/// Protection level: signature|appop
		public static var MANAGE_ONGOING_CALLS: PermissionName { "android.permission.MANAGE_ONGOING_CALLS" }
		
		/// Allows a calling application which manages its own calls through the self-managed ConnectionService APIs.
		public static var MANAGE_OWN_CALLS: PermissionName { "android.permission.MANAGE_OWN_CALLS" }
		
		/// Allows applications to enable/disable wifi auto join.
		public static var MANAGE_WIFI_AUTO_JOIN: PermissionName { "android.permission.MANAGE_WIFI_AUTO_JOIN" }
		
		/// Allows applications to get notified when a Wi-Fi interface request cannot be satisfied
		/// without tearing down one or more other interfaces, and provide a decision whether to approve the request or reject it.
		public static var MANAGE_WIFI_INTERFACES: PermissionName { "android.permission.MANAGE_WIFI_INTERFACES" }
		
		/// Not for use by third-party applications.
		public static var MASTER_CLEAR: PermissionName { "android.permission.MASTER_CLEAR" }
		
		/// Allows an application to know what content is playing and control its playback.
		public static var MEDIA_CONTENT_CONTROL: PermissionName { "android.permission.MEDIA_CONTENT_CONTROL" }
		
		/// Allows an application to modify global audio settings.
		public static var MODIFY_AUDIO_SETTINGS: PermissionName { "android.permission.MODIFY_AUDIO_SETTINGS" }
		
		/// Allows modification of the telephony state - power on, mmi, etc.
		public static var MODIFY_PHONE_STATE: PermissionName { "android.permission.MODIFY_PHONE_STATE" }
		
		/// Allows formatting file systems for removable storage.
		public static var MOUNT_FORMAT_FILESYSTEMS: PermissionName { "android.permission.MOUNT_FORMAT_FILESYSTEMS" }
		
		/// Allows mounting and unmounting file systems for removable storage.
		public static var MOUNT_UNMOUNT_FILESYSTEMS: PermissionName { "android.permission.MOUNT_UNMOUNT_FILESYSTEMS" }
		
		/// Required to be able to advertise and connect to nearby devices via Wi-Fi.
		public static var NEARBY_WIFI_DEVICES: PermissionName { "android.permission.NEARBY_WIFI_DEVICES" }
		
		/// Allows applications to perform I/O operations over NFC.
		public static var NFC: PermissionName { "android.permission.NFC" }
		
		/// Allows applications to receive NFC preferred payment service information.
		public static var NFC_PREFERRED_PAYMENT_INFO: PermissionName { "android.permission.NFC_PREFERRED_PAYMENT_INFO" }
		
		/// Allows applications to receive NFC transaction events.
		public static var NFC_TRANSACTION_EVENT: PermissionName { "android.permission.NFC_TRANSACTION_EVENT" }
		
		/// Allows an application to modify any wifi configuration, even if created by another application.
		public static var OVERRIDE_WIFI_CONFIG: PermissionName { "android.permission.OVERRIDE_WIFI_CONFIG" }
		
		/// Allows an application to collect component usage statistics
		///
		/// Declaring the permission implies intention to use the API and the user of the device can grant permission through the Settings application.
		public static var PACKAGE_USAGE_STATS: PermissionName { "android.permission.PACKAGE_USAGE_STATS" }
		
		/// This constant was deprecated in API level 15.
		/// This functionality will be removed in the future; please do not use.
		/// Allow an application to make its activities persistent.
		public static var PERSISTENT_ACTIVITY: PermissionName { "android.permission.PERSISTENT_ACTIVITY" }
		
		/// Allows an app to post notifications
		///
		/// Protection level: dangerous
		public static var POST_NOTIFICATIONS: PermissionName { "android.permission.POST_NOTIFICATIONS" }
		
		/// This constant was deprecated in API level 29.
		/// Applications should use CallRedirectionService instead of the Intent.ACTION_NEW_OUTGOING_CALL broadcast.
		public static var PROCESS_OUTGOING_CALLS: PermissionName { "android.permission.PROCESS_OUTGOING_CALLS" }
		
		/// Allows query of any normal app on the device, regardless of manifest declarations.
		public static var QUERY_ALL_PACKAGES: PermissionName { "android.permission.QUERY_ALL_PACKAGES" }
		
		/// Allows an application to query over global data in AppSearch that's visible to the ASSISTANT role.
		public static var READ_ASSISTANT_APP_SEARCH_DATA: PermissionName { "android.permission.READ_ASSISTANT_APP_SEARCH_DATA" }
		
		/// Allows read only access to phone state with a non dangerous permission, including the information like cellular network type, software version.
		public static var READ_BASIC_PHONE_STATE: PermissionName { "android.permission.READ_BASIC_PHONE_STATE" }
		
		/// Allows an application to read the user's calendar data.
		public static var READ_CALENDAR: PermissionName { "android.permission.READ_CALENDAR" }
		
		/// Allows an application to read the user's call log.
		public static var READ_CALL_LOG: PermissionName { "android.permission.READ_CALL_LOG" }
		
		/// Allows an application to read the user's contacts data.
		public static var READ_CONTACTS: PermissionName { "android.permission.READ_CONTACTS" }
		
		/// Allows an application to read from external storage.
		public static var READ_EXTERNAL_STORAGE: PermissionName { "android.permission.READ_EXTERNAL_STORAGE" }
		
		/// Allows an application to query over global data in AppSearch that's visible to the HOME role.
		public static var READ_HOME_APP_SEARCH_DATA: PermissionName { "android.permission.READ_HOME_APP_SEARCH_DATA" }
		
		/// This constant was deprecated in API level 16. The API that used this permission has been removed.
		public static var READ_INPUT_STATE: PermissionName { "android.permission.READ_INPUT_STATE" }
		
		/// Allows an application to read the low-level system log files.
		public static var READ_LOGS: PermissionName { "android.permission.READ_LOGS" }
		
		/// Allows an application to read audio files from external storage.
		public static var READ_MEDIA_AUDIO: PermissionName { "android.permission.READ_MEDIA_AUDIO" }
		
		/// Allows an application to read image files from external storage.
		public static var READ_MEDIA_IMAGE: PermissionName { "android.permission.READ_MEDIA_IMAGE" }
		
		/// Allows an application to read audio files from external storage.
		public static var READ_MEDIA_VIDEO: PermissionName { "android.permission.READ_MEDIA_VIDEO" }
		
		/// Allows an application to read nearby streaming policy.
		public static var READ_NEARBY_STREAMING_POLICY: PermissionName { "android.permission.READ_NEARBY_STREAMING_POLICY" }
		
		/// Allows read access to the device's phone number(s).
		public static var READ_PHONE_NUMBERS: PermissionName { "android.permission.READ_PHONE_NUMBERS" }
		
		/// Allows read only access to phone state, including the current cellular network information, the status of any ongoing calls, and a list of any PhoneAccounts registered on the device.
		public static var READ_PHONE_STATE: PermissionName { "android.permission.READ_PHONE_STATE" }
		
		/// Allows read only access to precise phone state.
		public static var READ_PRECISE_PHONE_STATE: PermissionName { "android.permission.READ_PRECISE_PHONE_STATE" }
		
		/// Allows an application to read SMS messages.
		public static var READ_SMS: PermissionName { "android.permission.READ_SMS" }
		
		/// Allows applications to read the sync settings.
		public static var READ_SYNC_SETTINGS: PermissionName { "android.permission.READ_SYNC_SETTINGS" }
		
		/// Allows applications to read the sync stats.
		public static var READ_SYNC_STATS: PermissionName { "android.permission.READ_SYNC_STATS" }
		
		/// Allows an application to read voicemails in the system.
		public static var READ_VOICEMAIL: PermissionName { "android.permission.READ_VOICEMAIL" }
		
		/// Required to be able to reboot the device.
		public static var REBOOT: PermissionName { "android.permission.REBOOT" }
		
		/// Allows an application to receive the Intent.ACTION_BOOT_COMPLETED that is broadcast after the system finishes booting.
		public static var RECEIVE_BOOT_COMPLETED: PermissionName { "android.permission.RECEIVE_BOOT_COMPLETED" }
		
		/// Allows an application to monitor incoming MMS messages.
		public static var RECEIVE_MMS: PermissionName { "android.permission.RECEIVE_MMS" }
		
		/// Allows an application to receive SMS messages.
		public static var RECEIVE_SMS: PermissionName { "android.permission.RECEIVE_SMS" }
		
		/// Allows an application to receive WAP push messages.
		public static var RECEIVE_WAP_PUSH: PermissionName { "android.permission.RECEIVE_WAP_PUSH" }
		
		/// Allows an application to record audio.
		public static var RECORD_AUDIO: PermissionName { "android.permission.RECORD_AUDIO" }
		
		/// Allows an application to change the Z-order of tasks.
		public static var REORDER_TASKS: PermissionName { "android.permission.REORDER_TASKS" }
		
		/// Allows application to request to be associated with a virtual display capable
		/// of streaming Android applications (AssociationRequest.DEVICE_PROFILE_APP_STREAMING) by CompanionDeviceManager.
		public static var REQUEST_COMPANION_PROFILE_APP_STREAMING: PermissionName { "android.permission.REQUEST_COMPANION_PROFILE_APP_STREAMING" }
		
		/// Allows application to request to be associated with a vehicle head unit capable
		/// of automotive projection (AssociationRequest.DEVICE_PROFILE_AUTOMOTIVE_PROJECTION) by CompanionDeviceManager.
		public static var REQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION: PermissionName { "android.permission.REQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION" }
		
		/// Allows application to request to be associated with a computer to share functionality
		/// and/or data with other devices, such as notifications, photos and media
		/// (AssociationRequest.DEVICE_PROFILE_COMPUTER) by CompanionDeviceManager.
		public static var REQUEST_COMPANION_PROFILE_COMPUTER: PermissionName { "android.permission.REQUEST_COMPANION_PROFILE_COMPUTER" }
		
		/// Allows app to request to be associated with a device via CompanionDeviceManager as a "watch"
		///
		/// Protection level: normal
		public static var REQUEST_COMPANION_PROFILE_WATCH: PermissionName { "android.permission.REQUEST_COMPANION_PROFILE_WATCH" }
		
		/// Allows a companion app to run in the background.
		public static var REQUEST_COMPANION_RUN_IN_BACKGROUND: PermissionName { "android.permission.REQUEST_COMPANION_RUN_IN_BACKGROUND" }
		 
		/// Allows an application to create a "self-managed" association.
		public static var REQUEST_COMPANION_SELF_MANAGED: PermissionName { "android.permission.REQUEST_COMPANION_SELF_MANAGED" }
		
		/// Allows a companion app to start a foreground service from the background.
		public static var REQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND: PermissionName { "android.permission.REQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND" }
		
		/// Allows a companion app to use data in the background.
		public static var REQUEST_COMPANION_USE_DATA_IN_BACKGROUND: PermissionName { "android.permission.REQUEST_COMPANION_USE_DATA_IN_BACKGROUND" }
		
		/// Allows an application to request deleting packages.
		public static var REQUEST_DELETE_PACKAGES: PermissionName { "android.permission.REQUEST_DELETE_PACKAGES" }
		
		/// Permission an application must hold in order to use Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS.
		public static var REQUEST_IGNORE_BATTERY_OPTIMIZATIONS: PermissionName { "android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" }
		
		/// Allows an application to request installing packages.
		public static var REQUEST_INSTALL_PACKAGES: PermissionName { "android.permission.REQUEST_INSTALL_PACKAGES" }
		
		/// Allows an application to subscribe to notifications about the presence status change of their associated companion device
		public static var REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE: PermissionName { "android.permission.REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE" }
		
		/// Allows an application to request the screen lock complexity and prompt users to update the screen lock to a certain complexity level.
		public static var REQUEST_PASSWORD_COMPLEXITY: PermissionName { "android.permission.REQUEST_PASSWORD_COMPLEXITY" }
		
		/// This constant was deprecated in API level 15. The ActivityManager.restartPackage(String) API is no longer supported.
		public static var RESTART_PACKAGES: PermissionName { "android.permission.RESTART_PACKAGES" }
		
		/// Allows applications to use exact alarm APIs.
		public static var SCHEDULE_EXACT_ALARM: PermissionName { "android.permission.SCHEDULE_EXACT_ALARM" }
		
		/// Allows an application (Phone) to send a request to other applications to handle the respond-via-message action during incoming calls.
		public static var SEND_RESPOND_VIA_MESSAGE: PermissionName { "android.permission.SEND_RESPOND_VIA_MESSAGE" }
		
		/// Allows an application to send SMS messages.
		public static var SEND_SMS: PermissionName { "android.permission.SEND_SMS" }
		
		/// Allows an application to broadcast an Intent to set an alarm for the user.
		public static var SET_ALARM: PermissionName { "android.permission.SET_ALARM" }
		
		/// Allows an application to control whether activities are immediately finished when put in the background.
		public static var SET_ALWAYS_FINISH: PermissionName { "android.permission.SET_ALWAYS_FINISH" }
		
		/// Modify the global animation scaling factor.
		public static var SET_ANIMATION_SCALE: PermissionName { "android.permission.SET_ANIMATION_SCALE" }
		
		/// Configure an application for debugging.
		public static var SET_DEBUG_APP: PermissionName { "android.permission.SET_DEBUG_APP" }
		
		/// This constant was deprecated in API level 15. No longer useful, see PackageManager.addPackageToPreferred(String) for details.
		public static var SET_PREFERRED_APPLICATIONS: PermissionName { "android.permission.SET_PREFERRED_APPLICATIONS" }
		
		/// Allows an application to set the maximum number of (not needed) application processes that can be running.
		public static var SET_PROCESS_LIMIT: PermissionName { "android.permission.SET_PROCESS_LIMIT" }
		
		/// Allows applications to set the system time directly.
		public static var SET_TIME: PermissionName { "android.permission.SET_TIME" }
		
		/// Allows applications to set the system time zone directly.
		public static var SET_TIME_ZONE: PermissionName { "android.permission.SET_TIME_ZONE" }
		
		/// Allows applications to set the wallpaper.
		public static var SET_WALLPAPER: PermissionName { "android.permission.SET_WALLPAPER" }
		
		/// Allows applications to set the wallpaper hints.
		public static var SET_WALLPAPER_HINTS: PermissionName { "android.permission.SET_WALLPAPER_HINTS" }
		
		/// Allow an application to request that a signal be sent to all persistent processes.
		public static var SIGNAL_PERSISTENT_PROCESSES: PermissionName { "android.permission.SIGNAL_PERSISTENT_PROCESSES" }
		
		/// This constant was deprecated in API level 31. The API that used this permission is no longer functional.
		public static var SMS_FINANCIAL_TRANSACTIONS: PermissionName { "android.permission.SMS_FINANCIAL_TRANSACTIONS" }
		
		/// Allows an application to start foreground services from the background at any time.
		public static var START_FOREGROUND_SERVICES_FROM_BACKGROUND: PermissionName { "android.permission.START_FOREGROUND_SERVICES_FROM_BACKGROUND" }
		
		/// Allows the holder to start the screen with a list of app features.
		public static var START_VIEW_APP_FEATURES: PermissionName { "android.permission.START_VIEW_APP_FEATURES" }
		
		/// Allows the holder to start the permission usage screen for an app.
		public static var START_VIEW_PERMISSION_USAGE: PermissionName { "android.permission.START_VIEW_PERMISSION_USAGE" }
		
		/// Allows an application to open, close, or disable the status bar and its icons.
		public static var STATUS_BAR: PermissionName { "android.permission.STATUS_BAR" }
		
		/// Allows an app to create windows using the type WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY, shown on top of all other apps.
		public static var SYSTEM_ALERT_WINDOW: PermissionName { "android.permission.SYSTEM_ALERT_WINDOW" }
		
		/// Allows using the device's IR transmitter, if available.
		public static var TRANSMIT_IR: PermissionName { "android.permission.TRANSMIT_IR" }
		
		/// Don't use this permission in your app.
		public static var UNINSTALL_SHORTCUT: PermissionName { "android.permission.UNINSTALL_SHORTCUT" }
		
		/// Allows an application to update device statistics.
		public static var UPDATE_DEVICE_STATS: PermissionName { "android.permission.UPDATE_DEVICE_STATS" }
		
		/// Allows an application to indicate via PackageInstaller.SessionParams.setRequireUserAction(int) that user action should not be required for an app update.
		public static var UPDATE_PACKAGES_WITHOUT_USER_ACTION: PermissionName { "android.permission.UPDATE_PACKAGES_WITHOUT_USER_ACTION" }
		
		/// Allows an app to use device supported biometric modalities.
		public static var USE_BIOMETRIC: PermissionName { "android.permission.USE_BIOMETRIC" }
		
		/// Allows apps to use exact alarms just like with SCHEDULE_EXACT_ALARM but without needing to request this permission from the user.
		public static var USE_EXACT_ALARM: PermissionName { "android.permission.USE_EXACT_ALARM" }
		
		/// This constant was deprecated in API level 28. Applications should request USE_BIOMETRIC instead
		public static var USE_FINGERPRINT: PermissionName { "android.permission.USE_FINGERPRINT" }
		
		/// Required for apps targeting Build.VERSION_CODES.Q that want to use notification full screen intents.
		public static var USE_FULL_SCREEN_INTENT: PermissionName { "android.permission.USE_FULL_SCREEN_INTENT" }
		
		/// Allows to read device identifiers and use ICC based authentication like EAP-AKA.
		public static var USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER: PermissionName { "android.permission.USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER" }
		
		/// Allows an application to use SIP service.
		public static var USE_SIP: PermissionName { "android.permission.USE_SIP" }
		
		/// Required to be able to range to devices using ultra-wideband.
		public static var UWB_RANGING: PermissionName { "android.permission.UWB_RANGING" }
		
		/// Allows access to the vibrator.
		public static var VIBRATE: PermissionName { "android.permission.VIBRATE" }
		
		/// Allows using PowerManager WakeLocks to keep processor from sleeping or screen from dimming.
		public static var WAKE_LOCK: PermissionName { "android.permission.WAKE_LOCK" }
		
		/// Allows applications to write the apn settings and read sensitive fields of an existing apn settings like user and password.
		public static var WRITE_APN_SETTINGS: PermissionName { "android.permission.WRITE_APN_SETTINGS" }
		
		/// Allows an application to write the user's calendar data.
		public static var WRITE_CALENDAR: PermissionName { "android.permission.WRITE_CALENDAR" }
		
		/// Allows an application to write (but not read) the user's call log data.
		public static var WRITE_CALL_LOG: PermissionName { "android.permission.WRITE_CALL_LOG" }
		
		/// Allows an application to write the user's contacts data.
		public static var WRITE_CONTACTS: PermissionName { "android.permission.WRITE_CONTACTS" }
		
		/// Allows an application to write to external storage.
		public static var WRITE_EXTERNAL_STORAGE: PermissionName { "android.permission.WRITE_EXTERNAL_STORAGE" }
		
		/// Allows an application to modify the Google service map.
		public static var WRITE_GSERVICES: PermissionName { "android.permission.WRITE_GSERVICES" }
		
		/// Allows an application to read or write the secure system settings.
		public static var WRITE_SECURE_SETTINGS: PermissionName { "android.permission.WRITE_SECURE_SETTINGS" }
		
		/// Allows an application to read or write the system settings.
		public static var WRITE_SETTINGS: PermissionName { "android.permission.WRITE_SETTINGS" }
		
		/// Allows applications to write the sync settings.
		public static var WRITE_SYNC_SETTINGS: PermissionName { "android.permission.WRITE_SYNC_SETTINGS" }
		
		/// Allows an application to modify and remove existing voicemails in the system.
		public static var WRITE_VOICEMAIL: PermissionName { "android.permission.WRITE_VOICEMAIL" }
	}
}
