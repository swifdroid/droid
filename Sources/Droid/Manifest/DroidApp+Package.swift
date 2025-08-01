//
//  DroidApp+Package.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Specifies a single app that your app intends to access.
	///
	/// This other app might integrate with your app,
	/// or your app might use services that the other app provides.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/queries-element#package)
	public class Package: ManifestTag {
        override class var name: String { "package" }
		
		required override init() {
            super.init()
        }
		
		public init (_ name: String) {
            super.init()
			params[.androidName] = name
		}
        
        override func uniqueParams() -> [ManifestTagParamName] {
            [.androidName]
        }
	}
}

