//
//  DroidApp+Activity.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	final class _ActivityTag: ManifestTag {
        override class var name: String { "activity" }

		override init () {}
	}

	/// Declares an activity (an Activity subclass) that implements part of the application's visual user interface.
	///
	/// All activities must be represented by `<activity>` elements in the manifest file.
	///
	/// Any that are not declared there will not be seen by the system and will never be run.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element)
	public final class ActivityTag: ManifestTag {
        override class var name: String { "activity" }
		
        var `class`: AnyActivity.Type
        
        override func uniqueParams() -> [ManifestTagParamName] {
            [.androidName]
        }
		
        /// The class that implements the activity, a subclass of AnyActivity.
        ///
        /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#nm)
        public required init(_ activity: AnyActivity.Type) {
            `class` = activity
            super.init()
            params[.androidName] = ".\(activity)"
        }
		
		// MARK: -
		
		/// Indicate that the activity can be launched as the embedded child of another activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#embedded)
		public func allowEmbedded(_ value: Bool = true) -> Self {
			params[.androidAllowEmbedded] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Whether or not the activity can move from the task that started it
		/// to the task it has an affinity for when that task is next brought to the front — "true"
		/// if it can move, and "false" if it must remain with the task where it started.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#reparent)
		public func allowTaskReparenting(_ value: Bool = true) -> Self {
			params[.androidAllowTaskReparenting] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Whether or not the state of the task that the activity is in will always
		/// be maintained by the system — "true" if it will be, and "false" if the system
		/// is allowed to reset the task to its initial state in certain situations.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#always)
		public func alwaysRetainTaskState(_ value: Bool = true) -> Self {
			params[.androidAlwaysRetainTaskState] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Whether or not tasks launched by activities with this attribute remains in
		/// the overview screen until the last activity in the task is completed. If true,
		/// the task is automatically removed from the overview screen. This overrides the caller's
		/// use of **FLAG_ACTIVITY_RETAIN_IN_RECENTS**. It must be a boolean value, either "true" or "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#autoremrecents)
		public func autoRemoveFromRecents(_ value: Bool = true) -> Self {
			params[.androidAutoRemoveFromRecents] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// A drawable resource providing an extended graphical banner for its associated item.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#banner)
		public func banner(_ value: String) -> Self { // TODO: drawable resource
			params[.androidBanner] = value
			return self
		}
		
		// MARK: -
		
		/// Whether or not all activities will be removed from the task,
		/// except for the root activity, whenever it is re-launched from
		/// the home screen — "true" if the task is always stripped down
		/// to its root activity, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#clear)
		public func clearTaskOnLaunch(_ value: Bool = true) -> Self {
			params[.androidClearTaskOnLaunch] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Requests the activity to be displayed in wide color gamut mode on compatible devices.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#colormode)
		public func colorMode(_ value: ActivityColorMode) -> Self {
			params[.androidColorMode] = ManifestTagParamValue(value.rawValue).value
			return self
		}
		
		// MARK: -
		
		/// Lists configuration changes that the activity will handle itself. For the rest activity will be simply restarted.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#config)
		public func configChanges(_ value: [ConfigChangeType]) -> Self {
            params[.androidConfigChanges] = ManifestTagParamValue(values: value).value
			return self
		}
		
		/// Lists configuration changes that the activity will handle itself. For the rest activity will be simply restarted.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#config)
		public func configChanges(_ value: ConfigChangeType...) -> Self {
			configChanges(value)
		}
		
		// MARK: -
		
		/// Whether or not the activity is direct-boot aware; that is, whether or not it can run before the user unlocks the device.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#directBootAware)
		public func directBootAware(_ value: Bool = true) -> Self {
			params[.androidDirectBootAware] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Specifies how a new instance of an activity should be added to a task each time it is launched.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#dlmode)
		public func documentLaunchMode(_ value: DocumentLaunchMode) -> Self {
			params[.androidDocumentLaunchMode] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Whether or not the activity can be instantiated
		/// by the system — "true" if it can be, and "false" if not.
		///
		/// The default value is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#enabled)
		public func enabled(_ value: Bool = true) -> Self {
			params[.androidEnabled] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Whether or not the task initiated by this activity should be excluded
		/// from the list of recently used applications, the overview screen.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#exclude)
		public func excludeFromRecents(_ value: Bool = true) -> Self {
			params[.androidExcludeFromRecents] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// This element sets whether the activity can be launched by components of other applications:
		///
		/// If "true", the activity is accessible to any app, and is launchable by its exact class name.
		///
		/// If "false", the activity can be launched only by components of the same application,
		/// applications with the same user ID, or privileged system components.
		/// This is the default value when there are no intent filters.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#exported)
		public func exported(_ value: Bool = true) -> Self {
			params[.androidExported] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Whether or not an existing instance of the activity should be shut down (finished),
		/// except for the root activity, whenever the user again launches
		/// its task (chooses the task on the home screen) — "true"
		/// if it should be shut down, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#finish)
		public func finishOnTaskLaunch(_ value: Bool = true) -> Self {
			params[.androidFinishOnTaskLaunch] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Whether or not hardware-accelerated rendering should be enabled
		/// for this Activity — "true" if it should be enabled, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#hwaccel)
		public func hardwareAccelerated(_ value: Bool = true) -> Self {
			params[.androidHardwareAccelerated] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// An icon representing the activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#icon)
		public func icon(_ value: String) -> Self { // TODO: drawable resource
			params[.androidIcon] = value
			return self
		}
		
		/// A default round icon for all application components.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#icon)
		public func roundIcon(_ value: String) -> Self { // TODO: drawable resource
			params[.androidRoundIcon] = value
			return self
		}
		
		// MARK: -
		
		/// Sets the immersive mode setting for the current activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#immersive)
		public func immersive(_ value: Bool = true) -> Self {
			params[.androidImmersive] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// A user-readable label for the activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#label)
		public func label(_ value: String) -> Self { // TODO: string resource
			params[.androidLabel] = value
			return self
		}
		
		// MARK: -
		
		/// An instruction on how the activity should be launched.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#lmode)
		public func launchMode(_ value: LaunchMode) -> Self {
			params[.androidLaunchMode] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Determines how the system presents this activity when the device is running in lock task mode.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#ltmode)
		public func lockTaskMode(_ value: LockTaskMode) -> Self {
			params[.androidLockTaskMode] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// The maximum number of tasks rooted at this activity in the overview screen.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#maxrecents)
		public func maxRecents(_ value: Int) -> Self {
			params[.androidMaxRecents] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// The maximum aspect ratio the activity supports.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#maxaspectratio)
		public func maxAspectRatio(_ value: Double) -> Self {
			params[.androidMaxAspectRatio] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Whether an instance of the activity can be launched into the process
		/// of the component that started it — "true" if it can be, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#multi)
		public func multiprocess(_ value: Bool = true) -> Self {
			params[.androidMultiprocess] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Whether or not the activity should be removed from the activity stack
		/// and finished (its finish() method called) when the user navigates away from it
		/// and it's no longer visible on screen — "true" if it should be finished, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#nohist)
		public func noHistory(_ value: Bool = true) -> Self {
			params[.androidNoHistory] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// The class name of the logical parent of the activity.
		/// The name here must match the class name given to the corresponding `<activity>` element's `android:name` attribute.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#parent)
		public func parentActivityName(_ value: AnyActivity.Type) -> Self {
			params[.androidParentActivityName] = ".\(value)"
			return self
		}
		
		// MARK: -
		
		/// Defines how an instance of an activity is preserved within a containing task across device restarts.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#persistableMode)
		public func persistableMode(_ value: PersistableMode) -> Self {
			params[.androidPersistableMode] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// The name of a permission that clients must have to launch
		/// the activity or otherwise get it to respond to an intent.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#prmsn)
		public func permission(_ value: ManifestPermission) -> Self {
			params[.androidPermission] = value.value
			return self
		}
		
		// MARK: -
		
		/// The name of the process in which the activity should run.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#proc)
		public func process(_ value: String) -> Self {
			params[.androidProcess] = value
			return self
		}
		
		// MARK: -
		
		/// Whether or not the activity relinquishes its task identifiers to an activity above it in the task stack.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#relinquish)
		public func relinquishTaskIdentity(_ value: Bool = true) -> Self {
			params[.androidRelinquishTaskIdentity] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Specifies whether the app supports multi-window mode.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#resizeableActivity)
		public func resizeableActivity(_ value: Bool = true) -> Self {
			params[.androidResizeableActivity] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// The orientation of the activity's display on the device.
		///
		/// The system ignores this attribute if the activity is running in multi-window mode.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#screen)
		public func screenOrientation(_ value: ScreenOrientation) -> Self {
			params[.androidScreenOrientation] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Whether or not the activity is shown when the device's current user is different
		/// than the user who launched the activity. You can set this attribute
		/// to a literal value—"true" or "false"—or you can set the attribute
		/// to a resource or theme attribute that contains a boolean value.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#showForAllUsers)
		public func showForAllUsers(_ value: Bool = true) -> Self {
			params[.androidShowForAllUsers] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Whether or not the activity can be killed and successfully restarted
		/// without having saved its state — "true" if it can be restarted without reference
		/// to its previous state, and "false" if its previous state is required.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#state)
		public func stateNotNeeded(_ value: Bool = true) -> Self {
			params[.androidStateNotNeeded] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// Specifies whether the activity supports Picture-in-Picture display.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#supportsPIP)
		public func supportsPictureInPicture(_ value: Bool = true) -> Self {
			params[.androidSupportsPictureInPicture] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// The task that the activity has an affinity for.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#aff)
		public func taskAffinity(_ value: String) -> Self {
			params[.androidTaskAffinity] = value
			return self
		}
		
		// MARK: -
		
		/// A reference to a style resource defining an overall theme for the activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#theme)
		public func theme(_ value: RStyle) -> Self { // TODO: resource or theme
			params[.androidTheme] = value.value
			return self
		}
		
		// MARK: -
		
		/// Extra options for an activity's UI.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#uioptions)
		public func uiOptions(_ value: ApplicationUIOptions) -> Self {
			params[.androidUIOptions] = ManifestTagParamValue(value).value
			return self
		}
		
		// MARK: -
		
		/// How the main window of the activity interacts with the window containing the on-screen soft keyboard.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#wsoft)
		public func windowSoftInputMode(_ value: [WindowSoftInputMode]) -> Self {
            params[.androidWindowSoftInputMode] = ManifestTagParamValue(values: value).value
			return self
		}
		
		/// How the main window of the activity interacts with the window containing the on-screen soft keyboard.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#wsoft)
		public func windowSoftInputMode(_ value: WindowSoftInputMode...) -> Self {
			windowSoftInputMode(value)
		}
		
		// MARK: -
		
		/// Specifies the types of intents that an activity, service, or broadcast receiver can respond to.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element)
		public func intentFilter(_ handler: () -> DroidApp.IntentFilter) -> Self {
			items.append(handler())
			return self
		}
		
		// MARK: -
		
		/// A name-value pair for an item of additional, arbitrary data that can be supplied to the parent component.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element)
		public func metaData(_ handler: () -> DroidApp.MetaData) -> Self {
			items.append(handler())
			return self
		}
	}
}

