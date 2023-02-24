//
//  CircularRevealGridLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage {
    public class CircularRevealGridLayoutClass: AndroidClassName {}
    
    public var CircularRevealGridLayout: CircularRevealGridLayoutClass { .init(superClass: self, "CircularRevealGridLayout") }
}

class CircularRevealGridLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.circularreveal.CircularRevealGridLayout], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
