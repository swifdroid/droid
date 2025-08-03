//
//  StackView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class StackViewClass: JClassName, @unchecked Sendable {}
    public var StackView: StackViewClass { .init(parent: self, name: "StackView") }
}

open class StackView: View, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .android.widget.StackView }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
