//
//  MaterialCheckBox.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.CheckBoxPackage {
    public class MaterialCheckBoxClass: AndroidClassName {}
    
    public var MaterialCheckBox: MaterialCheckBoxClass { .init(superClass: self, "MaterialCheckBox") }
}

class MaterialCheckBox: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.checkbox.MaterialCheckBox])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
