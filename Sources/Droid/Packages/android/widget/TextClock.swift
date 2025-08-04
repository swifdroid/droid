//
//  TextClock.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class TextClockClass: JClassName, @unchecked Sendable {}
    public var TextClock: TextClockClass { .init(parent: self, name: "TextClock") }
}

open class TextClock: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
