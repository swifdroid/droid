//
//  Window.swift
//  
//
//  Created by Mihael Isaev on 25.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

/// Abstract base class for a top-level window look and behavior policy.
/// An instance of this class should be used as the top-level view added to the window manager.
/// It provides standard UI policies such as a background, title area, default key processing, etc.
/// 
/// The framework will instantiate an implementation of this class on behalf of the application.
///
/// [Learn more](https://developer.android.com/reference/android/view/Window)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
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
    // TODO: addFlags
    // TODO: clearFlags
    // TODO: closePanel
    // TODO: findViewById
    // TODO: getAllowEnterTransitionOverlap
    // TODO: getAllowReturnTransitionOverlap
    // TODO: getCallback
    // TODO: getColorMode
    // TODO: getContainer
    // TODO: getContentScene
    // TODO: getContext
    // TODO: getCurrentFocus
    // TODO: getDecorView
    // TODO: getDefaultFeatures
    // TODO: getDesiredHdrHeadroom
    // TODO: getEnterTransition
    // TODO: getExitTransition
    // TODO: getFrameRateBoostOnTouchEnabled
    // TODO: getInsetsController
    // TODO: getLayoutInflater
    // TODO: getMediaController
    // TODO: getNavigationBarColor
    // TODO: getNavigationBarDividerColor
    // TODO: getOnBackInvokedDispatcher
    // TODO: getReenterTransition
    // TODO: getReturnTransition
    // TODO: getRootSurfaceControl
    // TODO: getSharedElementEnterTransition
    // TODO: getSharedElementExitTransition
    // TODO: getSharedElementReenterTransition
    // TODO: getSharedElementReturnTransition
    // TODO: getSharedElementsUseOverlay
    // TODO: getStatusBarColor
    // TODO: getSystemGestureExclusionRects
    // TODO: getTransitionBackgroundFadeDuration
    // TODO: getTransitionManager
    // TODO: getVolumeControlStream
    // TODO: getWindowManager
    // TODO: getWindowStyle
    // TODO: hasChildren
    // TODO: hasFeature
    // TODO: injectInputEvent
    // TODO: invalidatePanelMenu
    // TODO: isActive
    // TODO: isFloating
    // TODO: isFrameRatePowerSavingsBalanced
    // TODO: isNavigationBarContrastEnforced
    // TODO: isShortcutKey
    // TODO: isStatusBarContrastEnforced
    // TODO: isWideColorGamut
    // TODO: makeActive
    // TODO: onConfigurationChanged
    // TODO: openPanel
    // TODO: peekDecorView
    // TODO: performContextMenuIdentifierAction
    // TODO: performPanelIdentifierAction
    // TODO: performPanelShortcut
    // TODO: registerScrollCaptureCallback
    // TODO: removeOnFrameMetricsAvailableListener
    // TODO: requestFeature
    // TODO: requireViewById
    // TODO: restoreHierarchyState
    // TODO: saveHierarchyState
    // TODO: setAllowEnterTransitionOverlap
    // TODO: setAllowReturnTransitionOverlap
    // TODO: setAttributes
    // TODO: setBackgroundBlurRadius
    // TODO: setBackgroundDrawable
    // TODO: setBackgroundDrawableResource
    // TODO: setCallback
    // TODO: setChildDrawable
    // TODO: setChildInt
    // TODO: setClipToOutline
    // TODO: setColorMode
    // TODO: setContainer
    // TODO: setContentView
    // TODO: setContentView
    // TODO: setContentView
    // TODO: setDecorCaptionShade
    // TODO: setDecorFitsSystemWindows
    // TODO: setDesiredHdrHeadroom
    // TODO: setDimAmount
    // TODO: setElevation
    // TODO: setEnterTransition
    // TODO: setExitTransition
    // TODO: setFeatureDrawable
    // TODO: setFeatureDrawableAlpha
    // TODO: setFeatureDrawableResource
    // TODO: setFeatureDrawableUri
    // TODO: setFeatureInt
    // TODO: setFlags
    // TODO: setFormat
    // TODO: setFrameRateBoostOnTouchEnabled
    // TODO: setFrameRatePowerSavingsBalanced
    // TODO: setGravity
    // TODO: setHideOverlayWindows
    // TODO: setIcon
    // TODO: setLayout
    // TODO: setLocalFocus
    // TODO: setLogo
    // TODO: setMediaController
    // TODO: setNavigationBarColor
    // TODO: setNavigationBarContrastEnforced
    // TODO: setNavigationBarDividerColor
    // TODO: setPreferMinimalPostProcessing
    // TODO: setReenterTransition
    // TODO: setResizingCaptionDrawable
    // TODO: setRestrictedCaptionAreaListener
    // TODO: setReturnTransition
    // TODO: setSharedElementEnterTransition
    // TODO: setSharedElementExitTransition
    // TODO: setSharedElementReenterTransition
    // TODO: setSharedElementReturnTransition
    // TODO: setSharedElementsUseOverlay
    // TODO: setSoftInputMode
    // TODO: setStatusBarColor
    // TODO: setStatusBarContrastEnforced
    // TODO: setSustainedPerformanceMode
    // TODO: setSystemGestureExclusionRects
    // TODO: setTitle
    // TODO: setTitleColor
    // TODO: setTransitionBackgroundFadeDuration
    // TODO: setTransitionManager
    // TODO: setType
    // TODO: setUiOptions
    // TODO: setVolumeControlStream
    // TODO: setWindowAnimations
    // TODO: setWindowManager
    // TODO: setWindowManager
    // TODO: superDispatchGenericMotionEvent
    // TODO: superDispatchKeyEvent
    // TODO: superDispatchKeyShortcutEvent
    // TODO: superDispatchTouchEvent
    // TODO: superDispatchTrackballEvent
    // TODO: takeInputQueue
    // TODO: takeKeyEvents
    // TODO: takeSurface
    // TODO: togglePanel
    // TODO: unregisterScrollCaptureCallback
}

