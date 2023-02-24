//
//  CircularRevealFrameLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage.CoordinatorLayoutPackage {
    public class CircularRevealFrameLayoutClass: AndroidClassName {}
    
    public var CircularRevealFrameLayout: CircularRevealFrameLayoutClass { .init(superClass: self, "CircularRevealFrameLayout") }
}

class CircularRevealFrameLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.circularreveal.coordinatorlayout.CircularRevealFrameLayout], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
