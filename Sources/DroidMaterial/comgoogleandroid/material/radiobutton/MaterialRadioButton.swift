//
//  MaterialRadioButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.RadioButtonPackage {
    public class MaterialRadioButtonClass: JClassName, @unchecked Sendable {}
    
    public var MaterialRadioButton: MaterialRadioButtonClass { .init(parent: self, name: "MaterialRadioButton") }
}

// class MaterialRadioButton: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.radiobutton.MaterialRadioButton], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
