//
//  MaterialInternalPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class InternalPackage: AndroidClassName {}
    
    public var internal: InternalPackage { .init(superClass: self, "internal") }
}
