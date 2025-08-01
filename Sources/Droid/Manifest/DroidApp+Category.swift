//
//  DroidApp+Category.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Adds a category name to an intent filter.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/category-element)
	public class Category: ManifestTag {
        override class var name: String { "category" }
		
		required override init() {
            super.init()
        }
		
		public init (_ type: IntentCategoryType) {
            super.init()
            params[.androidName] = ManifestTagParamValue(type.value).value
		}
        
        override func uniqueParams() -> [ManifestTagParamName] {
            [.androidName]
        }
	}
}

