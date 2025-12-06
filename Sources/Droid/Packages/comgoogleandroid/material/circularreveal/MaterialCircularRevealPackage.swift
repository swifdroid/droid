//
//  MaterialCircularRevealPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class CircularRevealPackage: JClassName, @unchecked Sendable {}
    
    public var circularreveal: CircularRevealPackage { .init(parent: self, name: "circularreveal") }
}
