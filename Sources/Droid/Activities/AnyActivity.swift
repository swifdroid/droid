//
//  AnyActivity.swift
//
//
//  Created by Mihael Isaev on 25.02.2023.
//

public protocol Contextable: Sendable {
	@MainActor
	var context: ActivityContext { get }
}

@MainActor
public protocol AnyActivity: AnyObject, Contextable {
    static nonisolated var packageName: String? { get }
	static nonisolated var className: String { get }
    static nonisolated var gradleDependencies: [AppGradleDependency] { get }
	static nonisolated var javaImports: [String] { get }
    static nonisolated var parentClass: String { get }

	init ()

	func attach(to context: JObject)

	func onCreate(_ context: ActivityContext)

	// MARK: Manifest Properties

    /// Indicate that the activity can be launched as the embedded child of another activity.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#embedded)
    static nonisolated var allowEmbedded: Bool? { get }

    /// Whether or not the activity can move from the task that started it
    /// to the task it has an affinity for when that task is next brought to the front — "true"
    /// if it can move, and "false" if it must remain with the task where it started.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#reparent)
    static nonisolated var allowTaskReparenting: Bool? { get }

    /// Whether or not the state of the task that the activity is in will always
    /// be maintained by the system — "true" if it will be, and "false" if the system
    /// is allowed to reset the task to its initial state in certain situations.
    ///
    /// The default value is "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#always)
    static nonisolated var alwaysRetainTaskState: Bool? { get }

    /// Whether or not tasks launched by activities with this attribute remains in
    /// the overview screen until the last activity in the task is completed. If true,
    /// the task is automatically removed from the overview screen. This overrides the caller's
    /// use of **FLAG_ACTIVITY_RETAIN_IN_RECENTS**. It must be a boolean value, either "true" or "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#autoremrecents)
    static nonisolated var autoRemoveFromRecents: Bool? { get }

    /// A drawable resource providing an extended graphical banner for its associated item.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#banner)
    static nonisolated var banner: String? { get }

    /// Whether or not all activities will be removed from the task,
    /// except for the root activity, whenever it is re-launched from
    /// the home screen — "true" if the task is always stripped down
    /// to its root activity, and "false" if not.
    ///
    /// The default value is "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#clear)
    static nonisolated var clearTaskOnLaunch: Bool? { get }

    /// Requests the activity to be displayed in wide color gamut mode on compatible devices.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#colormode)
    static nonisolated var colorMode: String? { get }

    /// Lists configuration changes that the activity will handle itself. For the rest activity will be simply restarted.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#config)
    static nonisolated var configChanges: [ConfigChangeType] { get }

    /// Whether or not the activity is direct-boot aware; that is, whether or not it can run before the user unlocks the device.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#directBootAware)
    static nonisolated var directBootAware: Bool? { get }

    /// Specifies how a new instance of an activity should be added to a task each time it is launched.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#dlmode)
	static nonisolated var documentLaunchMode: DocumentLaunchMode? { get }
	
	/// Whether or not the activity can be instantiated
	/// by the system — "true" if it can be, and "false" if not.
	///
	/// The default value is "true".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#enabled)
	static nonisolated var enabled: Bool? { get }
	
	/// Whether or not the task initiated by this activity should be excluded
	/// from the list of recently used applications, the overview screen.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#exclude)
	static nonisolated var excludeFromRecents: Bool? { get }
	
	/// This element sets whether the activity can be launched by components of other applications:
	///
	/// If "true", the activity is accessible to any app, and is launchable by its exact class name.
	///
	/// If "false", the activity can be launched only by components of the same application,
	/// applications with the same user ID, or privileged system components.
	/// This is the default value when there are no intent filters.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#exported)
	static nonisolated var exported: Bool? { get }
	
	/// Whether or not an existing instance of the activity should be shut down (finished),
	/// except for the root activity, whenever the user again launches
	/// its task (chooses the task on the home screen) — "true"
	/// if it should be shut down, and "false" if not.
	///
	/// The default value is "false".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#finish)
	static nonisolated var finishOnTaskLaunch: Bool? { get }
	
	/// Whether or not hardware-accelerated rendering should be enabled
	/// for this Activity — "true" if it should be enabled, and "false" if not.
	///
	/// The default value is "false".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#hwaccel)
	static nonisolated var hardwareAccelerated: Bool? { get }
	
	/// An icon representing the activity.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#icon)
	static nonisolated var icon: String? { get } // TODO: drawable resource
	
	/// A default round icon for all application components.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#icon)
	static nonisolated var roundIcon: String? { get } // TODO: drawable resource
	
	/// Sets the immersive mode setting for the current activity.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#immersive)
	static nonisolated var immersive: Bool? { get }
	
