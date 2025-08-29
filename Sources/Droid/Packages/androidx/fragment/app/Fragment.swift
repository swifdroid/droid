//
//  Fragment.swift
//  Droid
//
//  Created by Mihael Isaev on 26.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

/// A Fragment is a piece of an application's user interface or behavior that can be placed in an Activity.
///
/// Interaction with fragments is done through `FragmentManager`, which can be obtained via Activity.getFragmentManager() and Fragment.getFragmentManager().
/// 
/// [Learn more](https://developer.android.com/reference/androidx/fragment/app/Fragment)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class Fragment: JObjectable, @unchecked Sendable {
    public class var className: JClassName { .init(stringLiteral: "androidx/fragment/app/Fragment") }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    /// Called when a fragment is first attached to its context. `onCreate` will be called after this.
    open func onAttach(_ context: ActivityContext) {} // TODO:
    
    open func onConfigurationChanged() {} // TODO: implement Configuration https://developer.android.com/reference/android/content/res/Configuration.html
    
    /// This hook is called whenever an item in a context menu is selected.
    /// The default implementation simply returns false to have the normal processing happen
    /// (calling the item's Runnable or sending a message to its Handler as appropriate).
    /// You can use this method for any items for which you would like to do processing without those other facilities.
    ///
    /// Use getMenuInfo to get extra information set by the View that added this menu item.
    ///
    /// Derived classes should call through to the base class for it to perform the default menu handling.
    open func onContextItemSelected(_ item: MenuItem) -> Bool { // TODO
        return false
    }

    /// Called to do initial creation of a fragment.
    /// This is called after `onAttach` and before `onCreateView`.
    ///
    /// Note that this can be called while the fragment's activity is still in the process of being created.
    /// As such, you can not rely on things like the activity's content view hierarchy being initialized at this point.
    /// If you want to do work once the activity itself is created, add a `androidx.lifecycle.LifecycleObserver`
    /// on the activity's Lifecycle, removing it when it receives the `CREATED` callback.
    ///
    /// Any restored child fragments will be created before the base `Fragment.onCreate` method returns.
    open func onCreate(_ savedInstanceState: Bundle?) {} // TODO

    /// Called when a fragment loads an animation.
    /// 
    /// Note that if `setCustomAnimations` was called with `Animator` resources
    /// instead of Animation resources, nextAnim will be an animator resource.
    ///
    /// Return your custom `Animation` implementation or one of the following:
    ///    - AlphaAnimation:	An animation that controls the alpha level of an object. 
    ///    - AnimationSet:	Represents a group of Animations that should be played together. 
    ///    - RotateAnimation:	An animation that controls the rotation of an object. 
    ///    - ScaleAnimation:	An animation that controls the scale of an object. 
    ///    - TranslateAnimation:	An animation that controls the position of an object.
    open func onCreateAnimation(_ transit: Int32, _ enter: Bool, _ nextAnim: Int32) -> Animation? { // TODO:
        return nil
    }

    /// Called when a fragment loads an animator.
    /// 
    /// This will be called when `onCreateAnimation` returns null.
    /// 
    /// Note that if setCustomAnimations was called with `Animation` resources
    /// instead of `Animator` resources, `nextAnim` will be an animation resource.
    ///
    /// Return your custom `Animator` implementation or one of the following:
    ///    - AnimatorSet:	This class plays a set of Animator objects in the specified order. 
    ///    - ValueAnimator:	This class provides a simple timing engine for running animations which calculate animated values and set them on target objects.
    ///    - ObjectAnimator:	This subclass of ValueAnimator provides support for animating properties on target objects. 
    ///    - TimeAnimator:	This class provides a simple callback mechanism to listeners that is synchronized with all other animators in the system. 
    open func onCreateAnimator(_ transit: Int32, _ enter: Bool, _ nextAnim: Int32) -> Animator? { // TODO:
        return nil
    }

    /// Called when a context menu for the view is about to be shown.
    /// 
    /// Unlike `onCreateOptionsMenu`, this will be called every time the context menu is about to be shown
    /// and should be populated for the view (or item inside the view for AdapterView subclasses, this can be found in the menuInfo)).
    /// 
    /// Use `onContextItemSelected` to know when an item has been selected.
    /// 
    /// The default implementation calls up to Activity.onCreateContextMenu,
    /// though you can not call this implementation if you don't want that behavior.
    /// 
    /// It is not safe to hold onto the context menu after this method returns.
    open func onCreateContextMenu(_ menu: ContextMenu, _ v: View, _ menuInfo: ContextMenu.ContextMenuInfo?) {} // TODO
    
    /// Called to have the fragment instantiate its user interface view.
    /// 
    /// This is optional, and non-graphical fragments can return null.
    /// 
    /// This will be called between onCreate and `onViewCreated`.
    /// 
    /// A default View can be returned by calling Fragment in your constructor.
    /// 
    /// Otherwise, this method returns null.
    /// 
    /// It is recommended to only inflate the layout in this method and move logic that operates on the returned View to onViewCreated.
    /// 
    /// If you return a View from here, you will later be called in onDestroyView when the view is being released.
    open func onCreateView(
        _ inflater: LayoutInflater,
        _ container: View?,
        _ savedInstanceState: Bundle?
    ) {} // TODO

    /// Called when the fragment is no longer in use.
    /// 
    /// This is called after `onStop` and before `onDetach`.
    open func onDestroy() {} // TODO

    /// Called when the view previously created by `onCreateView` has been detached from the fragment.
    /// 
    /// The next time the fragment needs to be displayed, a new view will be created.
    /// 
    /// This is called after onStop and before `onDestroy`.
    /// 
    /// It is called regardless of whether `onCreateView` returned a non-null view.
    /// 
    /// Internally it is called after the view's state has been saved but before it has been removed from its parent.
    open func onDestroyView() {} // TODO

    /// Called when the fragment is no longer attached to its activity.
    /// 
    /// This is called after `onDestroy`.
    open func onDetach() {}

    // TODO: onGetLayoutInflater: not sure how to implement it

    /// Called when the hidden state as returned by isHidden of the fragment or another fragment in its hierarchy has changed.
    /// 
    /// Fragments start out not hidden; this will be called whenever the fragment changes state from that.
    open func onHiddenChanged(hidden: Bool) {} // TODO

    /// Called when the Fragment's activity changes from fullscreen mode to multi-window mode and visa-versa.
    /// 
    /// This is generally tied to onMultiWindowModeChanged of the containing Activity.
    open func onMultiWindowModeChanged(isInMultiWindowMode: Bool) {} // TODO

    /// Called when the Fragment is no longer resumed.
    /// 
    /// This is generally tied to Activity.onPause of the containing Activity's lifecycle.
    open func onPause() {} // TODO

    /// Called by the system when the activity changes to and from picture-in-picture mode.
    /// 
    /// This is generally tied to onPictureInPictureModeChanged of the containing Activity.
    open func onPictureInPictureModeChanged(isInPictureInPictureMode: Bool) {} // TODO

    /// Callback for when the primary navigation state of this Fragment has changed.
    /// This can be the result of the `getParentFragmentManager` containing FragmentManager}
    /// having its primary navigation fragment changed via setPrimaryNavigationFragment
    /// or due to the primary navigation fragment changing in a parent FragmentManager.
    open func onPrimaryNavigationFragmentChanged(isPrimaryNavigationFragment: Bool) {} // TODO

    /// Called when the fragment is visible to the user and actively running.
    /// 
    /// This is generally tied to Activity.onResume of the containing Activity's lifecycle.
    open func onResume() {} // TODO

    /// Called to ask the fragment to save its current dynamic state, so it can later be reconstructed in a new instance if its process is restarted.
    /// 
    /// If a new instance of the fragment later needs to be created, the data you place in the Bundle here will be available
    /// in the Bundle given to onCreate, onCreateView, and onViewCreated.
    ///
    /// This corresponds to Activity.onSaveInstanceState(Bundle) and most of the discussion there applies here as well.
    /// 
    /// Note however: this method may be called at any time before onDestroy.
    /// 
    /// There are many situations where a fragment may be mostly torn down (such as when placed on the back stack with no UI showing),
    /// but its state will not be saved until its owning activity actually needs to save its state.
    open func onSaveInstanceState(outState: Bundle) {} // TODO

    /// Called when the Fragment is visible to the user.
    /// 
    /// This is generally tied to Activity.onStart of the containing Activity's lifecycle.
    open func onStart() {} // TODO

    /// Called when the Fragment is no longer started.
    /// 
    /// This is generally tied to Activity.onStop of the containing Activity's lifecycle.
    open func onStop() {} // TODO

    /// Called immediately after onCreateView has returned, but before any saved state has been restored in to the view.
    /// 
    /// This gives subclasses a chance to initialize themselves once they know their view hierarchy has been completely created.
    /// 
    /// The fragment's view hierarchy is not however attached to its parent at this point.
    open func onViewCreated(view: View, savedInstanceState: Bundle?) {} // TODO

    /// Called when all saved state has been restored into the view hierarchy of the fragment.
    /// 
    /// This can be used to do initialization based on saved state that you are letting the view hierarchy track itself,
    /// such as whether check box widgets are currently checked.
    /// 
    /// This is called after onViewCreated and before onStart.
    open func onViewStateRestored(savedInstanceState: Bundle) {} // TODO

    /// Postpone the entering Fragment transition until startPostponedEnterTransition or executePendingTransactions has been called.
    /// 
    /// This method gives the Fragment the ability to delay Fragment animations until all data is loaded.
    /// 
    /// Until then, the added, shown, and attached Fragments will be INVISIBLE and removed, hidden,
    /// and detached Fragments won't be have their Views removed.
    /// 
    /// The transaction runs when all postponed added Fragments in the transaction have called startPostponedEnterTransition.
    /// 
    /// This method should be called before being added to the FragmentTransaction or in onCreate, onAttach, or onCreateView}.
    /// 
    /// startPostponedEnterTransition must be called to allow the Fragment to start the transitions.
    /// 
    /// When a FragmentTransaction is started that may affect a postponed FragmentTransaction,
    /// based on which containers are in their operations, the postponed FragmentTransaction will have its start triggered.
    /// 
    /// The early triggering may result in faulty or nonexistent animations in the postponed transaction.
    /// 
    /// FragmentTransactions that operate only on independent containers will not interfere with each other's postponement.
    /// 
    /// Calling postponeEnterTransition on Fragments with a null View will not postpone the transition.
    public func postponeEnterTransition() {
        object.callVoidMethod(name: "postponeEnterTransition")
    }

    // TODO: postponeEnterTransition implement with TimeUnit?
    // TODO: registerForActivityResult?

    /// Registers a context menu to be shown for the given view (multiple views can show the context menu).
    /// 
    /// This method will set the OnCreateContextMenuListener on the view to this fragment,
    /// so onCreateContextMenu will be called when it is time to show the context menu.
    public func registerForContextMenu(_ view: View) {
        guard
            let view = view.instance
        else { return }
        object.callVoidMethod(name: "registerForContextMenu", args: view.signed(as: View.className))
    }

    /// Return the FragmentActivity this fragment is currently associated with.
    public func requireActivity() -> FragmentActivity! {
        guard
            let global = object.callObjectMethod(name: "requireActivity", returning: .object(FragmentActivity.className))
        else { return nil }
        return .init(global)
    }

    /// Return the arguments supplied when the fragment was instantiated.
    public func requireArguments() -> Bundle! {
        guard
            let global = object.callObjectMethod(name: "requireArguments", returning: .object(Bundle.className))
        else { return nil }
        return .init(global)
    }

    /// Return the Context this fragment is currently associated with.
    public func requireContext() -> ActivityContext! {
        guard
            let global = object.callObjectMethod(name: "requireContext", returning: .object(.android.content.Context))
        else { return nil }
        return .init(object: global)
    }

    /// Return the host object of this fragment.
    public func requireHost() -> JObject! {
        object.callObjectMethod(name: "requireHost", returning: .object("java/lang/Object"))
    }

    /// Returns the parent Fragment containing this Fragment.
    public func requireParentFragment() -> Fragment! {
        guard
            let global = object.callObjectMethod(name: "requireParentFragment", returning: .object(Fragment.className))
        else { return nil }
        return .init(global)
    }

    /// Get the root view for the fragment's layout (the one returned by onCreateView).
    public func requireView() -> View! {
        guard
            let context = context(), // TODO: replace with instance?.context
            let global = object.callObjectMethod(name: "requireView", returning: .object(View.className))
        else { return nil }
        return .init(global, context)
    }

    /// Sets whether the the exit transition and enter transition overlap or not.
    /// 
    /// When true, the enter transition will start as soon as possible.
    /// 
    /// When false, the enter transition will wait until the exit transition completes before starting.
    public func allowEnterTransitionOverlap(_ value: Bool = true) {
        object.callVoidMethod(name: "setAllowEnterTransitionOverlap", args: value)
    }

    /// Sets whether the the return transition and reenter transition overlap or not.
    /// 
    /// When true, the reenter transition will start as soon as possible.
    /// 
    /// When false, the reenter transition will wait until the return transition completes before starting.
    public func allowReturnTransitionOverlap(_ value: Bool = true) {
        object.callVoidMethod(name: "setAllowReturnTransitionOverlap", args: value)
    }

    /// Supply the construction arguments for this fragment.
    /// 
    /// The arguments supplied here will be retained across fragment destroy and creation.
    ///
    /// This method cannot be called if the fragment is added to a FragmentManager and if isStateSaved would return true.
    public func arguments(_ args: Bundle) {
        object.callVoidMethod(name: "setArguments", args: args.signed(as: Bundle.className))
    }

    // TODO: setEnterSharedElementCallback

    /// Sets the Transition that will be used to move Views into the initial scene.
    /// 
    /// The entering Views will be those that are regular Views or ViewGroups that have isTransitionGroup return true.
    /// 
    /// Typical Transitions will extend android.transition.Visibility as entering is governed by changing visibility from INVISIBLE to VISIBLE.
    /// 
    /// If transition is null, entering Views will remain unaffected.
    public func enterTransition(_ transition: JObject?) {
        guard let transition else { return }
        object.callVoidMethod(name: "setEnterTransition", args: transition.signed(as: "java/lang/Object"))
    }

    // TODO: setExitSharedElementCallback

    /// Sets the Transition that will be used to move Views out of the scene when the fragment is removed, hidden, or detached when not popping the back stack.
    /// 
    /// The exiting Views will be those that are regular Views or ViewGroups that have isTransitionGroup return true.
    /// 
    /// Typical Transitions will extend android.transition.Visibility as exiting is governed by changing visibility from VISIBLE to INVISIBLE.
    /// 
    /// If transition is null, the views will remain unaffected.
    public func exitTransition(_ transition: JObject?) {
        guard let transition else { return }
        object.callVoidMethod(name: "setExitTransition", args: transition.signed(as: "java/lang/Object"))
    }

    // TODO: setInitialSavedState

    /// Set a hint for whether this fragment's menu should be visible.
    /// 
    /// This is useful if you know that a fragment has been placed in your view hierarchy
    /// so that the user can not currently seen it, so any menu items it has should also not be shown.
    public func menuVisibility(_ menuVisible: Bool = true) {
        object.callVoidMethod(name: "setMenuVisibility", args: menuVisible)
    }

    /// Sets the Transition that will be used to move Views in to the scene when returning due to popping a back stack.
    /// 
    /// The entering Views will be those that are regular Views or ViewGroups that have isTransitionGroup return true.
    /// 
    /// Typical Transitions will extend android.transition.Visibility as exiting is governed by changing visibility from VISIBLE to INVISIBLE.
    /// 
    /// If transition is null, the views will remain unaffected. If nothing is set, the default will be to use the same transition as getExitTransition.
    public func reenterTransition(_ transition: JObject?) {
        guard let transition else { return }
        object.callVoidMethod(name: "setReenterTransition", args: transition.signed(as: "java/lang/Object"))
    }

    /// Sets the Transition that will be used to move Views out of the scene when the Fragment is preparing to be removed, hidden, or detached because of popping the back stack.
    /// 
    /// The exiting Views will be those that are regular Views or ViewGroups that have isTransitionGroup return true.
    /// 
    /// Typical Transitions will extend android.transition.Visibility as entering is governed by changing visibility from VISIBLE to INVISIBLE.
    /// 
    /// If transition is null, entering Views will remain unaffected. If nothing is set, the default will be to use the same value as set in setEnterTransition.
    public func returnTransition(_ transition: JObject?) {
        guard let transition else { return }
        object.callVoidMethod(name: "setReturnTransition", args: transition.signed(as: "java/lang/Object"))
    }

    /// Sets the Transition that will be used for shared elements transferred into the content Scene.
    /// 
    /// Typical Transitions will affect size and location, such as android.transition.ChangeBounds.
    /// 
    /// A null value will cause transferred shared elements to blink to the final position.
    public func sharedElementEnterTransition(_ transition: JObject?) {
        guard let transition else { return }
        object.callVoidMethod(name: "setSharedElementEnterTransition", args: transition.signed(as: "java/lang/Object"))
    }

    /// Sets the Transition that will be used for shared elements transferred back during a pop of the back stack.
    /// 
    /// This Transition acts in the leaving Fragment. Typical Transitions will affect size and location, such as android.transition.ChangeBounds.
    /// 
    /// A null value will cause transferred shared elements to blink to the final position.
    /// 
    /// If no value is set, the default will be to use the same value as setSharedElementEnterTransition.
    public func sharedElementReturnTransition(_ transition: JObject?) {
        guard let transition else { return }
        object.callVoidMethod(name: "setSharedElementReturnTransition", args: transition.signed(as: "java/lang/Object"))
    }

    /// Gets whether you should show UI with rationale before requesting a permission.
    open func shouldShowRequestPermissionRationale(permission: String) -> Bool {
        return true
    }

    /// Call startActivity from the fragment's containing Activity.
    public func startActivity(_ intent: Intent) {
        object.callVoidMethod(name: "startActivity", args: intent.signed(as: Intent.className))
    }

    /// Call startActivity from the fragment's containing Activity.
    public func startActivity(_ intent: Intent, options: Bundle) {
        object.callVoidMethod(name: "startActivity", args: intent.signed(as: Intent.className), options.signed(as: Bundle.className))
    }

    /// Begin postponed transitions after postponeEnterTransition was called.
    /// 
    /// If postponeEnterTransition() was called, you must call startPostponedEnterTransition()
    /// or executePendingTransactions to complete the FragmentTransaction.
    /// 
    /// If postponement was interrupted with executePendingTransactions,
    /// before startPostponedEnterTransition(), animations may not run or may execute improperly.
    public func startPostponedEnterTransition() {
        object.callVoidMethod(name: "startPostponedEnterTransition")
    }

    /// Prevents a context menu to be shown for the given view.
    /// 
    /// This method will remove the `OnCreateContextMenuListener` on the view.
    public func unregisterForContextMenu(_ view: View) {
        guard
            let view = view.instance
        else { return }
        object.callVoidMethod(name: "unregisterForContextMenu", args: view.signed(as: View.className))
    }
}

