//
//  CoordinatorLayoutWidgetPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage.CoordinatorLayoutPackage {
    public class WidgetPackage: AndroidClassName {}
    
    public var widget: WidgetPackage { .init(superClass: self, "widget") }
}
