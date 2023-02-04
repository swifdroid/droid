//
//  MaterialTransformationPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class TransformationPackage: AndroidClassName {}
    
    public var transformation: TransformationPackage { .init(superClass: self, "transformation") }
}
