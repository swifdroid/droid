//
//  ToggleButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ToggleButtonClass: JClassName, @unchecked Sendable {}
    public var ToggleButton: ToggleButtonClass { .init(parent: self, name: "ToggleButton") }
}

open class ToggleButton: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
