//
//  MaterialCircularRevealPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class CircularRevealPackage: AndroidClassName {}
    
    public var circularreveal: CircularRevealPackage { .init(superClass: self, "circularreveal") }
}
