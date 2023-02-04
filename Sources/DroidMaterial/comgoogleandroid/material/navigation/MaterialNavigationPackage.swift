//
//  MaterialNavigationPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class NavigationPackage: AndroidClassName {}
    
    public var navigation: NavigationPackage { .init(superClass: self, "navigation") }
}
