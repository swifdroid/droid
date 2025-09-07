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
open class Fragment: NativeFragment, @unchecked Sendable {
    /// The JNI class name
    public static let className: JClassName = "androidx/fragment/app/Fragment"

    var contentBlock: BodyBuilder.SingleView?

    /// Sets the content view for this fragment.
    @discardableResult
    public func body(@BodyBuilder block: @escaping BodyBuilder.SingleView) -> Self {
        contentBlock = block
        return self
    }

    /// Builds the UI for this fragment.
    open func buildUI() {}

    /// The content view for this fragment.
    var contentView: View?

    open override func onCreateView(_ inflater: LayoutInflater, _ container: View?, _ savedInstanceState: Bundle?) -> View? {
        buildUI()
        func returnPlaceholder() -> View {
            let contentView = TextView("Empty Fragment Content").gravity(.center)
            if let container {
                contentView.setStatusInParent(container, context)
            } else {
                contentView.setStatusAsContentView(context)
            }
            contentView.willMoveToParent()
            return contentView
        }
        guard let contentBlock else {
            return returnPlaceholder()
        }
        let item = contentBlock().bodyBuilderItem
        func setDefaultFrameLayout(_ item: BodyBuilderItem) {
            let view = FrameLayout()
            view.addItem(item)
            contentView = view
        }
        func proceedItem(_ item: BodyBuilderItem) {
            switch item {
            case .single(let view):
                contentView = view
            case .multiple(let views):
                if views.count == 1, let view = views.first {
                    contentView = view
                } else {
                    setDefaultFrameLayout(item)
                }
            case .nested(let items):
                if items.count == 1, let item = items.first {
                    proceedItem(item.bodyBuilderItem)
                } else {
                    setDefaultFrameLayout(item)
                }
            case .forEach:
                setDefaultFrameLayout(item)
            case .none:
                setDefaultFrameLayout(item)
            }
        }
        proceedItem(item)
        guard let contentView else {
            return returnPlaceholder()
        }
        if let container {
            contentView.setStatusInParent(container, context)
        } else {
            contentView.setStatusAsContentView(context)
        }
        contentView.willMoveToParent()
        return contentView
    }

