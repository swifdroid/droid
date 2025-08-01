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
        override class var name: String { "action" }
		
        required override init() {
            super.init()
        }
		
		public init (_ action: IntentActionType) {
            super.init()
			params[.androidName] = action.value
		}
        
        override func uniqueParams() -> [ManifestTagParamName] {
            [.androidName]
        }
	}
}

