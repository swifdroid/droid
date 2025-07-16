//
//  MaterialCheckBox.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.CheckBoxPackage {
    public class MaterialCheckBoxClass: JClassName, @unchecked Sendable {}
    
    public var MaterialCheckBox: MaterialCheckBoxClass { .init(parent: self, name: "MaterialCheckBox") }
}

// class MaterialCheckBox: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.checkbox.MaterialCheckBox], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
