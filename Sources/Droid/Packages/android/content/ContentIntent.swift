//
//  ContentIntent.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

extension AndroidPackage.ContentPackage {
    public class IntentClass: JClassName, @unchecked Sendable {}
    
    public var Intent: IntentClass { .init(parent: self, name: "Intent") }
}

// class ContentIntent: @unchecked Sendable, JObjectable {
//     func ppp() {
//         print(.info, "🪚context: \(self.classObject)")
//     }
// }
