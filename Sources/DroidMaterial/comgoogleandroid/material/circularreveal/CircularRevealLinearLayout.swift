//
//  CircularRevealLinearLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage {
    public class CircularRevealLinearLayoutClass: JClassName, @unchecked Sendable {}
    
    public var CircularRevealLinearLayout: CircularRevealLinearLayoutClass { .init(parent: self, name: "CircularRevealLinearLayout") }
}

// class CircularRevealLinearLayout: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.circularreveal.CircularRevealLinearLayout], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
