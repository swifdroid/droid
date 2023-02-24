//
//  MaterialTabsPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class TabsPackage: AndroidClassName {}
    
    public var tabs: TabsPackage { .init(superClass: self, "tabs") }
}
