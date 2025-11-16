//
//  DroidApp+Screen.swift
//  
//
//  Created by Mihael Isaev on 21.04.2022.
//

extension DroidApp {
	/// Specifies a single screen configuration with which the application is compatible.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/compatible-screens-element#screen)
	public class Screen: ManifestTag {
        override class var name: String { "screen" }
		
		public init (_ size: ScreenSize, _ density: ScreenDensity) {
			super.init()
			params[.androidScreenSize] = ManifestTagParamValue(size).value
			params[.androidScreenDensity] = ManifestTagParamValue(density).value
		}
		
		required override init() {
			super.init()
		}

		override func missingParams() -> [String] {
            guard params.keys.contains(.androidScreenSize), params.keys.contains(.androidScreenDensity) else { return ["screenSizes", "screenDensities"] }
			return []
		}
	}
	
	/// Specifies each screen configuration with which the application is compatible.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/compatible-screens-element)
	public class CompatibleScreens: ManifestTag {
        override class var name: String { "compatible-screens" }
		
		public override init () {
            super.init()
        }
		
		/// Single screen configuration with which the application is compatible.
		public func screen(_ size: ScreenSize, _ density: ScreenDensity) -> CompatibleScreens {
			items.append(Screen(size, density))
			return self
		}

		/// Single screen configuration with which the application is compatible.
		public static func screen(_ size: ScreenSize, _ density: ScreenDensity) -> CompatibleScreens {
			CompatibleScreens().screen(size, density)
		}
		
        override func missingItems() -> [String] {
			guard items.contains(Screen.self) else { return ["screen"] }
			return []
		}
	}
}
