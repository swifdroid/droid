//
//  TextView.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class TextViewClass: JClassName, @unchecked Sendable {}
    public var TextView: TextViewClass { .init(parent: self, name: "TextView") }
}

open class TextView: View, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.TextView }

    @discardableResult
    public override init() {
        super.init()
    }
}
