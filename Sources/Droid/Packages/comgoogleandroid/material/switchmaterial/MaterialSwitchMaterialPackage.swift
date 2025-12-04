//
//  MaterialSwitchMaterialPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class SwitchMaterialPackage: JClassName, @unchecked Sendable {}
    
    public var switchmaterial: SwitchMaterialPackage { .init(parent: self, name: "switchmaterial") }
}
