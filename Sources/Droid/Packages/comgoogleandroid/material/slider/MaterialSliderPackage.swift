//
//  MaterialSliderPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class SliderPackage: JClassName, @unchecked Sendable {}
    
    public var slider: SliderPackage { .init(parent: self, name: "slider") }
}
