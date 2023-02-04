//
//  ConfigChangeType.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

public struct ConfigChangeType: ExpressibleByStringLiteral, StringValuable {
	let value: String
	
	public init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
	
	/// The display density has changed — the user might have specified
	/// a different display scale, or a different display might now be active.
	public static var density: Self { "density" }
	
	/// The font scaling factor has changed — the user has selected a new global font size.
	public static var fontScale: Self { "fontScale" }
	
	/// The keyboard type has changed — for example, the user has plugged in an external keyboard.
	public static var keyboard: Self { "keyboard" }
	
	/// The keyboard accessibility has changed — for example, the user has revealed the hardware keyboard.
	public static var keyboardHidden: Self { "keyboardHidden" }
	
	/// The layout direction has changed — for example, changing from left-to-right (LTR) to right-to-left (RTL).
	public static var layoutDirection: Self { "layoutDirection" }
	
	/// The locale has changed — the user has selected a new language that text should be displayed in.
	public static var locale: Self { "locale" }
	
	/// The IMSI mobile country code (MCC) has changed — a SIM has been detected and updated the MCC.
	public static var mcc: Self { "mcc" }
	
	/// The IMSI mobile network code (MNC) has changed — a SIM has been detected and updated the MNC.
	public static var mnc: Self { "mnc" }
	
	/// The navigation type (trackball/dpad) has changed. (This should never normally happen.)
	public static var navigation: Self { "navigation" }
	
	/// The screen orientation has changed — the user has rotated the device.
	public static var orientation: Self { "orientation" }
	
	/// The screen layout has changed — a different display might now be active.
	public static var screenLayout: Self { "screenLayout" }
	
	/// The current available screen size has changed.
	/// This represents a change in the currently available size, relative to the current aspect ratio,
	/// so will change when the user switches between landscape and portrait.
	public static var screenSize: Self { "screenSize" }
	
	/// The physical screen size has changed.
	/// This represents a change in size regardless of orientation, so will only change
	/// when the actual physical screen size has changed such as switching to an external display.
	/// A change to this configuration corresponds to a change in the smallestWidth configuration.
	public static var smallestScreenSize: Self { "smallestScreenSize" }
	
	/// The touchscreen has changed. (This should never normally happen.)
	public static var touchscreen: Self { "touchscreen" }
	
	/// The user interface mode has changed — the user has placed the device into a desk
	/// or car dock, or the night mode has changed. For more information
	/// about the different UI modes, see UiModeManager.
	public static var uiMode: Self { "uiMode" }
}
