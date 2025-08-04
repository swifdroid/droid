//
//  AutoCompleteTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class AutoCompleteTextViewClass: JClassName, @unchecked Sendable {}
    public var AutoCompleteTextView: AutoCompleteTextViewClass { .init(parent: self, name: "AutoCompleteTextView") }
}

open class AutoCompleteTextView: EditText, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.AutoCompleteTextView }

    @discardableResult
    public override init() {
        super.init()
    }
}
