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
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}
