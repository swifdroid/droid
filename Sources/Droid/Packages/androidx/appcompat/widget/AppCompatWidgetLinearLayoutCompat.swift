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
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            .gravity,
            .weight
        ]
    }

    open override func processLayoutParams(_ lp: LayoutParams, for subview: View) {
        super.processLayoutParams(lp, for: subview)
        let params = filteredLayoutParams()
        for param in params {
            switch param.key {
                case .gravity:
                    if let value = param.value as? GravityLayoutParam.Value {
                        lp.setGravity(Int32(value.rawValue))
                    }
                case .weight:
                    if let value = param.value as? WeightLayoutParam.Value {
                        lp.setWeight(value)
                    }
                default: continue
            }
        }
    }
}
