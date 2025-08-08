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

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            .weight,
            .x,
            .y,
            .preventEdgeOffset,
            .minHeight,
            .maxHeight,
            .minWidth,
            .maxWidth
        ]
    }

    open override func processLayoutParams(_ lp: LayoutParams, for subview: View) {
        super.processLayoutParams(lp, for: subview)
        let params = filteredLayoutParams()
        for param in params {
            switch param.key {
                case .weight:
                    if let value = param.value as? WeightLayoutParam.Value {
                        lp.setWeight(value)
                    }
                case .x:
                    if let value = param.value as? XLayoutParam.Value {
                        lp.setX(value.1.toPixels(Int32(value.0)))
                    }
                case .y:
                    if let value = param.value as? YLayoutParam.Value {
                        lp.setY(value.1.toPixels(Int32(value.0)))
                    }
                case .preventEdgeOffset:
                    if let value = param.value as? PreventEdgeOffsetLayoutParam.Value {
                        // TODO: apply
                    }
                case .minHeight:
                    if let value = param.value as? MinHeightLayoutParam.Value {
                        // TODO: apply
                    }
                case .maxHeight:
                    if let value = param.value as? MaxHeightLayoutParam.Value {
                        // TODO: apply
                    }
                case .minWidth:
                    if let value = param.value as? MinWidthLayoutParam.Value {
                        // TODO: apply
                    }
                case .maxWidth:
                    if let value = param.value as? MaxWidthLayoutParam.Value {
                        // TODO: apply
                    }
                default: continue
            }
        }
    }
}

extension LayoutParamKey {
    static let x: LayoutParamKey = "x"
    static let y: LayoutParamKey = "y"
    static let preventEdgeOffset: LayoutParamKey = "preventEdgeOffset"
    static let minWidth: LayoutParamKey = "minWidth"
    static let maxWidth: LayoutParamKey = "maxWidth"
}

struct XLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .x
    let value: (Int, DimensionUnit)
}

struct YLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .y
    let value: (Int, DimensionUnit)
}

struct PreventEdgeOffsetLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .preventEdgeOffset
    let value: Bool
}

struct MinWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .minWidth
    let value: (Int, DimensionUnit)
}

struct MaxWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .maxWidth
    let value: (Int, DimensionUnit)
}