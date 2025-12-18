//
//  NativeFragment.swift
//  
//
//  Created by Mihael Isaev on 29.01.2022.
//

#if os(Android)
import Android
#endif

open class NativeFragment: NativeUIObject, AnyNativeObject, Contextable {
    /// The JNI class name
    class nonisolated var nativeObjectClassName: JClassName { "stream/swift/droid/appkit/views/NativeFragment" }
    class nonisolated var nativeNavHostFragmentObjectClassName: JClassName { "stream/swift/droid/appkit/views/NativeNavHostFragment" }

    public private(set) var context: ActivityContext?

    public required init(_ object: JObject) {
        super.init(object)
    }

    public init! () {
        guard let env = JEnv.current() else { return nil }
        super.init(env, Self.nativeObjectClassName, .static)
    }

    public convenience init? (_ className: JClassName) {
        guard let env = JEnv.current() else { return nil }
        self.init(env, Self.nativeObjectClassName, .static)
    }

    public override init? (_ env: JEnv, _ className: JClassName, _ initializer: Initializer = .normal) {
        super.init(env, className, .static)
    }

    /// Called when a fragment is first attached to its context. `onCreate` will be called after this.
    open func onAttach(_ context: Contextable) {
        self.context = context.context
        InnerLog.t("NativeFragment onAttach context: \(String(describing: self.context))")
    }
    
    // TODO: onConfigurationChanged -> use DroidApp's configuration change event instead
    
