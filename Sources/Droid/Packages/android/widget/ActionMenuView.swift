//
//  ActionMenuView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ActionMenuViewClass: JClassName, @unchecked Sendable {}
    public var ActionMenuView: ActionMenuViewClass { .init(parent: self, name: "ActionMenuView") }
}
extension AndroidPackage.WidgetPackage.ActionMenuViewClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let actionMenuView: Self = .init(.android.widget.ActionMenuView.LayoutParams)
}

open class ActionMenuView: LinearLayout, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.ActionMenuView }
    open override class var layoutParamsClass: LayoutParams.Class { .actionMenuView }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}