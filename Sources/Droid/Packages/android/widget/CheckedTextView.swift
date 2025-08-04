//
//  CheckedTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class CheckedTextViewClass: JClassName, @unchecked Sendable {}
    public var CheckedTextView: CheckedTextViewClass { .init(parent: self, name: "CheckedTextView") }
}

open class CheckedTextView: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
