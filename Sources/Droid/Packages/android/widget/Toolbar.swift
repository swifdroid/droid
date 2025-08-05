//
//  Toolbar.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ToolbarClass: JClassName, @unchecked Sendable {}
    public var Toolbar: ToolbarClass { .init(parent: self, name: "Toolbar") }
}

open class Toolbar1: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
