//
//  CheckBox.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class CheckBoxClass: JClassName, @unchecked Sendable {}
    public var CheckBox: CheckBoxClass { .init(parent: self, name: "CheckBox") }
}

open class CheckBox: View, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
