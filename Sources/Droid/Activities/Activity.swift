//
//  Activity.swift
//  
//
//  Created by Mihael Isaev on 25.06.2025.
//

public protocol Activity: AnyObject {
    static var className: String { get }

	var context: ActivityContext { get }
    
	init (object: JObject)

	func onCreate(_ context: ActivityContext)

    // static func create(object: JObject)

    // MARK: Manifest Properties

    /// Indicate that the activity can be launched as the embedded child of another activity.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#embedded)
    static var allowEmbedded: Bool? { get }

    /// Whether or not the activity can move from the task that started it
    /// to the task it has an affinity for when that task is next brought to the front — "true"
    /// if it can move, and "false" if it must remain with the task where it started.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#reparent)
    static var allowTaskReparenting: Bool? { get }

    /// Whether or not the state of the task that the activity is in will always
    /// be maintained by the system — "true" if it will be, and "false" if the system
    /// is allowed to reset the task to its initial state in certain situations.
    ///
    /// The default value is "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#always)
    static var alwaysRetainTaskState: Bool? { get }

    /// Whether or not tasks launched by activities with this attribute remains in
    /// the overview screen until the last activity in the task is completed. If true,
    /// the task is automatically removed from the overview screen. This overrides the caller's
    /// use of **FLAG_ACTIVITY_RETAIN_IN_RECENTS**. It must be a boolean value, either "true" or "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#autoremrecents)
    static var autoRemoveFromRecents: Bool? { get }

    /// A drawable resource providing an extended graphical banner for its associated item.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#banner)
    static var banner: String? { get }

    /// Whether or not all activities will be removed from the task,
    /// except for the root activity, whenever it is re-launched from
    /// the home screen — "true" if the task is always stripped down
    /// to its root activity, and "false" if not.
    ///
    /// The default value is "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#clear)
    static var clearTaskOnLaunch: Bool? { get }

    /// Requests the activity to be displayed in wide color gamut mode on compatible devices.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#colormode)
    static var colorMode: String? { get }

    /// Lists configuration changes that the activity will handle itself.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#config)
    static var configChanges: [ConfigChangeType] { get }

    /// Whether or not the activity is direct-boot aware; that is, whether or not it can run before the user unlocks the device.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#directBootAware)
    static var directBootAware: Bool? { get }

    /// Specifies how a new instance of an activity should be added to a task each time it is launched.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#dlmode)
	static var documentLaunchMode: DocumentLaunchMode? { get }
	
	/// Whether or not the activity can be instantiated
	/// by the system — "true" if it can be, and "false" if not.
	///
	/// The default value is "true".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#enabled)
	static var enabled: Bool? { get }
	
	/// Whether or not the task initiated by this activity should be excluded
	/// from the list of recently used applications, the overview screen.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#exclude)
	static var excludeFromRecents: Bool? { get }
	
	/// This element sets whether the activity can be launched by components of other applications:
	///
	/// If "true", the activity is accessible to any app, and is launchable by its exact class name.
	///
	/// If "false", the activity can be launched only by components of the same application,
	/// applications with the same user ID, or privileged system components.
	/// This is the default value when there are no intent filters.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#exported)
	static var exported: Bool? { get }
	
	/// Whether or not an existing instance of the activity should be shut down (finished),
	/// except for the root activity, whenever the user again launches
	/// its task (chooses the task on the home screen) — "true"
	/// if it should be shut down, and "false" if not.
	///
	/// The default value is "false".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#finish)
	static var finishOnTaskLaunch: Bool? { get }
	
	/// Whether or not hardware-accelerated rendering should be enabled
	/// for this Activity — "true" if it should be enabled, and "false" if not.
	///
	/// The default value is "false".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#hwaccel)
	static var hardwareAccelerated: Bool? { get }
	
	/// An icon representing the activity.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#icon)
	static var icon: String? { get } // TODO: drawable resource
	
	/// A default round icon for all application components.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#icon)
	static var roundIcon: String? { get } // TODO: drawable resource
	
	/// Sets the immersive mode setting for the current activity.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#immersive)
	static var immersive: Bool? { get }
	
	/// A user-readable label for the activity.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#label)
	static var label: String? { get } // TODO: string resource
	
	/// An instruction on how the activity should be launched.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#lmode)
	static var launchMode: LaunchMode? { get }
	
	/// Determines how the system presents this activity when the device is running in lock task mode.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#ltmode)
	static var lockTaskMode: LockTaskMode? { get }
	
	/// The maximum number of tasks rooted at this activity in the overview screen.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#maxrecents)
	static var maxRecents: Int? { get }
	
	/// The maximum aspect ratio the activity supports.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#maxaspectratio)
	static var maxAspectRatio: Double? { get }
	
	/// Whether an instance of the activity can be launched into the process
	/// of the component that started it — "true" if it can be, and "false" if not.
	///
	/// The default value is "false".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#multi)
	static var multiprocess: Bool? { get }
	
