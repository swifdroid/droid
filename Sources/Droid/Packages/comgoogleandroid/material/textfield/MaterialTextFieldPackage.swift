//
//  MaterialTextFieldPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class TextFieldPackage: JClassName, @unchecked Sendable {}
    
    public var textfield: TextFieldPackage { .init(parent: self, name: "textfield") }
}
