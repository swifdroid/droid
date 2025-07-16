//
//  MaterialRadioButtonPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class RadioButtonPackage: JClassName, @unchecked Sendable {}
    
    public var radiobutton: RadioButtonPackage { .init(parent: self, name: "radiobutton") }
}
