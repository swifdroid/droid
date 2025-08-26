//
//  AppCompatWidgetLinearLayoutCompat.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class LinearLayoutCompatClass: JClassName, @unchecked Sendable {}
    public var LinearLayoutCompat: LinearLayoutCompatClass { .init(parent: self, name: "LinearLayoutCompat") }
}
extension AndroidXPackage.AppCompatPackage.WidgetPackage.LinearLayoutCompatClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let linearLayoutCompat: Self = .init(.androidx.appcompat.widget.LinearLayoutCompat.LayoutParams)
}

open class LinearLayoutCompat: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .androidx.appcompat.widget.LinearLayoutCompat }
    public override class var layoutParamsClass: LayoutParams.Class { .linearLayoutCompat }

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
            .gravity,
            .weight
        ]
    }
}
