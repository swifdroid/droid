//
//  ConstraintLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ConstraintLayoutPackage.WidgetPackage {
    public class ConstraintLayoutClass: JClassName, @unchecked Sendable {}
    public var ConstraintLayout: ConstraintLayoutClass { .init(parent: self, name: "ConstraintLayout") }
}

open class ConstraintLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .androidx.constraintlayout.widget.ConstraintLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .constraintLayout }
    open override class var gradleDependencies: [String] { [
        "implementation(\"androidx.constraintlayout:constraintlayout:2.2.1\")"
    ] }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}