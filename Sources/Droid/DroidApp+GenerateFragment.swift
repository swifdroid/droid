//
//  DroidApp+GenerateFragment.swift
//  Droid
//
//  Created by Mihael Isaev on 13.12.2025.
//

#if !os(Android)
extension DroidApp {
    func generateFragment(_ fragmentName: String) -> String? {
        return """
        import stream.swift.droid.appkit.views.NativeFragment
        
        class \(fragmentName) : NativeFragment() {}
        """
    }
}
#endif