extension Fragment {
    /// Return the `FragmentActivity` this fragment is currently associated with.
    /// 
    /// May return null if the fragment is associated with a `Context` instead.
    public func activity() -> FragmentActivity? {
        guard
            let global = object.callObjectMethod(name: "getActivity", returning: .object(FragmentActivity.className))
        else { return nil }
        return .init(global)
    }

    /// Returns whether the the exit transition and enter transition overlap or not.
    /// 
    /// When true, the enter transition will start as soon as possible.
    ///
    /// When false, the enter transition will wait until the exit transition completes before starting.
    public func allowEnterTransitionOverlap() -> Bool {
        object.callBoolMethod(name: "getAllowEnterTransitionOverlap") ?? false
    }

    /// Returns whether the the return transition and reenter transition overlap or not.
    /// 
    /// When true, the reenter transition will start as soon as possible.
    /// 
    /// When false, the reenter transition will wait until the return transition completes before starting.
    public func allowReturnTransitionOverlap() -> Bool {
        object.callBoolMethod(name: "getAllowReturnTransitionOverlap") ?? false
    }

    /// Return the arguments supplied when the fragment was instantiated, if any.
    public func arguments() -> Bundle? {
        guard
            let global = object.callObjectMethod(name: "getArguments", returning: .object(Bundle.className))
        else { return nil }
        return .init(global)
    }

