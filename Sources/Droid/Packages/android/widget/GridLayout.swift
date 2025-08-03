//
//  GridLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class GridLayoutClass: JClassName, @unchecked Sendable {}
    public var GridLayout: GridLayoutClass { .init(parent: self, name: "GridLayout") }
}
extension AndroidPackage.WidgetPackage.GridLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let gridLayout: Self = .init(.android.widget.GridLayout.LayoutParams)
}

open class GridLayout: View, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.GridLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .gridLayout }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
