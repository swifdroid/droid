//
//  CircularProgressIndicator.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.ProgressIndicatorPackage {
    public class CircularProgressIndicatorClass: AndroidClassName {}
    
    public var CircularProgressIndicator: CircularProgressIndicatorClass { .init(superClass: self, "CircularProgressIndicator") }
}

class CircularProgressIndicator: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.progressindicator.CircularProgressIndicator], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
