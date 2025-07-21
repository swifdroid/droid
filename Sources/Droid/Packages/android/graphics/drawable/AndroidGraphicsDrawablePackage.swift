//
//  AndroidGraphicsDrawablePackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidPackage.GraphicsPackage {
    public class DrawablePackage: JClassName, @unchecked Sendable {}
    
    public var drawable: DrawablePackage { .init(parent: self, name: "drawable") }
}
