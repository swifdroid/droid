//
//  MaterialNavigationRailPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class NavigationRailPackage: JClassName, @unchecked Sendable {}
    
    public var navigationrail: NavigationRailPackage { .init(parent: self, name: "navigationrail") }
}
