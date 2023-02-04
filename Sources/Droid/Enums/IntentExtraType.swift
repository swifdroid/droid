//
//  IntentExtraType.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

public struct IntentExtraType: ExpressibleByStringLiteral {
	let value: String
	
	public init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
	
	/// Used as an int extra field in AlarmManager pending intents to tell the application
	/// being invoked how many pending alarms are being delivered with the intent.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_ALARM_COUNT)
	public static var ALARM_COUNT: Self { "android.intent.extra.ALARM_COUNT" }
	
	/// Extra used to indicate that an intent can allow the user to select and return multiple items.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_ALLOW_MULTIPLE)
	public static var ALLOW_MULTIPLE: Self { "android.intent.extra.ALLOW_MULTIPLE" }
	
	/// Used as a boolean extra field with **ACTION_INSTALL_PACKAGE** to install a package.
	///
	/// Tells the installer UI to skip the confirmation with the user if the .apk is replacing an existing one.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_ALLOW_REPLACE)
	public static var ALLOW_REPLACE: Self { "android.intent.extra.ALLOW_REPLACE" }
	
	/// An `[Intent]` describing additional, alternate choices you would like shown with **ACTION_CHOOSER**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_ALTERNATE_INTENTS)
	public static var ALTERNATE_INTENTS: Self { "android.intent.extra.ALTERNATE_INTENTS" }
	
	/// An optional field on **ACTION_ASSIST** and containing additional contextual information
	/// supplied by the current foreground app at the time of the assist request.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_ASSIST_CONTEXT)
	public static var ASSIST_CONTEXT: Self { "android.intent.extra.ASSIST_CONTEXT" }
	
	/// An optional field on **ACTION_ASSIST** containing the InputDevice id that was used to invoke the assist.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_ASSIST_INPUT_DEVICE_ID)
	public static var ASSIST_INPUT_DEVICE_ID: Self { "android.intent.extra.ASSIST_INPUT_DEVICE_ID" }
	
	/// An optional field on **ACTION_ASSIST** suggesting that the user
	/// will likely use a keyboard as the primary input device for assistance.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_ASSIST_INPUT_HINT_KEYBOARD)
	public static var ASSIST_INPUT_HINT_KEYBOARD: Self { "android.intent.extra.ASSIST_INPUT_HINT_KEYBOARD" }
	
	/// An optional field on **ACTION_ASSIST** containing the name
	/// of the current foreground application package at the time the assist was invoked.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_ASSIST_PACKAGE)
	public static var ASSIST_PACKAGE: Self { "android.intent.extra.ASSIST_PACKAGE" }
	
	/// An optional field on **ACTION_ASSIST** containing the uid
	/// of the current foreground application package at the time the assist was invoked.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_ASSIST_UID)
	public static var ASSIST_UID: Self { "android.intent.extra.ASSIST_UID" }
	
	/// A `[String]` holding attribution tags when used with **ACTION_VIEW_PERMISSION_USAGE_FOR_PERIOD**
	/// and **ACTION_MANAGE_PERMISSION_USAGE** E.g. an attribution tag could be `location_provider`, `com.google.android.gms.*`, etc.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_ATTRIBUTION_TAGS)
	public static var ATTRIBUTION_TAGS: Self { "android.intent.extra.ATTRIBUTION_TAGS" }
	
	/// Used as a boolean extra field in **ACTION_CHOOSER** intents to specify
	/// whether to show the chooser or not when there is only one application available to choose from.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_AUTO_LAUNCH_SINGLE_CHOICE)
	public static var AUTO_LAUNCH_SINGLE_CHOICE: Self { "android.intent.extra.AUTO_LAUNCH_SINGLE_CHOICE" }
	
	/// A `[String]` holding e-mail addresses that should be blind carbon copied.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_BCC)
	public static var BCC: Self { "android.intent.extra.BCC" }
	
	/// Used as a parcelable extra field in **ACTION_APP_ERROR**, containing the bug report.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_BUG_REPORT)
	public static var BUG_REPORT: Self { "android.intent.extra.BUG_REPORT" }
	
