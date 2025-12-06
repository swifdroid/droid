//
//  MaterialAppBarPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class AppBarPackage: JClassName, @unchecked Sendable {}
    
    public var appbar: AppBarPackage { .init(parent: self, name: "appbar") }
}
