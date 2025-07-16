//
//  MaterialButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.ButtonPackage {
    public class MaterialButtonClass: JClassName, @unchecked Sendable {}
    
    public var MaterialButton: MaterialButtonClass { .init(parent: self, name: "MaterialButton") }
}

// class MaterialButton: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.button.MaterialButton], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