    /// Return a private FragmentManager for placing and managing Fragments inside of this Fragment.
    public func childFragmentManager() -> FragmentManager! {
        guard
            let global = object.callObjectMethod(name: "getChildFragmentManager", returning: .object(FragmentManager.className))
        else { return nil }
        return .init(global)
    }

    /// Return the `Context` this fragment is currently associated with.
    public func context() -> ActivityContext? {
        guard
            let global = object.callObjectMethod(name: "getContext", returning: .object("android/content/Context"))
        else { return nil }
        return .init(object: global)
    }

    // TODO: getDefaultViewModelCreationExtras
    // TODO: getDefaultViewModelProviderFactory
    
    /// Returns the Transition that will be used to move Views into the initial scene.
    public func enterTransition() -> JObject? {
        object.callObjectMethod(name: "getEnterTransition", returning: .object("java/lang/Object"))
    }

    /// Returns the Transition that will be used to move Views out of the scene when the fragment is removed, hidden, or detached when not popping the back stack.
    public func exitTransition() -> JObject? {
        object.callObjectMethod(name: "getExitTransition", returning: .object("java/lang/Object"))
    }
    
    /// Return the host object of this fragment.
    /// 
    /// May return null if the fragment isn't currently being hosted.
    public func host() -> JObject? {
        object.callObjectMethod(name: "getHost", returning: .object("java/lang/Object"))
    }
    
