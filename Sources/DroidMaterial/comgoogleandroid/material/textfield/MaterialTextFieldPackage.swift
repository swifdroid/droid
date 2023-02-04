//
//  MaterialTextFieldPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class TextFieldPackage: AndroidClassName {}
    
    public var textfield: TextFieldPackage { .init(superClass: self, "textfield") }
}
