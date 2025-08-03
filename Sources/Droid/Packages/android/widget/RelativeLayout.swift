//
//  RelativeLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class RelativeLayoutClass: JClassName, @unchecked Sendable {}
    public var RelativeLayout: RelativeLayoutClass { .init(parent: self, name: "RelativeLayout") }
}
extension AndroidPackage.WidgetPackage.RelativeLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let relativeLayout: Self = .init(.android.widget.RelativeLayout.LayoutParams)
}

open class RelativeLayout: View, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .android.widget.RelativeLayout }
    public override class var layoutParamsClass: LayoutParams.Class { .relativeLayout }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
