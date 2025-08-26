//
//  SlidingPaneLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 06.08.2025.
//

extension AndroidXPackage.SlidingPaneLayoutPackage {
    public class SlidingPaneLayoutClass: JClassName, @unchecked Sendable {}
    public var SlidingPaneLayout: SlidingPaneLayoutClass { .init(parent: self, name: "SlidingPaneLayout") }
}
extension AndroidXPackage.SlidingPaneLayoutPackage.SlidingPaneLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let slidingPaneLayout: Self = .init(.androidx.slidingpanelayout.SlidingPaneLayout.LayoutParams)
}

open class SlidingPaneLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .androidx.slidingpanelayout.SlidingPaneLayout }
    public override class var layoutParamsClass: LayoutParams.Class { .slidingPaneLayout }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            .weight
        ]
    }
}