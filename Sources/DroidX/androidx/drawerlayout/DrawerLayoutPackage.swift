//
//  DrawerLayoutPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage {
    public class DrawerLayoutPackage: AndroidClassName {}
    
    public var drawerlayout: DrawerLayoutPackage { .init(superClass: self, "drawerlayout") }
}
