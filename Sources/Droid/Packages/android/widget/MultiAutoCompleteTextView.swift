//
//  MultiAutoCompleteTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class MultiAutoCompleteTextViewClass: JClassName, @unchecked Sendable {}
    public var MultiAutoCompleteTextView: MultiAutoCompleteTextViewClass { .init(parent: self, name: "MultiAutoCompleteTextView") }
}

open class MultiAutoCompleteTextView: View, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
