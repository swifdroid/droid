//
//  DroidApp+GenerateActivity.swift
//  
//
//  Created by Mihael Isaev on 26.02.2023.
//

#if !os(Android)
extension DroidApp {
    func generateActivity(_ activity: Activity.Type) -> String? {
        let imports = activity.javaImports.map { "import \($0)" }.joined(separator: "\n")
        return """
        \(imports)
        
        class \(activity.className) : \(activity.parentClass) {}
        """
    }
}
#endif