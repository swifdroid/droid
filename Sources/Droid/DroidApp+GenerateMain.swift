//
//  DroidApp+GenerateMain.swift
//  
//
//  Created by Mihael Isaev on 01.03.2023.
//

extension DroidApp {
    func generateMain(_ name: String) -> String? {
        let args = androidBuildingArguments
        let standardImports = [
            "android.content.Context"
        ]
//        let imports = (standardImports + activity.class.javaImports).map { "import \($0)" }.joined(separator: "\n")
        let imports = standardImports.map { "import \($0)" }.joined(separator: "\n")
        return """
        \(imports)
        
        class Main {
           companion object {
              init {
                 System.loadLibrary("\(args.mainTarget)")
              }
           }

           external fun initialize(context: Context)
           external fun deinitialize(context: Context)
        }
        """
    }
}
