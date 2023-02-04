//
//  MaterialRadioButtonPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class RadioButtonPackage: AndroidClassName {}
    
    public var radiobutton: RadioButtonPackage { .init(superClass: self, "radiobutton") }
}
