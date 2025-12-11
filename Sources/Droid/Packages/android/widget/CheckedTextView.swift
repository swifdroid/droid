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

open class CheckedTextView: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
