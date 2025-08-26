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
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            .isOverflowButton,
            .cellsUsed,
            .extraPixels,
            .expandable,
            .preventEdgeOffset
        ]
    }
}

extension LayoutParamKey {
    static let isOverflowButton: Self = "isOverflowButton"
    static let cellsUsed: Self = "cellsUsed"
    static let extraPixels: Self = "extraPixels"
    static let expandable: Self = "expandable"
    static let preventEdgeOffset: Self = "preventEdgeOffset"
}

struct IsOverflowButtonLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .isOverflowButton
    let value: Bool
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct CellsUsedLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .cellsUsed
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct ExtraPixelsLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .extraPixels
    let value: Bool
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct ExpandableLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .expandable
    let value: Bool
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct PreventEdgeOffsetLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .preventEdgeOffset
    let value: Bool
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}
