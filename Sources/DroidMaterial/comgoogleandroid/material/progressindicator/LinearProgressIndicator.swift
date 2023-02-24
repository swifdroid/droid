//
//  LinearProgressIndicator.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.ProgressIndicatorPackage {
    public class LinearProgressIndicatorClass: AndroidClassName {}
    
    public var LinearProgressIndicator: LinearProgressIndicatorClass { .init(superClass: self, "LinearProgressIndicator") }
}

class LinearProgressIndicator: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.progressindicator.LinearProgressIndicator], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
