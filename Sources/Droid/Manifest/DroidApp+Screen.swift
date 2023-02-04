//
//  DroidApp+Screen.swift
//  
//
//  Created by Mihael Isaev on 21.04.2022.
//

extension DroidApp {
	public class Screen: ManifestTag {
		static var name: String { "screen" }
		
		var params: [ManifestTagParam] = []
		var items: [ManifestTag] = []
		
		var screenSizes: [ScreenSize] = []
		var screenDensities: [ScreenDensity] = []
		
		func missingParams() -> [String] {
			guard params.contains(.androidScreenSize), params.contains(.androidScreenDensity) else { return ["screenSizes", "screenDensities"] }
			return []
		}
	}
	
	public class CompatibleScreens: ManifestTag {
		static var name: String { "compatible-screens" }
		
		var params: [ManifestTagParam] = []
		var items: [ManifestTag] = []
		
		public init () {}
		
		public func screen(_ screen: Screen) -> Self {
			items.append(screen)
			return self
		}
		
		func missingItems() -> [String] {
			guard items.contains(Screen.self) else { return ["screen"] }
			return []
		}
	}
}