/// Abstract base class for a top-level window look and behavior policy.
/// An instance of this class should be used as the top-level view added to the window manager.
/// It provides standard UI policies such as a background, title area, default key processing, etc.
/// 
/// The framework will instantiate an implementation of this class on behalf of the application.
///
/// [Learn more](https://developer.android.com/reference/androidx/core/view/WindowCompat)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class WindowCompat: JObjectable, Sendable {
    public static var className: JClassName { "androidx/appcompat/app/AppCompatDelegate" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

extension WindowCompat {
    public enum Feature: Int32 {
        /// Flag for enabling the Action Bar.
        case actionBar = 8
        /// Flag for requesting an Action Bar that overlays window content.
        case actionBarOverlay = 9
        /// Flag for specifying the behavior of action modes when an Action Bar is not present.
        case actionModeOverlay = 10
    }
}

/// This class represents a delegate which you can use to extend AppCompat's support to any `android.app.Activity`.
///
/// [Learn more](https://developer.android.com/reference/androidx/appcompat/app/AppCompatDelegate#FEATURE_ACTION_MODE_OVERLAY())
#if canImport(AndroidLooper)
@UIThreadActor
#endif
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
#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class ActionBar: JObjectable, Sendable {
    public static var className: JClassName { "androidx/appcompat/app/ActionBar" }
    public static var lpClassName: JClassName { "androidx/appcompat/app/ActionBar$LayoutParams" }

    public let object: JObject
    public unowned let context: ActivityContext

    public init (_ object: JObject, _ context: ActivityContext) {
        self.object = object
        self.context = context
    }
}

extension ActionBar {
    // TODO: addOnMenuVisibilityListener
    // TODO: addTab

    /// The current custom view.
    public func customView() -> View! {
        guard
            let returningClazz = JClass.load(.android.view.View),
            let global = object.callObjectMethod(name: "getCustomView", returningClass: returningClazz)
        else { return nil }
        let id = Int32.nextViewId()
        return .init(id: id, global, context)
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
        return unit.from(value)
    }

    /// Retrieve the current height of the ActionBar.
    public func height(_ unit: DimensionUnit = .dp) -> Int! {
        guard
            let value = object.callIntMethod(name: "getHeight")
        else { return nil }
        return unit.from(value)
    }

    /// Return the current vertical offset of the action bar.
    /// 
    /// The action bar's current hide offset is the distance that the action bar is currently scrolled offscreen in pixels.
    /// The valid range is 0 (fully visible) to the action bar's current measured height (fully invisible).
    public func hideOffset(_ unit: DimensionUnit = .dp) -> Int! {
        guard
            let value = object.callIntMethod(name: "getHideOffset")
        else { return nil }
        return unit.from(value)
    }
}

extension ActionBar {
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
        object.callVoidMethod(name: "setCustomView", args: view.signed(as: View.className), lp.signed(as: ActionBar.lpClassName))
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
    public func elevation(_ value: Float, unit: DimensionUnit = .dp) {
        object.callVoidMethod(name: "setElevation", args: unit.toPixels(value))
    }

    /// Set the current hide offset of the action bar.
    /// 
    /// The action bar's current hide offset is the distance that the action bar is currently scrolled offscreen in pixels.
    /// The valid range is 0 (fully visible) to the action bar's current measured height (fully invisible).
    public func hideOffset(_ value: Int, unit: DimensionUnit = .dp) {
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