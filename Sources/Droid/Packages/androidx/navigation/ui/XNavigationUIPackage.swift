//
//  XNavigationUIPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

extension AndroidXPackage.NavigationPackage {
    public class UIPackage: JClassName, @unchecked Sendable {}
    
    public var ui: UIPackage { .init(parent: self, name: "ui") }
}