	/// A user-readable label for the activity.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#label)
	static nonisolated var label: String? { get } // TODO: string resource
	
	/// An instruction on how the activity should be launched.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#lmode)
	static nonisolated var launchMode: LaunchMode? { get }
	
	/// Determines how the system presents this activity when the device is running in lock task mode.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#ltmode)
	static nonisolated var lockTaskMode: LockTaskMode? { get }
	
	/// The maximum number of tasks rooted at this activity in the overview screen.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#maxrecents)
	static nonisolated var maxRecents: Int? { get }
	
	/// The maximum aspect ratio the activity supports.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#maxaspectratio)
	static nonisolated var maxAspectRatio: Double? { get }
	
	/// Whether an instance of the activity can be launched into the process
	/// of the component that started it — "true" if it can be, and "false" if not.
	///
	/// The default value is "false".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#multi)
	static nonisolated var multiprocess: Bool? { get }
	
	/// Whether or not the activity should be removed from the activity stack
	/// and finished (its finish() method called) when the user navigates away from it
	/// and it's no longer visible on screen — "true" if it should be finished, and "false" if not.
	///
	/// The default value is "false".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#nohist)
	static nonisolated var noHistory: Bool? { get }
	
	/// The class name of the logical parent of the activity.
	/// The name here must match the class name given to the corresponding `<activity>` element's `android:name` attribute.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#parent)
	static nonisolated var parentActivityName: String? { get }
	
	/// Defines how an instance of an activity is preserved within a containing task across device restarts.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#persistableMode)
	static nonisolated var persistableMode: PersistableMode? { get }
	
	/// The name of a permission that clients must have to launch
	/// the activity or otherwise get it to respond to an intent.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#prmsn)
	static nonisolated var permission: String? { get }
	
	/// The name of the process in which the activity should run.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#proc)
	static nonisolated var process: String? { get }
	
	/// Whether or not the activity relinquishes its task identifiers to an activity above it in the task stack.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#relinquish)
	static nonisolated var relinquishTaskIdentity: Bool? { get }
	
	/// Specifies whether the app supports multi-window mode.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#resizeableActivity)
	static nonisolated var resizeableActivity: Bool? { get }
	
	/// The orientation of the activity's display on the device.
	///
	/// The system ignores this attribute if the activity is running in multi-window mode.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#screen)
	static nonisolated var screenOrientation: ScreenOrientation? { get }
	
	/// Whether or not the activity is shown when the device's current user is different
	/// than the user who launched the activity. You can set this attribute
	/// to a literal value—"true" or "false"—or you can set the attribute
	/// to a resource or theme attribute that contains a boolean value.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#showForAllUsers)
	static nonisolated var showForAllUsers: Bool? { get }
	
	/// Whether or not the activity can be killed and successfully restarted
	/// without having saved its state — "true" if it can be restarted without reference
	/// to its previous state, and "false" if its previous state is required.
	///
	/// The default value is "false".
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#state)
	static nonisolated var stateNotNeeded: Bool? { get }
	
	/// Specifies whether the activity supports Picture-in-Picture display.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#supportsPIP)
	static nonisolated var supportsPictureInPicture: Bool? { get }
	
	/// The task that the activity has an affinity for.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#aff)
	static nonisolated var taskAffinity: String? { get }
	
	/// A reference to a style resource defining an overall theme for the activity.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#theme)
	static nonisolated var theme: RStyle? { get }
	
	/// Extra options for an activity's UI.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#uioptions)
	static nonisolated var uiOptions: ApplicationUIOptions? { get }
	
	/// How the main window of the activity interacts with the window containing the on-screen soft keyboard.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#wsoft)
	static nonisolated var windowSoftInputMode: [WindowSoftInputMode] { get }
	
	/// Specifies the types of intents that an activity, service, or broadcast receiver can respond to.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element)
	static nonisolated var intentFilter: DroidApp.IntentFilter? { get }
	
	/// A name-value pair for an item of additional, arbitrary data that can be supplied to the parent component.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element)
	static nonisolated var metaData: DroidApp.MetaData? { get }

	// MARK: Start Activity

	/// Starts activity the classic way
	func startActivity(_ activity: AnyActivity.Type)
	/// Starts pre-initialized activity
	func startActivity<T: AnyActivity>(_ activity: T)

	// MARK: Finish Activity

	/// Call this when your activity is done and should be closed.
	///
	/// The ActivityResult is propagated back to whoever launched you via onActivityResult().
	func finish()

