//
//  MaterialButtonPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class ButtonPackage: JClassName, @unchecked Sendable {}
    
    public var button: ButtonPackage { .init(parent: self, name: "button") }
}
