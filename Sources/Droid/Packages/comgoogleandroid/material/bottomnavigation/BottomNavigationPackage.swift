//
//  MaterialBottomNavigationPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class BottomNavigationPackage: JClassName, @unchecked Sendable {}
    
    public var bottomnavigation: BottomNavigationPackage { .init(parent: self, name: "bottomnavigation") }
}