    /// This hook is called whenever an item in a context menu is selected.
    /// The default implementation simply returns false to have the normal processing happen
    /// (calling the item's Runnable or sending a message to its Handler as appropriate).
    /// You can use this method for any items for which you would like to do processing without those other facilities.
    ///
    /// Use getMenuInfo to get extra information set by the View that added this menu item.
    ///
    /// Derived classes should call through to the base class for it to perform the default menu handling.
    open func onContextItemSelected(_ item: MenuItem) -> Bool {
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
    open func onCreate(_ savedInstanceState: Bundle?) {}

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
    open func onCreateAnimation(_ transit: Int32, _ enter: Bool, _ nextAnim: Int32) -> Animation? {
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
    open func onCreateAnimator(_ transit: Int32, _ enter: Bool, _ nextAnim: Int32) -> Animator? {
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
    open func onCreateContextMenu(_ menu: ContextMenu, _ v: View, _ menuInfo: ContextMenu.ContextMenuInfo?) {}
    
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
    ) -> View? {
        return nil
    }

    /// Called when the fragment is no longer in use.
    /// 
    /// This is called after `onStop` and before `onDetach`.
    open func onDestroy() {}

    /// Called when the view previously created by `onCreateView` has been detached from the fragment.
    /// 
    /// The next time the fragment needs to be displayed, a new view will be created.
    /// 
    /// This is called after onStop and before `onDestroy`.
    /// 
    /// It is called regardless of whether `onCreateView` returned a non-null view.
    /// 
    /// Internally it is called after the view's state has been saved but before it has been removed from its parent.
    open func onDestroyView() {}

    /// Called when the fragment is no longer attached to its activity.
    /// 
    /// This is called after `onDestroy`.
    open func onDetach() {
        self.context = nil
    }

    // TODO: onGetLayoutInflater: not sure how to implement it and if we should to

    /// Called when the hidden state as returned by isHidden of the fragment or another fragment in its hierarchy has changed.
    /// 
    /// Fragments start out not hidden; this will be called whenever the fragment changes state from that.
    open func onHiddenChanged(hidden: Bool) {}

    /// Called when the Fragment's activity changes from fullscreen mode to multi-window mode and visa-versa.
    /// 
    /// This is generally tied to onMultiWindowModeChanged of the containing Activity.
    open func onMultiWindowModeChanged(isInMultiWindowMode: Bool) {}

    /// Called when the Fragment is no longer resumed.
    /// 
    /// This is generally tied to Activity.onPause of the containing Activity's lifecycle.
    open func onPause() {}

    /// Called by the system when the activity changes to and from picture-in-picture mode.
    /// 
    /// This is generally tied to onPictureInPictureModeChanged of the containing Activity.
    open func onPictureInPictureModeChanged(isInPictureInPictureMode: Bool) {}

    /// Callback for when the primary navigation state of this Fragment has changed.
    /// This can be the result of the `getParentFragmentManager` containing FragmentManager}
    /// having its primary navigation fragment changed via setPrimaryNavigationFragment
    /// or due to the primary navigation fragment changing in a parent FragmentManager.
    open func onPrimaryNavigationFragmentChanged(isPrimaryNavigationFragment: Bool) {}

    /// Called when the fragment is visible to the user and actively running.
    /// 
    /// This is generally tied to Activity.onResume of the containing Activity's lifecycle.
    open func onResume() {}

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
    open func onSaveInstanceState(outState: Bundle) {}

    /// Called when the Fragment is visible to the user.
    /// 
    /// This is generally tied to Activity.onStart of the containing Activity's lifecycle.
    open func onStart() {}

    /// Called when the Fragment is no longer started.
    /// 
    /// This is generally tied to Activity.onStop of the containing Activity's lifecycle.
    open func onStop() {}

    /// Called immediately after onCreateView has returned, but before any saved state has been restored in to the view.
    /// 
    /// This gives subclasses a chance to initialize themselves once they know their view hierarchy has been completely created.
    /// 
    /// The fragment's view hierarchy is not however attached to its parent at this point.
    open func onViewCreated(view: View, savedInstanceState: Bundle?) {}

    /// Called when all saved state has been restored into the view hierarchy of the fragment.
    /// 
    /// This can be used to do initialization based on saved state that you are letting the view hierarchy track itself,
    /// such as whether check box widgets are currently checked.
    /// 
    /// This is called after onViewCreated and before onStart.
    open func onViewStateRestored(savedInstanceState: Bundle?) {}
}

// MARK: - NativeFragment

#if os(Android)
@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onInit")
public func nativeFragmentOnInit(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, fragmentObject: jobject, classNameObject: jstring) {
    InnerLog.t("🩵 nativeFragmentOnInit")
    guard
        let global = fragmentObject.box(JEnv(env))?.object(),
        let className = JString(from: classNameObject)?.string()
    else {
        InnerLog.c("🟥 nativeFragmentOnInit unable to unwrap Fragment")
        return
    }
    MainActor.assumeIsolated {
        guard let fragmentType = DroidApp.shared._fragments.first(where: { $0.nativeFragmentClassName.fullName == className }) else {
            InnerLog.c("🟥 nativeFragmentOnInit unable to find Fragment class: \(className)")
            return
        }
        let fragment = fragmentType.init(global)
        fragment.addIntoStore()
        fragment.callVoidMethod(name: "assignId", args: fragment.id)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onAttach")
public func nativeFragmentOnAttach(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, context: jobject) {
    InnerLog.t("🩵 nativeFragmentOnAttach(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnAttach(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    if let object = context.box(JEnv(env))?.object() {
        MainActor.assumeIsolated {
            let context = ActivityContext(object: object)
            fragment.onAttach(context)
        }
    } else {
        InnerLog.c("🟥 nativeFragmentOnAttach(id: \(uniqueId)) unable to unwrap Context")
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onContextItemSelected")
public func nativeFragmentOnContextItemSelected(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, item: jobject) -> jboolean {
    InnerLog.t("🩵 nativeFragmentOnContextItemSelected(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnContextItemSelected(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return 0
    }
    guard let object = item.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnContextItemSelected(id: \(uniqueId)) unable to unwrap MenuItem")
        return 0
    }
    let result = MainActor.assumeIsolated {
        let item = MenuItem(object)
        return fragment.onContextItemSelected(item)
    }
    return result ? 1 : 0
}

private func _fragmentOnCreate(_ env: JEnv, _ fragmentId: Int32, _ bundle: Bundle?) -> (NativeFragment, Bundle?)? {
    if let saved = DroidApp.shared._savedFragments[fragmentId] {
        InnerLog.t("🩵 _fragmentOnCreate(id: \(fragmentId)) → saved block")
        let (fragment, savedInstanceState) = saved
        MainActor.assumeIsolated {
            #if os(Android)
            if let _: NativeFragment = ObjectStore.shared.find(id: fragmentId) {} else {
                fragment.addIntoStore()
            }
            DroidApp.shared._savedFragments.removeValue(forKey: fragmentId)
            fragment.onCreate(bundle ?? savedInstanceState)
            #endif
        }
        return (fragment, bundle ?? savedInstanceState)
    } else if let fragment: NativeFragment = ObjectStore.shared.find(id: fragmentId) {
        InnerLog.t("🩵 _fragmentOnCreate(id: \(fragmentId)) → existing block")
        return (fragment, bundle)
    } else {
        InnerLog.c("🟥 _fragmentOnCreate(id: \(fragmentId)) → else block: unable to find fragment, it was never initialized")
        return nil
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onCreate")
public func nativeFragmentOnCreate(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    InnerLog.t("🩵 nativeFragmentOnCreate(id: \(uniqueId))")
    if let (fragment, bundle) = _fragmentOnCreate(JEnv(env), uniqueId, nil) {
        MainActor.assumeIsolated {
            fragment.onCreate(bundle)
        }
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onCreateSavedInstanceState")
public func nativeFragmentOnCreateSavedInstanceState(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, savedInstanceState: jobject) {
    InnerLog.t("🩵 nativeFragmentOnCreateSavedInstanceState(id: \(uniqueId))")
    if let object = savedInstanceState.box(JEnv(env))?.object() {
        let bundle = Bundle(object)
        if let (fragment, bundle) = _fragmentOnCreate(JEnv(env), uniqueId, bundle) {
        MainActor.assumeIsolated {
            fragment.onCreate(bundle)
        }
    }
    } else {
        InnerLog.c("🟥 nativeFragmentOnCreate(id: \(uniqueId)) unable to unwrap Bundle")
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onCreateAnimation")
public func nativeFragmentOnCreateAnimation(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, transit: jint, enter: jboolean, nextAnim: jint) -> jobject? {
    InnerLog.t("🩵 nativeFragmentOnCreateAnimation(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnCreateAnimation(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return nil
    }
    let result = MainActor.assumeIsolated {
        return fragment.onCreateAnimator(transit, enter == 1, nextAnim)?.object.ref
    }
    return result?.ref
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onCreateAnimator")
public func nativeFragmentOnCreateAnimator(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, transit: jint, enter: jboolean, nextAnim: jint) -> jobject? {
    InnerLog.t("🩵 nativeFragmentOnCreateAnimator(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnCreateAnimator(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return nil
    }
    let result = MainActor.assumeIsolated {
        return fragment.onCreateAnimator(transit, enter == 1, nextAnim)?.object.ref
    }
    return result?.ref
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onCreateContextMenu")
public func nativeFragmentOnCreateContextMenu(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, menu: jobject, view: jobject) {
    InnerLog.t("🩵 nativeFragmentOnCreateContextMenu(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnCreateContextMenu(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    guard let menuObject = menu.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnCreateContextMenu(id: \(uniqueId)) unable to unwrap ContextMenu")
        return
    }
    guard let viewObject = view.box(JEnv(env))?.object(), let context = viewObject.context() else {
        InnerLog.c("🟥 nativeFragmentOnCreateContextMenu(id: \(uniqueId)) unable to unwrap View")
        return
    }
    MainActor.assumeIsolated {
        let activityContext = ActivityContext(object: context)
        let menu = ContextMenu(menuObject)
        let view = View(viewObject, { activityContext })
        fragment.onCreateContextMenu(menu, view, nil)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onCreateContextMenuWithInfo")
public func nativeFragmentOnCreateContextMenuWithInfo(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, menu: jobject, view: jobject, info: jobject) {
    InnerLog.t("🩵 nativeFragmentOnCreateContextMenuWithInfo(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnCreateContextMenuWithInfo(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    guard let menuObject = menu.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnCreateContextMenuWithInfo(id: \(uniqueId)) unable to unwrap ContextMenu")
        return
    }
    guard let viewObject = view.box(JEnv(env))?.object(), let context = viewObject.context() else {
        InnerLog.c("🟥 nativeFragmentOnCreateContextMenuWithInfo    (id: \(uniqueId)) unable to unwrap View")
        return
    }
    guard let infoObject = info.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnCreateContextMenuWithInfo(id: \(uniqueId)) unable to unwrap ContextMenu.Contextnfo")
        return
    }
    MainActor.assumeIsolated {
        let activityContext = ActivityContext(object: context)
        let menu = ContextMenu(menuObject)
        let view = View(viewObject, { activityContext })
        let info = ContextMenu.ContextMenuInfo(infoObject)
        fragment.onCreateContextMenu(menu, view, info)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onCreateView")
public func nativeFragmentOnCreateView(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, inflater: jobject) -> jobject? {
    InnerLog.t("🩵 nativeFragmentOnCreateView(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnCreateView(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return nil
    }
    guard let inflaterObject = inflater.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnCreateView(id: \(uniqueId)) unable to unwrap LayoutInflater")
        return nil
    }
    let result = MainActor.assumeIsolated {
        let inflater = LayoutInflater(inflaterObject)
        return fragment.onCreateView(inflater, nil, nil)?.instance?.object.ref
    }
    return result?.ref
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onCreateViewContainer")
public func nativeFragmentOnCreateViewContainer(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, inflater: jobject, container: jobject) -> jobject? {
    InnerLog.t("🩵 nativeFragmentOnCreateViewContainer(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnCreateViewContainer(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return nil
    }
    guard let inflaterObject = inflater.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnCreateViewContainer(id: \(uniqueId)) unable to unwrap LayoutInflater")
        return nil
    }
    guard let containerObject = container.box(JEnv(env))?.object(), let context = containerObject.context() else {
        InnerLog.c("🟥 nativeFragmentOnCreateViewContainer(id: \(uniqueId)) unable to unwrap ViewGroup")
        return nil
    }
    let result = MainActor.assumeIsolated {
        let activityContext = ActivityContext(object: context)
        let inflater = LayoutInflater(inflaterObject)
        let container = ViewGroup(containerObject, { activityContext })
        return fragment.onCreateView(inflater, container, nil)?.instance?.object.ref
    }
    return result?.ref
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onCreateViewSavedInstanceState")
public func nativeFragmentOnCreateViewSavedInstanceState(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, inflater: jobject, savedInstanceState: jobject) -> jobject? {
    InnerLog.t("🩵 nativeFragmentOnCreateViewSavedInstanceState(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnCreateViewSavedInstanceState(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return nil
    }
    guard let inflaterObject = inflater.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnCreateViewSavedInstanceState(id: \(uniqueId)) unable to unwrap LayoutInflater")
        return nil
    }
    guard let savedInstanceStateObject = savedInstanceState.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnCreateViewSavedInstanceState(id: \(uniqueId)) unable to unwrap Bundle")
        return nil
    }
    let result = MainActor.assumeIsolated {
        let inflater = LayoutInflater(inflaterObject)
        let savedInstanceState = Bundle(savedInstanceStateObject)
        return fragment.onCreateView(inflater, nil, savedInstanceState)?.instance?.object.ref
    }
    return result?.ref
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onCreateViewContainerSavedInstanceState")
public func nativeFragmentOnCreateViewContainerSavedInstanceState(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, inflater: jobject, container: jobject, savedInstanceState: jobject) -> jobject? {
    InnerLog.t("🩵 nativeFragmentOnCreateViewContainerSavedInstanceState")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnCreateViewContainerSavedInstanceState(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return nil
    }
    guard let inflaterObject = inflater.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnCreateViewContainerSavedInstanceState(id: \(uniqueId)) unable to unwrap LayoutInflater")
        return nil
    }
    guard let containerObject = container.box(JEnv(env))?.object(), let context = containerObject.context() else {
        InnerLog.c("🟥 nativeFragmentOnCreateViewContainerSavedInstanceState(id: \(uniqueId)) unable to unwrap ViewGroup")
        return nil
    }
    guard let savedInstanceStateObject = savedInstanceState.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnCreateViewContainerSavedInstanceState(id: \(uniqueId)) unable to unwrap Bundle")
        return nil
    }
    let result = MainActor.assumeIsolated {
        let activityContext = ActivityContext(object: context)
        let inflater = LayoutInflater(inflaterObject)
        let container = ViewGroup(containerObject, { activityContext })
        let savedInstanceState = Bundle(savedInstanceStateObject)
        return fragment.onCreateView(inflater, container, savedInstanceState)?.instance?.object.ref
    }
    return result?.ref
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onDestroy")
public func nativeFragmentOnDestroy(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    InnerLog.t("🩵 nativeFragmentOnDestroy(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnDestroy(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    MainActor.assumeIsolated {
        fragment.onDestroy()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onDestroyView")
public func nativeFragmentOnDestroyView(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    InnerLog.t("🩵 nativeFragmentOnDestroyView(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnDestroyView(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    MainActor.assumeIsolated {
        fragment.onDestroyView()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onDetach")
public func nativeFragmentOnDetach(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    InnerLog.t("🩵 nativeFragmentOnDetach(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnDetach(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    MainActor.assumeIsolated {
        fragment.onDetach()
    }
    ObjectStore.shared.remove(fragment)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onHiddenChanged")
public func nativeFragmentOnHiddenChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, hidden: jboolean) {
    InnerLog.t("🩵 nativeFragmentOnHiddenChanged(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnHiddenChanged(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    let hidden = hidden == 1
    MainActor.assumeIsolated {
        fragment.onHiddenChanged(hidden: hidden)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onMultiWindowModeChanged")
public func nativeFragmentOnMultiWindowModeChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, isInMultiWindowMode: jboolean) {
    InnerLog.t("🩵 nativeFragmentOnMultiWindowModeChanged(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnMultiWindowModeChanged(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    let isInMultiWindowMode = isInMultiWindowMode == 1
    MainActor.assumeIsolated {
        fragment.onMultiWindowModeChanged(isInMultiWindowMode: isInMultiWindowMode)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onPause")
public func nativeFragmentOnPause(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    InnerLog.t("🩵 nativeFragmentOnPause(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnPause(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    MainActor.assumeIsolated {
        fragment.onPause()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onPictureInPictureModeChanged")
public func nativeFragmentOnPictureInPictureModeChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, isInPictureInPictureMode: jboolean) {
    InnerLog.t("🩵 nativeFragmentOnPictureInPictureModeChanged(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnPictureInPictureModeChanged(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    let isInPictureInPictureMode = isInPictureInPictureMode == 1
    MainActor.assumeIsolated {
        fragment.onPictureInPictureModeChanged(isInPictureInPictureMode: isInPictureInPictureMode)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onPrimaryNavigationFragmentChanged")
public func nativeFragmentOnPrimaryNavigationFragmentChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, isPrimaryNavigationFragment: jboolean) {
    InnerLog.t("🩵 nativeFragmentOnPrimaryNavigationFragmentChanged(id: \(uniqueId))")
    let isPrimaryNavigationFragment = isPrimaryNavigationFragment == 1
    if let (fragment, _) = _fragmentOnCreate(JEnv(env), uniqueId, nil) {
        MainActor.assumeIsolated {
            fragment.onPrimaryNavigationFragmentChanged(isPrimaryNavigationFragment: isPrimaryNavigationFragment)
        }
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onResume")
public func nativeFragmentOnResume(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    InnerLog.t("🩵 nativeFragmentOnResume(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnResume(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    MainActor.assumeIsolated {
        fragment.onResume()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onSaveInstanceState")
public func nativeFragmentOnSaveInstanceState(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, savedInstanceState: jobject) {
    InnerLog.t("🩵 nativeFragmentOnSaveInstanceState(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnSaveInstanceState(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    guard let bundleObject = savedInstanceState.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnSaveInstanceState(id: \(uniqueId)) unable to unwrap Bundle")
        return
    }
    let bundle = Bundle(bundleObject)
    MainActor.assumeIsolated {
        fragment.onSaveInstanceState(outState: bundle)
        DroidApp.shared._savedFragments[uniqueId] = (fragment, bundle)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onStart")
public func nativeFragmentOnStart(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    InnerLog.t("🩵 nativeFragmentOnStart(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnStart(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    MainActor.assumeIsolated {
        fragment.onStart()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onStop")
public func nativeFragmentOnStop(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    InnerLog.t("🩵 nativeFragmentOnStop(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnStop(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    MainActor.assumeIsolated {
        fragment.onStop()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onViewCreated")
public func nativeFragmentOnViewCreated(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, view: jobject) {
    InnerLog.t("🩵 nativeFragmentOnViewCreated(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnViewCreated(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    guard let viewObject = view.box(JEnv(env))?.object(), let context = viewObject.context() else {
        InnerLog.c("🟥 nativeFragmentOnViewCreated(id: \(uniqueId)) unable to unwrap View")
        return
    }
    let viewId = viewObject.callIntMethod(JEnv(env), name: "getId")
    MainActor.assumeIsolated {
        let activityContext = ActivityContext(object: context)
        fragment.onViewCreated(view: .init(id: viewId, viewObject, { activityContext }), savedInstanceState: nil)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onViewCreatedSavedInstanceState")
public func nativeFragmentOnViewCreatedSavedInstanceState(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, view: jobject, savedInstanceState: jobject) {
    InnerLog.t("🩵 nativeFragmentOnViewCreatedSavedInstanceState(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnViewCreatedSavedInstanceState(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    guard let viewObject = view.box(JEnv(env))?.object(), let context = viewObject.context() else {
        InnerLog.c("🟥 nativeFragmentOnViewCreatedSavedInstanceState(id: \(uniqueId)) unable to unwrap View")
        return
    }
    guard let bundleObject = savedInstanceState.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnViewCreatedSavedInstanceState(id: \(uniqueId)) unable to unwrap Bundle")
        return
    }
    let viewId = viewObject.callIntMethod(JEnv(env), name: "getId")
    MainActor.assumeIsolated {
        let activityContext = ActivityContext(object: context)
        fragment.onViewCreated(view: .init(id: viewId, viewObject, { activityContext }), savedInstanceState: .init(bundleObject))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onViewStateRestored")
public func nativeFragmentOnViewStateRestored(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    InnerLog.t("🩵 nativeFragmentOnViewStateRestored(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnViewStateRestored(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    MainActor.assumeIsolated {
        fragment.onViewStateRestored(savedInstanceState: nil)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeFragment_onViewStateRestoredSavedInstanceState")
public func nativeFragmentOnViewStateRestoredSavedInstanceState(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, savedInstanceState: jobject) {
    InnerLog.t("🩵 nativeFragmentOnViewStateRestoredSavedInstanceState(id: \(uniqueId))")
    guard
        let fragment: NativeFragment = ObjectStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 nativeFragmentOnViewStateRestoredSavedInstanceState(id: \(uniqueId)) unable to find fragment, it was never initialized")
        return
    }
    guard let object = savedInstanceState.box(JEnv(env))?.object() else {
        InnerLog.c("🟥 nativeFragmentOnViewStateRestoredSavedInstanceState(id: \(uniqueId)) unable to unwrap Bundle")
        return
    }
    MainActor.assumeIsolated {
        fragment.onViewStateRestored(savedInstanceState: .init(object))
    }
}
#endif

// MARK: - NativeNavHostFragment

#if os(Android)
@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onAttach")
public func nativeNavHostFragmentOnAttach(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, context: jobject) {
    nativeFragmentOnAttach(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, context: context)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onContextItemSelected")
public func nativeNavHostFragmentOnContextItemSelected(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, item: jobject) -> jboolean {
    nativeFragmentOnContextItemSelected(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, item: item)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onCreate")
public func nativeNavHostFragmentOnCreate(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    nativeFragmentOnCreate(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onCreateSavedInstanceState")
public func nativeNavHostFragmentOnCreateSavedInstanceState(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, savedInstanceState: jobject) {
    nativeFragmentOnCreateSavedInstanceState(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, savedInstanceState: savedInstanceState)
}

// nativeNavHostFragmentOnCreateAnimation should be handled on Java side, it is too fragile to touch
// nativeNavHostFragmentOnCreateAnimator should be handled on Java side, it is too fragile to touch

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onCreateContextMenu")
public func nativeNavHostFragmentOnCreateContextMenu(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, menu: jobject, view: jobject) {
    nativeFragmentOnCreateContextMenu(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, menu: menu, view: view)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onCreateContextMenuWithInfo")
public func nativeNavHostFragmentOnCreateContextMenuWithInfo(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, menu: jobject, view: jobject, info: jobject) {
    nativeFragmentOnCreateContextMenuWithInfo(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, menu: menu, view: view, info: info)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onCreateView")
public func nativeNavHostFragmentOnCreateView(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, inflater: jobject) -> jobject? {
    nativeFragmentOnCreateView(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, inflater: inflater)
}

// nativeNavHostFragmentOnCreateViewContainer should always be handled on Java side

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onCreateViewSavedInstanceState")
public func nativeNavHostFragmentOnCreateViewSavedInstanceState(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, inflater: jobject, savedInstanceState: jobject) -> jobject? {
    nativeFragmentOnCreateViewSavedInstanceState(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, inflater: inflater, savedInstanceState: savedInstanceState)
}

// nativeNavHostFragmentOnCreateViewContainerSavedInstanceState should always be handled on Java side

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onDestroy")
public func nativeNavHostFragmentOnDestroy(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    nativeFragmentOnDestroy(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onDestroyView")
public func nativeNavHostFragmentOnDestroyView(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    nativeFragmentOnDestroyView(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onDetach")
public func nativeNavHostFragmentOnDetach(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    nativeFragmentOnDetach(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onHiddenChanged")
public func nativeNavHostFragmentOnHiddenChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, hidden: jboolean) {
    nativeFragmentOnHiddenChanged(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, hidden: hidden)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onMultiWindowModeChanged")
public func nativeNavHostFragmentOnMultiWindowModeChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, isInMultiWindowMode: jboolean) {
    nativeFragmentOnMultiWindowModeChanged(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, isInMultiWindowMode: isInMultiWindowMode)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onPause")
public func nativeNavHostFragmentOnPause(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    nativeFragmentOnPause(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onPictureInPictureModeChanged")
public func nativeNavHostFragmentOnPictureInPictureModeChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, isInPictureInPictureMode: jboolean) {
    nativeFragmentOnPictureInPictureModeChanged(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, isInPictureInPictureMode: isInPictureInPictureMode)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onPrimaryNavigationFragmentChanged")
public func nativeNavHostFragmentOnPrimaryNavigationFragmentChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, isPrimaryNavigationFragment: jboolean) {
    nativeFragmentOnPrimaryNavigationFragmentChanged(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, isPrimaryNavigationFragment: isPrimaryNavigationFragment)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onResume")
public func nativeNavHostFragmentOnResume(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    nativeFragmentOnResume(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onSaveInstanceState")
public func nativeNavHostFragmentOnSaveInstanceState(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, savedInstanceState: jobject) {
    nativeFragmentOnSaveInstanceState(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, savedInstanceState: savedInstanceState)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onStart")
public func nativeNavHostFragmentOnStart(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    nativeFragmentOnStart(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onStop")
public func nativeNavHostFragmentOnStop(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    nativeFragmentOnStop(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onViewCreated")
public func nativeNavHostFragmentOnViewCreated(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, view: jobject) {
    nativeFragmentOnViewCreated(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, view: view)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onViewCreatedSavedInstanceState")
public func nativeNavHostFragmentOnViewCreatedSavedInstanceState(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, view: jobject, savedInstanceState: jobject) {
    nativeFragmentOnViewCreatedSavedInstanceState(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, view: view, savedInstanceState: savedInstanceState)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onViewStateRestored")
public func nativeNavHostFragmentOnViewStateRestored(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    nativeFragmentOnViewStateRestored(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId)
}

@_cdecl("Java_stream_swift_droid_appkit_views_NativeNavHostFragment_onViewStateRestoredSavedInstanceState")
public func nativeNavHostFragmentOnViewStateRestoredSavedInstanceState(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, savedInstanceState: jobject) {
    nativeFragmentOnViewStateRestoredSavedInstanceState(env: env, callerClassObject: callerClassObject, uniqueId: uniqueId, savedInstanceState: savedInstanceState)
}
#endif
