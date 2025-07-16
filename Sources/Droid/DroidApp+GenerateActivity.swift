//
//  DroidApp+GenerateActivity.swift
//  
//
//  Created by Mihael Isaev on 26.02.2023.
//

import FoundationEssentials

#if !os(Android)
extension DroidApp {
    func generateActivity(_ name: String) -> String? {
        guard let app = _manifest.items.compactMap({ $0 as? Application }).first else { return nil }
        guard let activity = app.items.compactMap({ $0 as? ActivityTag }).first(where: { $0.class.className.name == name }) else { return nil }
        let standardImports = [
            "android.os.Bundle",
            "java.util.*",
            "swift.App"
        ]
        let imports = (standardImports + activity.class.requiredImports).map { "import \($0)" }.joined(separator: "\n")
        return """
        \(imports)
        
        class \(activity.class.className.name) : \(activity.class.parentClass) {
            val app = App()

            override fun onCreate(savedInstanceState: Bundle?) {
                super.onCreate(savedInstanceState)
                app.initialize(this)
            }

            override fun onDestroy() {
                super.onDestroy()
                app.deinitialize(this)
            }
        }
        """
    }
}
#endif