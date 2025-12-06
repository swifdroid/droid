//
//  Chip.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.ChipPackage {
    public class ChipClass: JClassName, @unchecked Sendable {}
    
    public var Chip: ChipClass { .init(parent: self, name: "Chip") }
}

// class Chip: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.chip.Chip], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
