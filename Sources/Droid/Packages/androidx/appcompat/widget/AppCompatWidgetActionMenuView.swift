//
//  AppCompatWidgetActionMenuView.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class ActionMenuViewClass: JClassName, @unchecked Sendable {}
    public var ActionMenuView: ActionMenuViewClass { .init(parent: self, name: "ActionMenuView") }
}
extension AndroidXPackage.AppCompatPackage.WidgetPackage.ActionMenuViewClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let actionMenuViewCompat: Self = .init(.androidx.appcompat.widget.ActionMenuView.LayoutParams)
}

open class ActionMenuViewCompat: LinearLayoutCompat, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .androidx.appcompat.widget.ActionMenuView }
    public override class var layoutParamsClass: LayoutParams.Class { .actionMenuViewCompat }

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
            .isOverflow,
            .cellsUsed,
            .expandable,
            .preventEdgeOffset
        ]
    }

    open override func processLayoutParams(_ lp: LayoutParams, for subview: View) {
        super.processLayoutParams(lp, for: subview)
        let params = filteredLayoutParams()
        for param in params {
            switch param.key {
                case .isOverflow:
                    if let value = param.value as? IsOverflowLayoutParam.Value {
                        // TODO: apply
                    }
                case .cellsUsed:
                    if let value = param.value as? CellsUsedLayoutParam.Value {
                        // TODO: apply
                    }
                case .expandable:
                    if let value = param.value as? ExpandableLayoutParam.Value {
                        // TODO: apply
                    }
                case .preventEdgeOffset:
                    if let value = param.value as? PreventEdgeOffsetLayoutParam.Value {
                        // TODO: apply
                    }
                default: continue
            }
        }
    }
}

extension LayoutParamKey {
    static let isOverflow: LayoutParamKey = "isOverflow"
    static let cellsUsed: LayoutParamKey = "cellsUsed"
    static let expandable: LayoutParamKey = "expandable"
    // static let preventEdgeOffset: LayoutParamKey = "preventEdgeOffset"
}

struct IsOverflowLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .isOverflow
    let value: Bool
}

struct CellsUsedLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .cellsUsed
    let value: Int32
}

struct ExpandableLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .expandable
    let value: Bool
}

// struct PreventEdgeOffsetLayoutParam: LayoutParamToApply {
//     let key: LayoutParamKey = .preventEdgeOffset
//     let value: Bool
// }
