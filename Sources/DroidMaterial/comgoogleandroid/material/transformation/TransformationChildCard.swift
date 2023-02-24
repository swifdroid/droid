//
//  TransformationChildCard.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.TransformationPackage {
    public class TransformationChildCardClass: AndroidClassName {}
    
    public var TransformationChildCard: TransformationChildCardClass { .init(superClass: self, "TransformationChildCard") }
}

class TransformationChildCard: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.transformation.TransformationChildCard], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
