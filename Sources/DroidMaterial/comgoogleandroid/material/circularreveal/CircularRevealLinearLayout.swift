//
//  CircularRevealLinearLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.CircularRevealPackage {
    public class CircularRevealLinearLayoutClass: AndroidClassName {}
    
    public var CircularRevealLinearLayout: CircularRevealLinearLayoutClass { .init(superClass: self, "CircularRevealLinearLayout") }
}

class CircularRevealLinearLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.circularreveal.CircularRevealLinearLayout])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
