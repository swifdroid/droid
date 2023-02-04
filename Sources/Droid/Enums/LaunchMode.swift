//
//  LaunchMode.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

/// An instruction on how the activity should be launched.
///
/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-element#lmode)
public struct LaunchMode: ExpressibleByStringLiteral, StringValuable {
	let value: String
	
	public init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
	
	/// Default. The system always creates a new instance of the activity in the target task and routes the intent to it.
	public static var standard: Self { "standard" }
	
	/// If an instance of the activity already exists at the top of the target task,
	/// the system routes the intent to that instance through a call to its `onNewIntent()` method,
	/// rather than creating a new instance of the activity.
	public static var singleTop: Self { "singleTop" }
	
	/// The system creates the activity at the root of a new task or locates the activity
	/// on an existing task with the same affinity. If an instance of the activity already exists
	/// and is at the root of the task, the system routes the intent to existing instance
	/// through a call to its `onNewIntent()` method, rather than creating a new one.
	public static var singleTask: Self { "singleTask" }
	
	/// Same as "singleTask", except that the system doesn't launch any other activities
	/// into the task holding the instance. The activity is always the single and only member of its task.
	public static var singleInstance: Self { "singleInstance" }
	
	/// The activity can only be running as the root activity of the task,
	/// the first activity that created the task, and therefore there will only be one instance
	/// of this activity in a task; but activity can be instantiated multiple times in different tasks.
	public static var singleInstancePerTask: Self { "singleInstancePerTask" }
}
