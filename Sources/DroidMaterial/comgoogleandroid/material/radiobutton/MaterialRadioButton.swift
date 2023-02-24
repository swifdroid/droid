//
//  MaterialRadioButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.RadioButtonPackage {
    public class MaterialRadioButtonClass: AndroidClassName {}
    
    public var MaterialRadioButton: MaterialRadioButtonClass { .init(superClass: self, "MaterialRadioButton") }
}

class MaterialRadioButton: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.radiobutton.MaterialRadioButton], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
