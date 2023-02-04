//
//  MaterialCheckBoxPackage.swift
//  Droie
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class CheckBoxPackage: AndroidClassName {}
    
    public var checkbox: CheckBoxPackage { .init(superClass: self, "checkbox") }
}