	/// Finish this activity as well as all activities immediately below
	/// it in the current task that have the same affinity.
	///
	/// This is typically used when an application can be launched on
	/// to another task (such as from an ACTION_VIEW of a content type it understands)
	/// and the user has used the up navigation to switch out of the current task and in to its own task.
	/// In this case, if the user has navigated down into any other activities of the second application,
	/// all of those should be removed from the original task as part of the task switch.
	/// 
	/// Note: this finish does not allow you to deliver results to the previous activity,
	/// and an exception will be thrown if you are trying to do so.
	func finishAffinity()

	/// Reverses the Activity Scene entry Transition
	/// and triggers the calling Activity to reverse its exit Transition.
	///
	/// When the exit Transition completes, `finish()` is called.
	///
	/// If no entry Transition was used, `finish()` is called immediately
	/// and the Activity exit Transition is run.
	func finishAfterTransition()

	/// Force finish another activity that you had previously started with startActivityForResult.
	/// 
	/// Params:
	///   - requestCode: The request code of the activity that you had given
	/// to `startActivityForResult()`. If there are multiple activities started with this request code, they will all be finished.
	func finishActivity(requiestCode: Int)

	// MARK: Lifecycle

	/// Called when the activity is about to enter a paused state.
    /// 
    /// This means another activity is coming into the foreground, 
    /// but this one is still partially visible. 
    /// Use this to pause animations, video playback, or other ongoing tasks.
	func onPause()
	
	/// Called when the system is about to save the activity's state,
    /// but before that state has actually been committed.
    ///
    /// Typically invoked before `onStop()`. 
    /// Override this to do lightweight cleanup tasks that should 
    /// not be persisted in the saved instance state.
	func onStateNotSaved()

	/// Called when the activity is about to resume interaction with the user.
    ///
    /// At this point, the activity is in the foreground and ready for user input.
    /// Resume any tasks that were paused (e.g. restarting animations or refreshing data).
	func onResume()

	/// Called after the activity has been stopped, just before it starts again.
    ///
    /// This is typically followed by a call to `onStart()` and then `onResume()`.
    /// Override this if you need to re-initialize resources that were released in `onStop()`.
	func onRestart()

	/// Called when the activity is becoming visible to the user.
    ///
    /// Happens after `onCreate()` (for a new instance) or `onRestart()` (for a restarted one).
    /// Use this for UI setup, registering receivers, or refreshing views.
	func onStart()

	/// Called when the activity is no longer visible to the user.
    ///
    /// This happens when a new activity covers it or the app goes to the background.
    /// Use this to release resources that don’t need to be kept while the activity is not visible.
	func onStop()

	/// Called before the activity is completely destroyed.
    ///
    /// This may occur when:
    /// - The activity is finishing (`finish()` was called), or
    /// - The system needs to reclaim memory.
    ///
    /// Use this to perform final cleanup, like releasing resources or saving persistent data.
	func onDestroy()

	/// Called when the activity's window has been attached to the window manager.
    ///
    /// This is the point where your activity can safely interact with the actual window.
    /// Useful for performing final UI setup that depends on the window being ready.
	func onAttachedToWindow()

	/// Called when the user presses the **Back** button.
    ///
    /// By default, this finishes the current activity.
    /// Override this to implement custom back navigation logic 
    /// (e.g., showing a confirmation dialog before exit).
	func onBackPressed()

	/// Called when an activity you launched with `startActivityForResult()` finishes.
    ///
    /// - Parameters:
    ///   - requestCode: The integer request code originally supplied.
    ///   - resultCode: The integer result code returned by the child activity.
    ///   - intent: Optional data returned from the child activity.
    ///   - componentCaller: The caller component that initiated the request.
    ///
    /// Override this to handle results from sub-activities (e.g., picking an image or capturing video).
	func onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?, componentCaller: ComponentCaller?)

	/// Called when the activity's multi-window mode changes.
	///
	/// - Parameter isInMultiWindowMode: `true` if the activity is now in multi-window mode, `false` otherwise.
	/// 
	/// Override this to adjust your UI or behavior based on whether the activity is in multi-window mode.
	func onMultiWindowModeChanged(isInMultiWindowMode: Bool)

	/// Called when the user responds to a permission request.
	/// 
	/// - Parameters:
	///   - requestCode: The integer request code originally supplied to `requestPermissions()`.
	///   - results: An array of `ActivityPermissionResult` indicating the permissions requested and whether they were granted.
	///   - deviceId: The ID of the device for which the permissions were requested.
	///
	/// Override this to handle the user's response to permission requests.
	func onRequestPermissionsResult(requestCode: Int, results: [ActivityPermissionResult], deviceId: Int)
}

public struct ActivityPermissionResult: Sendable {
	public let permission: ManifestPermission
	public let granted: Bool

