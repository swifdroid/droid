//
//  FillInType.swift
//  
//
//  Created by Mihael Isaev on 23.04.2022.
//

public struct FillInType: ExpressibleByIntegerLiteral {
	let value: Int
	
	public init(integerLiteral value: IntegerLiteralType) {
		self.value = value
	}
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FILL_IN_ACTION)
	public static var IN_ACTION: Self { 0x00000001 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FILL_IN_CATEGORIES)
	public static var IN_CATEGORIES: Self { 0x00000004 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FILL_IN_CLIP_DATA)
	public static var IN_CLIP_DATA: Self { 0x00000080 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FILL_IN_COMPONENT)
	public static var IN_COMPONENT: Self { 0x00000008 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FILL_IN_DATA)
	public static var IN_DATA: Self { 0x00000002 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FILL_IN_IDENTIFIER)
	public static var IN_IDENTIFIER: Self { 0x00000100 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FILL_IN_PACKAGE)
	public static var IN_PACKAGE: Self { 0x00000010 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FILL_IN_SELECTOR)
	public static var IN_SELECTOR: Self { 0x00000040 }
	
	/// [Learn more](https://developer.android.com/reference/android/content/Intent#FILL_IN_SOURCE_BOUNDS)
	public static var IN_SOURCE_BOUNDS: Self { 0x00000020 }
}
