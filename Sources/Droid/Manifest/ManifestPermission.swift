//
//  ManifestPermission.swift
//  Droid
//
//  Created by Mihael Isaev on 13.09.2025.
//

public struct ManifestPermission: ExpressibleByStringLiteral, StringValuable, Sendable, CustomStringConvertible {
    public let value: String
    public let requiredFeatures: [ManifestFeature]
    
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
        self.requiredFeatures = []
    }

    public init (_ value: String, _ requiredFeatures: [ManifestFeature]) {
        self.value = value
        self.requiredFeatures = requiredFeatures
    }

    public var description: String { value }

    static let extendedPermissions: [ManifestPermission] = [
        .accessCoarseLocation,
        .accessFineLocation,
        .accessWifiState,
        .bluetooth,
        .bluetoothAdmin,
        .callPhone,
        .callPrivileged,
        .camera,
        .changeWifiMulticastState,
        .changeWifiState,
        .installLocationProvider,
        .readPhoneState,
        .readSms,
        .receiveMms,
        .receiveSms,
        .sendSms,
        .writeApnSettings
    ]

    public func warnIfNeeded() {
        if (!DroidApp.shared._manifest.usesPermission.contains(where: { $0.params[.androidName] == value })) {
            Log.c("⚠️ You forgot to add `.usesPermission(.\(value))` to your `DroidApp` manifest!")
        }
        if (requiredFeatures.count > 0) {
            for requiredFeature in requiredFeatures {
                if (!DroidApp.shared._manifest.usesFeature.contains(where: { $0.params[.androidName] == requiredFeature.value })) {
                    Log.c("⚠️ You forgot to add `.usesFeature(.\(requiredFeature.value))` to your `DroidApp` manifest!")
                }
            }
        }
    }

    /// Allows a calling app to continue a call which was started in another app.
    public static let acceptHandover: ManifestPermission = "android.permission.ACCEPT_HANDOVER"
    /// Allows an app to access location in the background.
    public static let accessBackgroundLocation: ManifestPermission = "android.permission.ACCESS_BACKGROUND_LOCATION"
    /// Allows an application to access data blobs across users.
    public static let accessBlobsAcrossUsers: ManifestPermission = "android.permission.ACCESS_BLOBS_ACROSS_USERS"
    /// Allows read/write access to the "properties" table in the checkin database, to change values that get uploaded.
    public static let accessCheckinProperties: ManifestPermission = "android.permission.ACCESS_CHECKIN_PROPERTIES"
    /// Allows an app to access approximate location.
    public static let accessCoarseLocation: ManifestPermission = .init("android.permission.ACCESS_COARSE_LOCATION", [.hardwareLocation])
    /// Allows an app to access precise location.
    public static let accessFineLocation: ManifestPermission = .init("android.permission.ACCESS_FINE_LOCATION", [.hardwareLocation])
    /// Allows applications to access profiles with android.content.pm.UserProperties#PROFILE_API_VISIBILITY_HIDDEN user property, e.g.
    public static let accessHiddenProfiles: ManifestPermission = "android.permission.ACCESS_HIDDEN_PROFILES"
    /// This permission protects a content provider within home/launcher applications, enabling management of home screen metadata such as shortcut placement, launch intents, and labels.
    public static let accessLauncherData: ManifestPermission = "android.permission.ACCESS_LAUNCHER_DATA"
    /// Allows an application to access extra location provider commands.
    public static let accessLocationExtraCommands: ManifestPermission = .init("android.permission.ACCESS_LOCATION_EXTRA_COMMANDS", [.hardwareLocation])
    /// Allows an application to access any geographic locations persisted in the user's shared collection.
    public static let accessMediaLocation: ManifestPermission = "android.permission.ACCESS_MEDIA_LOCATION"
    /// Allows applications to access information about networks.
    public static let accessNetworkState: ManifestPermission = "android.permission.ACCESS_NETWORK_STATE"
    /// Marker permission for applications that wish to access notification policy.
    public static let accessNotificationPolicy: ManifestPermission = "android.permission.ACCESS_NOTIFICATION_POLICY"
    /// Allows applications to access information about Wi-Fi networks.
    public static let accessWifiState: ManifestPermission = .init("android.permission.ACCESS_WIFI_STATE", [.hardwareWifi])
    /// Allows applications to call into AccountAuthenticators.
    public static let accountManager: ManifestPermission = "android.permission.ACCOUNT_MANAGER"
    /// Allows an application to recognize physical activity.
    public static let activityRecognition: ManifestPermission = "android.permission.ACTIVITY_RECOGNITION"
    /// Allows an application to add voicemails into the system.
    public static let addVoicemail: ManifestPermission = "android.permission.ADD_VOICEMAIL"
    /// Allows the app to answer an incoming phone call.
    public static let answerPhoneCalls: ManifestPermission = "android.permission.ANSWER_PHONE_CALLS"
    /// Allows an app to apply a ERROR(/MediaQualityManager.PictureProfile) to a layer via ERROR(/MediaCodec.PARAMETER_KEY_PICTURE_PROFILE) and, additionally, system apps via ERROR(/SurfaceControl.Transaction#setPictureProfileHandle).
    public static let applyPictureProfile: ManifestPermission = "android.permission.APPLY_PICTURE_PROFILE"
    /// Allows an application to collect battery statistics
    public static let batteryStats: ManifestPermission = "android.permission.BATTERY_STATS"
    /// Must be required by an AccessibilityService, to ensure that only the system can bind to it.
    public static let bindAccessibilityService: ManifestPermission = "android.permission.BIND_ACCESSIBILITY_SERVICE"
    /// Allows an application to tell the AppWidget service which application can access AppWidget's data.
    public static let bindAppwidget: ManifestPermission = "android.permission.BIND_APPWIDGET"
    /// Must be required by an AppFunctionService, to ensure that only the system can bind to it.
    public static let bindAppFunctionService: ManifestPermission = "android.permission.BIND_APP_FUNCTION_SERVICE"
    /// Must be required by a AutofillService, to ensure that only the system can bind to it.
    public static let bindAutofillService: ManifestPermission = "android.permission.BIND_AUTOFILL_SERVICE"
    /// Must be required by a CallRedirectionService, to ensure that only the system can bind to it.
    public static let bindCallRedirectionService: ManifestPermission = "android.permission.BIND_CALL_REDIRECTION_SERVICE"
    /// A subclass of CarrierMessagingClientService must be protected with this permission.
    public static let bindCarrierMessagingClientService: ManifestPermission = "android.permission.BIND_CARRIER_MESSAGING_CLIENT_SERVICE"
    /// This constant was deprecated in API level 23. Use BIND_CARRIER_SERVICES instead
    public static let bindCarrierMessagingService: ManifestPermission = "android.permission.BIND_CARRIER_MESSAGING_SERVICE"
    /// The system process that is allowed to bind to services in carrier apps will have this permission.
    public static let bindCarrierServices: ManifestPermission = "android.permission.BIND_CARRIER_SERVICES"
    /// This constant was deprecated in API level 30. For publishing direct share targets, please follow the instructions in https://developer.android.com/training/sharing/receive.html#providing-direct-share-targets instead.
    public static let bindChooserTargetService: ManifestPermission = "android.permission.BIND_CHOOSER_TARGET_SERVICE"
    /// Must be required by any CompanionDeviceServices to ensure that only the system can bind to it.
    public static let bindCompanionDeviceService: ManifestPermission = "android.permission.BIND_COMPANION_DEVICE_SERVICE"
    /// Must be required by a ConditionProviderService, to ensure that only the system can bind to it.
    public static let bindConditionProviderService: ManifestPermission = "android.permission.BIND_CONDITION_PROVIDER_SERVICE"
    /// Allows SystemUI to request third party controls.
    public static let bindControls: ManifestPermission = "android.permission.BIND_CONTROLS"
    /// Must be required by a CredentialProviderService to ensure that only the system can bind to it.
    public static let bindCredentialProviderService: ManifestPermission = "android.permission.BIND_CREDENTIAL_PROVIDER_SERVICE"
    /// Must be required by device administration receiver, to ensure that only the system can interact with it.
    public static let bindDeviceAdmin: ManifestPermission = "android.permission.BIND_DEVICE_ADMIN"
    /// Must be required by an DreamService, to ensure that only the system can bind to it.
    public static let bindDreamService: ManifestPermission = "android.permission.BIND_DREAM_SERVICE"
    /// Must be required by a InCallService, to ensure that only the system can bind to it.
    public static let bindIncallService: ManifestPermission = "android.permission.BIND_INCALL_SERVICE"
    /// Must be required by an InputMethodService, to ensure that only the system can bind to it.
    public static let bindInputMethod: ManifestPermission = "android.permission.BIND_INPUT_METHOD"
    /// Must be required by an MidiDeviceService, to ensure that only the system can bind to it.
    public static let bindMidiDeviceService: ManifestPermission = "android.permission.BIND_MIDI_DEVICE_SERVICE"
    /// Must be required by a HostApduService or OffHostApduService to ensure that only the system can bind to it.
    public static let bindNfcService: ManifestPermission = "android.permission.BIND_NFC_SERVICE"
    /// Must be required by an NotificationListenerService, to ensure that only the system can bind to it.
    public static let bindNotificationListenerService: ManifestPermission = "android.permission.BIND_NOTIFICATION_LISTENER_SERVICE"
    /// Must be required by a PrintService, to ensure that only the system can bind to it.
    public static let bindPrintService: ManifestPermission = "android.permission.BIND_PRINT_SERVICE"
    /// Must be required by a QuickAccessWalletService to ensure that only the system can bind to it.
    public static let bindQuickAccessWalletService: ManifestPermission = "android.permission.BIND_QUICK_ACCESS_WALLET_SERVICE"
    /// Allows an application to bind to third party quick settings tiles.
    public static let bindQuickSettingsTile: ManifestPermission = "android.permission.BIND_QUICK_SETTINGS_TILE"
    /// Must be required by a RemoteViewsService, to ensure that only the system can bind to it.
    public static let bindRemoteviews: ManifestPermission = "android.permission.BIND_REMOTEVIEWS"
    /// Must be required by a CallScreeningService, to ensure that only the system can bind to it.
    public static let bindScreeningService: ManifestPermission = "android.permission.BIND_SCREENING_SERVICE"
    /// Must be required by a ConnectionService, to ensure that only the system can bind to it.
    public static let bindTelecomConnectionService: ManifestPermission = "android.permission.BIND_TELECOM_CONNECTION_SERVICE"
    /// Must be required by a TextService (e.g. SpellCheckerService) to ensure that only the system can bind to it.
    public static let bindTextService: ManifestPermission = "android.permission.BIND_TEXT_SERVICE"
    /// Must be required by a android.media.tv.ad.TvAdService to ensure that only the system can bind to it.
    public static let bindTvAdService: ManifestPermission = "android.permission.BIND_TV_AD_SERVICE"
    /// Must be required by a TvInputService to ensure that only the system can bind to it.
    public static let bindTvInput: ManifestPermission = "android.permission.BIND_TV_INPUT"
    /// Must be required by a TvInteractiveAppService to ensure that only the system can bind to it.
    public static let bindTvInteractiveApp: ManifestPermission = "android.permission.BIND_TV_INTERACTIVE_APP"
    /// Must be required by a link VisualVoicemailService to ensure that only the system can bind to it.
    public static let bindVisualVoicemailService: ManifestPermission = "android.permission.BIND_VISUAL_VOICEMAIL_SERVICE"
    /// Must be required by a VoiceInteractionService, to ensure that only the system can bind to it.
    public static let bindVoiceInteraction: ManifestPermission = "android.permission.BIND_VOICE_INTERACTION"
    /// Must be required by a VpnService, to ensure that only the system can bind to it.
    public static let bindVpnService: ManifestPermission = "android.permission.BIND_VPN_SERVICE"
    /// Must be required by an VrListenerService, to ensure that only the system can bind to it.
    public static let bindVrListenerService: ManifestPermission = "android.permission.BIND_VR_LISTENER_SERVICE"
    /// Must be required by a WallpaperService, to ensure that only the system can bind to it.
    public static let bindWallpaper: ManifestPermission = "android.permission.BIND_WALLPAPER"
    /// Allows applications to connect to paired bluetooth devices.
    public static let bluetooth: ManifestPermission = .init("android.permission.BLUETOOTH", [.hardwareBluetooth])
    /// Allows applications to discover and pair bluetooth devices.
    public static let bluetoothAdmin: ManifestPermission = .init("android.permission.BLUETOOTH_ADMIN", [.hardwareBluetooth])
    /// Required to be able to advertise to nearby Bluetooth devices.
    public static let bluetoothAdvertise: ManifestPermission = "android.permission.BLUETOOTH_ADVERTISE"
    /// Required to be able to connect to paired Bluetooth devices.
    public static let bluetoothConnect: ManifestPermission = "android.permission.BLUETOOTH_CONNECT"
    /// Allows applications to pair bluetooth devices without user interaction, and to allow or disallow phonebook access or message access.
    public static let bluetoothPrivileged: ManifestPermission = "android.permission.BLUETOOTH_PRIVILEGED"
    /// Required to be able to discover and pair nearby Bluetooth devices.
    public static let bluetoothScan: ManifestPermission = "android.permission.BLUETOOTH_SCAN"
    /// Allows an application to access data from sensors that the user uses to measure what is happening inside their body, such as heart rate.
    public static let bodySensors: ManifestPermission = "android.permission.BODY_SENSORS"
    /// Allows an application to access data from sensors that the user uses to measure what is happening inside their body, such as heart rate.
    public static let bodySensorsBackground: ManifestPermission = "android.permission.BODY_SENSORS_BACKGROUND"
    /// Allows an application to broadcast a notification that an application package has been removed.
    public static let broadcastPackageRemoved: ManifestPermission = "android.permission.BROADCAST_PACKAGE_REMOVED"
    /// Allows an application to broadcast an SMS receipt notification.
    public static let broadcastSms: ManifestPermission = "android.permission.BROADCAST_SMS"
    /// Allows an application to broadcast sticky intents.
    public static let broadcastSticky: ManifestPermission = "android.permission.BROADCAST_STICKY"
    /// Allows an application to broadcast a WAP PUSH receipt notification.
    public static let broadcastWapPush: ManifestPermission = "android.permission.BROADCAST_WAP_PUSH"
    /// Allows an app which implements the InCallService API to be eligible to be enabled as a calling companion app.
    public static let callCompanionApp: ManifestPermission = "android.permission.CALL_COMPANION_APP"
    /// Allows an application to initiate a phone call without going through the Dialer user interface for the user to confirm the call.
    public static let callPhone: ManifestPermission = .init("android.permission.CALL_PHONE", [.hardwareTelephony])
    /// Allows an application to call any phone number, including emergency numbers, without going through the Dialer user interface for the user to confirm the call being placed.
    public static let callPrivileged: ManifestPermission = .init("android.permission.CALL_PRIVILEGED", [.hardwareTelephony])
    /// Required to be able to access the camera device.
    public static let camera: ManifestPermission = .init("android.permission.CAMERA", [.hardwareCamera])
    /// Allows an application to capture audio output.
    public static let captureAudioOutput: ManifestPermission = "android.permission.CAPTURE_AUDIO_OUTPUT"
    /// Allows an application to be able to capture keys before Android system get chance to process system keys and shortcuts.
    public static let captureKeyboard: ManifestPermission = "android.permission.CAPTURE_KEYBOARD"
    /// Allows an application to change whether an application component (other than its own) is enabled or not.
    public static let changeComponentEnabledState: ManifestPermission = "android.permission.CHANGE_COMPONENT_ENABLED_STATE"
    /// Allows an application to modify the current configuration, such as locale.
    public static let changeConfiguration: ManifestPermission = "android.permission.CHANGE_CONFIGURATION"
    /// Allows applications to change network connectivity state.
    public static let changeNetworkState: ManifestPermission = "android.permission.CHANGE_NETWORK_STATE"
    /// Allows applications to enter Wi-Fi Multicast mode.
    public static let changeWifiMulticastState: ManifestPermission = .init("android.permission.CHANGE_WIFI_MULTICAST_STATE", [.hardwareWifi])
    /// Allows applications to change Wi-Fi connectivity state.
    public static let changeWifiState: ManifestPermission = .init("android.permission.CHANGE_WIFI_STATE", [.hardwareWifi])
    /// Allows an application to clear the caches of all installed applications on the device.
    public static let clearAppCache: ManifestPermission = "android.permission.CLEAR_APP_CACHE"
    /// Allows an application to configure and connect to Wifi displays
    public static let configureWifiDisplay: ManifestPermission = "android.permission.CONFIGURE_WIFI_DISPLAY"
    /// Allows enabling/disabling location update notifications from the radio.
    public static let controlLocationUpdates: ManifestPermission = "android.permission.CONTROL_LOCATION_UPDATES"
    /// Allows a browser to invoke the set of query apis to get metadata about credential candidates prepared during the CredentialManager.prepareGetCredential API.
    public static let credentialManagerQueryCandidateCredentials: ManifestPermission = "android.permission.CREDENTIAL_MANAGER_QUERY_CANDIDATE_CREDENTIALS"
    /// Allows specifying candidate credential providers to be queried in Credential Manager get flows, or to be preferred as a default in the Credential Manager create flows.
    public static let credentialManagerSetAllowedProviders: ManifestPermission = "android.permission.CREDENTIAL_MANAGER_SET_ALLOWED_PROVIDERS"
    /// Allows a browser to invoke credential manager APIs on behalf of another RP.
    public static let credentialManagerSetOrigin: ManifestPermission = "android.permission.CREDENTIAL_MANAGER_SET_ORIGIN"
    /// Old permission for deleting an app's cache files, no longer used, but signals for us to quietly ignore calls instead of throwing an exception.
    public static let deleteCacheFiles: ManifestPermission = "android.permission.DELETE_CACHE_FILES"
    /// Allows an application to delete packages.
    public static let deletePackages: ManifestPermission = "android.permission.DELETE_PACKAGES"
    /// Allows an application to deliver companion messages to system
    public static let deliverCompanionMessages: ManifestPermission = "android.permission.DELIVER_COMPANION_MESSAGES"
    /// Allows an application to get notified when a screen capture of its windows is attempted.
    public static let detectScreenCapture: ManifestPermission = "android.permission.DETECT_SCREEN_CAPTURE"
    /// Allows an application to get notified when it is being recorded.
    public static let detectScreenRecording: ManifestPermission = "android.permission.DETECT_SCREEN_RECORDING"
    /// Allows applications to RW to diagnostic resources.
    public static let diagnostic: ManifestPermission = "android.permission.DIAGNOSTIC"
    /// Allows applications to disable the keyguard if it is not secure.
    public static let disableKeyguard: ManifestPermission = "android.permission.DISABLE_KEYGUARD"
    /// Allows an application to retrieve state dump information from system services.
    public static let dump: ManifestPermission = "android.permission.DUMP"
    /// Allows an application to indicate via PackageInstaller.SessionParams.setRequestUpdateOwnership(boolean) that it has the intention of becoming the update owner.
    public static let enforceUpdateOwnership: ManifestPermission = "android.permission.ENFORCE_UPDATE_OWNERSHIP"
    /// Allows an assistive application to perform actions on behalf of users inside of applications.
    public static let executeAppAction: ManifestPermission = "android.permission.EXECUTE_APP_ACTION"
    /// Allows an application to perform actions on behalf of users inside of applications.
    public static let executeAppFunctions: ManifestPermission = "android.permission.EXECUTE_APP_FUNCTIONS"
    /// Allows an application to expand or collapse the status bar.
    public static let expandStatusBar: ManifestPermission = "android.permission.EXPAND_STATUS_BAR"
    /// Run as a manufacturer test application, running as the root user.
    public static let factoryTest: ManifestPermission = "android.permission.FACTORY_TEST"
    /// Allows a regular application to use Service.startForeground.
    public static let foregroundService: ManifestPermission = "android.permission.FOREGROUND_SERVICE"
    /// Allows a regular application to use Service.startForeground with the type "camera".
    public static let foregroundServiceCamera: ManifestPermission = "android.permission.FOREGROUND_SERVICE_CAMERA"
    /// Allows a regular application to use Service.startForeground with the type "connectedDevice".
    public static let foregroundServiceConnectedDevice: ManifestPermission = "android.permission.FOREGROUND_SERVICE_CONNECTED_DEVICE"
    /// Allows a regular application to use Service.startForeground with the type "dataSync".
    public static let foregroundServiceDataSync: ManifestPermission = "android.permission.FOREGROUND_SERVICE_DATA_SYNC"
    /// Allows a regular application to use Service.startForeground with the type "health".
    public static let foregroundServiceHealth: ManifestPermission = "android.permission.FOREGROUND_SERVICE_HEALTH"
    /// Allows a regular application to use Service.startForeground with the type "location".
    public static let foregroundServiceLocation: ManifestPermission = "android.permission.FOREGROUND_SERVICE_LOCATION"
    /// Allows a regular application to use Service.startForeground with the type "mediaPlayback".
    public static let foregroundServiceMediaPlayback: ManifestPermission = "android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK"
    /// Allows a regular application to use Service.startForeground with the type "mediaProcessing".
    public static let foregroundServiceMediaProcessing: ManifestPermission = "android.permission.FOREGROUND_SERVICE_MEDIA_PROCESSING"
    /// Allows a regular application to use Service.startForeground with the type "mediaProjection".
    public static let foregroundServiceMediaProjection: ManifestPermission = "android.permission.FOREGROUND_SERVICE_MEDIA_PROJECTION"
    /// Allows a regular application to use Service.startForeground with the type "microphone".
    public static let foregroundServiceMicrophone: ManifestPermission = "android.permission.FOREGROUND_SERVICE_MICROPHONE"
    /// Allows a regular application to use Service.startForeground with the type "phoneCall".
    public static let foregroundServicePhoneCall: ManifestPermission = "android.permission.FOREGROUND_SERVICE_PHONE_CALL"
    /// Allows a regular application to use Service.startForeground with the type "remoteMessaging".
    public static let foregroundServiceRemoteMessaging: ManifestPermission = "android.permission.FOREGROUND_SERVICE_REMOTE_MESSAGING"
    /// Allows a regular application to use Service.startForeground with the type "specialUse".
    public static let foregroundServiceSpecialUse: ManifestPermission = "android.permission.FOREGROUND_SERVICE_SPECIAL_USE"
    /// Allows a regular application to use Service.startForeground with the type "systemExempted".
    public static let foregroundServiceSystemExempted: ManifestPermission = "android.permission.FOREGROUND_SERVICE_SYSTEM_EXEMPTED"
    /// Allows access to the list of accounts in the Accounts Service.
    public static let getAccounts: ManifestPermission = "android.permission.GET_ACCOUNTS"
    /// Allows access to the list of accounts in the Accounts Service.
    public static let getAccountsPrivileged: ManifestPermission = "android.permission.GET_ACCOUNTS_PRIVILEGED"
    /// Allows an application to find out the space used by any package.
    public static let getPackageSize: ManifestPermission = "android.permission.GET_PACKAGE_SIZE"
    /// This constant was deprecated in API level 21. No longer enforced.
    public static let getTasks: ManifestPermission = "android.permission.GET_TASKS"
    /// This permission can be used on content providers to allow the global search system to access their data.
    public static let globalSearch: ManifestPermission = "android.permission.GLOBAL_SEARCH"
    /// Allows an app to prevent non-system-overlay windows from being drawn on top of it
    public static let hideOverlayWindows: ManifestPermission = "android.permission.HIDE_OVERLAY_WINDOWS"
    /// Allows an app to access sensor data with a sampling rate greater than 200 Hz.
    public static let highSamplingRateSensors: ManifestPermission = "android.permission.HIGH_SAMPLING_RATE_SENSORS"
    /// Allows an application to install a location provider into the Location Manager.
    public static let installLocationProvider: ManifestPermission = .init("android.permission.INSTALL_LOCATION_PROVIDER", [.hardwareLocation])
    /// Allows an application to install packages.
    public static let installPackages: ManifestPermission = "android.permission.INSTALL_PACKAGES"
    /// Allows an application to install a shortcut in Launcher.
    public static let installShortcut: ManifestPermission = "android.permission.INSTALL_SHORTCUT"
    /// Allows an instant app to create foreground services.
    public static let instantAppForegroundService: ManifestPermission = "android.permission.INSTANT_APP_FOREGROUND_SERVICE"
    /// Allows interaction across profiles in the same profile group.
    public static let interactAcrossProfiles: ManifestPermission = "android.permission.INTERACT_ACROSS_PROFILES"
    /// Allows applications to open network sockets.
    public static let internet: ManifestPermission = "android.permission.INTERNET"
    /// Allows an application to call ActivityManager.killBackgroundProcesses(String).
    public static let killBackgroundProcesses: ManifestPermission = "android.permission.KILL_BACKGROUND_PROCESSES"
    /// Allows an application to capture screen content to perform a screenshot using the intent action Intent.ACTION_LAUNCH_CAPTURE_CONTENT_ACTIVITY_FOR_NOTE.
    public static let launchCaptureContentActivityForNote: ManifestPermission = "android.permission.LAUNCH_CAPTURE_CONTENT_ACTIVITY_FOR_NOTE"
    /// An application needs this permission for Settings.ACTION_SETTINGS_EMBED_DEEP_LINK_ACTIVITY to show its Activity embedded in Settings app.
    public static let launchMultiPaneSettingsDeepLink: ManifestPermission = "android.permission.LAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK"
    /// Allows a data loader to read a package's access logs.
    public static let loaderUsageStats: ManifestPermission = "android.permission.LOADER_USAGE_STATS"
    /// Allows an application to use location features in hardware, such as the geofencing api.
    public static let locationHardware: ManifestPermission = "android.permission.LOCATION_HARDWARE"
    /// Allows financed device kiosk apps to perform actions on the Device Lock service
    public static let manageDeviceLockState: ManifestPermission = "android.permission.MANAGE_DEVICE_LOCK_STATE"
    /// Allows an application to manage policy related to accessibility.
    public static let manageDevicePolicyAccessibility: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_ACCESSIBILITY"
    /// Allows an application to set policy related to account management.
    public static let manageDevicePolicyAccountManagement: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_ACCOUNT_MANAGEMENT"
    /// Allows an application to set device policies outside the current user that are required for securing device ownership without accessing user data.
    public static let manageDevicePolicyAcrossUsers: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_ACROSS_USERS"
    /// Allows an application to set device policies outside the current user.
    public static let manageDevicePolicyAcrossUsersFull: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_ACROSS_USERS_FULL"
    /// Allows an application to set device policies outside the current user that are critical for securing data within the current user.
    public static let manageDevicePolicyAcrossUsersSecurityCritical: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_ACROSS_USERS_SECURITY_CRITICAL"
    /// Allows an application to set policy related to airplane mode.
    public static let manageDevicePolicyAirplaneMode: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_AIRPLANE_MODE"
    /// Allows an application to manage policy regarding modifying applications.
    public static let manageDevicePolicyAppsControl: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_APPS_CONTROL"
    /// Allows an application to manage policy related to AppFunctions.
    public static let manageDevicePolicyAppFunctions: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_APP_FUNCTIONS"
    /// Allows an application to manage application restrictions.
    public static let manageDevicePolicyAppRestrictions: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_APP_RESTRICTIONS"
    /// Allows an application to manage policy related to application user data.
    public static let manageDevicePolicyAppUserData: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_APP_USER_DATA"
    /// Allows an application to set policy related to sending assist content to a privileged app such as the Assistant app.
    public static let manageDevicePolicyAssistContent: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_ASSIST_CONTENT"
    /// Allows an application to set policy related to audio output.
    public static let manageDevicePolicyAudioOutput: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_AUDIO_OUTPUT"
    /// Allows an application to set policy related to autofill.
    public static let manageDevicePolicyAutofill: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_AUTOFILL"
    /// Allows an application to manage backup service policy.
    public static let manageDevicePolicyBackupService: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_BACKUP_SERVICE"
    /// Allows an application to manage policy related to block package uninstallation.
    public static let manageDevicePolicyBlockUninstall: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_BLOCK_UNINSTALL"
    /// Allows an application to set policy related to bluetooth.
    public static let manageDevicePolicyBluetooth: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_BLUETOOTH"
    /// Allows an application to request bugreports with user consent.
    public static let manageDevicePolicyBugreport: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_BUGREPORT"
    /// Allows an application to manage calling policy.
    public static let manageDevicePolicyCalls: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_CALLS"
    /// Allows an application to set policy related to restricting a user's ability to use or enable and disable the camera.
    public static let manageDevicePolicyCamera: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_CAMERA"
    /// Allows an application to manage policy related to camera toggle.
    public static let manageDevicePolicyCameraToggle: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_CAMERA_TOGGLE"
    /// Allows an application to set policy related to certificates.
    public static let manageDevicePolicyCertificates: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_CERTIFICATES"
    /// Allows an application to manage policy related to common criteria mode.
    public static let manageDevicePolicyCommonCriteriaMode: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_COMMON_CRITERIA_MODE"
    /// Allows an application to manage policy related to content protection.
    public static let manageDevicePolicyContentProtection: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_CONTENT_PROTECTION"
    /// Allows an application to manage debugging features policy.
    public static let manageDevicePolicyDebuggingFeatures: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_DEBUGGING_FEATURES"
    /// Allows an application to set policy related to the default sms application.
    public static let manageDevicePolicyDefaultSms: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_DEFAULT_SMS"
    /// Allows an application to manage policy related to device identifiers.
    public static let manageDevicePolicyDeviceIdentifiers: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_DEVICE_IDENTIFIERS"
    /// Allows an application to set policy related to the display.
    public static let manageDevicePolicyDisplay: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_DISPLAY"
    /// Allows an application to set policy related to factory reset.
    public static let manageDevicePolicyFactoryReset: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_FACTORY_RESET"
    /// Allows an application to set policy related to fun.
    public static let manageDevicePolicyFun: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_FUN"
    /// Allows an application to set policy related to input methods.
    public static let manageDevicePolicyInputMethods: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_INPUT_METHODS"
    /// Allows an application to manage installing from unknown sources policy.
    public static let manageDevicePolicyInstallUnknownSources: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_INSTALL_UNKNOWN_SOURCES"
    /// Allows an application to set policy related to keeping uninstalled packages.
    public static let manageDevicePolicyKeepUninstalledPackages: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_KEEP_UNINSTALLED_PACKAGES"
    /// Allows an application to manage policy related to keyguard.
    public static let manageDevicePolicyKeyguard: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_KEYGUARD"
    /// Allows an application to set policy related to locale.
    public static let manageDevicePolicyLocale: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_LOCALE"
    /// Allows an application to set policy related to location.
    public static let manageDevicePolicyLocation: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_LOCATION"
    /// Allows an application to lock a profile or the device with the appropriate cross-user permission.
    public static let manageDevicePolicyLock: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_LOCK"
    /// Allows an application to set policy related to lock credentials.
    public static let manageDevicePolicyLockCredentials: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_LOCK_CREDENTIALS"
    /// Allows an application to manage lock task policy.
    public static let manageDevicePolicyLockTask: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_LOCK_TASK"
    /// Allows an application to set policy related to subscriptions downloaded by an admin.
    public static let manageDevicePolicyManagedSubscriptions: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_MANAGED_SUBSCRIPTIONS"
    /// Allows an application to manage policy related to metered data.
    public static let manageDevicePolicyMeteredData: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_METERED_DATA"
    /// Allows an application to set policy related to restricting a user's ability to use or enable and disable the microphone.
    public static let manageDevicePolicyMicrophone: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_MICROPHONE"
    /// Allows an application to manage policy related to microphone toggle.
    public static let manageDevicePolicyMicrophoneToggle: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_MICROPHONE_TOGGLE"
    /// Allows an application to set policy related to mobile networks.
    public static let manageDevicePolicyMobileNetwork: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_MOBILE_NETWORK"
    /// Allows an application to manage policy preventing users from modifying users.
    public static let manageDevicePolicyModifyUsers: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_MODIFY_USERS"
    /// Allows an application to manage policy related to the Memory Tagging Extension (MTE).
    public static let manageDevicePolicyMte: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_MTE"
    /// Allows an application to set policy related to nearby communications (e.g. Beam and nearby streaming).
    public static let manageDevicePolicyNearbyCommunication: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_NEARBY_COMMUNICATION"
    /// Allows an application to set policy related to network logging.
    public static let manageDevicePolicyNetworkLogging: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_NETWORK_LOGGING"
    /// Allows an application to manage the identity of the managing organization.
    public static let manageDevicePolicyOrganizationIdentity: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_ORGANIZATION_IDENTITY"
    /// Allows an application to set policy related to override APNs.
    public static let manageDevicePolicyOverrideApn: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_OVERRIDE_APN"
    /// Allows an application to set policy related to hiding and suspending packages.
    public static let manageDevicePolicyPackageState: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_PACKAGE_STATE"
    /// Allows an application to set policy related to physical media.
    public static let manageDevicePolicyPhysicalMedia: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_PHYSICAL_MEDIA"
    /// Allows an application to set policy related to printing.
    public static let manageDevicePolicyPrinting: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_PRINTING"
    /// Allows an application to set policy related to private DNS.
    public static let manageDevicePolicyPrivateDns: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_PRIVATE_DNS"
    /// Allows an application to set policy related to profiles.
    public static let manageDevicePolicyProfiles: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_PROFILES"
    /// Allows an application to set policy related to interacting with profiles (e.g. Disallowing cross-profile copy and paste).
    public static let manageDevicePolicyProfileInteraction: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_PROFILE_INTERACTION"
    /// Allows an application to set a network-independent global HTTP proxy.
    public static let manageDevicePolicyProxy: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_PROXY"
    /// Allows an application query system updates.
    public static let manageDevicePolicyQuerySystemUpdates: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_QUERY_SYSTEM_UPDATES"
    /// Allows an application to force set a new device unlock password or a managed profile challenge on current user.
    public static let manageDevicePolicyResetPassword: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_RESET_PASSWORD"
    /// Allows an application to set policy related to restricting the user from configuring private DNS.
    public static let manageDevicePolicyRestrictPrivateDns: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_RESTRICT_PRIVATE_DNS"
    /// Allows an application to set the grant state of runtime permissions on packages.
    public static let manageDevicePolicyRuntimePermissions: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_RUNTIME_PERMISSIONS"
    /// Allows an application to set policy related to users running in the background.
    public static let manageDevicePolicyRunInBackground: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_RUN_IN_BACKGROUND"
    /// Allows an application to manage safe boot policy.
    public static let manageDevicePolicySafeBoot: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_SAFE_BOOT"
    /// Allows an application to set policy related to screen capture.
    public static let manageDevicePolicyScreenCapture: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_SCREEN_CAPTURE"
    /// Allows an application to set policy related to the usage of the contents of the screen.
    public static let manageDevicePolicyScreenContent: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_SCREEN_CONTENT"
    /// Allows an application to set policy related to security logging.
    public static let manageDevicePolicySecurityLogging: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_SECURITY_LOGGING"
    /// Allows an application to set policy related to settings.
    public static let manageDevicePolicySettings: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_SETTINGS"
    /// Allows an application to set policy related to sms.
    public static let manageDevicePolicySms: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_SMS"
    /// Allows an application to set policy related to the status bar.
    public static let manageDevicePolicyStatusBar: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_STATUS_BAR"
    /// Allows an application to set support messages for when a user action is affected by an active policy.
    public static let manageDevicePolicySupportMessage: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_SUPPORT_MESSAGE"
    /// Allows an application to set policy related to suspending personal apps.
    public static let manageDevicePolicySuspendPersonalApps: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_SUSPEND_PERSONAL_APPS"
    /// Allows an application to manage policy related to system apps.
    public static let manageDevicePolicySystemApps: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_SYSTEM_APPS"
    /// Allows an application to set policy related to system dialogs.
    public static let manageDevicePolicySystemDialogs: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_SYSTEM_DIALOGS"
    /// Allows an application to set policy related to system updates.
    public static let manageDevicePolicySystemUpdates: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_SYSTEM_UPDATES"
    /// Allows an application to set policy related to Thread network.
    public static let manageDevicePolicyThreadNetwork: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_THREAD_NETWORK"
    /// Allows an application to manage device policy relating to time.
    public static let manageDevicePolicyTime: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_TIME"
    /// Allows an application to set policy related to usb data signalling.
    public static let manageDevicePolicyUsbDataSignalling: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_USB_DATA_SIGNALLING"
    /// Allows an application to set policy related to usb file transfers.
    public static let manageDevicePolicyUsbFileTransfer: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_USB_FILE_TRANSFER"
    /// Allows an application to set policy related to users.
    public static let manageDevicePolicyUsers: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_USERS"
    /// Allows an application to set policy related to VPNs.
    public static let manageDevicePolicyVpn: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_VPN"
    /// Allows an application to set policy related to the wallpaper.
    public static let manageDevicePolicyWallpaper: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_WALLPAPER"
    /// Allows an application to set policy related to Wifi.
    public static let manageDevicePolicyWifi: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_WIFI"
    /// Allows an application to set policy related to windows.
    public static let manageDevicePolicyWindows: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_WINDOWS"
    /// Allows an application to manage policy related to wiping data.
    public static let manageDevicePolicyWipeData: ManifestPermission = "android.permission.MANAGE_DEVICE_POLICY_WIPE_DATA"
    /// Allows an application to manage access to documents, usually as part of a document picker.
    public static let manageDocuments: ManifestPermission = "android.permission.MANAGE_DOCUMENTS"
    /// Allows an application a broad access to external storage in scoped storage.
    public static let manageExternalStorage: ManifestPermission = "android.permission.MANAGE_EXTERNAL_STORAGE"
    /// Allows an application to modify and delete media files on this device or any connected storage device without user confirmation.
    public static let manageMedia: ManifestPermission = "android.permission.MANAGE_MEDIA"
    /// Allows to query ongoing call details and manage ongoing calls
    public static let manageOngoingCalls: ManifestPermission = "android.permission.MANAGE_ONGOING_CALLS"
    /// Allows a calling application which manages its own calls through the self-managed ConnectionService APIs.
    public static let manageOwnCalls: ManifestPermission = "android.permission.MANAGE_OWN_CALLS"
    /// Allows applications to get notified when a Wi-Fi interface request cannot be satisfied without tearing down one or more other interfaces, and provide a decision whether to approve the request or reject it.
    public static let manageWifiInterfaces: ManifestPermission = "android.permission.MANAGE_WIFI_INTERFACES"
    /// This permission is used to let OEMs grant their trusted app access to a subset of privileged wifi APIs to improve wifi performance.
    public static let manageWifiNetworkSelection: ManifestPermission = "android.permission.MANAGE_WIFI_NETWORK_SELECTION"
    /// Not for use by third-party applications.
    public static let masterClear: ManifestPermission = "android.permission.MASTER_CLEAR"
    /// Allows an application to know what content is playing and control its playback.
    public static let mediaContentControl: ManifestPermission = "android.permission.MEDIA_CONTENT_CONTROL"
    /// Allows an application to control the routing of media apps.
    public static let mediaRoutingControl: ManifestPermission = "android.permission.MEDIA_ROUTING_CONTROL"
    /// Allows an application to modify global audio settings.
    public static let modifyAudioSettings: ManifestPermission = "android.permission.MODIFY_AUDIO_SETTINGS"
    /// Allows modification of the telephony state - power on, mmi, etc.
    public static let modifyPhoneState: ManifestPermission = .init("android.permission.MODIFY_PHONE_STATE", [.hardwareTelephony])
    /// Allows formatting file systems for removable storage.
    public static let mountFormatFilesystems: ManifestPermission = "android.permission.MOUNT_FORMAT_FILESYSTEMS"
    /// Allows mounting and unmounting file systems for removable storage.
    public static let mountUnmountFilesystems: ManifestPermission = "android.permission.MOUNT_UNMOUNT_FILESYSTEMS"
    /// Required to be able to advertise and connect to nearby devices via Wi-Fi.
    public static let nearbyWifiDevices: ManifestPermission = "android.permission.NEARBY_WIFI_DEVICES"
    /// Allows applications to perform I/O operations over NFC.
    public static let nfc: ManifestPermission = "android.permission.NFC"
    /// Allows applications to receive NFC preferred payment service information.
    public static let nfcPreferredPaymentInfo: ManifestPermission = "android.permission.NFC_PREFERRED_PAYMENT_INFO"
    /// Allows applications to receive NFC transaction events.
    public static let nfcTransactionEvent: ManifestPermission = "android.permission.NFC_TRANSACTION_EVENT"
    /// Allows an application to modify any wifi configuration, even if created by another application.
    public static let overrideWifiConfig: ManifestPermission = "android.permission.OVERRIDE_WIFI_CONFIG"
    /// Allows an application to collect component usage statistics
    public static let packageUsageStats: ManifestPermission = "android.permission.PACKAGE_USAGE_STATS"
    /// This constant was deprecated in API level 15. This functionality will be removed in the future; please do not use. Allow an application to make its activities persistent.
    public static let persistentActivity: ManifestPermission = "android.permission.PERSISTENT_ACTIVITY"
    /// Allows an app to post notifications
    public static let postNotifications: ManifestPermission = "android.permission.POST_NOTIFICATIONS"
    /// Required for apps to post promoted notifications.
    public static let postPromotedNotifications: ManifestPermission = "android.permission.POST_PROMOTED_NOTIFICATIONS"
    /// This constant was deprecated in API level 29. Applications should use CallRedirectionService instead of the Intent.ACTION_NEW_OUTGOING_CALL broadcast.
    public static let processOutgoingCalls: ManifestPermission = .init("android.permission.PROCESS_OUTGOING_CALLS", [.hardwareTelephony])
    /// Allows an application to display its suggestions using the autofill framework.
    public static let provideOwnAutofillSuggestions: ManifestPermission = "android.permission.PROVIDE_OWN_AUTOFILL_SUGGESTIONS"
    /// Allows an application to be able to store and retrieve credentials from a remote device.
    public static let provideRemoteCredentials: ManifestPermission = "android.permission.PROVIDE_REMOTE_CREDENTIALS"
    /// Allows an application to query the device's advanced protection mode status.
    public static let queryAdvancedProtectionMode: ManifestPermission = "android.permission.QUERY_ADVANCED_PROTECTION_MODE"
    /// Allows query of any normal app on the device, regardless of manifest declarations.
    public static let queryAllPackages: ManifestPermission = "android.permission.QUERY_ALL_PACKAGES"
    /// Required to be able to range to devices using generic ranging module.
    public static let ranging: ManifestPermission = "android.permission.RANGING"
    /// Allows an application to query over global data in AppSearch that's visible to the ASSISTANT role.
    public static let readAssistantAppSearchData: ManifestPermission = "android.permission.READ_ASSISTANT_APP_SEARCH_DATA"
    /// Allows read only access to phone state with a non dangerous permission, including the information like cellular network type, software version.
    public static let readBasicPhoneState: ManifestPermission = "android.permission.READ_BASIC_PHONE_STATE"
    /// Allows an application to read the user's calendar data.
    public static let readCalendar: ManifestPermission = "android.permission.READ_CALENDAR"
    /// Allows an application to read the user's call log.
    public static let readCallLog: ManifestPermission = "android.permission.READ_CALL_LOG"
    /// Allows an application to read the aggregated color zones on the screen for use cases like TV ambient backlight usages.
    public static let readColorZones: ManifestPermission = "android.permission.READ_COLOR_ZONES"
    /// Allows an application to read the user's contacts data.
    public static let readContacts: ManifestPermission = "android.permission.READ_CONTACTS"
    /// Allows an application to access the data in Dropbox.
    public static let readDropboxData: ManifestPermission = "android.permission.READ_DROPBOX_DATA"
    /// Allows an application to read from external storage.
    public static let readExternalStorage: ManifestPermission = "android.permission.READ_EXTERNAL_STORAGE"
    /// Allows an application to query over global data in AppSearch that's visible to the HOME role.
    public static let readHomeAppSearchData: ManifestPermission = "android.permission.READ_HOME_APP_SEARCH_DATA"
    /// This constant was deprecated in API level 16. The API that used this permission has been removed.
    public static let readInputState: ManifestPermission = "android.permission.READ_INPUT_STATE"
    /// Allows an application to read the low-level system log files.
    public static let readLogs: ManifestPermission = "android.permission.READ_LOGS"
    /// Allows an application to read audio files from external storage.
    public static let readMediaAudio: ManifestPermission = "android.permission.READ_MEDIA_AUDIO"
    /// Allows an application to read image files from external storage.
    public static let readMediaImages: ManifestPermission = "android.permission.READ_MEDIA_IMAGES"
    /// Allows an application to read video files from external storage.
    public static let readMediaVideo: ManifestPermission = "android.permission.READ_MEDIA_VIDEO"
    /// Allows an application to read image or video files from external storage that a user has selected via the permission prompt photo picker.
    public static let readMediaVisualUserSelected: ManifestPermission = "android.permission.READ_MEDIA_VISUAL_USER_SELECTED"
    /// Allows an application to read nearby streaming policy.
    public static let readNearbyStreamingPolicy: ManifestPermission = "android.permission.READ_NEARBY_STREAMING_POLICY"
    /// Allows read access to the device's phone number(s), which is exposed to instant applications.
    public static let readPhoneNumbers: ManifestPermission = "android.permission.READ_PHONE_NUMBERS"
    /// Allows read only access to phone state, including the current cellular network information, the status of any ongoing calls, and a list of any PhoneAccounts registered on the device.
    public static let readPhoneState: ManifestPermission = "android.permission.READ_PHONE_STATE"
    /// Allows read only access to precise phone state.
    public static let readPrecisePhoneState: ManifestPermission = "android.permission.READ_PRECISE_PHONE_STATE"
    /// Allows an application to read SMS messages.
    public static let readSms: ManifestPermission = .init("android.permission.READ_SMS", [.hardwareTelephony])
    /// Allows applications to read the sync settings.
    public static let readSyncSettings: ManifestPermission = "android.permission.READ_SYNC_SETTINGS"
    /// Allows applications to read the sync stats.
    public static let readSyncStats: ManifestPermission = "android.permission.READ_SYNC_STATS"
    /// Allows an application to access the Settings Preference services to read settings exposed by the system Settings app and system apps that contribute settings surfaced by the Settings app.
    public static let readSystemPreferences: ManifestPermission = "android.permission.READ_SYSTEM_PREFERENCES"
    /// Allows an application to read voicemails in the system.
    public static let readVoicemail: ManifestPermission = "android.permission.READ_VOICEMAIL"
    /// Required to be able to reboot the device.
    public static let reboot: ManifestPermission = "android.permission.REBOOT"
    /// Allows an application to receive the Intent.ACTION_BOOT_COMPLETED that is broadcast after the system finishes booting.
    public static let receiveBootCompleted: ManifestPermission = "android.permission.RECEIVE_BOOT_COMPLETED"
    /// Allows an application to monitor incoming MMS messages.
    public static let receiveMms: ManifestPermission = .init("android.permission.RECEIVE_MMS", [.hardwareTelephony])
    /// Allows apps with a NotificationListenerService to receive notifications with sensitive information
    public static let receiveSensitiveNotifications: ManifestPermission = "android.permission.RECEIVE_SENSITIVE_NOTIFICATIONS"
    /// Allows an application to receive SMS messages.
    public static let receiveSms: ManifestPermission = .init("android.permission.RECEIVE_SMS", [.hardwareTelephony])
    /// Allows an application to receive WAP push messages.
    public static let receiveWapPush: ManifestPermission = .init("android.permission.RECEIVE_WAP_PUSH", [.hardwareTelephony])
    /// Allows an application to record audio.
    public static let recordAudio: ManifestPermission = .init("android.permission.RECORD_AUDIO", [.hardwareMicrophone])
    /// Allows an application to change the Z-order of tasks.
    public static let reorderTasks: ManifestPermission = "android.permission.REORDER_TASKS"
    /// Allows application to request to be associated with a virtual device capable of streaming Android applications (AssociationRequest.DEVICE_PROFILE_APP_STREAMING) by CompanionDeviceManager.
    public static let requestCompanionProfileAppStreaming: ManifestPermission = "android.permission.REQUEST_COMPANION_PROFILE_APP_STREAMING"
    /// Allows application to request to be associated with a vehicle head unit capable of automotive projection (AssociationRequest.DEVICE_PROFILE_AUTOMOTIVE_PROJECTION) by CompanionDeviceManager.
    public static let requestCompanionProfileAutomotiveProjection: ManifestPermission = "android.permission.REQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION"
    /// Allows application to request to be associated with a computer to share functionality and/or data with other devices, such as notifications, photos and media (AssociationRequest.DEVICE_PROFILE_COMPUTER) by CompanionDeviceManager.
    public static let requestCompanionProfileComputer: ManifestPermission = "android.permission.REQUEST_COMPANION_PROFILE_COMPUTER"
    /// Allows app to request to be associated with a device via CompanionDeviceManager as "glasses"
    public static let requestCompanionProfileGlasses: ManifestPermission = "android.permission.REQUEST_COMPANION_PROFILE_GLASSES"
    /// Allows application to request to stream content from an Android host to a nearby device (AssociationRequest.DEVICE_PROFILE_NEARBY_DEVICE_STREAMING) by CompanionDeviceManager.
    public static let requestCompanionProfileNearbyDeviceStreaming: ManifestPermission = "android.permission.REQUEST_COMPANION_PROFILE_NEARBY_DEVICE_STREAMING"
    /// Allows app to request to be associated with a device via CompanionDeviceManager as a "watch"
    public static let requestCompanionProfileWatch: ManifestPermission = "android.permission.REQUEST_COMPANION_PROFILE_WATCH"
    /// Allows a companion app to run in the background.
    public static let requestCompanionRunInBackground: ManifestPermission = "android.permission.REQUEST_COMPANION_RUN_IN_BACKGROUND"
    /// Allows an application to create a "self-managed" association.
    public static let requestCompanionSelfManaged: ManifestPermission = "android.permission.REQUEST_COMPANION_SELF_MANAGED"
    /// Allows a companion app to start a foreground service from the background.
    public static let requestCompanionStartForegroundServicesFromBackground: ManifestPermission = "android.permission.REQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND"
    /// Allows a companion app to use data in the background.
    public static let requestCompanionUseDataInBackground: ManifestPermission = "android.permission.REQUEST_COMPANION_USE_DATA_IN_BACKGROUND"
    /// Allows an application to request deleting packages.
    public static let requestDeletePackages: ManifestPermission = "android.permission.REQUEST_DELETE_PACKAGES"
    /// Permission an application must hold in order to use Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS.
    public static let requestIgnoreBatteryOptimizations: ManifestPermission = "android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS"
    /// Allows an application to request installing packages.
    public static let requestInstallPackages: ManifestPermission = "android.permission.REQUEST_INSTALL_PACKAGES"
    /// Allows an application to subscribe to notifications about the presence status change of their associated companion device
    public static let requestObserveCompanionDevicePresence: ManifestPermission = "android.permission.REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE"
    /// Allows an application to subscribe to notifications about the nearby devices' presence status change base on the UUIDs.
    public static let requestObserveDeviceUuidPresence: ManifestPermission = "android.permission.REQUEST_OBSERVE_DEVICE_UUID_PRESENCE"
    /// Allows an application to request the screen lock complexity and prompt users to update the screen lock to a certain complexity level.
    public static let requestPasswordComplexity: ManifestPermission = "android.permission.REQUEST_PASSWORD_COMPLEXITY"
    /// This constant was deprecated in API level 15. The ActivityManager.restartPackage(String) API is no longer supported.
    public static let restartPackages: ManifestPermission = "android.permission.RESTART_PACKAGES"
    /// Allows applications to use the user-initiated jobs API.
    public static let runUserInitiatedJobs: ManifestPermission = "android.permission.RUN_USER_INITIATED_JOBS"
    /// Allows applications to use exact alarm APIs.
    public static let scheduleExactAlarm: ManifestPermission = "android.permission.SCHEDULE_EXACT_ALARM"
    /// Allows an application (Phone) to send a request to other applications to handle the respond-via-message action during incoming calls.
    public static let sendRespondViaMessage: ManifestPermission = "android.permission.SEND_RESPOND_VIA_MESSAGE"
    /// Allows an application to send SMS messages.
    public static let sendSms: ManifestPermission = .init("android.permission.SEND_SMS", [.hardwareTelephony])
    /// Allows an application to broadcast an Intent to set an alarm for the user.
    public static let setAlarm: ManifestPermission = "android.permission.SET_ALARM"
    /// Allows an application to control whether activities are immediately finished when put in the background.
    public static let setAlwaysFinish: ManifestPermission = "android.permission.SET_ALWAYS_FINISH"
    /// Modify the global animation scaling factor.
    public static let setAnimationScale: ManifestPermission = "android.permission.SET_ANIMATION_SCALE"
    /// Allows an application to set the advanced features on BiometricDialog (SystemUI), including logo, logo description, and content view with more options button.
    public static let setBiometricDialogAdvanced: ManifestPermission = "android.permission.SET_BIOMETRIC_DIALOG_ADVANCED"
    /// Configure an application for debugging.
    public static let setDebugApp: ManifestPermission = "android.permission.SET_DEBUG_APP"
    /// This constant was deprecated in API level 15. No longer useful, see PackageManager.addPackageToPreferred(String) for details.
    public static let setPreferredApplications: ManifestPermission = "android.permission.SET_PREFERRED_APPLICATIONS"
    /// Allows an application to set the maximum number of (not needed) application processes that can be running.
    public static let setProcessLimit: ManifestPermission = "android.permission.SET_PROCESS_LIMIT"
    /// Allows applications to set the system time directly.
    public static let setTime: ManifestPermission = "android.permission.SET_TIME"
    /// Allows applications to set the system time zone directly.
    public static let setTimeZone: ManifestPermission = "android.permission.SET_TIME_ZONE"
    /// Allows applications to set the wallpaper.
    public static let setWallpaper: ManifestPermission = "android.permission.SET_WALLPAPER"
    /// Allows applications to set the wallpaper hints.
    public static let setWallpaperHints: ManifestPermission = "android.permission.SET_WALLPAPER_HINTS"
    /// Allow an application to request that a signal be sent to all persistent processes.
    public static let signalPersistentProcesses: ManifestPermission = "android.permission.SIGNAL_PERSISTENT_PROCESSES"
    /// This constant was deprecated in API level 31. The API that used this permission is no longer functional.
    public static let smsFinancialTransactions: ManifestPermission = "android.permission.SMS_FINANCIAL_TRANSACTIONS"
    /// Allows an application to start foreground services from the background at any time.
    public static let startForegroundServicesFromBackground: ManifestPermission = "android.permission.START_FOREGROUND_SERVICES_FROM_BACKGROUND"
    /// Allows the holder to start the screen with a list of app features.
    public static let startViewAppFeatures: ManifestPermission = "android.permission.START_VIEW_APP_FEATURES"
    /// Allows the holder to start the permission usage screen for an app.
    public static let startViewPermissionUsage: ManifestPermission = "android.permission.START_VIEW_PERMISSION_USAGE"
    /// Allows an application to open, close, or disable the status bar and its icons.
    public static let statusBar: ManifestPermission = "android.permission.STATUS_BAR"
    /// Allows an application to subscribe to device locked and keyguard locked (i.e., showing) state.
    public static let subscribeToKeyguardLockedState: ManifestPermission = "android.permission.SUBSCRIBE_TO_KEYGUARD_LOCKED_STATE"
    /// Allows an app to create windows using the type WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY, shown on top of all other apps.
    public static let systemAlertWindow: ManifestPermission = "android.permission.SYSTEM_ALERT_WINDOW"
    /// Allows using the device's IR transmitter, if available.
    public static let transmitIr: ManifestPermission = "android.permission.TRANSMIT_IR"
    /// Allows an app to turn on the screen on, e.g. with PowerManager.ACQUIRE_CAUSES_WAKEUP.
    public static let turnScreenOn: ManifestPermission = "android.permission.TURN_SCREEN_ON"
    /// Allows an app to enter Picture-in-Picture mode when the user is not explicitly requesting it.
    public static let tvImplicitEnterPip: ManifestPermission = "android.permission.TV_IMPLICIT_ENTER_PIP"
    /// Don't use this permission in your app.
    public static let uninstallShortcut: ManifestPermission = "android.permission.UNINSTALL_SHORTCUT"
    /// Allows an application to update device statistics.
    public static let updateDeviceStats: ManifestPermission = "android.permission.UPDATE_DEVICE_STATS"
    /// Allows an application to indicate via PackageInstaller.SessionParams.setRequireUserAction(int) that user action should not be required for an app update.
    public static let updatePackagesWithoutUserAction: ManifestPermission = "android.permission.UPDATE_PACKAGES_WITHOUT_USER_ACTION"
    /// Allows an app to use device supported biometric modalities.
    public static let useBiometric: ManifestPermission = "android.permission.USE_BIOMETRIC"
    /// Allows apps to use exact alarms just like with SCHEDULE_EXACT_ALARM but without needing to request this permission from the user.
    public static let useExactAlarm: ManifestPermission = "android.permission.USE_EXACT_ALARM"
    /// This constant was deprecated in API level 28. Applications should request USE_BIOMETRIC instead
    public static let useFingerprint: ManifestPermission = "android.permission.USE_FINGERPRINT"
    /// Required for apps targeting Build.VERSION_CODES.Q that want to use notification full screen intents.
    public static let useFullScreenIntent: ManifestPermission = "android.permission.USE_FULL_SCREEN_INTENT"
    /// Allows to read device identifiers and use ICC based authentication like EAP-AKA.
    public static let useIccAuthWithDeviceIdentifier: ManifestPermission = "android.permission.USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER"
    /// Allows an application to use SIP service.
    public static let useSip: ManifestPermission = "android.permission.USE_SIP"
    /// Required to be able to range to devices using ultra-wideband.
    public static let uwbRanging: ManifestPermission = "android.permission.UWB_RANGING"
    /// Allows access to the vibrator.
    public static let vibrate: ManifestPermission = "android.permission.VIBRATE"
    /// Allows using PowerManager WakeLocks to keep processor from sleeping or screen from dimming.
    public static let wakeLock: ManifestPermission = "android.permission.WAKE_LOCK"
    /// Allows applications to write the apn settings and read sensitive fields of an existing apn settings like user and password.
    public static let writeApnSettings: ManifestPermission = .init("android.permission.WRITE_APN_SETTINGS", [.hardwareTelephony])
    /// Allows an application to write the user's calendar data.
    public static let writeCalendar: ManifestPermission = "android.permission.WRITE_CALENDAR"
    /// Allows an application to write and read the user's call log data.
    public static let writeCallLog: ManifestPermission = "android.permission.WRITE_CALL_LOG"
    /// Allows an application to write the user's contacts data.
    public static let writeContacts: ManifestPermission = "android.permission.WRITE_CONTACTS"
    /// Allows an application to write to external storage.
    public static let writeExternalStorage: ManifestPermission = "android.permission.WRITE_EXTERNAL_STORAGE"
    /// Allows an application to modify the Google service map.
    public static let writeGservices: ManifestPermission = "android.permission.WRITE_GSERVICES"
    /// Allows an application to read or write the secure system settings.
    public static let writeSecureSettings: ManifestPermission = "android.permission.WRITE_SECURE_SETTINGS"
    /// Allows an application to read or write the system settings.
    public static let writeSettings: ManifestPermission = "android.permission.WRITE_SETTINGS"
    /// Allows applications to write the sync settings.
    public static let writeSyncSettings: ManifestPermission = "android.permission.WRITE_SYNC_SETTINGS"
    /// Allows an application to access the Settings Preference services to write settings values exposed by the system Settings app and system apps that contribute settings surfaced in the Settings app.
    public static let writeSystemPreferences: ManifestPermission = "android.permission.WRITE_SYSTEM_PREFERENCES"
    /// Allows an application to modify and remove existing voicemails in the system.
    public static let writeVoicemail: ManifestPermission = "android.permission.WRITE_VOICEMAIL"
}