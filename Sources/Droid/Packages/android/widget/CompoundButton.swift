//
//  CompoundButton.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

extension AndroidPackage.WidgetPackage {
    public class CompoundButtonClass: JClassName, @unchecked Sendable {}
    public var CompoundButton: CompoundButtonClass { .init(parent: self, name: "CompoundButton") }
}

open class CompoundButton: Button, Checkable, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
