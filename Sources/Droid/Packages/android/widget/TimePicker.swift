//
//  TimePicker.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class TimePickerClass: JClassName, @unchecked Sendable {}
    public var TimePicker: TimePickerClass { .init(parent: self, name: "TimePicker") }
}

open class TimePicker: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
