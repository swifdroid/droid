//
//  MaterialButtonToggleGroup.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.ButtonPackage {
    public class MaterialButtonToggleGroupClass: JClassName, @unchecked Sendable {}
    
    public var MaterialButtonToggleGroup: MaterialButtonToggleGroupClass { .init(parent: self, name: "MaterialButtonToggleGroup") }
}

// class MaterialButtonToggleGroup: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.button.MaterialButtonToggleGroup], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