    /// Return the identifier this fragment is known by.
    /// 
    /// This is either the `android:id` value supplied in a layout or the container view ID supplied when adding the fragment.
    public func id() -> Int32? {
        object.callIntMethod(name: "getId")
    }

    // TODO: getLayoutInflater
    // TODO: getLifecycle

    /// Returns the parent Fragment containing this Fragment.
    /// 
    /// If this Fragment is attached directly to an Activity, returns null.
    public func parentFragment() -> Fragment? {
        guard
            let global = object.callObjectMethod(name: "getParentFragment", returning: .object(Fragment.className))
        else { return nil }
        return .init(global)
    }

    /// Return the FragmentManager for interacting with fragments associated with this fragment's activity.
    /// 
    /// Note that this will be available slightly before getActivity, during the time from when the fragment is placed in a FragmentTransaction until it is committed and attached to its activity.
    /// 
    /// If this Fragment is a child of another Fragment, the FragmentManager returned here will be the parent's getChildFragmentManager.
    public func parentFragmentManager() -> FragmentManager! {
        guard
            let global = object.callObjectMethod(name: "getParentFragmentManager", returning: .object(FragmentManager.className))
        else { return nil }
        return .init(global)
    }

    /// Returns the Transition that will be used to move Views in to the scene when returning due to popping a back stack.
    public func reenterTransition() -> JObject? {
        object.callObjectMethod(name: "getReenterTransition", returning: .object("java/lang/Object"))
    }

