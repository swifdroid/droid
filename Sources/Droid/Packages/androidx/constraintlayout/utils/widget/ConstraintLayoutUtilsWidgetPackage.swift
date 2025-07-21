//
//  ConstraintLayoutUtilsWidgetPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ConstraintLayoutPackage.UtilsPackage {
    public class WidgetPackage: JClassName, @unchecked Sendable {}
    
    public var widget: WidgetPackage { .init(parent: self, name: "widget") }
}
