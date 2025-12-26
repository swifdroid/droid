//
//  XNavigationFragmentPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

extension AndroidXPackage.NavigationPackage {
    public class FragmentPackage: JClassName, @unchecked Sendable {}
    
    public var fragment: FragmentPackage { .init(parent: self, name: "fragment") }
}
