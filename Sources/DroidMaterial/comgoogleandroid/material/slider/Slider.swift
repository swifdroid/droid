//
//  Slider.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.SliderPackage {
    public class SliderClass: JClassName, @unchecked Sendable {}
    
    public var Slider: SliderClass { .init(parent: self, name: "Slider") }
}

// class Slider: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.slider.Slider], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
