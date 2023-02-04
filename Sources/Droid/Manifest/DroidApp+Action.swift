//
//  DroidApp+Action.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Adds an action to an intent filter.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/action-element)
	public class Action: ManifestTag {
		static var name: String { "action" }
		
		var params: [ManifestTagParam] = []
		var items: [ManifestTag] = []
		
		required init() {}
		
		public init (_ action: IntentActionType) {
			params.append(.init(.androidName, action.value))
		}
	}
}