    open override func onViewCreated(view: View, savedInstanceState: Bundle?) {
        if let contentView, let instance = contentView.instance {
            if let lp = instance.layoutParams() {
                contentView.processLayoutParams(instance, lp, for: contentView)
                contentView.layoutParams(lp)
            }
            contentView.didMoveToParent()
        }
    }

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
            let returningClazz = JClass.load(FragmentActivity.className),
            let global = object.callObjectMethod(name: "requireActivity", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Return the arguments supplied when the fragment was instantiated.
    public func requireArguments() -> Bundle! {
        guard
            let returningClazz = JClass.load(Bundle.className),
            let global = object.callObjectMethod(name: "requireArguments", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Return the Context this fragment is currently associated with.
    public func requireContext() -> ActivityContext! {
        guard
            let returningClazz = JClass.load(.android.content.Context),
            let global = object.callObjectMethod(name: "requireContext", returningClass: returningClazz)
        else { return nil }
        return .init(object: global)
    }

    /// Return the host object of this fragment.
    public func requireHost() -> JObject! {
        guard
            let returningClazz = JClass.load("java/lang/Object")
        else { return nil }
        return object.callObjectMethod(name: "requireHost", returningClass: returningClazz)
    }

    /// Returns the parent Fragment containing this Fragment.
    public func requireParentFragment() -> Fragment! {
        guard
            let returningClazz = JClass.load(Fragment.className),
            let global = object.callObjectMethod(name: "requireParentFragment", returningClass: returningClazz)
        else { return nil }
        return .init(global, self)
    }

    /// Get the root view for the fragment's layout (the one returned by onCreateView).
    public func requireView() -> View! {
        guard
            let returningClazz = JClass.load(View.className),
            let global = object.callObjectMethod(name: "requireView", returningClass: returningClazz)
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
            let returningClazz = JClass.load(FragmentActivity.className),
            let global = object.callObjectMethod(name: "getActivity", returningClass: returningClazz)
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
            let returningClazz = JClass.load(Bundle.className),
            let global = object.callObjectMethod(name: "getArguments", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Return a private FragmentManager for placing and managing Fragments inside of this Fragment.
    public func childFragmentManager() -> FragmentManager! {
        guard
            let returningClazz = JClass.load(FragmentManager.className),
            let global = object.callObjectMethod(name: "getChildFragmentManager", returningClass: returningClazz)
        else { return nil }
        return .init(global, self)
    }

    /// Return the `Context` this fragment is currently associated with.
    public func context() -> ActivityContext? {
        guard
            let returningClazz = JClass.load("android/content/Context"),
            let global = object.callObjectMethod(name: "getContext", returningClass: returningClazz)
        else { return nil }
        return .init(object: global)
    }

    // TODO: getDefaultViewModelCreationExtras
    // TODO: getDefaultViewModelProviderFactory
    
    /// Returns the Transition that will be used to move Views into the initial scene.
    public func enterTransition() -> JObject? {
        guard
            let returningClazz = JClass.load("java/lang/Object")
        else { return nil }
        return object.callObjectMethod(name: "getEnterTransition", returningClass: returningClazz)
    }

    /// Returns the Transition that will be used to move Views out of the scene when the fragment is removed, hidden, or detached when not popping the back stack.
    public func exitTransition() -> JObject? {
        guard
            let returningClazz = JClass.load("java/lang/Object")
        else { return nil }
        return object.callObjectMethod(name: "getExitTransition", returningClass: returningClazz)
    }
    
    /// Return the host object of this fragment.
    /// 
    /// May return null if the fragment isn't currently being hosted.
    public func host() -> JObject? {
        guard
            let returningClazz = JClass.load("java/lang/Object")
        else { return nil }
        return object.callObjectMethod(name: "getHost", returningClass: returningClazz)
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
            let returningClazz = JClass.load(Fragment.className),
            let global = object.callObjectMethod(name: "getParentFragment", returningClass: returningClazz)
        else { return nil }
        return .init(global, self)
    }

    /// Return the FragmentManager for interacting with fragments associated with this fragment's activity.
    /// 
    /// Note that this will be available slightly before getActivity, during the time from when the fragment is placed in a FragmentTransaction until it is committed and attached to its activity.
    /// 
    /// If this Fragment is a child of another Fragment, the FragmentManager returned here will be the parent's getChildFragmentManager.
    public func parentFragmentManager() -> FragmentManager! {
        guard
            let returningClazz = JClass.load(Fragment.className),
            let global = object.callObjectMethod(name: "getParentFragmentManager", returningClass: returningClazz)
        else { return nil }
        return .init(global, self)
    }

    /// Returns the Transition that will be used to move Views in to the scene when returning due to popping a back stack.
    public func reenterTransition() -> JObject? {
        guard
            let returningClazz = JClass.load("java/lang/Object")
        else { return nil }
        return object.callObjectMethod(name: "getReenterTransition", returningClass: returningClazz)
    }

    // TODO: getResources

    /// Returns the Transition that will be used to move Views out of the scene when the Fragment is preparing to be removed, hidden, or detached because of popping the back stack.
    public func returnTransition() -> JObject? {
        guard
            let returningClazz = JClass.load("java/lang/Object")
        else { return nil }
        return object.callObjectMethod(name: "getReturnTransition", returningClass: returningClazz)
    }

    // TODO: getSavedStateRegistry

    /// Returns the Transition that will be used for shared elements transferred into the content Scene.
    public func sharedElementEnterTransition() -> JObject? {
        guard
            let returningClazz = JClass.load("java/lang/Object")
        else { return nil }
        return object.callObjectMethod(name: "getSharedElementEnterTransition", returningClass: returningClazz)
    }

    /// Return the Transition that will be used for shared elements transferred back during a pop of the back stack.
    public func sharedElementReturnTransition() -> JObject? {
        guard
            let returningClazz = JClass.load("java/lang/Object")
        else { return nil }
        return object.callObjectMethod(name: "getSharedElementReturnTransition", returningClass: returningClazz)
    }

    /// Return a localized string from the application's package's default string table.
    public func string(_ resId: Int32) -> String! {
        guard
            let returningClazz = JClass.load(JString.className),
            let obj = object.callObjectMethod(name: "getString", args: resId, returningClass: returningClazz)
        else { return nil }
        return JString(obj).toString()
    }

    /// Get the tag name of the fragment, if specified.
    public func tag() -> String? {
        guard
            let returningClazz = JClass.load(JString.className),
            let obj = object.callObjectMethod(name: "getTag", returningClass: returningClazz)
        else { return nil }
        return JString(obj).toString()
    }

    /// Return a localized, styled `CharSequence` from the application's package's default string table.
    public func text(_ resId: Int32) -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let obj = object.callObjectMethod(name: "getText", args: resId, returningClass: returningClazz)
        else { return nil }
        return JString(obj).toString()
    }

    public func view() -> View? {
        guard
            let returningClazz = JClass.load(View.className),
            let global = object.callObjectMethod(name: "getView", returningClass: returningClazz)
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