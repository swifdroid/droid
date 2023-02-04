//
//  DroidApp+Activity.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Declares an activity (an Activity subclass) that implements part of the application's visual user interface.
	///
	/// All activities must be represented by `<activity>` elements in the manifest file.
	///
	/// Any that are not declared there will not be seen by the system and will never be run.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element)
	public class Activity: ManifestTag {
		static var name: String { "activity" }
		
		var params: [ManifestTagParam] = []
		var items: [ManifestTag] = []
		
		required init() {}
		
		// MARK: -
		
		/// Indicate that the activity can be launched as the embedded child of another activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#embedded)
		public func allowEmbedded(_ value: Bool) -> Self {
			params.append(.init(.androidAllowEmbedded, value))
			return self
		}
		
		/// Indicate that the activity can be launched as the embedded child of another activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#embedded)
		public static func allowEmbedded(_ value: Bool) -> Self {
			Self().allowEmbedded(value)
		}
		
		// MARK: -
		
		/// Whether or not the activity can move from the task that started it
		/// to the task it has an affinity for when that task is next brought to the front — "true"
		/// if it can move, and "false" if it must remain with the task where it started.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#reparent)
		public func allowTaskReparenting(_ value: Bool) -> Self {
			params.append(.init(.androidAllowTaskReparenting, value))
			return self
		}
		
		/// Whether or not the activity can move from the task that started it
		/// to the task it has an affinity for when that task is next brought to the front — "true"
		/// if it can move, and "false" if it must remain with the task where it started.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#reparent)
		public static func allowTaskReparenting(_ value: Bool) -> Self {
			Self().allowTaskReparenting(value)
		}
		
		// MARK: -
		
		/// Whether or not the state of the task that the activity is in will always
		/// be maintained by the system — "true" if it will be, and "false" if the system
		/// is allowed to reset the task to its initial state in certain situations.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#always)
		public func alwaysRetainTaskState(_ value: Bool) -> Self {
			params.append(.init(.androidAlwaysRetainTaskState, value))
			return self
		}
		
		/// Whether or not the state of the task that the activity is in will always
		/// be maintained by the system — "true" if it will be, and "false" if the system
		/// is allowed to reset the task to its initial state in certain situations.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#always)
		public static func alwaysRetainTaskState(_ value: Bool) -> Self {
			Self().alwaysRetainTaskState(value)
		}
		
		// MARK: -
		
		/// Whether or not tasks launched by activities with this attribute remains in
		/// the overview screen until the last activity in the task is completed. If true,
		/// the task is automatically removed from the overview screen. This overrides the caller's
		/// use of **FLAG_ACTIVITY_RETAIN_IN_RECENTS**. It must be a boolean value, either "true" or "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#autoremrecents)
		public func autoRemoveFromRecents(_ value: Bool) -> Self {
			params.append(.init(.androidAutoRemoveFromRecents, value))
			return self
		}
		
		/// Whether or not tasks launched by activities with this attribute remains in
		/// the overview screen until the last activity in the task is completed. If true,
		/// the task is automatically removed from the overview screen. This overrides the caller's
		/// use of **FLAG_ACTIVITY_RETAIN_IN_RECENTS**. It must be a boolean value, either "true" or "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#autoremrecents)
		public static func autoRemoveFromRecents(_ value: Bool) -> Self {
			Self().autoRemoveFromRecents(value)
		}
		
		// MARK: -
		
		/// A drawable resource providing an extended graphical banner for its associated item.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#banner)
		public func banner(_ value: String) -> Self { // TODO: drawable resource
			params.append(.init(.androidBanner, value))
			return self
		}
		
		/// A drawable resource providing an extended graphical banner for its associated item.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#banner)
		public static func banner(_ value: String) -> Self {
			Self().banner(value)
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
		public func clearTaskOnLaunch(_ value: Bool) -> Self {
			params.append(.init(.androidClearTaskOnLaunch, value))
			return self
		}
		
		/// Whether or not all activities will be removed from the task,
		/// except for the root activity, whenever it is re-launched from
		/// the home screen — "true" if the task is always stripped down
		/// to its root activity, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#clear)
		public static func clearTaskOnLaunch(_ value: Bool) -> Self {
			Self().clearTaskOnLaunch(value)
		}
		
		// MARK: -
		
		/// Requests the activity to be displayed in wide color gamut mode on compatible devices.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#colormode)
		public func colorMode(_ value: String) -> Self {
			params.append(.init(.androidColorMode, value))
			return self
		}
		
		/// Requests the activity to be displayed in wide color gamut mode on compatible devices.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#colormode)
		public static func colorMode(_ value: String) -> Self {
			Self().colorMode(value)
		}
		
		// MARK: -
		
		/// Lists configuration changes that the activity will handle itself.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#config)
		public func configChanges(_ value: [ConfigChangeType]) -> Self {
			params.append(.init(.androidConfigChanges, values: value))
			return self
		}
		
		/// Lists configuration changes that the activity will handle itself.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#config)
		public static func configChanges(_ value: [ConfigChangeType]) -> Self {
			Self().configChanges(value)
		}
		
		/// Lists configuration changes that the activity will handle itself.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#config)
		public func configChanges(_ value: ConfigChangeType...) -> Self {
			configChanges(value)
		}
		
		/// Lists configuration changes that the activity will handle itself.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#config)
		public static func configChanges(_ value: ConfigChangeType...) -> Self {
			Self().configChanges(value)
		}
		
		// MARK: -
		
		/// Whether or not the activity is direct-boot aware; that is, whether or not it can run before the user unlocks the device.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#directBootAware)
		public func directBootAware(_ value: Bool) -> Self {
			params.append(.init(.androidDirectBootAware, value))
			return self
		}
		
		/// Whether or not the activity is direct-boot aware; that is, whether or not it can run before the user unlocks the device.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#directBootAware)
		public static func directBootAware(_ value: Bool) -> Self {
			Self().directBootAware(value)
		}
		
		// MARK: -
		
		/// Specifies how a new instance of an activity should be added to a task each time it is launched.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#dlmode)
		public func documentLaunchMode(_ value: DocumentLaunchMode) -> Self {
			params.append(.init(.androidDocumentLaunchMode, value))
			return self
		}
		
		/// Specifies how a new instance of an activity should be added to a task each time it is launched.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#dlmode)
		public static func documentLaunchMode(_ value: DocumentLaunchMode) -> Self {
			Self().documentLaunchMode(value)
		}
		
		// MARK: -
		
		/// Whether or not the activity can be instantiated
		/// by the system — "true" if it can be, and "false" if not.
		///
		/// The default value is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#enabled)
		public func enabled(_ value: Bool) -> Self {
			params.append(.init(.androidEnabled, value))
			return self
		}
		
		/// Whether or not the activity can be instantiated
		/// by the system — "true" if it can be, and "false" if not.
		///
		/// The default value is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#enabled)
		public static func enabled(_ value: Bool) -> Self {
			Self().enabled(value)
		}
		
		// MARK: -
		
		/// Whether or not the task initiated by this activity should be excluded
		/// from the list of recently used applications, the overview screen.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#exclude)
		public func excludeFromRecents(_ value: Bool) -> Self {
			params.append(.init(.androidExcludeFromRecents, value))
			return self
		}
		
		/// Whether or not the task initiated by this activity should be excluded
		/// from the list of recently used applications, the overview screen.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#exclude)
		public static func excludeFromRecents(_ value: Bool) -> Self {
			Self().excludeFromRecents(value)
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
		public func exported(_ value: Bool) -> Self {
			params.append(.init(.androidExported, value))
			return self
		}
		
		/// This element sets whether the activity can be launched by components of other applications:
		///
		/// If "true", the activity is accessible to any app, and is launchable by its exact class name.
		///
		/// If "false", the activity can be launched only by components of the same application,
		/// applications with the same user ID, or privileged system components.
		/// This is the default value when there are no intent filters.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#exported)
		public static func exported(_ value: Bool) -> Self {
			Self().exported(value)
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
		public func finishOnTaskLaunch(_ value: Bool) -> Self {
			params.append(.init(.androidFinishOnTaskLaunch, value))
			return self
		}
		
		/// Whether or not an existing instance of the activity should be shut down (finished),
		/// except for the root activity, whenever the user again launches
		/// its task (chooses the task on the home screen) — "true"
		/// if it should be shut down, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#finish)
		public static func finishOnTaskLaunch(_ value: Bool) -> Self {
			Self().finishOnTaskLaunch(value)
		}
		
		// MARK: -
		
		/// Whether or not hardware-accelerated rendering should be enabled
		/// for this Activity — "true" if it should be enabled, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#hwaccel)
		public func hardwareAccelerated(_ value: Bool) -> Self {
			params.append(.init(.androidHardwareAccelerated, value))
			return self
		}
		
		/// Whether or not hardware-accelerated rendering should be enabled
		/// for this Activity — "true" if it should be enabled, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#hwaccel)
		public static func hardwareAccelerated(_ value: Bool) -> Self {
			Self().hardwareAccelerated(value)
		}
		
		// MARK: -
		
		/// An icon representing the activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#icon)
		public func icon(_ value: String) -> Self { // TODO: drawable resource
			params.append(.init(.androidIcon, value))
			return self
		}
		
		/// An icon representing the activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#icon)
		public static func icon(_ value: String) -> Self {
			Self().icon(value)
		}
		
		/// A default round icon for all application components.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#icon)
		public func roundIcon(_ value: String) -> Self { // TODO: drawable resource
			params.append(.init(.androidRoundIcon, value))
			return self
		}
		
		/// A default round icon for all application components.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#icon)
		public static func roundIcon(_ value: String) -> Self {
			Self().roundIcon(value)
		}
		
		// MARK: -
		
		/// Sets the immersive mode setting for the current activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#immersive)
		public func immersive(_ value: Bool) -> Self {
			params.append(.init(.androidImmersive, value))
			return self
		}
		
		/// Sets the immersive mode setting for the current activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#immersive)
		public static func immersive(_ value: Bool) -> Self {
			Self().immersive(value)
		}
		
		// MARK: -
		
		/// A user-readable label for the activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#label)
		public func label(_ value: String) -> Self { // TODO: string resource
			params.append(.init(.androidLabel, value))
			return self
		}
		
		/// A user-readable label for the activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#label)
		public static func label(_ value: String) -> Self {
			Self().label(value)
		}
		
		// MARK: -
		
		/// An instruction on how the activity should be launched.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#lmode)
		public func launchMode(_ value: LaunchMode) -> Self {
			params.append(.init(.androidLaunchMode, value))
			return self
		}
		
		/// An instruction on how the activity should be launched.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#lmode)
		public static func launchMode(_ value: LaunchMode) -> Self {
			Self().launchMode(value)
		}
		
		// MARK: -
		
		/// Determines how the system presents this activity when the device is running in lock task mode.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#ltmode)
		public func lockTaskMode(_ value: LockTaskMode) -> Self {
			params.append(.init(.androidLockTaskMode, value))
			return self
		}
		
		/// Determines how the system presents this activity when the device is running in lock task mode.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#ltmode)
		public static func lockTaskMode(_ value: LockTaskMode) -> Self {
			Self().lockTaskMode(value)
		}
		
		// MARK: -
		
		/// The maximum number of tasks rooted at this activity in the overview screen.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#maxrecents)
		public func maxRecents(_ value: Int) -> Self {
			params.append(.init(.androidMaxRecents, value))
			return self
		}
		
		/// The maximum number of tasks rooted at this activity in the overview screen.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#maxrecents)
		public static func maxRecents(_ value: Int) -> Self {
			Self().maxRecents(value)
		}
		
		// MARK: -
		
		/// The maximum aspect ratio the activity supports.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#maxaspectratio)
		public func maxAspectRatio(_ value: Double) -> Self {
			params.append(.init(.androidMaxAspectRatio, value))
			return self
		}
		
		/// The maximum aspect ratio the activity supports.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#maxaspectratio)
		public static func maxAspectRatio(_ value: Double) -> Self {
			Self().maxAspectRatio(value)
		}
		
		// MARK: -
		
		/// Whether an instance of the activity can be launched into the process
		/// of the component that started it — "true" if it can be, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#multi)
		public func multiprocess(_ value: Bool) -> Self {
			params.append(.init(.androidMultiprocess, value))
			return self
		}
		
		/// Whether an instance of the activity can be launched into the process
		/// of the component that started it — "true" if it can be, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#multi)
		public static func multiprocess(_ value: Bool) -> Self {
			Self().multiprocess(value)
		}
		
		// MARK: -
		
		/// The name of the class that implements the activity, a subclass of Activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#nm)
		public func name(_ value: String) -> Self {
			params.append(.init(.androidName, value))
			return self
		}
		
		/// The name of the class that implements the activity, a subclass of Activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#nm)
		public static func name(_ value: String) -> Self {
			Self().name(value)
		}
		
		// MARK: -
		
		/// Whether or not the activity should be removed from the activity stack
		/// and finished (its finish() method called) when the user navigates away from it
		/// and it's no longer visible on screen — "true" if it should be finished, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#nohist)
		public func noHistory(_ value: Bool) -> Self {
			params.append(.init(.androidNoHistory, value))
			return self
		}
		
		/// Whether or not the activity should be removed from the activity stack
		/// and finished (its finish() method called) when the user navigates away from it
		/// and it's no longer visible on screen — "true" if it should be finished, and "false" if not.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#nohist)
		public static func noHistory(_ value: Bool) -> Self {
			Self().noHistory(value)
		}
		
		// MARK: -
		
		/// The class name of the logical parent of the activity.
		/// The name here must match the class name given to the corresponding `<activity>` element's `android:name` attribute.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#parent)
		public func parentActivityName(_ value: String) -> Self {
			params.append(.init(.androidParentActivityName, value))
			return self
		}
		
		/// The class name of the logical parent of the activity.
		/// The name here must match the class name given to the corresponding `<activity>` element's `android:name` attribute.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#parent)
		public static func parentActivityName(_ value: String) -> Self {
			Self().parentActivityName(value)
		}
		
		// MARK: -
		
		/// Defines how an instance of an activity is preserved within a containing task across device restarts.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#persistableMode)
		public func persistableMode(_ value: PersistableMode) -> Self {
			params.append(.init(.androidPersistableMode, value))
			return self
		}
		
		/// Defines how an instance of an activity is preserved within a containing task across device restarts.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#persistableMode)
		public static func persistableMode(_ value: PersistableMode) -> Self {
			Self().persistableMode(value)
		}
		
		// MARK: -
		
		/// The name of a permission that clients must have to launch
		/// the activity or otherwise get it to respond to an intent.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#prmsn)
		public func permission(_ value: String) -> Self {
			params.append(.init(.androidPermission, value))
			return self
		}
		
		/// The name of a permission that clients must have to launch
		/// the activity or otherwise get it to respond to an intent.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#prmsn)
		public static func permission(_ value: String) -> Self {
			Self().permission(value)
		}
		
		// MARK: -
		
		/// The name of the process in which the activity should run.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#proc)
		public func process(_ value: String) -> Self {
			params.append(.init(.androidProcess, value))
			return self
		}
		
		/// The name of the process in which the activity should run.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#proc)
		public static func process(_ value: String) -> Self {
			Self().process(value)
		}
		
		// MARK: -
		
		/// Whether or not the activity relinquishes its task identifiers to an activity above it in the task stack.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#relinquish)
		public func relinquishTaskIdentity(_ value: Bool) -> Self {
			params.append(.init(.androidRelinquishTaskIdentity, value))
			return self
		}
		
		/// Whether or not the activity relinquishes its task identifiers to an activity above it in the task stack.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#relinquish)
		public static func relinquishTaskIdentity(_ value: Bool) -> Self {
			Self().relinquishTaskIdentity(value)
		}
		
		// MARK: -
		
		/// Specifies whether the app supports multi-window mode.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#resizeableActivity)
		public func resizeableActivity(_ value: Bool) -> Self {
			params.append(.init(.androidResizeableActivity, value))
			return self
		}
		
		/// Specifies whether the app supports multi-window mode.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#resizeableActivity)
		public static func resizeableActivity(_ value: Bool) -> Self {
			Self().resizeableActivity(value)
		}
		
		// MARK: -
		
		/// The orientation of the activity's display on the device.
		///
		/// The system ignores this attribute if the activity is running in multi-window mode.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#screen)
		public func screenOrientation(_ value: ScreenOrientation) -> Self {
			params.append(.init(.androidScreenOrientation, value))
			return self
		}
		
		/// The orientation of the activity's display on the device.
		///
		/// The system ignores this attribute if the activity is running in multi-window mode.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#screen)
		public static func screenOrientation(_ value: ScreenOrientation) -> Self {
			Self().screenOrientation(value)
		}
		
		// MARK: -
		
		/// Whether or not the activity is shown when the device's current user is different
		/// than the user who launched the activity. You can set this attribute
		/// to a literal value—"true" or "false"—or you can set the attribute
		/// to a resource or theme attribute that contains a boolean value.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#showForAllUsers)
		public func showForAllUsers(_ value: Bool) -> Self {
			params.append(.init(.androidShowForAllUsers, value))
			return self
		}
		
		/// Whether or not the activity is shown when the device's current user is different
		/// than the user who launched the activity. You can set this attribute
		/// to a literal value—"true" or "false"—or you can set the attribute
		/// to a resource or theme attribute that contains a boolean value.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#showForAllUsers)
		public static func showForAllUsers(_ value: Bool) -> Self {
			Self().showForAllUsers(value)
		}
		
		// MARK: -
		
		/// Whether or not the activity can be killed and successfully restarted
		/// without having saved its state — "true" if it can be restarted without reference
		/// to its previous state, and "false" if its previous state is required.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#state)
		public func stateNotNeeded(_ value: Bool) -> Self {
			params.append(.init(.androidStateNotNeeded, value))
			return self
		}
		
		/// Whether or not the activity can be killed and successfully restarted
		/// without having saved its state — "true" if it can be restarted without reference
		/// to its previous state, and "false" if its previous state is required.
		///
		/// The default value is "false".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#state)
		public static func stateNotNeeded(_ value: Bool) -> Self {
			Self().stateNotNeeded(value)
		}
		
		// MARK: -
		
		/// Specifies whether the activity supports Picture-in-Picture display.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#supportsPIP)
		public func supportsPictureInPicture(_ value: Bool) -> Self {
			params.append(.init(.androidSupportsPictureInPicture, value))
			return self
		}
		
		/// Specifies whether the activity supports Picture-in-Picture display.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#supportsPIP)
		public static func supportsPictureInPicture(_ value: Bool) -> Self {
			Self().supportsPictureInPicture(value)
		}
		
		// MARK: -
		
		/// The task that the activity has an affinity for.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#aff)
		public func taskAffinity(_ value: String) -> Self {
			params.append(.init(.androidTaskAffinity, value))
			return self
		}
		
		/// The task that the activity has an affinity for.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#aff)
		public static func taskAffinity(_ value: String) -> Self {
			Self().taskAffinity(value)
		}
		
		// MARK: -
		
		/// A reference to a style resource defining an overall theme for the activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#theme)
		public func theme(_ value: String) -> Self { // TODO: resource or theme
			params.append(.init(.androidTheme, value))
			return self
		}
		
		/// A reference to a style resource defining an overall theme for the activity.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#theme)
		public static func theme(_ value: String) -> Self {
			Self().theme(value)
		}
		
		// MARK: -
		
		/// Extra options for an activity's UI.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#uioptions)
		public func uiOptions(_ value: ApplicationUIOptions) -> Self {
			params.append(.init(.androidUIOptions, value))
			return self
		}
		
		/// Extra options for an activity's UI.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#uioptions)
		public static func uiOptions(_ value: ApplicationUIOptions) -> Self {
			Self().uiOptions(value)
		}
		
		// MARK: -
		
		/// How the main window of the activity interacts with the window containing the on-screen soft keyboard.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#wsoft)
		public func windowSoftInputMode(_ value: [WindowSoftInputMode]) -> Self {
			params.append(.init(.androidWindowSoftInputMode, values: value))
			return self
		}
		
		/// How the main window of the activity interacts with the window containing the on-screen soft keyboard.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#wsoft)
		public static func windowSoftInputMode(_ value: [WindowSoftInputMode]) -> Self {
			Self().windowSoftInputMode(value)
		}
		
		/// How the main window of the activity interacts with the window containing the on-screen soft keyboard.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#wsoft)
		public func windowSoftInputMode(_ value: WindowSoftInputMode...) -> Self {
			windowSoftInputMode(value)
		}
		
		/// How the main window of the activity interacts with the window containing the on-screen soft keyboard.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#wsoft)
		public static func windowSoftInputMode(_ value: WindowSoftInputMode...) -> Self {
			Self().windowSoftInputMode(value)
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
	}
}

