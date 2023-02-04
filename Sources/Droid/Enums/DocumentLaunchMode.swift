//
//  DocumentLaunchMode.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

public struct DocumentLaunchMode: ExpressibleByStringLiteral, StringValuable {
	let value: String
	
	public init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
	
	/// The system searches for a task whose base intent's **ComponentName**
	/// and data URI match those of the launching intent. If the system finds such a task,
	/// the system clears the task, and restarts with the root activity receiving a call to`onNewIntent(android.content.Intent)`.
	/// If the system does not find such a task, the system creates a new task.
	public static var intoExisting: Self { "intoExisting" }
	
	/// The activity creates a new task for the document, even if the document is already opened.
	/// This is the same as setting both the **FLAG_ACTIVITY_NEW_DOCUMENT** and **FLAG_ACTIVITY_MULTIPLE_TASK** flags.
	public static var always: Self { "always" }
	
	/// The activity does not create a new task for the activity.
	/// This is the default value, which creates a new task only when
	/// **FLAG_ACTIVITY_NEW_TASK** is set. The overview screen
	/// treats the activity as it would by default: it displays a single task for the app,
	/// which resumes from whatever activity the user last invoked.
	public static var none: Self { "none" }
	
	/// This activity is not launched into a new document even if the Intent
	/// contains **FLAG_ACTIVITY_NEW_DOCUMENT**. Setting this overrides
	/// the behavior of the **FLAG_ACTIVITY_NEW_DOCUMENT** and **FLAG_ACTIVITY_MULTIPLE_TASK** flags,
	/// if either of these are set in the activity, and the overview screen displays
	/// a single task for the app, which resumes from whatever activity the user last invoked.
	public static var never: Self { "never" }
}
