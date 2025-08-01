//
//  DroidApp+Screen.swift
//  
//
//  Created by Mihael Isaev on 21.04.2022.
//

extension DroidApp {
	public class Screen: ManifestTag {
        override class var name: String { "screen" }
		
		var screenSizes: [ScreenSize] = []
		var screenDensities: [ScreenDensity] = []
		
        override func missingParams() -> [String] {
            guard params.keys.contains(.androidScreenSize), params.keys.contains(.androidScreenDensity) else { return ["screenSizes", "screenDensities"] }
			return []
		}
	}
	
	public class CompatibleScreens: ManifestTag {
        override class var name: String { "compatible-screens" }
		
		public override init () {
            super.init()
        }
		
		public func screen(_ screen: Screen) -> Self {
			items.append(screen)
			return self
		}
		
        override func missingItems() -> [String] {
			guard items.contains(Screen.self) else { return ["screen"] }
			return []
		}
	}
}
