//
//  ContentContext.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

extension AndroidPackage.ContentPackage {
    public class ContextClass: JClassName, @unchecked Sendable {}
    
    public var Context: ContextClass { .init(parent: self, name: "Context") }
}

// class ContentContext: @unchecked Sendable, JObjectable {
//     func ppp() {
//         print(.info, "🪚context: \(self.classObject)")
//     }
// }
