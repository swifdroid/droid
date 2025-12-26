//
//  XNavigationPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

extension AndroidXPackage {
    public class NavigationPackage: JClassName, @unchecked Sendable {}
    
    public var navigation: NavigationPackage { .init(parent: self, name: "navigation") }
}