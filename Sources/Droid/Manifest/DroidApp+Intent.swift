//
//  DroidApp+Intent.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Specifies an intent filter signature.
	///
	/// Your app can discover other apps that have matching
	/// [<intent-filter>](https://developer.android.com/training/basics/intents/filters) elements.
	///
	/// [Learn more](https://developer.android.com/training/package-visibility/declaring)
	public class Intent: ManifestTag {
		static var name: String { "intent" }
		
		var params: [ManifestTagParam] = []
		var items: [ManifestTag] = []
		
		required init() {}
		
		// MARK: -
		
		public func action(_ type: IntentActionType) -> Self {
			items.append(Action(type))
			return self
		}
		
		public static func action(_ type: IntentActionType) -> Self {
			Self().action(type)
		}
		
		// MARK: -
		
		public func category(_ type: IntentCategoryType) -> Self {
			items.append(Category(type))
			return self
		}
		
		public static func category(_ type: IntentCategoryType) -> Self {
			Self().category(type)
		}
		
		// MARK: -
		
		public func data(_ handler: () -> Data) -> Self {
			items.append(handler())
			return self
		}
		
		public static func data(_ handler: @escaping () -> Data) -> Self {
			Self().data(handler)
		}
		
		func missingItems() -> [String] {
			var missing: [ManifestTag.Type] = []
			if !items.contains(Action.self) {
				missing.append(Action.self)
			}
			return missing.map { $0.name }
		}
	}
}

