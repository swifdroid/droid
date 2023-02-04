//
//  LockTaskMode.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

/// Determines how the system presents this activity when the device is running in lock task mode.
///
/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#ltmode)
public struct LockTaskMode: ExpressibleByStringLiteral, StringValuable {
	let value: String
	
	public init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
	
	/// Tasks don't launch into lock task mode but can be placed there by calling startLockTask().
	///
	/// This is the default value.
	public static var normal: Self { "normal" }
	
	/// Tasks don't launch into lockTask mode, and the device user can't pin these tasks from the overview screen.
	public static var never: Self { "never" }
	
	/// If the DPC authorizes this package using `DevicePolicyManager.setLockTaskPackages()`,
	/// then this mode is identical to always, except that the activity needs to call `stopLockTask()`
	/// before being able to finish if it is the last locked task.
	/// If the DPC does not authorize this package then this mode is identical to normal.
	public static var if_whitelisted: Self { "if_whitelisted" }
	
	/// Tasks rooted at this activity always launch into lock task mode.
	///
	/// If the system is already in lock task mode when this task is launched
	/// then the new task are launched on top of the current task.
	/// Tasks launched in this mode can exit lock task mode by calling finish().
	public static var always: Self { "always" }
}
