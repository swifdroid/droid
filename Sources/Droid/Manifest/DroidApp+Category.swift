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
		static var name: String { "category" }
		
		var params: [ManifestTagParam] = []
		var items: [ManifestTag] = []
		
		required init() {}
		
		public init (_ type: IntentCategoryType) {
			params.append(.init(.androidName, type.value))
		}
	}
}

