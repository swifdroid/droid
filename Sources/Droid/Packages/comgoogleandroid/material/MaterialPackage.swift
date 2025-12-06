//
//  MaterialPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension ComGoogleAndroidPackage {
    public class MaterialPackage: JClassName, @unchecked Sendable {}
    
    public var material: MaterialPackage { .init(parent: self, name: "material") }
}
