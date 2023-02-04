//
//  ConstraintLayoutUtilsWidgetPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation

extension AndroidXPackage.ConstraintLayoutPackage.UtilsPackage {
    public class WidgetPackage: AndroidClassName {}
    
    public var widget: WidgetPackage { .init(superClass: self, "widget") }
}
