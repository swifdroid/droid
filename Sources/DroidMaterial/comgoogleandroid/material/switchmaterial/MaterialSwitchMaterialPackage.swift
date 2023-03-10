//
//  MaterialSwitchMaterialPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class SwitchMaterialPackage: AndroidClassName {}
    
    public var switchmaterial: SwitchMaterialPackage { .init(superClass: self, "switchmaterial") }
}
