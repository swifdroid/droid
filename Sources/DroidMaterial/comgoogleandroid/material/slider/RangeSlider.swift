//
//  RangeSlider.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.SliderPackage {
    public class RangeSliderClass: AndroidClassName {}
    
    public var RangeSlider: RangeSliderClass { .init(superClass: self, "RangeSlider") }
}

class RangeSlider: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.slider.RangeSlider], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