	/// Whether or not the activity should be removed from the activity stack
	/// and finished (its finish() method called) when the user navigates away from it
	/// and it's no longer visible on screen — "true" if it should be finished, and "false" if not.
	///
	/// The default value is "false".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#nohist)
	static var noHistory: Bool? { get }
	
	/// The class name of the logical parent of the activity.
	/// The name here must match the class name given to the corresponding `<activity>` element's `android:name` attribute.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#parent)
	static var parentActivityName: String? { get }
	
	/// Defines how an instance of an activity is preserved within a containing task across device restarts.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#persistableMode)
	static var persistableMode: PersistableMode? { get }
	
	/// The name of a permission that clients must have to launch
	/// the activity or otherwise get it to respond to an intent.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#prmsn)
	static var permission: String? { get }
	
	/// The name of the process in which the activity should run.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#proc)
	static var process: String? { get }
	
	/// Whether or not the activity relinquishes its task identifiers to an activity above it in the task stack.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#relinquish)
	static var relinquishTaskIdentity: Bool? { get }
	
	/// Specifies whether the app supports multi-window mode.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#resizeableActivity)
	static var resizeableActivity: Bool? { get }
	
	/// The orientation of the activity's display on the device.
	///
	/// The system ignores this attribute if the activity is running in multi-window mode.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#screen)
	static var screenOrientation: ScreenOrientation? { get }
	
	/// Whether or not the activity is shown when the device's current user is different
	/// than the user who launched the activity. You can set this attribute
	/// to a literal value—"true" or "false"—or you can set the attribute
	/// to a resource or theme attribute that contains a boolean value.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#showForAllUsers)
	static var showForAllUsers: Bool? { get }
	
	/// Whether or not the activity can be killed and successfully restarted
	/// without having saved its state — "true" if it can be restarted without reference
	/// to its previous state, and "false" if its previous state is required.
	///
	/// The default value is "false".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#state)
	static var stateNotNeeded: Bool? { get }
	
	/// Specifies whether the activity supports Picture-in-Picture display.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#supportsPIP)
	static var supportsPictureInPicture: Bool? { get }
	
	/// The task that the activity has an affinity for.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#aff)
	static var taskAffinity: String? { get }
	
	/// A reference to a style resource defining an overall theme for the activity.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#theme)
	static var theme: String? { get } // TODO: resource or theme
	
	/// Extra options for an activity's UI.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#uioptions)
	static var uiOptions: ApplicationUIOptions? { get }
	
	/// How the main window of the activity interacts with the window containing the on-screen soft keyboard.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#wsoft)
	static var windowSoftInputMode: [WindowSoftInputMode] { get }
	
	/// Specifies the types of intents that an activity, service, or broadcast receiver can respond to.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element)
	static var intentFilter: DroidApp.IntentFilter? { get }
	
	/// A name-value pair for an item of additional, arbitrary data that can be supplied to the parent component.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element)
	static var metaData: DroidApp.MetaData? { get }
}

extension Activity {
	public static var className: String { "\(Self.self)" }

	public static var allowEmbedded: Bool? { nil }
	public static var allowTaskReparenting: Bool? { nil }
	public static var alwaysRetainTaskState: Bool? { nil }
	public static var autoRemoveFromRecents: Bool? { nil }
	public static var banner: String? { nil }
	public static var clearTaskOnLaunch: Bool? { nil }
	public static var colorMode: String? { nil }
	public static var configChanges: [ConfigChangeType] { [] }
	public static var directBootAware: Bool? { nil }
	public static var documentLaunchMode: DocumentLaunchMode? { nil }
	public static var enabled: Bool? { nil }
	public static var excludeFromRecents: Bool? { nil }
	public static var exported: Bool? { nil }
	public static var finishOnTaskLaunch: Bool? { nil }
	public static var hardwareAccelerated: Bool? { nil }
	public static var icon: String? { nil }
	public static var roundIcon: String? { nil }
	public static var immersive: Bool? { nil }
	public static var label: String? { nil }
	public static var launchMode: LaunchMode? { nil }
	public static var lockTaskMode: LockTaskMode? { nil }
	public static var maxRecents: Int? { nil }
	public static var maxAspectRatio: Double? { nil }
	public static var multiprocess: Bool? { nil }
	public static var noHistory: Bool? { nil }
	public static var parentActivityName: String? { nil }
	public static var persistableMode: PersistableMode? { nil }
	public static var permission: String? { nil }
	public static var process: String? { nil }
	public static var relinquishTaskIdentity: Bool? { nil }
	public static var resizeableActivity: Bool? { nil }
	public static var screenOrientation: ScreenOrientation? { nil }
	public static var showForAllUsers: Bool? { nil }
	public static var stateNotNeeded: Bool? { nil }
	public static var supportsPictureInPicture: Bool? { nil }
	public static var taskAffinity: String? { nil }
	public static var theme: String? { nil }
	public static var uiOptions: ApplicationUIOptions? { nil }
	public static var windowSoftInputMode: [WindowSoftInputMode] { [] }
	public static var intentFilter: DroidApp.IntentFilter? { nil }
	public static var metaData: DroidApp.MetaData? { nil }
}