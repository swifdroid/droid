//
//  AndroidTextPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 27.01.2022.
//

import DroidFoundation

extension AndroidPackage {
    public class TextPackage: AndroidClassName {}
    
    public var text: TextPackage { .init(superClass: self, "text") }
}
