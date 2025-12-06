//
//  MaterialCheckBoxPackage.swift
//  Droie
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class CheckBoxPackage: JClassName, @unchecked Sendable {}
    
    public var checkbox: CheckBoxPackage { .init(parent: self, name: "checkbox") }
}
