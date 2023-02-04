//
//  CircularProgressIndicator.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.ProgressIndicatorPackage {
    public class CircularProgressIndicatorClass: AndroidClassName {}
    
    public var CircularProgressIndicator: CircularProgressIndicatorClass { .init(superClass: self, "CircularProgressIndicator") }
}

class CircularProgressIndicator: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.progressindicator.CircularProgressIndicator])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