    // TODO: getResources

    /// Returns the Transition that will be used to move Views out of the scene when the Fragment is preparing to be removed, hidden, or detached because of popping the back stack.
    public func returnTransition() -> JObject? {
        object.callObjectMethod(name: "getReturnTransition", returning: .object("java/lang/Object"))
    }

    // TODO: getSavedStateRegistry

    /// Returns the Transition that will be used for shared elements transferred into the content Scene.
    public func sharedElementEnterTransition() -> JObject? {
        object.callObjectMethod(name: "getSharedElementEnterTransition", returning: .object("java/lang/Object"))
    }

    /// Return the Transition that will be used for shared elements transferred back during a pop of the back stack.
    public func sharedElementReturnTransition() -> JObject? {
        object.callObjectMethod(name: "getSharedElementReturnTransition", returning: .object("java/lang/Object"))
    }

    /// Return a localized string from the application's package's default string table.
    public func string(_ resId: Int32) -> String! {
        guard
            let obj = object.callObjectMethod(name: "getString", args: resId, returning: .object(JString.className))
        else { return nil }
        return JString(obj).toString()
    }

    /// Get the tag name of the fragment, if specified.
    public func tag() -> String? {
        guard
            let obj = object.callObjectMethod(name: "getTag", returning: .object(JString.className))
        else { return nil }
        return JString(obj).toString()
    }

