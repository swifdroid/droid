//
//  MaterialInternalPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class InternalPackage: JClassName, @unchecked Sendable {}
    
    public var `internal`: InternalPackage { .init(parent: self, name: "internal") }
}
