//
//  Slider.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.SliderPackage {
    public class SliderClass: AndroidClassName {}
    
    public var Slider: SliderClass { .init(superClass: self, "Slider") }
}

class Slider: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.slider.Slider], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
