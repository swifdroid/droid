//
//  AndroidWidgetPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

extension AndroidPackage {
    public class WidgetPackage: JClassName, @unchecked Sendable {}
    public var widget: WidgetPackage { .init(parent: self, name: "widget") }
}
