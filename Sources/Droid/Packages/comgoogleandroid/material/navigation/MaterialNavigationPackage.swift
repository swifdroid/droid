//
//  MaterialNavigationPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class NavigationPackage: JClassName, @unchecked Sendable {}
    
    public var navigation: NavigationPackage { .init(parent: self, name: "navigation") }
}
