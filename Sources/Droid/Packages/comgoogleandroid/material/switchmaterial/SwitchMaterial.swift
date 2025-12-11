//
//  SwitchMaterial.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.SwitchMaterialPackage {
    public class SwitchMaterialClass: JClassName, @unchecked Sendable {}
    
    public var SwitchMaterial: SwitchMaterialClass { .init(parent: self, name: "SwitchMaterial") }
}

// class SwitchMaterial: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.switchmaterial.SwitchMaterial], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
