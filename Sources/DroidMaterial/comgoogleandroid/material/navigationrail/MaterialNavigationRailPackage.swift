//
//  MaterialNavigationRailPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage {
    public class NavigationRailPackage: AndroidClassName {}
    
    public var navigationrail: NavigationRailPackage { .init(superClass: self, "navigationrail") }
}
