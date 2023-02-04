//
//  ViewPagerPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage {
    public class ViewPagerPackage: AndroidClassName {}
    
    public var viewpager: ViewPagerPackage { .init(superClass: self, "viewpager") }
}
