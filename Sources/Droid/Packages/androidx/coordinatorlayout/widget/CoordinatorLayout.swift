//
//  CoordinatorLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.CoordinatorLayoutPackage.WidgetPackage {
    public class CoordinatorLayoutClass: JClassName, @unchecked Sendable {}
    public var CoordinatorLayout: CoordinatorLayoutClass { .init(parent: self, name: "CoordinatorLayout") }
}
extension AndroidXPackage.CoordinatorLayoutPackage.WidgetPackage.CoordinatorLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let coordinatorLayout: Self = .init(.androidx.coordinatorlayout.widget.CoordinatorLayout.LayoutParams)
}

open class CoordinatorLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .androidx.coordinatorlayout.widget.CoordinatorLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .coordinatorLayout }
    open override class var gradleDependencies: [String] { [
        #"implementation("androidx.coordinatorlayout:coordinatorlayout:1.3.0")"#
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
