//
//  ChipGroup.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.ChipPackage {
    public class ChipGroupClass: JClassName, @unchecked Sendable {}
    
    public var ChipGroup: ChipGroupClass { .init(parent: self, name: "ChipGroup") }
}

// class ChipGroup: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.chip.ChipGroup], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
