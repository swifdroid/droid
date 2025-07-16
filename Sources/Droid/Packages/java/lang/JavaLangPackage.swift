//
//  JavaLangPackage.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

import DroidFoundation

extension JavaPackage {
    public class LangPackage: JClassName, @unchecked Sendable {}
    
    public var lang: LangPackage { .init(parent: self, name: "lang") }
}
