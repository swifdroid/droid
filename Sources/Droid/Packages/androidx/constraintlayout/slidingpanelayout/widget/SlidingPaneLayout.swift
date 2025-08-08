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
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            .slideable,
            .weight
        ]
    }

    open override func processLayoutParams(_ lp: LayoutParams, for subview: View) {
        super.processLayoutParams(lp, for: subview)
        let params = filteredLayoutParams()
        for param in params {
            switch param.key {
                case .slideable:
                    if let value = param.value as? SlideableLayoutParam.Value {
                        // TODO: apply
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

extension LayoutParamKey {
    static let slideable: LayoutParamKey = "slideable"
    // static let weight: LayoutParamKey = "weight"
}

struct SlideableLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .slideable
    let value: Bool
}

// struct WeightLayoutParam: LayoutParamToApply {
//     let key: LayoutParamKey = .weight
//     let value: Float
// }