//
//  CircularRevealCardView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage.CardViewPackage {
    public class CircularRevealCardViewClass: AndroidClassName {}
    
    public var CircularRevealCardView: CircularRevealCardViewClass { .init(superClass: self, "CircularRevealCardView") }
}

class CircularRevealCardView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.circularreveal.cardview.CircularRevealCardView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
