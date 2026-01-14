//
//  Window.swift
//  
//
//  Created by Mihael Isaev on 25.08.2025.
//

/// Abstract base class for a top-level window look and behavior policy.
/// An instance of this class should be used as the top-level view added to the window manager.
/// It provides standard UI policies such as a background, title area, default key processing, etc.
/// 
/// The framework will instantiate an implementation of this class on behalf of the application.
///
/// [Learn more](https://developer.android.com/reference/android/view/Window)
@MainActor
public final class Window: JObjectable, Sendable {
    public static var className: JClassName { "android/view/Window" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

extension Window {
    public enum DecorCaptionShade: Int32 {
        case auto = 0
        case light = 1
        case dark = 2
    }

    static let defaultFeatures: Int32 = 65

    public enum Feature: Int32 {
        /// Flag for enabling the Action Bar.
        /// 
        /// This is enabled by default for some devices.
        /// The Action Bar replaces the title bar and provides an alternate location for an on-screen menu button on some devices.
        case actionBar = 8
        /// This mode is especially useful with `View.SYSTEM_UI_FLAG_FULLSCREEN`,
        /// which allows you to seamlessly hide the action bar in conjunction with other screen decorations.
        ///
        /// As of Build.VERSION_CODES.JELLY_BEAN, when an ActionBar is in this mode it will adjust the insets
        /// provided to `View.fitSystemWindows(Rect)` to include the content covered by the action bar, so you can do layout within that space.
        case actionBarOverlay = 9
        /// Flag for specifying the behavior of action modes when an Action Bar is not present.
        /// If overlay is enabled, the action mode UI will be allowed to cover existing window content.
        case actionModeOverlay = 10
        /// Enables Activities to run Activity Transitions either through sending
        /// or receiving `ActivityOptions` bundle created
        /// with `ActivityOptions.makeSceneTransitionAnimation(Activity, android.util.Pair[])`
        /// or `ActivityOptions.makeSceneTransitionAnimation(Activity, View, String)`.
        case activityTransitions = 13
        /// Flag for requesting that window content changes should be animated using a TransitionManager.
        ///
        /// The TransitionManager is set using `setTransitionManager(android.transition.TransitionManager)`.
        /// If none is set, a default TransitionManager will be used.
        case contentTransitions = 12
        /// Flag for the context menu. This is enabled by default.
        case contextMenu = 6
        /// Flag for custom title. You cannot combine this feature with other title features.
        case customTitle = 7
        /// Flag for having an icon on the left side of the title bar
        case leftIcon = 3
        /// Flag for the "no title" feature, turning off the title at the top of the screen.
        case noTitle = 1
        /// Flag for the "options panel" feature. This is enabled by default.
        case optionsPanel = 0
        /// Flag for having an icon on the right side of the title bar
        case rightIcon = 4
    }

    /// The transitionName for the navigation bar background View when a custom background is used.
    public static let navigationBarBackgroundTransitionName = "android:navigation:background"
    /// The transitionName for the status bar background View when a custom background is used.
    public static let statusBarBackgroundTransitionName = "android:status:background"
}

extension Window {
    // TODO: addContentView
    
    /// Convenience function to set the flag bits as specified in flags, as per `setFlags(int, int)`.
    @discardableResult
    public func addFlags(_ flags: Int32) -> Self {
        callVoidMethod(name: "addFlags", args: flags)
        return self
    }

    // TODO: addOnFrameMetricsAvailableListener
    
    /// Convenience function to clear the flag bits as specified in flags, as per `setFlags(int, int)`.
    @discardableResult
    public func clearFlags(_ flags: Int32) -> Self {
        callVoidMethod(name: "clearFlags", args: flags)
        return self
    }

    @discardableResult
    public func closeAllPanels() -> Self {
        callVoidMethod(name: "closeAllPanels")
        return self
    }

    @discardableResult
    public func closePanel(_ featureId: Int32) -> Self {
        callVoidMethod(name: "closePanel", args: featureId)
        return self
    }

    // TODO: findViewById

    /// Returns how the transition set in `setEnterTransition(android.transition.Transition)`
    /// overlaps with the exit transition of the calling Activity.
    /// 
    /// When true, the transition will start as soon as possible.
    /// When false, the transition will wait until the remote exiting
    /// transition completes before starting.
    /// 
    /// The default value is true.
    public func allowEnterTransitionOverlap() -> Bool {
        callBoolMethod(name: "getAllowEnterTransitionOverlap") ?? true
    }
    
    /// Returns how the transition set in `setExitTransition(android.transition.Transition)`
    /// overlaps with the exit transition of the called Activity when reentering after if finishes.
    /// 
    /// When true, the transition will start as soon as possible.
    /// When false, the transition will wait until the called Activity's exiting
    /// transition completes before starting.
    /// The default value is true.
    public func allowReturnTransitionOverlap() -> Bool {
        callBoolMethod(name: "getAllowReturnTransitionOverlap") ?? true
    }

    // TODO: getAttributes
    // TODO: getCallback

    /// Returns the requested color mode of the window.
    public func colorMode() -> ActivityColorMode {
        guard
            let v = callIntMethod(name: "getColorMode")
        else { return .default }
        return .init(rawValue: v) ?? .default
    }

    /// Return the container for this Window.
    public func container() -> Window? {
        guard
            let returningClazz = JClass.load(Window.className),
            let global = callObjectMethod(name: "getContainer", returningClass: returningClazz)
        else { return nil }
        return Window(global)
    }

    // TODO: getContentScene

    /// Return the Context this window policy is running in,
    /// for retrieving resources and other information.
    public func context() -> ActivityContext? { // TODO: change to WindowContext
        guard
            let returningClazz = JClass.load(.android.content.Context),
            let global = callObjectMethod(name: "getContext", returningClass: returningClazz)
        else { return nil }
        return ActivityContext(object: global)
    }

    /// Return the view in this Window that currently has focus,
    /// or null if there are none. Note that this does not look in any containing Window.
    public func currentFocus() -> View? {
        guard
            let returningClazz = JClass.load(.android.view.View),
            let global = callObjectMethod(name: "getCurrentFocus", returningClass: returningClazz)
        else { return nil }
        return .init(global, { [weak self] in
            InnerLog.t("🟡 Window.currentFocus(): getting context (\(self?.context() != nil))")
            return self?.context()
        })
    }

    /// Retrieve the top-level window decor view (containing the standard window
    /// frame/decorations and the client's content inside of that),
    /// which can be added as a window to the window manager.
    /// 
    /// Note that calling this function for the first time "locks in" various window characteristics.
    public func decorView() -> View? {
        guard
            let returningClazz = JClass.load(.android.view.View),
            let global = callObjectMethod(name: "getDecorView", returningClass: returningClazz)
        else { return nil }
        return .init(global, { [weak self] in
            InnerLog.t("🟡 Window.decorView(): getting context (\(self?.context() != nil))")
            return self?.context()
        })
    }

    /// Return the feature bits set by default on a window.
    public func getDefaultFeatures() -> Int32 {
        callIntMethod(name: "getDefaultFeatures") ?? 0
    }

    /// Get the desired amount of HDR headroom as set by `setDesiredHdrHeadroom(float)`.
    public func desiredHdrHeadroom() -> Float {
        callFloatMethod(name: "getDesiredHdrHeadroom") ?? 0.0
    }

    /// Returns the transition used to move Views into the initial scene.
    /// The entering Views will be those that are regular Views or ViewGroups
    /// that have ViewGroup.isTransitionGroup return true.
    /// Typical Transitions will extend Visibility as entering is governed
    /// by changing visibility from `View.INVISIBLE` to `View.VISIBLE`.
    /// If transition is null, entering Views will remain unaffected.
    /// Requires `FEATURE_ACTIVITY_TRANSITIONS`.
    // public func enterTransition() -> Transition? {
    //     guard
    //         let returningClazz = JClass.load(Transition.className),
    //         let global = callObjectMethod(name: "getEnterTransition", returningClass: returningClazz)
    //     else { return nil }
    //     return Transition(global)
    // }

    /// Returns the Transition that will be used to move Views out of the scene
    /// when starting a new Activity. The exiting Views will be those that are
    /// regular Views or ViewGroups that have ViewGroup.isTransitionGroup return true.
    /// Typical Transitions will extend Visibility as exiting is governed by changing
    /// visibility from `View.VISIBLE` to `View.INVISIBLE`. If transition is null,
    /// the views will remain unaffected. Requires `FEATURE_ACTIVITY_TRANSITIONS`.
    // public func exitTra 
    
    /// Get whether frame rate touch boost is enabled.
    public func frameRateBoostOnTouchEnabled() -> Bool {
        callBoolMethod(name: "getFrameRateBoostOnTouchEnabled") ?? false
    }

    // TODO: getInsetsController
    // TODO: getLayoutInflater
    
    /// Gets the `MediaController` that was previously set.
    public func mediaController() -> MediaController? {
        guard
            let returningClazz = JClass.load(MediaController.className),
            let global = callObjectMethod(name: "getMediaController", returningClass: returningClazz)
        else { return nil }
        return MediaController(global, { [weak self] in
            InnerLog.t("🟡 Window.mediaController(): getting context (\(self?.context() != nil))")
            return self?.context()
        })
    }

    /// Get the current navigation bar color.
    /// 
    /// This method was deprecated in API level 35.
    public func navigationBarColor() -> GraphicsColor? {
        guard
            let value = callIntMethod(name: "getNavigationBarColor")
        else { return nil }
        return .init(integerLiteral: value)
    }

    /// Retrieves the color of the navigation bar divider.
    ///
    /// This method was added in API level 35.
    public func navigationBarDividerColor() -> GraphicsColor? {
        guard
            let value = callIntMethod(name: "getNavigationBarDividerColor")
        else { return nil }
        return .init(integerLiteral: value)
    }
    
    // TODO: getOnBackInvokedDispatcher
    
    /// Returns the Transition that will be used to move Views in
    /// to the scene when returning from a previously-started Activity.
    // public func reenterTransition() -> Transition? {
    //     guard
    //         let returningClazz = JClass.load(Transition.className),
    //         let global = callObjectMethod(name: "getReenterTransition", returningClass: returningClazz)
    //     else { return nil }
    //     return Transition(global)
    // }

    /// Returns the Transition that will be used to move Views
    /// out of the scene when the Window is preparing to close,
    /// for example after a call to `Activity.finishAfterTransition()`.
    // public func returnTransition() -> Transition? {
    //     guard
    //         let returningClazz = JClass.load(Transition.className),
    //         let global = callObjectMethod(name: "getReturnTransition", returningClass: returningClazz)
    //     else { return nil }
    //     return Transition(global)
    // }

    // TODO: getRootSurfaceControl

    /// Returns the Transition that will be used for shared elements
    /// transferred into the content Scene.
    /// 
    /// Requires `FEATURE_ACTIVITY_TRANSITIONS`.
    // public func sharedElementEnterTransition() -> Transition? {
    //     guard
    //         let returningClazz = JClass.load(Transition.className),
    //         let global = callObjectMethod(name: "getSharedElementEnterTransition", returningClass: returningClazz)
    //     else { return nil }
    //     return Transition(global)
    // }
    
    /// Returns the Transition to use for shared elements in the launching Window
    /// prior to transferring to the launched Activity's Window.
    /// 
    /// Requires `FEATURE_ACTIVITY_TRANSITIONS`.
    // public func sharedElementExitTransition() -> Transition? {
    //     guard
    //         let returningClazz = JClass.load(Transition.className),
    //         let global = callObjectMethod(name: "getSharedElementExitTransition", returningClass: returningClazz)
    //     else { return nil }
    //     return Transition(global)
    // }
    
    /// Returns the Transition that will be used for shared elements reentering
    /// from a started Activity after it has returned the shared element to it start location.
    /// 
    /// Requires `FEATURE_ACTIVITY_TRANSITIONS`.
    // public func sharedElementReenterTransition() -> Transition? {
    //     guard
    //         let returningClazz = JClass.load(Transition.className),
    //         let global = callObjectMethod(name: "getSharedElementReenterTransition", returningClass: returningClazz)
    //     else { return nil }
    //     return Transition(global)
    // }
    
    /// Returns the Transition that will be used for shared elements
    /// transferred back to a calling Activity.
    /// 
    /// Requires FEATURE_ACTIVITY_TRANSITIONS.
    // public func sharedElementReturnTransition() -> Transition? {
    //     guard
    //         let returningClazz = JClass.load(Transition.className),
    //         let global = callObjectMethod(name: "getSharedElementReturnTransition", returningClass: returningClazz)
    //     else { return nil }
    //     return Transition(global)
    // }
    
    /// Returns true when shared elements should use an Overlay during
    /// shared element transitions or false when they should animate
    /// as part of the normal View hierarchy.
    /// 
    /// The default value is true.
    public func sharedElementsUseOverlay() -> Bool {
        callBoolMethod(name: "getSharedElementsUseOverlay") ?? true
    }
    
    /// Get the current status bar color.
    ///
    /// This method was deprecated in API level 35.
    public func statusBarColor() -> GraphicsColor? {
        guard
            let value = callIntMethod(name: "getStatusBarColor")
        else { return nil }
        return .init(integerLiteral: value)
    }
    // TODO: getSystemGestureExclusionRects
    
    /// Returns the duration, in milliseconds, of the window background
    /// fade when transitioning into or away from an Activity
    /// when called with an Activity Transition.
    public func transitionBackgroundFadeDuration() -> Int64 {
        callLongMethod(name: "getTransitionBackgroundFadeDuration") ?? 0
    }

    // TODO: getTransitionManager
    
    /// Get the current volume control stream.
    public func volumeControlStream() -> Int32 {
        callIntMethod(name: "getVolumeControlStream") ?? -1
    }

    // TODO: getWindowManager
    // TODO: getWindowStyle
    
    /// Returns true if this window has any child windows.
    public func hasChildren() -> Bool {
        callBoolMethod(name: "hasChildren") ?? false
    }

    /// Query for the availability of a certain feature.
    public func hasFeature(_ featureId: Int32) -> Bool {
        callBoolMethod(name: "hasFeature", args: featureId) ?? false
    }

    /// Inject an event to window locally.
    public func injectInputEvent(_ event: InputEvent) {
        callVoidMethod(name: "injectInputEvent", args: event.signed(as: InputEvent.className))
    }
    
    /// Invalidate the panel menu for the given feature id.
    public func invalidatePanelMenu(_ featureId: Int32) {
        callVoidMethod(name: "invalidatePanelMenu", args: featureId)
    }
    
    /// Check if the window is currently active.
    public func isActive() -> Bool {
        callBoolMethod(name: "isActive") ?? false
    }
    
    /// Return whether this window is being displayed with a floating style
    /// (based on the `R.attr.windowIsFloating` attribute in the style/theme).
    public func isFloating() -> Bool {
        callBoolMethod(name: "isFloating") ?? false
    }
    
    /// Get whether frameratepowersavingsbalance is enabled for this Window.
    /// This allows device to adjust refresh rate as needed and can be useful for power saving. 
    public func isFrameRatePowerSavingsBalanced() -> Bool {
        callBoolMethod(name: "isFrameRatePowerSavingsBalanced") ?? false
    }
    
    /// Returns whether the system is ensuring that the navigation bar
    /// has enough contrast when a fully transparent background is requested.
    /// 
    /// When the navigation bar color has a non-zero alpha value,
    /// the value of this property has no effect.
    public func isNavigationBarContrastEnforced() -> Bool {
        callBoolMethod(name: "isNavigationBarContrastEnforced") ?? false
    }
    
    /// Is a keypress one of the defined shortcut keys for this window.
    public func isShortcutKey(_ keyCode: Int, _ event: KeyEvent) -> Bool {
        callBoolMethod(name: "isShortcutKey", args: Int32(keyCode), event.signed(as: KeyEvent.className)) ?? false
    }

    /// Returns whether the system is ensuring that the status bar
    /// has enough contrast when a fully transparent background is requested.
    /// 
    /// When the status bar color has a non-zero alpha value,
    /// the value of this property has no effect.
    ///
    /// This method was deprecated in API level 35.
    public func isStatusBarContrastEnforced() -> Bool {
        callBoolMethod(name: "isStatusBarContrastEnforced") ?? false
    }
    
    /// Returns true if this window's color mode is `ActivityInfo.COLOR_MODE_WIDE_COLOR_GAMUT`,
    /// the display has a wide color gamut and this device supports wide color gamut rendering.
    public func isWideColorGamut() -> Bool {
        callBoolMethod(name: "isWideColorGamut") ?? false
    }
    
    /// Make this window active.
    public func makeActive() {
        callVoidMethod(name: "makeActive")
    }

    // TODO: onConfigurationChanged

    /// Open a panel for the given feature id.
    public func openPanel(_ featureId: Int32, _ event: KeyEvent) {
        callVoidMethod(name: "openPanel", args: featureId, event.signed(as: KeyEvent.className))
    }

    /// Retrieve the current decor view, but only if it has already been created; otherwise returns null.
    public func peekDecorView() -> View? {
        guard
            let returningClazz = JClass.load(.android.view.View),
            let global = callObjectMethod(name: "peekDecorView", returningClass: returningClazz)
        else { return nil }
        return .init(global, { [weak self] in
            InnerLog.t("🟡 Window.peekDecorView(): getting context (\(self?.context() != nil))")
            return self?.context()
        })
    }
    
    /// Perform the context menu action associated with a particular identifier.
    public func performContextMenuIdentifierAction(_ id: Int32, _ flags: Int32) -> Bool {
        callBoolMethod(name: "performContextMenuIdentifierAction", args: id, flags) ?? false
    }
    
    /// Perform the panel action associated with a particular identifier.
    public func performPanelIdentifierAction(_ featureId: Int32, _ id: Int32, _ flags: Int32) -> Bool {
        callBoolMethod(name: "performPanelIdentifierAction", args: featureId, id, flags) ?? false
    }

    /// Perform a shortcut action.
    public func performPanelShortcut(_ featureId: Int32, _ keyCode: Int32, _ event: KeyEvent, _ flags: Int32) -> Bool {
        callBoolMethod(name: "performPanelShortcut", args: featureId, keyCode, event.signed(as: KeyEvent.className), flags) ?? false
    }
    
    // TODO: registerScrollCaptureCallback
    // TODO: removeOnFrameMetricsAvailableListener

    /// Enable extended screen features.
    /// This must be called before `setContentView()`.
    /// May be called as many times as desired as long
    /// as it is before `setContentView()`. If not called,
    /// no extended features will be available. You can not turn off
    /// a feature once it is requested. You canot use other
    /// title features with `FEATURE_CUSTOM_TITLE`.
    public func requestFeature(_ featureId: Int32) -> Bool {
        callBoolMethod(name: "requestFeature", args: featureId) ?? false
    }

    // TODO: requireViewById
    // TODO: restoreHierarchyState
    // TODO: saveHierarchyState

    /// Controls how the transition set in `setEnterTransition(android.transition.Transition)`
    /// overlaps with the exit transition of the calling Activity.
    ///
    /// When true, the transition will start as soon as possible.
    /// When false, the transition will wait until the remote exiting transition completes before starting.
    ///
    /// The default value is true.
    @discardableResult
    public func allowEnterTransitionOverlap(_ value: Bool = true) -> Self {
        callVoidMethod(name: "setAllowEnterTransitionOverlap", args: value)
        return self
    }
    
    /// Controls how the transition set in `setExitTransition(android.transition.Transition)`
    /// overlaps with the exit transition of the called Activity when reentering after if finishes.
    /// 
    /// When true, the transition will start as soon as possible.
    /// When false, the transition will wait until the called Activity's exiting transition completes before starting.
    /// 
    /// The default value is true.
    @discardableResult
    public func allowReturnTransitionOverlap(_ value: Bool = true) -> Self {
        callVoidMethod(name: "setAllowReturnTransitionOverlap", args: value)
        return self
    }

    // TODO: setAttributes

    /// Blurs the screen behind the window within the bounds of the window.
    ///
    /// The density of the blur is set by the blur radius.
    /// The radius defines the size of the neighbouring area,
    /// from which pixels will be averaged to form the final color for each pixel.
    /// The operation approximates a Gaussian blur. A radius of 0 means no blur.
    /// The higher the radius, the denser the blur.
    ///
    /// The window background drawable is drawn on top of the blurred region.
    /// The blur region bounds and rounded corners will mimic those of the background drawable.
    @discardableResult
    public func backgroundBlurRadius(_ radius: Int32) -> Self {
        callVoidMethod(name: "setBackgroundBlurRadius", args: radius)
        return self
    }
    
    /// Change the background of this window to a custom Drawable.
    /// Setting the background to null will make the window be opaque.
    /// To make the window transparent, you can use an empty drawable
    /// (for instance a ColorDrawable with the color 0 or the system drawable android:drawable/empty.)
    @discardableResult
    public func backgroundDrawable(_ drawable: Drawable) -> Self {
        callVoidMethod(name: "setBackgroundDrawable", args: drawable.signed(as: Drawable.className))
        return self
    }

    /// Change the background of this window to a custom Drawable resource.
    /// Setting the background to null will make the window be opaque.
    /// To make the window transparent, you can use an empty drawable
    /// (for instance a ColorDrawable with the color 0 or the system drawable android:drawable/empty.)
    @discardableResult
    public func backgroundDrawableResource(_ resId: Int32) -> Self {
        callVoidMethod(name: "setBackgroundDrawableResource", args: resId)
        return self
    }

    // TODO: setCallback

    /// Set a drawable to be used in a child feature of the window.
    @discardableResult
    public func childDrawable(_ featureId: Int32, _ drawable: Drawable) -> Self {
        callVoidMethod(name: "setChildDrawable", args: featureId, drawable.signed(as: Drawable.className))
        return self
    }
    
    /// Set an integer to be used in a child feature of the window.
    @discardableResult
    public func childInt(_ featureId: Int32, _ value: Int32) -> Self {
        callVoidMethod(name: "setChildInt", args: featureId, value)
        return self
    }

    /// Sets whether window content should be clipped to the outline of the window background.
    @discardableResult
    public func clipToOutline(_ clipToOutline: Bool = true) -> Self {
        callVoidMethod(name: "setClipToOutline", args: clipToOutline)
        return self
    }
    
    /// Sets the requested color mode of the window.
    /// 
    /// The requested the color mode might override the window's pixel format.
    @discardableResult
    public func colorMode(_ colorMode: ActivityColorMode) -> Self {
        callVoidMethod(name: "setColorMode", args: colorMode.rawValue)
        return self
    }

    @discardableResult
    public func container(_ container: Window) -> Self {
        callVoidMethod(name: "setContainer", args: container.signed(as: Window.className))
        return self
    }
    // TODO: setContentView

    /// Set what color should the caption controls be.
    /// 
    /// By default the system will try to determine the color from the theme.
    @discardableResult
    public func decorCaptionShade(_ decorCaptionShade: DecorCaptionShade) -> Self {
        callVoidMethod(name: "setDecorCaptionShade", args: decorCaptionShade.rawValue)
        return self
    }
    
    /// Sets whether the decor view should fit root-level content views for WindowInsets.
    ///
    /// If set to true, the framework will inspect the now deprecated
    /// `View.SYSTEM_UI_LAYOUT_FLAGS` as well the `WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE`
    /// flag and fits content according to these flags.
    ///
    /// If set to false, the framework will not fit the content view
    /// to the insets and will just pass through the WindowInsets to the content view.
    ///
    /// If the app targets VANILLA_ICE_CREAM or above, the behavior will
    /// be like setting this to false, and cannot be changed.
    ///
    /// This method was deprecated in API level 35.
    @discardableResult
    public func decorFitsSystemWindows(_ fitSystemWindows: Bool = true) -> Self {
        callVoidMethod(name: "setDecorFitsSystemWindows", args: fitSystemWindows)
        return self
    }
    
    /// Sets the desired amount of HDR headroom to be used when rendering
    /// as a ratio of `targetHdrPeakBrightnessInNits / targetSdrWhitePointInNits`.
    /// Only applies when `setColorMode(int)` is `ActivityInfo.COLOR_MODE_HDR`.
    @discardableResult
    public func desiredHdrHeadroom(_ desiredHdrHeadroom: Float) -> Self {
        callVoidMethod(name: "setDesiredHdrHeadroom", args: desiredHdrHeadroom)
        return self
    }
    
    /// Set the amount of dim behind the window when using `WindowManager.LayoutParams.FLAG_DIM_BEHIND`.
    /// This overrides the default dim amount of that is selected by the `Window` based on its theme.
    @discardableResult
    public func dimAmount(_ amount: Float) -> Self {
        callVoidMethod(name: "setDimAmount", args: amount)
        return self
    }

    /// WindowCompat proxy method.
    /// 
    /// Enables the content of the given window to reach the edges of the window
    /// without getting inset by system insets, and prevents the framework
    /// from placing color views behind system bars.
    // @discardableResult
    // public func enableEdgeToEdge() -> Self {
    //     WindowCompat.enableEdgeToEdge(self)
    //     return self
    // } // enable when API 36 will be available
    
    /// Sets the window elevation.
    ///
    /// Changes to this property take effect immediately and will cause the window surface to be recreated.
    /// This is an expensive operation and as a result, this property should not be animated.
    @discardableResult
    public func elevation(_ elevation: Float) -> Self {
        callVoidMethod(name: "setElevation", args: elevation)
        return self
    }

    /// Sets the Transition that will be used to move Views into the initial scene.
    // @discardableResult
    // public func enterTransition(_ transition: Transition) -> Self {
    //     callVoidMethod(name: "setEnterTransition", args: transition.signed(as: Transition.className))
    //     return self
    // }
    
    /// Sets the Transition that will be used to move Views out of the scene when starting a new Activity.
    // @discardableResult
    // public func exitTransition(_ transition: Transition) -> Self {
    //     callVoidMethod(name: "setExitTransition", args: transition.signed(as: Transition.className))
    //     return self
    // }
    
    /// Set an explicit Drawable value for feature of this window.
    /// You must have called requestFeature(featureId) before calling this function.
    @discardableResult
    public func featureDrawable(_ featureId: Int32, _ drawable: Drawable) -> Self {
        callVoidMethod(name: "setFeatureDrawable", args: featureId, drawable.signed(as: Drawable.className))
        return self
    }
    
    /// Set a custom alpha value for the given drawable feature,
    /// controlling how much the background is visible through it.
    ///
    /// Parameters:
    ///  - featureId: The feature id whose drawable alpha is to be set.
    /// - alpha: The alpha value [0..255] to set on the feature drawable.
    @discardableResult
    public func featureDrawableAlpha(_ featureId: Int32, _ alpha: Int32) -> Self {
        callVoidMethod(name: "setFeatureDrawableAlpha", args: featureId, alpha)
        return self
    }
    
    /// Set the value for a drawable feature of this window,
    /// from a resource identifier. You must have called
    /// `requestFeature(featureId)` before calling this function.
    @discardableResult
    public func featureDrawableResource(_ featureId: Int32, _ resId: Int32) -> Self {
        callVoidMethod(name: "setFeatureDrawableResource", args: featureId, resId)
        return self
    }
    
    /// Set the value for a drawable feature of this window, from a URI.
    /// You must have called `requestFeature(featureId)` before calling this function.
    ///
    /// The only URI currently supported is `content:`, specifying an image in a content provider.
    public func featureDrawableUri(_ featureId: Int32, _ uri: Uri) -> Self {
        callVoidMethod(name: "setFeatureDrawableUri", args: featureId, uri.signed(as: Uri.className))
        return self
    }

    /// Set the integer value for a feature.
    /// The range of the value depends on the feature being set.
    /// For `FEATURE_PROGRESS`, it should go from 0 to 10000.
    /// At 10000 the progress is complete and the indicator hidden.
    @discardableResult
    public func featureInt(_ featureId: Int32, _ value: Int32) -> Self {
        callVoidMethod(name: "setFeatureInt", args: featureId, value)
        return self
    }
    
    /// Set the flag bits as specified in flags.
    @discardableResult
    public func flags(_ flags: Int32, _ mask: Int32) -> Self {
        callVoidMethod(name: "setFlags", args: flags, mask)
        return self
    }
    
    /// Set the format of window, as per the PixelFormat types.
    /// This overrides the default format that is selected by the Window based on its window decorations.
    @discardableResult
    public func format(_ format: Int32) -> Self {
        callVoidMethod(name: "setFormat", args: format)
        return self
    }
    
    /// Sets whether the frame rate touch boost is enabled for this Window.
    /// When enabled, the frame rate will be boosted when a user touches the Window.
    @discardableResult
    public func frameRateBoostOnTouchEnabled(_ enabled: Bool = true) -> Self {
        callVoidMethod(name: "setFrameRateBoostOnTouchEnabled", args: enabled)
        return self
    }
    
    /// Set whether frameratepowersavingsbalance is enabled for this Window.
    /// This allows device to adjust refresh rate as needed and can be useful for power saving.
    @discardableResult
    public func frameRatePowerSavingsBalanced(_ balanced: Bool = true) -> Self {
        callVoidMethod(name: "setFrameRatePowerSavingsBalanced", args: balanced)
        return self
    }
    
    /// Set the gravity of the window, as per the Gravity constants.
    /// This controls how the window manager is positioned in the overall window;
    /// it is only useful when using `WRAP_CONTENT` for the layout width or height.
    @discardableResult
    public func gravity(_ gravity: Gravity) -> Self {
        callVoidMethod(name: "setGravity", args: Int32(gravity.rawValue))
        return self
    }
    
    /// Prevent non-system overlay windows from being drawn on top of this window.
    /// Requires `Manifest.permission.HIDE_OVERLAY_WINDOWS`.
    @discardableResult
    public func hideOverlayWindows(_ hideOverlayWindows: Bool = true) -> Self {
        callVoidMethod(name: "setHideOverlayWindows", args: hideOverlayWindows)
        return self
    }
    
    /// Set the primary icon for this window.
    @discardableResult
    public func icon(_ icon: Int32) -> Self {
        callVoidMethod(name: "setIcon", args: icon)
        return self
    }
    
    /// Set the width and height layout parameters of the window.
    /// The default for both of these is `MATCH_PARENT`;
    /// you can change them to `WRAP_CONTENT` or an absolute value to make a window that is not full-screen.
    @discardableResult
    public func layout(_ width: LayoutParams.LayoutSize, _ height: LayoutParams.LayoutSize, _ unit: DimensionUnit = .dp) -> Self {
        callVoidMethod(name: "setLayout", args: width.value < 0 ? width.value : unit.toPixels(width.value), height.value < 0 ? height.value : unit.toPixels(height.value))
        return self
    }
    
    /// Set focus locally.
    /// 
    /// The window should have the`WindowManager.LayoutParams.FLAG_LOCAL_FOCUS_MODE` flag set already.
    @discardableResult
    public func localFocus(_ hasFocus: Bool, _ intouchMode: Bool) -> Self {
        callVoidMethod(name: "setLocalFocus", args: hasFocus, intouchMode)
        return self
    }
    
    /// Set the logo for this window.
    /// 
    /// A logo is often shown in place of an icon but is generally wider
    /// and communicates window title information as well.
    @discardableResult
    public func logo(_ resId: Int32) -> Self {
        callVoidMethod(name: "setLogo", args: resId)
        return self
    }
    
    /// Sets a `MediaController` to send media keys and volume changes to.
    /// If set, this should be preferred for all media keys and volume requests sent to this window.
    @discardableResult
    public func mediaController(_ mediaController: MediaController) -> Self {
        guard let instance = mediaController.instance else {
            InnerLog.c("🚨 MediaController instance is nil, something is wrong")
            return self
        }
        callVoidMethod(name: "setMediaController", args: instance.signed(as: MediaController.className))
        return self
    }
    
    /// Sets the color of the navigation bar to.
    /// 
    /// This method was deprecated in API level 35.
    @discardableResult
    public func navigationBarColor(_ color: GraphicsColor) -> Self {
        callVoidMethod(name: "setNavigationBarColor", args: color.value)
        return self
    }
    
    /// Sets whether the system should ensure that the navigation bar
    /// has enough contrast when a fully transparent background is requested.
    ///
    /// If set to this value, the system will determine whether
    /// a scrim is necessary to ensure that the navigation bar
    /// has enough contrast with the contents of this app, and set
    /// an appropriate effective bar background color accordingly.
    ///
    /// When the navigation bar color has a non-zero alpha value,
    /// the value of this property has no effect.
    @discardableResult
    public func navigationBarContrastEnforced(_ enforced: Bool = true) -> Self {
        callVoidMethod(name: "setNavigationBarContrastEnforced", args: enforced)
        return self
    }
    
    /// Shows a thin line of the specified color between the navigation bar and the app content.
    ///
    /// This method was deprecated in API level 35.
    @discardableResult
    public func navigationBarDividerColor(_ color: GraphicsColor) -> Self {
        callVoidMethod(name: "setNavigationBarDividerColor", args: color.value)
        return self
    }
    
    /// If isPreferred is true, this method requests that the connected display
    /// does minimal post processing when this window is visible on the screen.
    /// Otherwise, it requests that the display switches back to standard image processing.
    ///
    /// By default, the display does not do minimal post processing and if this
    /// is desired, this method should not be used. It should be used with
    /// `isPreferred=true` when low latency has a higher priority than image
    /// enhancement processing (e.g. for games or video conferencing).
    /// The display will automatically go back into standard image processing
    /// mode when no window requesting minimal posst processing is visible
    /// on screen anymore. setPreferMinimalPostProcessing(false) can be used
    /// if setPreferMinimalPostProcessing(true) was previously called
    /// for this window and minimal post processing is no longer required.
    /// 
    /// If the Display sink is connected via HDMI, the device will begin to send
    /// infoframes with Auto Low Latency Mode enabled and Game Content Type.
    /// This will switch the connected display to a minimal image processing
    /// mode (if available), which reduces latency, improving the user experience
    /// for gaming or video conferencing applications. For more information,
    /// see HDMI 2.1 specification.
    /// 
    /// If the Display sink has an internal connection or uses some other protocol than HDMI,
    /// effects may be similar but implementation-defined.
    /// 
    /// The ability to switch to a mode with minimal post proessing may be disabled
    /// by a user setting in the system settings menu. In that case, this method does nothing.
    @discardableResult
    public func preferMinimalPostProcessing(_ value: Bool = true) -> Self {
        callVoidMethod(name: "setPreferMinimalPostProcessing", args: value)
        return self
    }
    
    /// Sets the Transition that will be used to move Views in to the scene when returning from a previously-started Activity.
    // @discardableResult
    // public func reenterTransition(_ transition: Transition) -> Self {
    //     callVoidMethod(name: "setReenterTransition", args: transition.signed(as: Transition.className))
    //     return self
    // }
    
    /// Set the drawable that is drawn underneath the caption during the resizing.
    @discardableResult
    public func resizingCaptionDrawable(_ drawable: Drawable) -> Self {
        callVoidMethod(name: "setResizingCaptionDrawable", args: drawable.signed(as: Drawable.className))
        return self
    }

    // TODO: setRestrictedCaptionAreaListener

    /// Sets the Transition that will be used to move Views out of the scene
    /// when the Window is preparing to close, for example after
    /// a call to `Activity.finishAfterTransition()`.
    // @discardableResult
    // public func returnTransition(_ transition: Transition) -> Self {
    //     callVoidMethod(name: "setReturnTransition", args: transition.signed(as: Transition.className))
    //     return self
    // }

    /// Sets the Transition that will be used for shared elements transferred into the content Scene.
    // @discardableResult
    // public func sharedElementEnterTransition(_ transition: Transition) -> Self {
    //     callVoidMethod(name: "setSharedElementEnterTransition", args: transition.signed(as: Transition.className))
    //     return self
    // }
    
    /// Sets the Transition that will be used for shared elements after starting a new Activity
    /// before the shared elements are transferred to the called Activity.
    // @discardableResult
    // public func sharedElementExitTransition(_ transition: Transition) -> Self {
    //     callVoidMethod(name: "setSharedElementExitTransition", args: transition.signed(as: Transition.className))
    //     return self
    // }
    
    /// Sets the Transition that will be used for shared elements reentering
    /// from a started Activity after it has returned the shared element to it start location.
    // @discardableResult
    // public func sharedElementReenterTransition(_ transition: Transition) -> Self {
    //     callVoidMethod(name: "setSharedElementReenterTransition", args: transition.signed(as: Transition.className))
    //     return self
    // }
    
    /// Sets the Transition that will be used for shared elements transferred back to a calling Activity.
    // @discardableResult
    // public func sharedElementReturnTransition(_ transition: Transition) -> Self {
    //     callVoidMethod(name: "setSharedElementReturnTransition", args: transition.signed(as: Transition.className))
    //     return self
    // }

    /// Sets whether or not shared elements should use an Overlay during shared element transitions. The default value is true.
    @discardableResult
    public func sharedElementsUseOverlay(_ useOverlay: Bool = true) -> Self {
        callVoidMethod(name: "setSharedElementsUseOverlay", args: useOverlay)
        return self
    }

    /// Specify an explicit soft input mode to use for the window.
    @discardableResult
    public func softInputMode(_ mode: Int32) -> Self {
        callVoidMethod(name: "setSoftInputMode", args: mode)
        return self
    }
    
    /// Sets the color of the status bar to `color`.
    ///
    /// This method was deprecated in API level 35.
    @discardableResult
    public func statusBarColor(_ color: GraphicsColor) -> Self {
        callVoidMethod(name: "setStatusBarColor", args: color.value)
        return self
    }
    
    /// Sets whether the system should ensure that the status bar has enough
    /// contrast when a fully transparent background is requested.
    /// 
    /// If set to this value, the system will determine whether a scrim
    /// is necessary to ensure that the status bar has enough contrast
    /// with the contents of this app, and set an appropriate
    /// effective bar background color accordingly.
    /// 
    /// When the status bar color has a non-zero alpha value,
    /// the value of this property has no effect.
    ///
    /// This method was deprecated in API level 35.
    @discardableResult
    public func statusBarContrastEnforced(_ enforced: Bool = true) -> Self {
        callVoidMethod(name: "setStatusBarContrastEnforced", args: enforced)
        return self
    }
    
    /// Sets whether sustained performance mode is enabled for this Window.
    @discardableResult
    public func sustainedPerformanceMode(_ enabled: Bool = true) -> Self {
        callVoidMethod(name: "setSustainedPerformanceMode", args: enabled)
        return self
    }
    
    // TODO: setSystemGestureExclusionRects
    
    /// Sets a user-facing title for the window.
    @discardableResult
    public func title(_ title: String) -> Self {
        callVoidMethod(name: "setTitle", args: title.signedAsCharSequence())
        return self
    }
    
    /// Sets the color of the title text.
    @discardableResult
    public func titleColor(_ color: GraphicsColor) -> Self {
        callVoidMethod(name: "setTitleColor", args: color.value)
        return self
    }
    
    /// Sets the duration, in milliseconds, of the window background fade
    /// when transitioning into or away from an Activity when called with an Activity Transition.
    @discardableResult
    public func transitionBackgroundFadeDuration(_ duration: Int64) -> Self {
        callVoidMethod(name: "setTransitionBackgroundFadeDuration", args: duration)
        return self
    }

    // TODO: setTransitionManager

    /// Set the type of the window, as per the `WindowManager.LayoutParams` types.
    public func type(_ type: Int32) -> Self {
        callVoidMethod(name: "setType", args: type)
        return self
    }
    
    /// Set extra options that will influence the UI for this window.
    @discardableResult
    public func uiOptions(_ uiOptions: Int32) -> Self {
        callVoidMethod(name: "setUiOptions", args: uiOptions)
        return self
    }

    /// Set extra options that will influence the UI for this window.
    /// 
    /// Only the bits filtered by mask will be modified.
    @discardableResult
    public func uiOptions(_ uiOptions: Int32, _ mask: Int32) -> Self {
        callVoidMethod(name: "setUiOptions", args: uiOptions, mask)
        return self
    }
    
    /// Sets the volume control stream for this window.
    @discardableResult
    public func volumeControlStream(_ streamType: Int32) -> Self {
        callVoidMethod(name: "setVolumeControlStream", args: streamType)
        return self
    }
    
    /// Specify custom animations to use for the window, as per `WindowManager.LayoutParams.windowAnimations`.
    /// 
    /// Providing anything besides 0 here will override the animations the window would normally retrieve from its theme.
    @discardableResult
    public func windowAnimations(_ resId: Int32) -> Self {
        callVoidMethod(name: "setWindowAnimations", args: resId)
        return self
    }
    
    // TODO: takeInputQueue
    
    /// Request that key events come to this activity.
    /// Use this if your activity has no views with focus,
    /// but the activity still wants a chance to process key events.
    public func takeKeyEvents(_ value: Bool = true) {
        callVoidMethod(name: "takeKeyEvents", args: value)
    }

    // TODO: takeSurface
    
    /// Toggle a panel for the given feature id.
    public func togglePanel(_ featureId: Int32, _ event: KeyEvent) {
        callVoidMethod(name: "togglePanel", args: featureId, event.signed(as: KeyEvent.className))
    }
    
    // TODO: unregisterScrollCaptureCallback
}

/// This class represents a delegate which you can use to extend AppCompat's support to any `android.app.Activity`.
///
/// [Learn more](https://developer.android.com/reference/androidx/appcompat/app/AppCompatDelegate#FEATURE_ACTION_MODE_OVERLAY())
@MainActor
public final class AppCompatDelegate: JObjectable, Sendable {
    public static var className: JClassName { "androidx/core/view/WindowCompat" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

extension AppCompatDelegate {
    public enum Feature: Int32 {
        /// Flag for specifying the behavior of action modes when an Action Bar is not present.
        /// If overlay is enabled, the action mode UI will be allowed to cover existing window content.
        case actionModeOverlay = 10
        /// Flag for enabling the support Action Bar.
        ///
        /// This is enabled by default for some devices.
        /// The Action Bar replaces the title bar and provides an alternate location for an on-screen menu button on some devices.
        case supportActionBar = 108
        /// Flag for requesting an support Action Bar that overlays window content.
        /// Normally an Action Bar will sit in the space above window content,
        /// but if this feature is requested along with `FEATURE_SUPPORT_ACTION_BAR`
        /// it will be layered over the window content itself.
        /// This is useful if you would like your app to have more control over how the Action Bar is displayed,
        // such as letting application content scroll beneath an Action Bar with a transparent background
        // or otherwise displaying a transparent/translucent Action Bar over application content.
        ///
        /// This mode is especially useful with `View.SYSTEM_UI_FLAG_FULLSCREEN`,
        /// which allows you to seamlessly hide the action bar in conjunction with other screen decorations.
        /// When an ActionBar is in this mode it will adjust the insets provided to `View.fitSystemWindows(Rect)`
        /// to include the content covered by the action bar, so you can do layout within that space.
        case supportActionBarOverlay = 109
    }

    public enum Mode: Int32 {
        /// An unspecified mode for night mode.
        /// This is primarily used with `setLocalNightMode`, to allow the default night mode to be used.
        /// If both the default and local night modes are set to this value, then the default value of `MODE_NIGHT_FOLLOW_SYSTEM` is applied.
        case nightUnspecified = -100
        /// Mode which uses the system's night mode setting to determine if it is night or not.
        case nightFollowSystem = -1
        /// Night mode which switches between dark and light mode depending on the time of day (dark at night, light in the day).
        ///
        /// The calculation used to determine whether it is night or not makes use of the location APIs (if this app has the necessary permissions).
        /// This allows us to generate accurate sunrise and sunset times.
        /// If this app does not have permission to access the location APIs then we use hardcoded times which will be less accurate.
        case nightAuto = 0
        /// Night mode which uses always uses a light mode, enabling notnight qualified resources regardless of the time.
        case nightNo = 1
        /// Night mode which uses always uses a dark mode, enabling night qualified resources regardless of the time.
        case nightYes = 2
        /// Night mode which uses a dark mode when the system's 'Battery Saver' feature is enabled, otherwise it uses a 'light mode'.
        /// This mode can help the device to decrease power usage, depending on the display technology in the device.
        /// Please note: this mode should only be used when running on devices which do not provide a similar device-wide setting.
        case nightAutoBattery = 3
    }
}

/// A primary toolbar within the activity that may display the activity title, 
/// application-level navigation affordances, and other interactive items.
///
/// [Learn more](https://developer.android.com/reference/androidx/appcompat/app/ActionBar)
@MainActor
public final class ActionBarCompat: JObjectable, Sendable {
    public static var className: JClassName { "androidx/appcompat/app/ActionBar" }
    public static var lpClassName: JClassName { "androidx/appcompat/app/ActionBar$LayoutParams" }

    let id: Int32 = .nextViewId()
    public let object: JObject
    public private(set) weak var context: ActivityContext?

    public init (_ object: JObject, _ context: ActivityContext) {
        self.object = object
        self.context = context
    }
}

// MARK: OnMenuVisibilityListener

extension ActionBarCompat {
    public typealias ActionBarCompatOnMenuVisibilityListenerHandler = @MainActor (_ isVisible: Bool) -> Void
    /// Add a listener that will respond to menu visibility change events.
    ///
    /// The callback is called when an action bar menu is shown or hidden.
    /// Applications may want to use this to tune auto-hiding behavior for the action bar
    /// or pause/resume video playback, gameplay, or other activity within the main content area.
    @discardableResult
    public func onMenuVisibilityChanged(_ handler: @escaping ActionBarCompatOnMenuVisibilityListenerHandler) -> Self {
        #if os(Android)
        guard let context else {
            InnerLog.c("🚨 ActionBarCompat.onMenuVisibilityChanged: context is nil, cannot proceed")
            return self
        }
        let listener = NativeActionBarCompatOnMenuVisibilityListener(id, viewId: id).setHandler { @MainActor [weak self] in
            guard let self else { return }
            return handler($0)
        }
        guard let instance = listener.instantiate(context) else {
            InnerLog.c("🚨 ActionBarCompat.onMenuVisibilityChanged: listener instance is nil, cannot proceed")
            return self
        }
        listener.addIntoStore()
        callVoidMethod(name: "addOnMenuVisibilityListener", args: instance.object.signed(as: listener.androidClassName))
        return self
        #else
        return self
        #endif
    }
}

extension ActionBarCompat {
    // TODO: addTab

    /// The current custom view.
    public func customView() -> View! {
        guard
            let returningClazz = JClass.load(.android.view.View),
            let global = object.callObjectMethod(name: "getCustomView", returningClass: returningClazz)
        else { return nil }
        let id = Int32.nextViewId()
        return .init(id: id, global, { [weak context] in
            InnerLog.t("🟡 ActionBar.customView(): getting context (\(context != nil))")
            return context
        })
    }

    /// The current set of display options.
    public func displayOptions() -> Display! {
        guard
            let value = object.callIntMethod(name: "getDisplayOptions")
        else { return nil }
        return .init(rawValue: Int(value))
    }

    /// Get the Z-axis elevation of the action bar in pixels.
    /// 
    /// The action bar's elevation is the distance it is placed from its parent surface. Higher values are closer to the user.
    public func elevation(_ unit: DimensionUnit = .dp) -> Float! {
        guard
            let value = object.callFloatMethod(name: "getElevation")
        else { return nil }
        return unit.fromPixels(value)
    }

    /// Retrieve the current height of the ActionBar.
    public func height(_ unit: DimensionUnit = .dp) -> Int! {
        guard
            let value = object.callIntMethod(name: "getHeight")
        else { return nil }
        return unit.fromPixels(value)
    }

    /// Return the current vertical offset of the action bar.
    /// 
    /// The action bar's current hide offset is the distance that the action bar is currently scrolled offscreen in pixels.
    /// The valid range is 0 (fully visible) to the action bar's current measured height (fully invisible).
    public func hideOffset(_ unit: DimensionUnit = .dp) -> Int! {
        guard
            let value = object.callIntMethod(name: "getHideOffset")
        else { return nil }
        return unit.fromPixels(value)
    }
}

extension ActionBarCompat {
    public struct Display: OptionSet, Sendable {
        public let rawValue: Int

        public init (rawValue: Int) {
            self.rawValue = rawValue
        }

        /// Display the 'home' element such that it appears as an 'up' affordance. e.g. show an arrow to the left indicating the action that will be taken.
        /// Set this flag if selecting the 'home' button in the action bar to return up by a single level in your UI rather than back to the top level or front page.
        /// 
        /// Setting this option will implicitly enable interaction with the home/up button.
        /// See [setHomeButtonEnabled](https://developer.android.com/reference/androidx/appcompat/app/ActionBar#setHomeButtonEnabled(boolean)).
        public static let homeAsUp: Display = .init(rawValue: 4)
        /// Show the custom view if one has been set.
        public static let showCustom: Display = .init(rawValue: 16)
        /// Show 'home' elements in this action bar, leaving more space for other navigation elements. This includes logo and icon.
        public static let showHome: Display = .init(rawValue: 2)
        /// Show the activity title and subtitle, if present.
        public static let showTitle: Display = .init(rawValue: 8)
        /// Use logo instead of icon if available. This flag will cause appropriate navigation modes to use a wider logo in place of the standard icon.
        public static let useLogo: Display = .init(rawValue: 1)
    }

    public enum NavigationMode: Int32 {
        /// Standard navigation mode.
        /// Consists of either a logo or icon and title text with an optional subtitle.
        /// Clicking any of these elements will dispatch `onOptionsItemSelected` to the host Activity with a `MenuItem` with item ID `android.R.id.home`.
        case standard = 0
        /// List navigation mode. Instead of static title text this mode presents a list menu for navigation within the activity. e.g. this might be presented to the user as a dropdown list.
        case list = 1
        /// Tab navigation mode. Instead of static title text this mode presents a series of tabs for navigation within the activity.
        case tabs = 2
    }

    /// Returns the current ActionBar subtitle in standard mode.
    public func subtitle() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let str = object.callObjectMethod(name: "getSubtitle", returningClass: returningClazz)
        else { return nil }
        return JString(str).string()
    }

    // TODO: getThemedContext

    public func title() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let str = object.callObjectMethod(name: "getTitle", returningClass: returningClazz)
        else { return nil }
        return JString(str).string()
    }

    /// Hide the `ActionBar` if it is currently showing.
    /// If the window hosting the `ActionBar` does not have the feature `FEATURE_ACTION_BAR_OVERLAY`
    /// it will resize application content to fit the new space available.
    /// 
    /// Instead of calling this function directly, you can also cause an `ActionBar` using the overlay feature
    /// to hide through `View.SYSTEM_UI_FLAG_FULLSCREEN`. Hiding the ActionBar through this system UI flag
    /// allows you to more seamlessly hide it in conjunction with other screen decorations.
    public func hide() {
        object.callVoidMethod(name: "hide")
    }

    /// Return whether the action bar is configured to scroll out
    /// of sight along with a [nested scrolling child](https://developer.android.com/reference/android/view/View.html#setNestedScrollingEnabled(boolean)).
    public func isHideOnContentScrollEnabled() -> Bool {
        object.callBoolMethod(name: "isHideOnContentScrollEnabled") ?? false
    }

    public func isShowing() -> Bool {
        object.callBoolMethod(name: "isShowing") ?? false
    }

    // TODO: removeOnMenuVisibilityListener

    /// Set the `ActionBar`'s background.
    /// This will be used for the primary action bar.
    public func backgroundDrawable(_ drawable: Drawable) {
        object.callVoidMethod(name: "setBackgroundDrawable", args: drawable.signed(as: Drawable.className))
    }

    /// Set the action bar into custom navigation mode, supplying a view for custom navigation.
    /// 
    /// Custom navigation views appear between the application icon and any action buttons
    /// and may use any space available there. Common use cases for custom navigation views
    /// might include an auto-suggesting address bar for a browser or other navigation mechanisms
    /// that do not translate well to provided navigation modes.
    /// 
    /// The display option `DISPLAY_SHOW_CUSTOM` must be set for the custom view to be displayed.
    public func customView(_ id: Int32) {
        object.callVoidMethod(name: "setCustomView", args: id)
    }

    /// Set the action bar into custom navigation mode, supplying a view for custom navigation.
    /// 
    /// Custom navigation views appear between the application icon and any action buttons
    /// and may use any space available there. Common use cases for custom navigation views
    /// might include an auto-suggesting address bar for a browser or other navigation mechanisms
    /// that do not translate well to provided navigation modes.
    public func customView(_ view: View) {
        guard
            let view = view.instance
        else { return }
        object.callVoidMethod(name: "setCustomView", args: view.signed(as: View.className))
    }

    /// Set the action bar into custom navigation mode, supplying a view for custom navigation.
    /// 
    /// Custom navigation views appear between the application icon and any action buttons
    /// and may use any space available there. Common use cases for custom navigation views
    /// might include an auto-suggesting address bar for a browser or other navigation mechanisms
    /// that do not translate well to provided navigation modes.
    /// 
    /// The display option `DISPLAY_SHOW_CUSTOM` must be set for the custom view to be displayed.
    public func customView(_ view: View, _ lp: LayoutParams) {
        guard
            let view = view.instance
        else { return }
        object.callVoidMethod(name: "setCustomView", args: view.signed(as: View.className), lp.signed(as: ActionBarCompat.lpClassName))
    }

    /// Set whether home should be displayed as an "up" affordance.
    /// Set this to true if selecting "home" returns up by a single level in your UI rather than back to the top level or front page.
    /// 
    /// To set several display options at once, see the `setDisplayOptions` methods.
    public func displayHomeAsUpEnabled(_ enabled: Bool = true) {
        object.callVoidMethod(name: "setDisplayHomeAsUpEnabled", args: enabled)
    }

    /// Set display options.
    /// 
    /// This changes all display option bits at once.
    public func displayOptions(_ options: Display) {
        object.callVoidMethod(name: "setDisplayOptions", args: Int32(options.rawValue))
    }

    /// Set selected display options.
    /// Only the options specified by mask will be changed.
    /// To change all display option bits at once, see `setDisplayOptions`.
    ///
    /// Example:
    ///    - `setDisplayOptions(0, .showHome)` will disable the `DISPLAY_SHOW_HOME` option.
    ///    - `setDisplayOptions(.showHome, .showHome | .useLogo)` will enable `DISPLAY_SHOW_HOME` and disable `DISPLAY_USE_LOGO`.
    public func displayOptions(_ options: Display, _ mask: Display) {
        object.callVoidMethod(name: "setDisplayOptions", args: Int32(options.rawValue), Int32(mask.rawValue))
    }

    /// Set whether a custom view should be displayed, if set.
    /// 
    /// To set several display options at once, see the `setDisplayOptions` methods.
    public func displayShowCustomEnabled(_ enabled: Bool = true) {
        object.callVoidMethod(name: "setDisplayShowCustomEnabled", args: enabled)
    }

    /// Set whether to include the application home affordance in the action bar. Home is presented as either an activity icon or logo.
    /// 
    /// To set several display options at once, see the `setDisplayOptions` methods.
    public func displayShowHomeEnabled(_ enabled: Bool = true) {
        object.callVoidMethod(name: "setDisplayShowHomeEnabled", args: enabled)
    }

    /// Set whether an activity title/subtitle should be displayed.
    /// 
    /// To set several display options at once, see the `setDisplayOptions` methods.
    public func displayShowTitleEnabled(_ enabled: Bool = true) {
        object.callVoidMethod(name: "setDisplayShowTitleEnabled", args: enabled)
    }
    
    /// Set whether to display the activity logo rather than the activity icon. A logo is often a wider, more detailed image.
    /// 
    /// To set several display options at once, see the `setDisplayOptions` methods.
    public func displayUseLogoEnabled(_ enabled: Bool = true) {
        object.callVoidMethod(name: "setDisplayUseLogoEnabled", args: enabled)
    }

    /// Set the Z-axis elevation of the action bar in pixels.
    ///
    /// The action bar's elevation is the distance it is placed from its parent surface. Higher values are closer to the user.
    public func elevation(_ value: Float, _ unit: DimensionUnit = .dp) {
        object.callVoidMethod(name: "setElevation", args: unit.toPixels(value))
    }

    /// Set the current hide offset of the action bar.
    /// 
    /// The action bar's current hide offset is the distance that the action bar is currently scrolled offscreen in pixels.
    /// The valid range is 0 (fully visible) to the action bar's current measured height (fully invisible).
    public func hideOffset(_ value: Int, _ unit: DimensionUnit = .dp) {
        object.callVoidMethod(name: "setHideOffset", args: unit.toPixels(Int32(value)))
    }

    /// Enable hiding the action bar on content scroll.
    /// 
    /// If enabled, the action bar will scroll out of sight along with a nested scrolling child view's content.
    /// The action bar must be in overlay mode to enable hiding on content scroll.
    /// 
    /// When partially scrolled off screen the action bar is considered hidden.
    /// A call to show will cause it to return to full view.
    public func hideOnContentScrollEnabled(_ enabled: Bool = true) {
        object.callVoidMethod(name: "setHideOnContentScrollEnabled", args: enabled)
    }

    /// Set an alternate description for the Home/Up action, when enabled.
    ///
    /// This description is commonly used for accessibility/screen readers when the Home action is enabled.
    /// (See [setDisplayHomeAsUpEnabled](https://developer.android.com/reference/androidx/appcompat/app/ActionBar#setDisplayHomeAsUpEnabled(boolean)).)
    /// Examples of this are, "Navigate Home" or "Navigate Up" depending on the `DISPLAY_HOME_AS_UP` display option.
    /// If you have changed the home-as-up indicator using `setHomeAsUpIndicator` to indicate more specific functionality
    /// such as a sliding drawer, you should also set this to accurately describe the action.
    ///
    /// Setting this to null will use the system default description.
    public func homeActionContentDescription(_ description: String) {
        guard
            let description = JString(from: description)
        else { return }
        object.callVoidMethod(name: "setHomeActionContentDescription", args: description.signedAsCharSequence())
    }

    /// Set an alternate description for the Home/Up action, when enabled.
    ///
    /// This description is commonly used for accessibility/screen readers when the Home action is enabled.
    /// (See [setDisplayHomeAsUpEnabled](https://developer.android.com/reference/androidx/appcompat/app/ActionBar#setDisplayHomeAsUpEnabled(boolean)).)
    /// Examples of this are, "Navigate Home" or "Navigate Up" depending on the `DISPLAY_HOME_AS_UP` display option.
    /// If you have changed the home-as-up indicator using `setHomeAsUpIndicator` to indicate more specific functionality
    /// such as a sliding drawer, you should also set this to accurately describe the action.
    ///
    /// Setting this to null will use the system default description.
    public func homeActionContentDescription(_ resId: Int32) {
        object.callVoidMethod(name: "setHomeActionContentDescription", args: resId)
    }

    /// Set an alternate drawable to display next to the icon/logo/title when `DISPLAY_HOME_AS_UP` is enabled.
    /// This can be useful if you are using this mode to display an alternate selection for up navigation, such as a sliding drawer.
    ///
    /// If you pass null to this method, the default drawable from the theme will be used.
    ///
    /// If you implement alternate or intermediate behavior around Up,
    /// you should also call `setHomeActionContentDescription()` to provide a correct description of the action for accessibility support.
    public func homeAsUpIndicator(_ drawable: Drawable) {
        object.callVoidMethod(name: "setHomeAsUpIndicator", args: drawable.signed(as: Drawable.className))
    }

    /// Set an alternate drawable to display next to the icon/logo/title when `DISPLAY_HOME_AS_UP` is enabled.
    /// This can be useful if you are using this mode to display an alternate selection for up navigation, such as a sliding drawer.
    ///
    /// If you pass null to this method, the default drawable from the theme will be used.
    ///
    /// If you implement alternate or intermediate behavior around Up,
    /// you should also call `setHomeActionContentDescription()` to provide a correct description of the action for accessibility support.
    public func homeAsUpIndicator(_ resId: Int32) {
        object.callVoidMethod(name: "setHomeAsUpIndicator", args: resId)
    }

    /// Enable or disable the "home" button in the corner of the action bar.
    /// Note that this is the application home/up affordance on the action bar, not the system wide home button.)
    ///
    /// This defaults to true for packages targeting
    /// 
    /// Setting the `DISPLAY_HOME_AS_UP` display option will automatically enable the home button.
    public func homeButtonEnabled(_ enabled: Bool = true) {
        object.callVoidMethod(name: "setHomeButtonEnabled", args: enabled)
    }

    /// Set the icon to display in the 'home' section of the action bar.
    ///
    /// The action bar will use an icon specified by its style or the activity icon by default.
    /// Whether the home section shows an icon or logo is controlled by the display option `DISPLAY_USE_LOGO`.
    public func icon(_ drawable: Drawable) {
        object.callVoidMethod(name: "setIcon", args: drawable.signed(as: Drawable.className))
    }

    /// Set the icon to display in the 'home' section of the action bar.
    ///
    /// The action bar will use an icon specified by its style or the activity icon by default.
    /// Whether the home section shows an icon or logo is controlled by the display option `DISPLAY_USE_LOGO`.
    public func icon(_ resId: Int32) {
        object.callVoidMethod(name: "setIcon", args: resId)
    }

    /// Set the logo to display in the 'home' section of the action bar.
    /// 
    /// The action bar will use a logo specified by its style or the activity logo by default.
    /// Whether the home section shows an icon or logo is controlled by the display option `DISPLAY_USE_LOGO`.
    public func logo(_ drawable: Drawable) {
        object.callVoidMethod(name: "setLogo", args: drawable.signed(as: Drawable.className))
    }

    /// Set the logo to display in the 'home' section of the action bar.
    /// 
    /// The action bar will use a logo specified by its style or the activity logo by default.
    /// Whether the home section shows an icon or logo is controlled by the display option `DISPLAY_USE_LOGO`.
    public func logo(_ resId: Int32) {
        object.callVoidMethod(name: "setLogo", args: resId)
    }

    /// Set the ActionBar's split background.
    /// This will appear in the split action bar containing menu-provided action buttons on some devices and configurations.
    /// 
    /// You can enable split action bar with `uiOptions`
    public func splitBackgroundDrawable(_ drawable: Drawable) {
        object.callVoidMethod(name: "setSplitBackgroundDrawable", args: drawable.signed(as: Drawable.className))
    }

    /// Set the ActionBar's split background.
    /// This will appear in the split action bar containing menu-provided action buttons on some devices and configurations.
    /// 
    /// You can enable split action bar with `uiOptions`
    public func splitBackgroundDrawable(_ resId: Int32) {
        object.callVoidMethod(name: "setSplitBackgroundDrawable", args: resId)
    }

    /// Set the action bar's subtitle.
    /// 
    /// This will only be displayed if `DISPLAY_SHOW_TITLE` is set.
    public func subtitle(_ value: String) {
        guard
            let value = JString(from: value)
        else { return }
        object.callVoidMethod(name: "setSubtitle", args: value.signedAsCharSequence())
    }

    /// Set the action bar's subtitle.
    /// 
    /// This will only be displayed if `DISPLAY_SHOW_TITLE` is set.
    public func subtitle(_ resId: Int32) {
        object.callVoidMethod(name: "setSubtitle", args: resId)
    }

    /// Set the action bar's title.
    /// 
    /// This will only be displayed if `DISPLAY_SHOW_TITLE` is set.
    public func title(_ value: String) {
        guard
            let value = JString(from: value)
        else { return }
        object.callVoidMethod(name: "setTitle", args: value.signedAsCharSequence())
    }

    /// Set the action bar's title.
    /// 
    /// This will only be displayed if `DISPLAY_SHOW_TITLE` is set.
    public func title(_ resId: Int32) {
        object.callVoidMethod(name: "setTitle", args: resId)
    }

    /// Show the `ActionBar` if it is not currently showing.
    /// If the window hosting the `ActionBar` does not have the feature `FEATURE_ACTION_BAR_OVERLAY`
    /// it will resize application content to fit the new space available.
    ///
    /// If you are hiding the `ActionBar` through `View.SYSTEM_UI_FLAG_FULLSCREEN`,
    /// you should not call this function directly.
    public func show() {
        object.callVoidMethod(name: "show")
    }
}