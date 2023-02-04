//
//  SwitchMaterial.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.SwitchMaterialPackage {
    public class SwitchMaterialClass: AndroidClassName {}
    
    public var SwitchMaterial: SwitchMaterialClass { .init(superClass: self, "SwitchMaterial") }
}

class SwitchMaterial: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.switchmaterial.SwitchMaterial])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