    /// Return a localized, styled `CharSequence` from the application's package's default string table.
    public func text(_ resId: Int32) -> String? {
        guard
            let obj = object.callObjectMethod(name: "getText", args: resId, returning: .object(JString.charSequenseClassName))
        else { return nil }
        return JString(obj).toString()
    }

    public func view() -> View? {
        guard
            let global = object.callObjectMethod(name: "getView", returning: .object(View.className)),
            let context = context()
        else { return nil }
        let id = global.callIntMethod(name: "getId")
        return .init(id: id, global, context)
    }

    // TODO: getViewLifecycleOwner
    // TODO: getViewLifecycleOwnerLiveData

    /// Return true if the fragment is currently added to its activity.
    public func isAdded() -> Bool {
        object.callBoolMethod(name: "isAdded") ?? false
    }

    /// Return true if the fragment has been explicitly detached from the UI.
    /// That is, `FragmentTransaction.detach(Fragment)` has been used on it.
    public func isDetached() -> Bool {
        object.callBoolMethod(name: "isDetached") ?? false
    }

    /// Return true if the fragment has been hidden.
    /// 
    /// This includes the case if the fragment is hidden because its parent is hidden.
    /// By default fragments are shown. You can find out about changes to this state with `onHiddenChanged`.
    /// Note that the hidden state is orthogonal to other states – that is, to be visible to the user, a fragment must be both started and not hidden.
    public func isHidden() -> Bool {
        object.callBoolMethod(name: "isHidden") ?? false
    }

