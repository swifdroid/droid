//
//  MaterialSliderPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class SliderPackage: AndroidClassName {}
    
    public var slider: SliderPackage { .init(superClass: self, "slider") }
}
