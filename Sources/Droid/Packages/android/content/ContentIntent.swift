//
//  ContentIntent.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

import DroidFoundation

extension AndroidPackage.ContentPackage {
    public class IntentClass: AndroidClassName {}
    
    public var Intent: IntentClass { .init(superClass: self, "Intent") }
}

class ContentIntent: JClass {
    func ppp() {
        print(.info, "🪚context: \(self.classObject)")
    }
}
