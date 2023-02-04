//
//  FlagType.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

public struct FlagType: ExpressibleByIntegerLiteral {
	let value: Int
	
	public init(integerLiteral value: IntegerLiteralType) {
		self.value = value
	}
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_BROUGHT_TO_FRONT)
	public static var ACTIVITY_BROUGHT_TO_FRONT: Self { 0x00400000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_CLEAR_TASK)
	public static var ACTIVITY_CLEAR_TASK: Self { 0x00008000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_CLEAR_TOP)
	public static var ACTIVITY_CLEAR_TOP: Self { 0x04000000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET)
	public static var ACTIVITY_CLEAR_WHEN_TASK_RESET: Self { 0x00080000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS)
	public static var ACTIVITY_EXCLUDE_FROM_RECENTS: Self { 0x00800000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_FORWARD_RESULT)
	public static var ACTIVITY_FORWARD_RESULT: Self { 0x02000000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_LAUNCHED_FROM_HISTORY)
	public static var ACTIVITY_LAUNCHED_FROM_HISTORY: Self { 0x00100000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_LAUNCH_ADJACENT)
	public static var ACTIVITY_LAUNCH_ADJACENT: Self { 0x00001000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_MATCH_EXTERNAL)
	public static var ACTIVITY_MATCH_EXTERNAL: Self { 0x00000800 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_MULTIPLE_TASK)
	public static var ACTIVITY_MULTIPLE_TASK: Self { 0x08000000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_NEW_DOCUMENT)
	public static var ACTIVITY_NEW_DOCUMENT: Self { 0x00080000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_NEW_TASK)
	public static var ACTIVITY_NEW_TASK: Self { 0x10000000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_NO_ANIMATION)
	public static var ACTIVITY_NO_ANIMATION: Self { 0x00010000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_NO_HISTORY)
	public static var ACTIVITY_NO_HISTORY: Self { 0x40000000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_NO_USER_ACTION)
	public static var ACTIVITY_NO_USER_ACTION: Self { 0x00040000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_PREVIOUS_IS_TOP)
	public static var ACTIVITY_PREVIOUS_IS_TOP: Self { 0x01000000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_REORDER_TO_FRONT)
	public static var ACTIVITY_REORDER_TO_FRONT: Self { 0x00020000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_REQUIRE_DEFAULT)
	public static var ACTIVITY_REQUIRE_DEFAULT: Self { 0x00000200 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_REQUIRE_NON_BROWSER)
	public static var ACTIVITY_REQUIRE_NON_BROWSER: Self { 0x00000400 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_RESET_TASK_IF_NEEDED)
	public static var ACTIVITY_RESET_TASK_IF_NEEDED: Self { 0x00200000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_RETAIN_IN_RECENTS)
	public static var ACTIVITY_RETAIN_IN_RECENTS: Self { 0x00002000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_SINGLE_TOP)
	public static var ACTIVITY_SINGLE_TOP: Self { 0x20000000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_TASK_ON_HOME)
	public static var ACTIVITY_TASK_ON_HOME: Self { 0x00004000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_DEBUG_LOG_RESOLUTION)
	public static var DEBUG_LOG_RESOLUTION: Self { 0x00000008 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_DIRECT_BOOT_AUTO)
	public static var DIRECT_BOOT_AUTO: Self { 0x00000100 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_EXCLUDE_STOPPED_PACKAGES)
	public static var EXCLUDE_STOPPED_PACKAGES: Self { 0x00000010 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_FROM_BACKGROUND)
	public static var FROM_BACKGROUND: Self { 0x00000004 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_GRANT_PERSISTABLE_URI_PERMISSION)
	public static var GRANT_PERSISTABLE_URI_PERMISSION: Self { 0x00000040 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_GRANT_PREFIX_URI_PERMISSION)
	public static var GRANT_PREFIX_URI_PERMISSION: Self { 0x00000080 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_GRANT_READ_URI_PERMISSION)
	public static var GRANT_READ_URI_PERMISSION: Self { 0x00000001 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_INCLUDE_STOPPED_PACKAGES)
	public static var INCLUDE_STOPPED_PACKAGES: Self { 0x00000020 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_RECEIVER_FOREGROUND)
	public static var RECEIVER_FOREGROUND: Self { 0x10000000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_RECEIVER_NO_ABORT)
	public static var RECEIVER_NO_ABORT: Self { 0x08000000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_RECEIVER_REGISTERED_ONLY)
	public static var RECEIVER_REGISTERED_ONLY: Self { 0x40000000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_RECEIVER_REPLACE_PENDING)
	public static var RECEIVER_REPLACE_PENDING: Self { 0x20000000 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FLAG_RECEIVER_VISIBLE_TO_INSTANT_APPS)
	public static var RECEIVER_VISIBLE_TO_INSTANT_APPS: Self { 0x00200000 }
}