	/// A `[String]` holding e-mail addresses that should be carbon copied.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_CC)
	public static var CC: Self { "android.intent.extra.CC" }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_CHANGED_COMPONENT_NAME)
	public static var CHANGED_COMPONENT_NAME: Self { "android.intent.extra.CHANGED_COMPONENT_NAME" }
	
	/// This field is part of **ACTION_PACKAGE_CHANGED**, and contains a string array
	/// of all of the components that have changed. If the state of the overall package has changed,
	/// then it will contain an entry with the package name itself.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_CHANGED_COMPONENT_NAME_LIST)
	public static var CHANGED_COMPONENT_NAME_LIST: Self { "android.intent.extra.CHANGED_COMPONENT_NAME_LIST" }
	
	/// This field is part of **ACTION_EXTERNAL_APPLICATIONS_AVAILABLE**,
	/// **ACTION_EXTERNAL_APPLICATIONS_UNAVAILABLE**, **ACTION_PACKAGES_SUSPENDED**,
	/// **ACTION_PACKAGES_UNSUSPENDED** and contains a string array of all of the components that have changed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_CHANGED_PACKAGE_LIST)
	public static var CHANGED_PACKAGE_LIST: Self { "android.intent.extra.CHANGED_PACKAGE_LIST" }
	
	/// This field is part of **ACTION_EXTERNAL_APPLICATIONS_AVAILABLE**,
	/// **ACTION_EXTERNAL_APPLICATIONS_UNAVAILABLE** and contains an integer array
	/// of uids of all of the components that have changed.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_CHANGED_UID_LIST)
	public static var CHANGED_UID_LIST: Self { "android.intent.extra.CHANGED_UID_LIST" }
	
	/// An IntentSender for an Activity that will be invoked when the user makes a selection from the chooser activity presented by **ACTION_CHOOSER**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_CHOOSER_REFINEMENT_INTENT_SENDER)
	public static var CHOOSER_REFINEMENT_INTENT_SENDER: Self { "android.intent.extra.CHOOSER_REFINEMENT_INTENT_SENDER" }
	
	/// A ChooserTarget[] for **ACTION_CHOOSER** describing additional high-priority deep-link targets for the chooser to present to the user.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_CHOOSER_TARGETS)
	public static var CHOOSER_TARGETS: Self { "android.intent.extra.CHOOSER_TARGETS" }
	
	/// The ComponentName chosen by the user to complete an action.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_CHOSEN_COMPONENT)
	public static var CHOSEN_COMPONENT: Self { "android.intent.extra.CHOSEN_COMPONENT" }
	
	/// An IntentSender that will be notified if a user successfully chooses a target component to handle
	/// an action in an **ACTION_CHOOSER** activity. The IntentSender will have the extra **EXTRA_CHOSEN_COMPONENT**
	/// appended to it containing the ComponentName of the chosen component.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_CHOSEN_COMPONENT_INTENT_SENDER)
	public static var CHOSEN_COMPONENT_INTENT_SENDER: Self { "android.intent.extra.CHOSEN_COMPONENT_INTENT_SENDER" }
	
	/// Intent extra: A ComponentName value.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_COMPONENT_NAME)
	public static var COMPONENT_NAME: Self { "android.intent.extra.COMPONENT_NAME" }
	
	/// An ArrayList of String annotations describing content for **ACTION_CHOOSER**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_CONTENT_ANNOTATIONS)
	public static var CONTENT_ANNOTATIONS: Self { "android.intent.extra.CONTENT_ANNOTATIONS" }
	
	/// Optional CharSequence extra to provide a search query.
	///
	/// The format of this query is dependent on the receiving application.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_CONTENT_QUERY)
	public static var CONTENT_QUERY: Self { "android.intent.extra.CONTENT_QUERY" }
	
	/// Used as a boolean extra field in **ACTION_PACKAGE_REMOVED** intents to indicate whether
	/// this represents a full uninstall (removing both the code and its data)
	/// or a partial uninstall (leaving its data, implying that this is an update).
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_DATA_REMOVED)
	public static var DATA_REMOVED: Self { "android.intent.extra.DATA_REMOVED" }
	
	/// Used as an int extra field in **ACTION_DOCK_EVENT** intents to request the dock state.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_DOCK_STATE)
	public static var DOCK_STATE: Self { "android.intent.extra.DOCK_STATE" }
	
	/// Used as an int value for **EXTRA_DOCK_STATE** to represent that the phone is in a car dock.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_DOCK_STATE_CAR)
	public static var DOCK_STATE_CAR: Self { "android.intent.extra.DOCK_STATE_CAR" }
	
	/// Used as an int value for **EXTRA_DOCK_STATE** to represent that the phone is in a desk dock.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_DOCK_STATE_DESK)
	public static var DOCK_STATE_DESK: Self { "android.intent.extra.DOCK_STATE_DESK" }
	
	/// Used as an int value for **EXTRA_DOCK_STATE** to represent that the phone is in a digital (high end) dock.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_DOCK_STATE_HE_DESK)
	public static var DOCK_STATE_HE_DESK: Self { "android.intent.extra.DOCK_STATE_HE_DESK" }
	
	/// Used as an int value for **EXTRA_DOCK_STATE** to represent that the phone is in a analog (low end) dock.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_DOCK_STATE_LE_DESK)
	public static var DOCK_STATE_LE_DESK: Self { "android.intent.extra.DOCK_STATE_LE_DESK" }
	
	/// Used as an int value for **EXTRA_DOCK_STATE** to represent that the phone is not in any dock.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_DOCK_STATE_UNDOCKED)
	public static var DOCK_STATE_UNDOCKED: Self { "android.intent.extra.DOCK_STATE_UNDOCKED" }
	
	/// Used as a boolean extra field in **ACTION_PACKAGE_REMOVED** or **ACTION_PACKAGE_CHANGED**
	/// intents to override the default action of restarting the application.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_DONT_KILL_APP)
	public static var DONT_KILL_APP: Self { "android.intent.extra.DONT_KILL_APP" }
	
	/// Intent extra: The number of milliseconds.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_DURATION_MILLIS)
	public static var DURATION_MILLIS: Self { "android.intent.extra.DURATION_MILLIS" }
	
	/// A String[] holding e-mail addresses that should be delivered to.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_EMAIL)
	public static var EMAIL: Self { "android.intent.extra.EMAIL" }
	
	/// A long representing the end timestamp (epoch time in millis) of the permission usage
	/// when used with **ACTION_VIEW_PERMISSION_USAGE_FOR_PERIOD** and **ACTION_MANAGE_PERMISSION_USAGE**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_END_TIME)
	public static var END_TIME: Self { "android.intent.extra.END_TIME" }
	
	/// A `ComponentName[]` describing components that should be filtered out and omitted
	/// from a list of components presented to the user.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_EXCLUDE_COMPONENTS)
	public static var EXCLUDE_COMPONENTS: Self { "android.intent.extra.EXCLUDE_COMPONENTS" }
	
	/// Extra that can be included on activity intents coming from the storage UI
	/// when it launches sub-activities to manage various types of storage.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_FROM_STORAGE)
	public static var FROM_STORAGE: Self { "android.intent.extra.FROM_STORAGE" }
	
	/// A constant String that is associated with the Intent, used with **ACTION_SEND** to supply
	/// an alternative to **EXTRA_TEXT** as HTML formatted text.
	///
	/// Note that you must also supply **EXTRA_TEXT**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_HTML_TEXT)
	public static var HTML_TEXT: Self { "android.intent.extra.HTML_TEXT" }
	
	/// Optional index with semantics depending on the intent action.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_INDEX)
	public static var INDEX: Self { "android.intent.extra.INDEX" }
	
	/// A `Parcelable[]` of Intent or LabeledIntent objects as set with `putExtra(java.lang.String`, `android.os.Parcelable[]`)
	/// to place at the front of the list of choices, when shown to the user with an **ACTION_CHOOSER**.
	///
	/// You can choose up to two additional activities to show before the app suggestions (the limit of two additional activities starts in Android 10).
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_INITIAL_INTENTS)
	public static var INITIAL_INTENTS: Self { "android.intent.extra.INITIAL_INTENTS" }
	
	/// Used as a string extra field with **ACTION_INSTALL_PACKAGE** to install a package.
	///
	/// Specifies the installer package name; this package will receive the **ACTION_APP_ERROR** intent.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_INSTALLER_PACKAGE_NAME)
	public static var INSTALLER_PACKAGE_NAME: Self { "android.intent.extra.INSTALLER_PACKAGE_NAME" }
	
	/// An Intent describing the choices you would like shown with **ACTION_PICK_ACTIVITY** or **ACTION_CHOOSER**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_INTENT)
	public static var INTENT: Self { "android.intent.extra.INTENT" }
	
	/// A KeyEvent object containing the event that triggered the creation of the Intent it is in.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_KEY_EVENT)
	public static var KEY_EVENT: Self { "android.intent.extra.KEY_EVENT" }
	
	/// Intent extra: A LocaleList
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_LOCALE_LIST)
	public static var LOCALE_LIST: Self { "android.intent.extra.LOCALE_LIST" }
	
	/// Extra used to indicate that an intent should only return data that is on the local device.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_LOCAL_ONLY)
	public static var LOCAL_ONLY: Self { "android.intent.extra.LOCAL_ONLY" }
	
	/// Intent extra: ID of the context used on **ACTION_VIEW_LOCUS**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_LOCUS_ID)
	public static var LOCUS_ID: Self { "android.intent.extra.LOCUS_ID" }
	
	/// Extra used to communicate a set of acceptable MIME types.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_MIME_TYPES)
	public static var MIME_TYPES: Self { "android.intent.extra.MIME_TYPES" }
	
	/// Used as an optional int extra field in **ACTION_PACKAGE_REMOVED** intents to supply
	/// the new uid the package will be assigned. This would only be set when a package is leaving
	/// sharedUserId in an upgrade, or when a system app upgrade that had left sharedUserId is getting uninstalled.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_NEW_UID)
	public static var NEW_UID: Self { "android.intent.extra.NEW_UID" }
	
	/// Used as a boolean extra field with **ACTION_INSTALL_PACKAGE** to install a package.
	///
	/// Specifies that the application being installed should not be treated as coming from an unknown source,
	/// but as coming from the app invoking the Intent. For this to work you must start the installer with startActivityForResult().
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_NOT_UNKNOWN_SOURCE)
	public static var NOT_UNKNOWN_SOURCE: Self { "android.intent.extra.NOT_UNKNOWN_SOURCE" }
	
	/// Used as a URI extra field with **ACTION_INSTALL_PACKAGE** and **ACTION_VIEW** to indicate the URI
	/// from which the local APK in the Intent data field originated from.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_ORIGINATING_URI)
	public static var ORIGINATING_URI: Self { "android.intent.extra.ORIGINATING_URI" }
	
	/// Intent extra: An app package name.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_PACKAGE_NAME)
	public static var PACKAGE_NAME: Self { "android.intent.extra.PACKAGE_NAME" }
	
	/// Intent extra: The name of a permission group.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_PERMISSION_GROUP_NAME)
	public static var PERMISSION_GROUP_NAME: Self { "android.intent.extra.PERMISSION_GROUP_NAME" }
	
	/// A String holding the phone number originally entered in **ACTION_NEW_OUTGOING_CALL**, or the actual number to call in a **ACTION_CALL**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_PHONE_NUMBER)
	public static var PHONE_NUMBER: Self { "android.intent.extra.PHONE_NUMBER" }
	
	/// Used as an optional int extra field in **ACTION_PACKAGE_ADDED** intents
	/// to supply the previous uid the package had been assigned.
	///
	/// This would only be set when a package is leaving sharedUserId in an upgrade,
	/// or when a system app upgrade that had left sharedUserId is getting uninstalled.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_PREVIOUS_UID)
	public static var PREVIOUS_UID: Self { "android.intent.extra.PREVIOUS_UID" }
	
	/// The name of the extra used to define the text to be processed, as a CharSequence.
	///
	/// Note that this may be a styled CharSequence, so you must use Bundle.getCharSequence() to retrieve it.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_PROCESS_TEXT)
	public static var PROCESS_TEXT: Self { "android.intent.extra.PROCESS_TEXT" }
	
	/// The name of the boolean extra used to define if the processed text will be used as read-only.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_PROCESS_TEXT_READONLY)
	public static var PROCESS_TEXT_READONLY: Self { "android.intent.extra.PROCESS_TEXT_READONLY" }
	
	/// An optional extra of String[] indicating which quick view features should be made available
	/// to the user in the quick view UI while handing a **ACTION_QUICK_VIEW** intent.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_QUICK_VIEW_FEATURES)
	public static var QUICK_VIEW_FEATURES: Self { "android.intent.extra.QUICK_VIEW_FEATURES" }
	
	/// Optional boolean extra indicating whether quiet mode has been switched on or off.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_QUIET_MODE)
	public static var QUIET_MODE: Self { "android.intent.extra.QUIET_MODE" }
	
	/// This extra can be used with any Intent used to launch an activity, supplying information about who is launching that activity.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_REFERRER)
	public static var REFERRER: Self { "android.intent.extra.REFERRER" }
	
	/// Alternate version of **EXTRA_REFERRER** that supplies the URI as a String rather than a Uri object.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_REFERRER_NAME)
	public static var REFERRER_NAME: Self { "android.intent.extra.REFERRER_NAME" }
	
	/// Used in the extra field in the remote intent. It's a string token passed with the remote intent.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_REMOTE_INTENT_TOKEN)
	public static var REMOTE_INTENT_TOKEN: Self { "android.intent.extra.REMOTE_INTENT_TOKEN" }
	
	/// A Bundle forming a mapping of potential target package names to different extras Bundles
	/// to add to the default intent extras in EXTRA_INTENT when used with **ACTION_CHOOSER**.
	/// Each key should be a package name. The package need not be currently installed on the device.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_REPLACEMENT_EXTRAS)
	public static var REPLACEMENT_EXTRAS: Self { "android.intent.extra.REPLACEMENT_EXTRAS" }
	
	/// Used as a boolean extra field in **ACTION_PACKAGE_REMOVED** intents to indicate that
	/// this is a replacement of the package, so this broadcast will immediately be followed
	/// by an add broadcast for a different version of the same package.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_REPLACING)
	public static var REPLACING: Self { "android.intent.extra.REPLACING" }
	
	/// Extra sent in the intent to the BroadcastReceiver that handles **ACTION_GET_RESTRICTION_ENTRIES**.
	///
	/// The type of the extra is a Bundle containing the restrictions as key/value pairs.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_RESTRICTIONS_BUNDLE)
	public static var RESTRICTIONS_BUNDLE: Self { "android.intent.extra.RESTRICTIONS_BUNDLE" }
	
	/// Extra used in the response from a BroadcastReceiver that handles **ACTION_GET_RESTRICTION_ENTRIES**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_RESTRICTIONS_INTENT)
	public static var RESTRICTIONS_INTENT: Self { "android.intent.extra.RESTRICTIONS_INTENT" }
	
	/// Extra used in the response from a BroadcastReceiver that handles **ACTION_GET_RESTRICTION_ENTRIES**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_RESTRICTIONS_LIST)
	public static var RESTRICTIONS_LIST: Self { "android.intent.extra.RESTRICTIONS_LIST" }
	
	/// A ResultReceiver used to return data back to the sender.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_RESULT_RECEIVER)
	public static var RESULT_RECEIVER: Self { "android.intent.extra.RESULT_RECEIVER" }
	
	/// Used as a boolean extra field with **ACTION_INSTALL_PACKAGE** or **ACTION_UNINSTALL_PACKAGE**.
	///
	/// Specifies that the installer UI should return to the application the result code of the install/uninstall.
	/// The returned result code will be `Activity.RESULT_OK` on success or `Activity.RESULT_FIRST_USER` on failure.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_RETURN_RESULT)
	public static var RETURN_RESULT: Self { "android.intent.extra.RETURN_RESULT" }
	
	/// The name of the extra used to define the icon, as a Bitmap, of a shortcut.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_SHORTCUT_ICON)
	public static var SHORTCUT_ICON: Self { "android.intent.extra.SHORTCUT_ICON" }
	
	/// The name of the extra used to define the icon, as a ShortcutIconResource, of a shortcut.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_SHORTCUT_ICON_RESOURCE)
	public static var SHORTCUT_ICON_RESOURCE: Self { "android.intent.extra.SHORTCUT_ICON_RESOURCE" }
	
	/// Intent extra: ID of the shortcut used to send the share intent. Will be sent with **ACTION_SEND**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_SHORTCUT_ID)
	public static var SHORTCUT_ID: Self { "android.intent.extra.SHORTCUT_ID" }
	
	/// The name of the extra used to define the Intent of a shortcut.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_SHORTCUT_INTENT)
	public static var SHORTCUT_INTENT: Self { "android.intent.extra.SHORTCUT_INTENT" }
	
	/// The name of the extra used to define the name of a shortcut.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_SHORTCUT_NAME)
	public static var SHORTCUT_NAME: Self { "android.intent.extra.SHORTCUT_NAME" }
	
	/// Optional extra for **ACTION_SHUTDOWN** that allows the sender to qualify that this shutdown is only
	/// for the user space of the system, not a complete shutdown.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_SHUTDOWN_USERSPACE_ONLY)
	public static var SHUTDOWN_USERSPACE_ONLY: Self { "android.intent.extra.SHUTDOWN_USERSPACE_ONLY" }
	
	/// Intent extra: An app split name.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_SPLIT_NAME)
	public static var SPLIT_NAME: Self { "android.intent.extra.SPLIT_NAME" }
	
	/// A long representing the start timestamp (epoch time in millis) of the permission usage when used
	/// with **ACTION_VIEW_PERMISSION_USAGE_FOR_PERIOD** and **ACTION_MANAGE_PERMISSION_USAGE**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_START_TIME)
	public static var START_TIME: Self { "android.intent.extra.START_TIME" }
	
	/// A content: URI holding a stream of data associated with the Intent,
	/// used with **ACTION_SEND** to supply the data being sent.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_STREAM)
	public static var STREAM: Self { "android.intent.extra.STREAM" }
	
	/// A constant string holding the desired subject line of a message.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_SUBJECT)
	public static var SUBJECT: Self { "android.intent.extra.SUBJECT" }
	
	/// Intent extra: A Bundle of extras for a package being suspended.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_SUSPENDED_PACKAGE_EXTRAS)
	public static var SUSPENDED_PACKAGE_EXTRAS: Self { "android.intent.extra.SUSPENDED_PACKAGE_EXTRAS" }
	
	/// The initial data to place in a newly created record.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_TEMPLATE)
	public static var TEMPLATE: Self { "android.intent.extra.TEMPLATE" }
	
	/// A constant CharSequence that is associated with the Intent.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_TEXT)
	public static var TEXT: Self { "android.intent.extra.TEXT" }
	
	/// Optional extra specifying a time in milliseconds since the Epoch. The value must be non-negative.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_TIME)
	public static var TIME: Self { "android.intent.extra.TIME" }
	
	/// Extra sent with **ACTION_TIMEZONE_CHANGED** specifying the new time zone of the device.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_TIMEZONE)
	public static var TIMEZONE: Self { "android.intent.extra.TIMEZONE" }
	
	/// A CharSequence dialog title to provide to the user when used with a **ACTION_CHOOSER**.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_TITLE)
	public static var TITLE: Self { "android.intent.extra.TITLE" }
	
	/// Used as an int extra field in **ACTION_UID_REMOVED** intents to supply the uid the package had been assigned.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_UID)
	public static var UID: Self { "android.intent.extra.UID" }
	
	/// Used as a boolean extra field in **ACTION_PACKAGE_REMOVED**, **ACTION_UID_REMOVED**,
	/// and **ACTION_PACKAGE_ADDED** intents to indicate that this package is changing its UID.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_UID_CHANGING)
	public static var UID_CHANGING: Self { "android.intent.extra.UID_CHANGING" }
	
	/// The UserHandle carried with intents.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_USER)
	public static var USER: Self { "android.intent.extra.USER" }
	
	/// Used as a boolean extra field in **ACTION_PACKAGE_REMOVED** intents to signal
	/// that the application was removed with the user-initiated action.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#EXTRA_USER_INITIATED)
	public static var USER_INITIATED: Self { "android.intent.extra.USER_INITIATED" }
}
