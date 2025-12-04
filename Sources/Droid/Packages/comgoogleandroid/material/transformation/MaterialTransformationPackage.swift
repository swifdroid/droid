//
//  MaterialTransformationPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class TransformationPackage: JClassName, @unchecked Sendable {}
    
    public var transformation: TransformationPackage { .init(parent: self, name: "transformation") }
}
