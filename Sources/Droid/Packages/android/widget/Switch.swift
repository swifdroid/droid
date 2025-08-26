//
//  Switch.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class SwitchClass: JClassName, @unchecked Sendable {}
    public var Switch: SwitchClass { .init(parent: self, name: "Switch") }
}

open class Switch: View, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
