//
//  ScreenOrientation.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

/// The orientation of the activity's display on the device.
///
/// The system ignores this attribute if the activity is running in multi-window mode.
///
/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#screen)
public struct ScreenOrientation: ExpressibleByStringLiteral, StringValuable {
	let value: String
	
	public init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
	
	/// The default value. The system chooses the orientation.
	/// The policy it uses, and therefore the choices made in specific contexts,
	/// may differ from device to device.
	public static var unspecified: Self { "unspecified" }
	
	/// The same orientation as the activity that's immediately beneath it in the activity stack.
	public static var behind: Self { "behind" }
	
	/// Landscape orientation (the display is wider than it is tall).
	public static var landscape: Self { "landscape" }
	
	/// Portrait orientation (the display is taller than it is wide).
	public static var portrait: Self { "portrait" }
	
	/// Landscape orientation in the opposite direction from normal landscape.
	public static var reverseLandscape: Self { "reverseLandscape" }
	
	/// Portrait orientation in the opposite direction from normal portrait.
	public static var reversePortrait: Self { "reversePortrait" }
	
	/// Landscape orientation, but can be either normal or reverse landscape
	/// based on the device sensor. The sensor is used even if the user has locked sensor-based rotation.
	public static var sensorLandscape: Self { "sensorLandscape" }
	
	/// Portrait orientation, but can be either normal or reverse portrait
	/// based on the device sensor. The sensor is used even if the user has locked sensor-based rotation.
	public static var sensorPortrait: Self { "sensorPortrait" }
	
	/// Landscape orientation, but can be either normal or reverse landscape
	/// based on the device sensor and the user's preference.
	public static var userLandscape: Self { "userLandscape" }
	
	/// Portrait orientation, but can be either normal or reverse portrait
	/// based on the device sensor and the user's preference.
	public static var userPortrait: Self { "userPortrait" }
	
	/// The orientation is determined by the device orientation sensor.
	/// The orientation of the display depends on how the user is holding the device;
	/// it changes when the user rotates the device. Some devices, though,
	/// will not rotate to all four possible orientations, by default. To allow all four orientations,
	/// use "fullSensor" The sensor is used even if the user locked sensor-based rotation.
	public static var sensor: Self { "sensor" }
	
	/// The orientation is determined by the device orientation sensor for any of the 4 orientations.
	/// This is similar to "sensor" except this allows any of the 4 possible screen orientations,
	/// regardless of what the device will normally do (for example, some devices won't normally
	/// use reverse portrait or reverse landscape, but this enables those).
	public static var fullSensor: Self { "fullSensor" }
	
	/// The orientation is determined without reference to a physical orientation sensor.
	/// The sensor is ignored, so the display will not rotate based on how the user moves the device.
	public static var nosensor: Self { "nosensor" }
	
	/// The user's current preferred orientation.
	public static var user: Self { "user" }
	
	/// If the user has locked sensor-based rotation, this behaves the same as user,
	/// otherwise it behaves the same as fullSensor and allows any of the 4 possible screen orientations.
	public static var fullUser: Self { "fullUser" }
	
	/// Locks the orientation to its current rotation, whatever that is.
	public static var locked: Self { "locked" }
}
