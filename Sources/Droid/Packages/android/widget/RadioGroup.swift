//
//  RadioGroup.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class RadioGroupClass: JClassName, @unchecked Sendable {}
    public var RadioGroup: RadioGroupClass { .init(parent: self, name: "RadioGroup") }
}

open class RadioGroup: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
