//
//  AndroidGraphicsDrawablePackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidPackage.GraphicsPackage {
    public class DrawablePackage: AndroidClassName {}
    
    public var drawable: DrawablePackage { .init(superClass: self, "drawable") }
}
