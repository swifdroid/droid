//
//  WindowSoftInputMode.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

/// How the main window of the activity interacts with the window containing the on-screen soft keyboard.
///
/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#wsoft)
public struct WindowSoftInputMode: ExpressibleByStringLiteral, StringValuable {
	let value: String
	
	public init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
	
	/// The state of the soft keyboard (whether it is hidden or visible) is not specified.
	/// The system will choose an appropriate state or rely on the setting in the theme.
	/// This is the default setting for the behavior of the soft keyboard.
	public static var stateUnspecified: Self { "stateUnspecified" }
	
	/// The soft keyboard is kept in whatever state it was last in,
	/// whether visible or hidden, when the activity comes to the fore.
	public static var stateUnchanged: Self { "stateUnchanged" }
	
	/// The soft keyboard is hidden when the user chooses the activity — that is,
	/// when the user affirmatively navigates forward to the activity,
	/// rather than backs into it because of leaving another activity.
	public static var stateHidden: Self { "stateHidden" }
	
	/// The soft keyboard is always hidden when the activity's main window has input focus.
	public static var stateAlwaysHidden: Self { "stateAlwaysHidden" }
	
	/// The soft keyboard is made visible when the user chooses the activity — that is,
	/// when the user affirmatively navigates forward to the activity, rather than backs into it because of leaving another activity.
	public static var stateVisible: Self { "stateVisible" }
	
	/// The soft keyboard is visible when the window receives input focus.
	public static var stateAlwaysVisible: Self { "stateAlwaysVisible" }
	
	/// It is unspecified whether the activity's main window resizes to make room for the soft keyboard,
	/// or whether the contents of the window pan to make the current focus visible on-screen.
	/// The system will automatically select one of these modes depending on whether the content
	/// of the window has any layout views that can scroll their contents. If there is such a view, the window
	/// will be resized, on the assumption that scrolling can make all of the window's contents visible within a smaller area.
	/// This is the default setting for the behavior of the main window.
	public static var adjustUnspecified: Self { "adjustUnspecified" }
	
	/// The activity's main window is always resized to make room for the soft keyboard on screen.
	public static var adjustResize: Self { "adjustResize" }
	
	/// The activity's main window is not resized to make room for the soft keyboard.
	/// Rather, the contents of the window are automatically panned so that
	/// the current focus is never obscured by the keyboard and users
	/// can always see what they are typing. This is generally less desirable than resizing,
	/// because the user may need to close the soft keyboard to get
	/// at and interact with obscured parts of the window.
	public static var adjustPan: Self { "adjustPan" }
}
