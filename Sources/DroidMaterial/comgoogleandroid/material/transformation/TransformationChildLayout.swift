//
//  TransformationChildLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.TransformationPackage {
    public class TransformationChildLayoutClass: AndroidClassName {}
    
    public var TransformationChildLayout: TransformationChildLayoutClass { .init(superClass: self, "TransformationChildLayout") }
}

class TransformationChildLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.transformation.TransformationChildLayout], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
