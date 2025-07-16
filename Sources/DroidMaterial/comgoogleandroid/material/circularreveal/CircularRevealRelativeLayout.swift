//
//  CircularRevealRelativeLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage {
    public class CircularRevealRelativeLayoutClass: JClassName, @unchecked Sendable {}
    
    public var CircularRevealRelativeLayout: CircularRevealRelativeLayoutClass { .init(parent: self, name: "CircularRevealRelativeLayout") }
}

// class CircularRevealRelativeLayout: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.circularreveal.CircularRevealRelativeLayout], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
