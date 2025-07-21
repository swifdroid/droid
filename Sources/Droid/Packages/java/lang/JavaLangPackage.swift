//
//  JavaLangPackage.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

extension JavaPackage {
    public class LangPackage: JClassName, @unchecked Sendable {}
    
    public var lang: LangPackage { .init(parent: self, name: "lang") }
}