	public init? (_ permission: String, _ granted: Int32) {
		self.permission = ManifestPermission.extendedPermissions.first(where: { $0.value == permission }) ?? ManifestPermission(stringLiteral: permission)
		self.granted = granted == 0
	}
}

extension AnyActivity {
	var type: Self.Type { Self.self }
}

extension AnyActivity {
	/// Starts activity the classic way
    public func startActivity(_ activity: AnyActivity.Type) {
        #if os(Android)
		InnerLog.d("Starting activity 1 \(activity)")
        guard let _ = DroidApp.shared._activities.first(where: { $0 == activity }) else {
            InnerLog.c("Unable to start \(activity.className) because it is not registered in the App->Manifest->activities.")
            return
        }
		InnerLog.d("Starting activity 2 \(activity)")
		let activityClassName = context.activityClass(activity)
		InnerLog.d("Starting activity 2.1 \(activity)")
		let className = JClassName(stringLiteral: activityClassName)
		InnerLog.d("Starting activity 2.2 \(activity)")
        guard
            let env = JEnv.current(),
            let intent = Intent(env, className: className)
        else {
            InnerLog.c("Unable to create `Intent` for \(activity).")
            return
        }
		InnerLog.d("Starting activity 3 \(activity)")
		context.callVoidMethod(nil, name: "startActivity", args: intent.object.signed(as: .android.content.Intent))
        #endif
    }

    /// Starts pre-initialized activity
    public func startActivity<T: AnyActivity>(_ activity: T) {
        DroidApp.shared._pendingActivities = [activity]
        startActivity(T.self)
    }

	/// Starts activity the classic way
    public func startActivityForResult(_ activity: AnyActivity.Type, requestCode: Int) {
        #if os(Android)
        guard let _ = DroidApp.shared._activities.first(where: { $0 == activity }) else {
            InnerLog.c("Unable to start \(activity.className) because it is not registered in the App->Manifest->activities.")
            return
        }
        guard
            let env = JEnv.current(),
            let intent = Intent(env, className: JClassName(stringLiteral: context.activityClass(activity)))
        else {
            InnerLog.c("Unable to create `Intent` for \(activity).")
            return
        }
		context.callVoidMethod(nil, name: "startActivityForResult", args: intent.object.signed(as: .android.content.Intent), Int32(requestCode))
        #endif
    }

    /// Starts pre-initialized activity
    public func startActivityForResult<T: AnyActivity>(_ activity: T, requestCode: Int) {
        DroidApp.shared._pendingActivities = [activity]
        startActivityForResult(T.self, requestCode: requestCode)
    }

	/// Starts multiple activities the classic way
    public func startActivities(_ activities: [AnyActivity.Type]) {
        #if os(Android)
        for activity in activities {
			guard let _ = DroidApp.shared._activities.first(where: { $0 == activity }) else {
				InnerLog.c("Unable to start \(activity.className) because it is not registered in the App->Manifest->activities.")
				return
			}
		}
		guard
            let env = JEnv.current()
		else { return }
		let intents: [Intent] = activities.compactMap({
			Intent(env, className: JClassName(stringLiteral: context.activityClass($0)))
		})
        guard
            intents.count == activities.count,
			let firstIntent = intents.first
        else {
            InnerLog.c("Unable to instantiate some Intents.")
            return
        }
		guard
			let objectArray = env.newObjectArray(length: Int32(activities.count), clazz: firstIntent.clazz)
		else {
			InnerLog.c("Unable to instantiate JObjectArray for the Intents.")
			return
		}
		for (index, intent) in intents.enumerated() {
			env.setObjectArrayElement(objectArray, index: Int32(index), value: intent.object)
		}
		context.callVoidMethod(nil, name: "startActivities", args: [(objectArray.object, .object(array: true, .android.content.Intent))])
        #endif
    }

	/// Starts multiple pre-initialized activities
	public func startActivities(_ activities: any AnyActivity...) {
		startActivities(activities)
	}

	/// Starts multiple pre-initialized activities
	public func startActivities(_ activities: [any AnyActivity]) {
		DroidApp.shared._pendingActivities = activities
		startActivities(activities.map { $0.type })
	}
}

extension AnyActivity {
	public func finish() {
		context.callVoidMethod(nil, name: "finish")
	}

	public func finishAffinity() {
		context.callVoidMethod(nil, name: "finishAffinity")
	}

	public func finishAfterTransition() {
		context.callVoidMethod(nil, name: "finishAfterTransition")
	}

	public func finishActivity(requiestCode: Int) {
		context.callVoidMethod(nil, name: "finishActivity", args: Int32(requiestCode))
	}
}

extension AnyActivity {
	public static nonisolated var packageName: String? { nil }
	public static nonisolated var className: String { "\(Self.self)" }
}