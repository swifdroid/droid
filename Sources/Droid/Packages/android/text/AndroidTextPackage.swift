//
//  AndroidTextPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 27.01.2022.
//

import DroidFoundation

extension AndroidPackage {
    public class TextPackage: JClassName, @unchecked Sendable {}
    
    public var text: TextPackage { .init(parent: self, name: "text") }
}
