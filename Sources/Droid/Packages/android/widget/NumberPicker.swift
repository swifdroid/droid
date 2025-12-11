//
//  NumberPicker.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class NumberPickerClass: JClassName, @unchecked Sendable {}
    public var NumberPicker: NumberPickerClass { .init(parent: self, name: "NumberPicker") }
}

open class NumberPicker: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
