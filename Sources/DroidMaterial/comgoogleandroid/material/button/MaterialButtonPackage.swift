//
//  MaterialButtonPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class ButtonPackage: AndroidClassName {}
    
    public var button: ButtonPackage { .init(superClass: self, "button") }
}
