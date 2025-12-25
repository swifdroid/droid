//
//  ActionBar.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// A primary toolbar within the activity that may display the activity title,
/// application-level navigation affordances, and other interactive items.
/// 
/// Beginning with Android 3.0 (API level 11), the action bar appears
/// at the top of an activity's window when the activity uses the system's
/// Holo theme (or one of its descendant themes), which is the default.
/// You may otherwise add the action bar by calling
/// `requestFeature(FEATURE_ACTION_BAR)` or by declaring it in a custom theme
/// with the `windowActionBar` property.
/// 
/// Beginning with Android L (API level 21), the action bar may be represented
/// by any Toolbar widget within the application layout. The application may
/// signal to the Activity which Toolbar should be treated as the Activity's action bar.
/// Activities that use this feature should use one of the supplied .NoActionBar
/// themes, set the windowActionBar attribute to false or otherwise not request
/// the window feature.
/// 
/// By adjusting the window features requested by the theme and the layouts used
/// for an Activity's content view, an app can use the standard system action bar
/// on older platform releases and the newer inline toolbars on newer platform
/// releases. The ActionBar object obtained from the Activity can be used
/// to control either configuration transparently.
/// 
/// When using the Holo themes the action bar shows the application icon on the
/// left, followed by the activity title. If your activity has an options menu,
/// you can make select items accessible directly from the action bar
/// as "action items". You can also modify various characteristics of the action
/// bar or remove it completely.
/// 
/// When using the Material themes (default in API 21 or newer) the navigation
/// button (formerly "Home") takes over the space previously occupied
/// by the application icon. Apps wishing to express a stronger branding
/// should use their brand colors heavily in the action bar and other application
/// chrome or use a logo in place of their standard title text.
/// 
/// From your activity, you can retrieve an instance of ActionBar
/// by calling `getActionBar()`.
/// 
/// In some cases, the action bar may be overlayed by another bar that enables
/// contextual actions, using an ActionMode. For example, when the user selects
/// one or more items in your activity, you can enable an action mode
/// that offers actions specific to the selected items, with a UI that temporarily
/// replaces the action bar. Although the UI may occupy the same space,
/// the ActionMode APIs are distinct and independent from those for ActionBar.
///
/// [Learn more](https://developer.android.com/reference/android/app/ActionBar)
@MainActor
open class ActionBar: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/app/ActionBar" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

// TODO: implement ActionBar methods