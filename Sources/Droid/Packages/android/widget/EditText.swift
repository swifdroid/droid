//
//  EditText.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class EditTextClass: JClassName, @unchecked Sendable {}
    public var EditText: EditTextClass { .init(parent: self, name: "EditText") }
}

open class EditText: TextView, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.EditText }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
    
    func addTextChangedListener(_ textWatcher: JClass) {
        // callVoidWithMethod("addTextChangedListener", .object(.android.text.TextWatcher) / textWatcher)
    }
}
