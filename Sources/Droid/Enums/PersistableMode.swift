//
//  PersistableMode.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

/// Defines how an instance of an activity is preserved within a containing task across device restarts.
///
/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#persistableMode)
public struct PersistableMode: ExpressibleByStringLiteral, StringValuable {
	let value: String
	
	public init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
	
	/// When the system restarts, the activity task is preserved, but only the root activity's launching intent is used.
	///
	/// Default value.
	public static var persistRootOnly: Self { "persistRootOnly" }
	
	/// This activity's state is preserved, along with the state of each activity higher up
	/// the back stack that has its own persistableMode attribute set to persistAcrossReboots.
	///
	/// If an activity doesn't have a persistableMode attribute that is set to persistAcrossReboots,
	/// or if it's launched using the Intent. **FLAG_ACTIVITY_NEW_DOCUMENT** flag,
	/// then that activity, along with all activities higher up the back stack, aren't preserved.
	public static var persistAcrossReboots: Self { "persistAcrossReboots" }
	
	/// The activity's state isn't preserved.
	public static var persistNever: Self { "persistNever" }
}
