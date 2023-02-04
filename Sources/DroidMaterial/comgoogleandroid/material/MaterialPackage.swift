//
//  MaterialPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension ComGoogleAndroidPackage {
    public class MaterialPackage: AndroidClassName {}
    
    public var material: MaterialPackage { .init(superClass: self, "material") }
}
