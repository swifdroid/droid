//
//  ViewPager2WidgetPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation

extension AndroidXPackage.ViewPager2Package {
    public class WidgetPackage: AndroidClassName {}
    
    public var widget: WidgetPackage { .init(superClass: self, "widget") }
}
