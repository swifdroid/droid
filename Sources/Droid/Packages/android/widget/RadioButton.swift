//
//  RadioButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class RadioButtonClass: JClassName, @unchecked Sendable {}
    public var RadioButton: RadioButtonClass { .init(parent: self, name: "RadioButton") }
}

open class RadioButton: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
