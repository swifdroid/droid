//
//  MaterialTextViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class TextViewPackage: AndroidClassName {}
    
    public var textview: TextViewPackage { .init(superClass: self, "textview") }
}