    /// Return true if the layout is included as part of an activity view hierarchy via the tag.
    ///
    /// This will always be true when fragments are created through the tag,
    /// except in the case where an old fragment is restored from a previous state and it does not appear in the layout of the current state.
    public func isInLayout() -> Bool {
        object.callBoolMethod(name: "isInLayout") ?? false
    }

    /// Return true if this fragment is currently being removed from its activity.
    /// This is not whether its activity is finishing, but rather whether it is in the process of being removed from its activity.
    public func isRemoving() -> Bool {
        object.callBoolMethod(name: "isRemoving") ?? false
    }

    /// Return true if the fragment is in the resumed state.
    /// This is true for the duration of `onResume` and `onPause` as well.
    public func isResumed() -> Bool {
        object.callBoolMethod(name: "isResumed") ?? false
    }

    /// Returns true if this fragment is added and its state has already been saved by its host.
    /// Any operations that would change saved state should not be performed if this method returns true,
    /// and some operations such as setArguments will fail.
    public func isStateSaved() -> Bool {
        object.callBoolMethod(name: "isStateSaved") ?? false
    }

    /// Return true if the fragment is currently visible to the user.
    /// 
    /// This means it: (1) has been added, (2) has its view attached to the window, and (3) is not hidden.
    public func isVisible() -> Bool {
        object.callBoolMethod(name: "isVisible") ?? false
    }

    // TODO: 
    // TODO:
    // TODO:

}