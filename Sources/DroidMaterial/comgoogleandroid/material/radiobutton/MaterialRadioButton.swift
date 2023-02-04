//
//  MaterialRadioButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.RadioButtonPackage {
    public class MaterialRadioButtonClass: AndroidClassName {}
    
    public var MaterialRadioButton: MaterialRadioButtonClass { .init(superClass: self, "MaterialRadioButton") }
}

class MaterialRadioButton: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.radiobutton.MaterialRadioButton])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
