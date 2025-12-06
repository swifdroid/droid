//
//  MaterialTextViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class TextViewPackage: JClassName, @unchecked Sendable {}
    
    public var textview: TextViewPackage { .init(parent: self, name: "textview") }
}
