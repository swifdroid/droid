//
//  IntentCategoryType.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

public struct IntentCategoryType: ExpressibleByStringLiteral, StringValuable, Sendable, CustomStringConvertible {
    public let value: String
    
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }

    public var description: String { value }
	
	/// The accessibility shortcut is a global gesture for users with disabilities to trigger an important
	/// for them accessibility feature to help developers determine whether they want to make their activity a shortcut target.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_ACCESSIBILITY_SHORTCUT_TARGET)
	public static var ACCESSIBILITY_SHORTCUT_TARGET: Self { "android.intent.category.ACCESSIBILITY_SHORTCUT_TARGET" }
	
	/// Set if the activity should be considered as an alternative action to the data the user is currently viewing.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_ALTERNATIVE)
	public static var ALTERNATIVE: Self { "android.intent.category.ALTERNATIVE" }
	
	/// Used with **ACTION_MAIN** to launch the browser application.
	/// The activity should be able to browse the Internet.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_BROWSER)
	public static var APP_BROWSER: Self { "android.intent.category.APP_BROWSER" }
	
	/// Used with **ACTION_MAIN** to launch the calculator application.
	/// The activity should be able to perform standard arithmetic operations.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_CALCULATOR)
	public static var APP_CALCULATOR: Self { "android.intent.category.APP_CALCULATOR" }
	
	/// Used with **ACTION_MAIN** to launch the calendar application.
	/// The activity should be able to view and manipulate calendar entries.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_CALENDAR)
	public static var APP_CALENDAR: Self { "android.intent.category.APP_CALENDAR" }
	
	/// Used with **ACTION_MAIN** to launch the contacts application.
	/// The activity should be able to view and manipulate address book entries.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_CONTACTS)
	public static var APP_CONTACTS: Self { "android.intent.category.APP_CONTACTS" }
	
	/// Used with **ACTION_MAIN** to launch the email application.
	/// The activity should be able to send and receive email.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_EMAIL)
	public static var APP_EMAIL: Self { "android.intent.category.APP_EMAIL" }
	
	/// Used with **ACTION_MAIN** to launch the files application.
	/// The activity should be able to browse and manage files stored on the device.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_FILES)
	public static var APP_FILES: Self { "android.intent.category.APP_FILES" }
	
	/// Used with **ACTION_MAIN** to launch the fitness application.
	/// The activity should be able to give the user fitness information and manage workouts
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_FITNESS)
	public static var APP_FITNESS: Self { "android.intent.category.APP_FITNESS" }
	
	/// Used with **ACTION_MAIN** to launch the gallery application.
	/// The activity should be able to view and manipulate image and video files stored on the device.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_GALLERY)
	public static var APP_GALLERY: Self { "android.intent.category.APP_GALLERY" }
	
	/// Used with **ACTION_MAIN** to launch the maps application.
	/// The activity should be able to show the user's current location and surroundings.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_MAPS)
	public static var APP_MAPS: Self { "android.intent.category.APP_MAPS" }
	
	/// This activity allows the user to browse and download new applications.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_MARKET)
	public static var APP_MARKET: Self { "android.intent.category.APP_MARKET" }
	
	/// Used with **ACTION_MAIN** to launch the messaging application.
	/// The activity should be able to send and receive text messages.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_MESSAGING)
	public static var APP_MESSAGING: Self { "android.intent.category.APP_MESSAGING" }
	
	/// Used with **ACTION_MAIN** to launch the music application.
	/// The activity should be able to play, browse, or manipulate music files stored on the device.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_MUSIC)
	public static var APP_MUSIC: Self { "android.intent.category.APP_MUSIC" }
	
	/// Used with **ACTION_MAIN** to launch the weather application.
	/// The activity should be able to give the user information about the weather
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_APP_WEATHER)
	public static var APP_WEATHER: Self { "android.intent.category.APP_WEATHER" }
	
	/// Activities that can be safely invoked from a browser must support this category.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_BROWSABLE)
	public static var BROWSABLE: Self { "android.intent.category.BROWSABLE" }
	
	/// An activity to run when device is inserted into a car dock.
	///
	/// Used with **ACTION_MAIN** to launch an activity. For more information, see UiModeManager.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_CAR_DOCK)
	public static var CAR_DOCK: Self { "android.intent.category.CAR_DOCK" }
	
	/// Used to indicate that the activity can be used in a car environment.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_CAR_MODE)
	public static var CAR_MODE: Self { "android.intent.category.CAR_MODE" }
	
	/// Set if the activity should be an option for the default action (center press) to perform on a piece of data.
	///
	/// Setting this will hide from the user any activities without it set when performing an action on some data.
	///
	/// Note that this is normally -not- set in the Intent when initiating an action -- it is for use in intent filters specified in packages.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_DEFAULT)
	public static var DEFAULT: Self { "android.intent.category.DEFAULT" }
	
	/// An activity to run when device is inserted into a desk dock.
	///
	/// Used with **ACTION_MAIN** to launch an activity. For more information, see UiModeManager.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_DESK_DOCK)
	public static var DESK_DOCK: Self { "android.intent.category.DESK_DOCK" }
	
	/// This activity is a development preference panel.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_DEVELOPMENT_PREFERENCE)
	public static var DEVELOPMENT_PREFERENCE: Self { "android.intent.category.DEVELOPMENT_PREFERENCE" }
	
	/// Capable of running inside a parent activity container.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_EMBED)
	public static var EMBED: Self { "android.intent.category.EMBED" }
	
	/// To be used as code under test for framework instrumentation tests.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_FRAMEWORK_INSTRUMENTATION_TEST)
	public static var FRAMEWORK_INSTRUMENTATION_TEST: Self { "android.intent.category.FRAMEWORK_INSTRUMENTATION_TEST" }
	
	/// An activity to run when device is inserted into a digital (high end) dock.
	///
	/// Used with **ACTION_MAIN** to launch an activity. For more information, see UiModeManager.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_HE_DESK_DOCK)
	public static var HE_DESK_DOCK: Self { "android.intent.category.HE_DESK_DOCK" }
	
	/// This is the home activity, that is the first activity that is displayed when the device boots.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_HOME)
	public static var HOME: Self { "android.intent.category.HOME" }
	
	/// Provides information about the package it is in; typically used if a package
	/// does not contain a **CATEGORY_LAUNCHER** to provide a front-door to the user
	/// without having to be shown in the all apps list.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_INFO)
	public static var INFO: Self { "android.intent.category.INFO" }
	
	/// Should be displayed in the top-level launcher.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_LAUNCHER)
	public static var LAUNCHER: Self { "android.intent.category.LAUNCHER" }
	
	/// Indicates an activity optimized for Leanback mode, and that should be displayed in the Leanback launcher.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_LEANBACK_LAUNCHER)
	public static var LEANBACK_LAUNCHER: Self { "android.intent.category.LEANBACK_LAUNCHER" }
	
	/// An activity to run when device is inserted into a analog (low end) dock.
	///
	/// Used with **ACTION_MAIN** to launch an activity. For more information, see UiModeManager.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_LE_DESK_DOCK)
	public static var LE_DESK_DOCK: Self { "android.intent.category.LE_DESK_DOCK" }
	
	/// This activity may be exercised by the monkey or other automated test tools.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_MONKEY)
	public static var MONKEY: Self { "android.intent.category.MONKEY" }
	
	/// Used to indicate that an intent only wants URIs that can be opened with `ContentResolver#openFileDescriptor(Uri, String)`.
	///
	/// Openable URIs must support at least the columns defined in OpenableColumns when queried.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_OPENABLE)
	public static var OPENABLE: Self { "android.intent.category.OPENABLE" }
	
	/// This activity is a preference panel.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_PREFERENCE)
	public static var PREFERENCE: Self { "android.intent.category.PREFERENCE" }
	
	/// To be used as a sample code example (not part of the normal user experience).
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_SAMPLE_CODE)
	public static var SAMPLE_CODE: Self { "android.intent.category.SAMPLE_CODE" }
	
	/// The home activity shown on secondary displays that support showing home activities.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_SECONDARY_HOME)
	public static var SECONDARY_HOME: Self { "android.intent.category.SECONDARY_HOME" }
	
	/// Set if the activity should be considered as an alternative selection action to the data the user has currently selected.
	/// This is like **CATEGORY_ALTERNATIVE**, but is used in activities showing a list of items from which the user can select,
	/// giving them alternatives to the default action that will be performed on it.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_SELECTED_ALTERNATIVE)
	public static var SELECTED_ALTERNATIVE: Self { "android.intent.category.SELECTED_ALTERNATIVE" }
	
	/// Intended to be used as a tab inside of a containing TabActivity.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_TAB)
	public static var TAB: Self { "android.intent.category.TAB" }
	
	/// To be used as a test (not part of the normal user experience).
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_TEST)
	public static var TEST: Self { "android.intent.category.TEST" }
	
	/// Used to indicate that an intent filter can accept files which are not necessarily openable
	/// by `ContentResolver#openFileDescriptor(Uri, String)`, but at least streamable
	/// via `ContentResolver#openTypedAssetFileDescriptor(Uri, String, Bundle)` using one of the stream types exposed
	/// via `ContentResolver#getStreamTypes(Uri, String)`.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_TYPED_OPENABLE)
	public static var TYPED_OPENABLE: Self { "android.intent.category.TYPED_OPENABLE" }
	
	/// To be used as a unit test (run through the Test Harness).
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_UNIT_TEST)
	public static var UNIT_TEST: Self { "android.intent.category.UNIT_TEST" }
	
	/// Categories for activities that can participate in voice interaction.
	///
	/// An activity that supports this category must be prepared to run with no UI shown at all
	/// (though in some case it may have a UI shown), and rely on VoiceInteractor to interact with the user.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_VOICE)
	public static var VOICE: Self { "android.intent.category.VOICE" }
	
	/// An activity to use for the launcher when the device is placed in a VR Headset viewer.
	///
	/// Used with **ACTION_MAIN** to launch an activity. For more information, see UiModeManager.
	///
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#CATEGORY_VR_HOME)
	public static var VR_HOME: Self { "android.intent.category.VR_HOME" }
}
