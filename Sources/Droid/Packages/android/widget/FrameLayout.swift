//
//  FrameLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 24.06.2025.
//

extension AndroidPackage.WidgetPackage {
    public class FrameLayoutClass: JClassName, @unchecked Sendable {}
    public var FrameLayout: FrameLayoutClass { .init(parent: self, name: "FrameLayout") }
}
extension AndroidPackage.WidgetPackage.FrameLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let frameLayout: Self = .init(.android.widget.FrameLayout.LayoutParams)
}

open class FrameLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.FrameLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .frameLayout }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
