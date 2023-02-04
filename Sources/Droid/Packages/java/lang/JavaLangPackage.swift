//
//  JavaLangPackage.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

import DroidFoundation

extension JavaPackage {
    public class LangPackage: AndroidClassName {}
    
    public var lang: LangPackage { .init(superClass: self, "lang") }
}
