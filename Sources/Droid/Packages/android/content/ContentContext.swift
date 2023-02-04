//
//  ContentContext.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

import DroidFoundation

extension AndroidPackage.ContentPackage {
    public class ContextClass: AndroidClassName {}
    
    public var Context: ContextClass { .init(superClass: self, "Context") }
}

class ContentContext: JClass {
    func ppp() {
        print(.info, "🪚context: \(self.classObject)")
    }
}
