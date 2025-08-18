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

    var textState: State<String>?

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public init(_ text: String) {
        super.init()
        self.text(text)
    }

    @discardableResult
    public init(_ state: State<String>) {
        super.init()
        self.text(state)
    }
}

extension TextView: _SetTextable {}

// MARK: Gravity

extension TextView {
    @discardableResult
    public func gravity(_ value: Gravity) -> Self {
        GravityViewProperty(value: value).applyOrAppend(nil, self)
    }
}
