//
//  CircularRevealCoordinatorLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage {
    public class CircularRevealCoordinatorLayoutClass: JClassName, @unchecked Sendable {}
    
    public var CircularRevealCoordinatorLayout: CircularRevealCoordinatorLayoutClass { .init(parent: self, name: "CircularRevealCoordinatorLayout") }
}

// class CircularRevealCoordinatorLayout: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.circularreveal.CircularRevealCoordinatorLayout], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
