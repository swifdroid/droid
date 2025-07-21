//
//  DrawerLayoutPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage {
    public class DrawerLayoutPackage: JClassName, @unchecked Sendable {}
    
    public var drawerlayout: DrawerLayoutPackage { .init(parent: self, name: "drawerlayout") }
}
