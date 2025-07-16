//
//  CircularRevealFrameLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage.CoordinatorLayoutPackage {
    public class CircularRevealFrameLayoutClass: JClassName, @unchecked Sendable {}
    
    public var CircularRevealFrameLayout: CircularRevealFrameLayoutClass { .init(parent: self, name: "CircularRevealFrameLayout") }
}

// class CircularRevealFrameLayout: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.circularreveal.coordinatorlayout.CircularRevealFrameLayout], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
