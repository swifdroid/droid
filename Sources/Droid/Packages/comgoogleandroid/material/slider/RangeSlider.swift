//
//  RangeSlider.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.SliderPackage {
    public class RangeSliderClass: JClassName, @unchecked Sendable {}
    
    public var RangeSlider: RangeSliderClass { .init(parent: self, name: "RangeSlider") }
}

// class RangeSlider: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.slider.RangeSlider], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
