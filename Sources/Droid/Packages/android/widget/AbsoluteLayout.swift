//
//  AbsoluteLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class AbsoluteLayoutClass: JClassName, @unchecked Sendable {}
    public var AbsoluteLayout: AbsoluteLayoutClass { .init(parent: self, name: "AbsoluteLayout") }
}
extension AndroidPackage.WidgetPackage.AbsoluteLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let absoluteLayout: Self = .init(.android.widget.AbsoluteLayout.LayoutParams)
}

open class AbsoluteLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.AbsoluteLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .absoluteLayout }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
