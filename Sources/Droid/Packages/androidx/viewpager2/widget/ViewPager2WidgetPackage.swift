//
//  ViewPager2WidgetPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation

extension AndroidXPackage.ViewPager2Package {
    public class WidgetPackage: JClassName, @unchecked Sendable {}
    
    public var widget: WidgetPackage { .init(parent: self, name: "widget") }
}
