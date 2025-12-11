//
//  DatePicker.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class DatePickerClass: JClassName, @unchecked Sendable {}
    public var DatePicker: DatePickerClass { .init(parent: self, name: "DatePicker") }
}

open class DatePicker: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
