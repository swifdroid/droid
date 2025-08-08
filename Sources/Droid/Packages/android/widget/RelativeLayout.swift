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

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            .alignParentTop,
            .alignParentBottom,
            .alignParentLeft,
            .alignParentRight,
            .alignParentStart,
            .alignParentEnd,
            .centerInParent,
            .centerHorizontal,
            .centerVertical,
            .above,
            .below,
            .toLeftOf,
            .toRightOf,
            .toStartOf,
            .toEndOf,
            .alignTop,
            .alignBottom,
            .alignLeft,
            .alignRight,
            .alignStart,
            .alignEnd,
            .alignBaseline
        ]
    }

    open override func processLayoutParams(_ lp: LayoutParams, for subview: View) {
        super.processLayoutParams(lp, for: subview)
        let params = filteredLayoutParams()
        for param in params {
            switch param.key {
                case .alignParentTop:
                    if let value = param.value as? AlignParentTopLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignParentBottom:
                    if let value = param.value as? AlignParentBottomLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignParentLeft:
                    if let value = param.value as? AlignParentLeftLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignParentRight:
                    if let value = param.value as? AlignParentRightLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignParentStart:
                    if let value = param.value as? AlignParentStartLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignParentEnd:
                    if let value = param.value as? AlignParentEndLayoutParam.Value {
                        // TODO: apply
                    }
                case .centerInParent:
                    if let value = param.value as? CenterInParentLayoutParam.Value {
                        // TODO: apply
                    }
                case .centerHorizontal:
                    if let value = param.value as? CenterHorizontalLayoutParam.Value {
                        // TODO: apply
                    }
                case .centerVertical:
                    if let value = param.value as? CenterVerticalLayoutParam.Value {
                        // TODO: apply
                    }
                case .above:
                    if let value = param.value as? AboveLayoutParam.Value {
                        // TODO: apply
                    }
                case .below:
                    if let value = param.value as? BelowLayoutParam.Value {
                        // TODO: apply
                    }
                case .toLeftOf:
                    if let value = param.value as? ToLeftOfLayoutParam.Value {
                        // TODO: apply
                    }
                case .toRightOf:
                    if let value = param.value as? ToRightOfLayoutParam.Value {
                        // TODO: apply
                    }
                case .toStartOf:
                    if let value = param.value as? ToStartOfLayoutParam.Value {
                        // TODO: apply
                    }
                case .toEndOf:
                    if let value = param.value as? ToEndOfLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignTop:
                    if let value = param.value as? AlignTopLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignBottom:
                    if let value = param.value as? AlignBottomLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignLeft:
                    if let value = param.value as? AlignLeftLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignRight:
                    if let value = param.value as? AlignRightLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignStart:
                    if let value = param.value as? AlignStartLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignEnd:
                    if let value = param.value as? AlignEndLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignBaseline:
                    if let value = param.value as? AlignBaselineLayoutParam.Value {
                        // TODO: apply
                    }
                default: continue
            }
        }
    }
}

extension LayoutParamKey {
    // MARK: Relative to Parent
    static let alignParentTop: LayoutParamKey = "alignParentTop"
    static let alignParentBottom: LayoutParamKey = "alignParentBottom"
    static let alignParentLeft: LayoutParamKey = "alignParentLeft"
    static let alignParentRight: LayoutParamKey = "alignParentRight"
    static let alignParentStart: LayoutParamKey = "alignParentStart"
    static let alignParentEnd: LayoutParamKey = "alignParentEnd"
    static let centerInParent: LayoutParamKey = "centerInParent"
    static let centerHorizontal: LayoutParamKey = "centerHorizontal"
    static let centerVertical: LayoutParamKey = "centerVertical"
    // MARK: Relative to Other Views
    static let above: LayoutParamKey = "centerVertical"
    static let below: LayoutParamKey = "centerVertical"
    static let toLeftOf: LayoutParamKey = "centerVertical"
    static let toRightOf: LayoutParamKey = "centerVertical"
    static let toStartOf: LayoutParamKey = "centerVertical"
    static let toEndOf: LayoutParamKey = "centerVertical"
    static let alignTop: LayoutParamKey = "centerVertical"
    static let alignBottom: LayoutParamKey = "centerVertical"
    static let alignLeft: LayoutParamKey = "centerVertical"
    static let alignRight: LayoutParamKey = "centerVertical"
    static let alignStart: LayoutParamKey = "centerVertical"
    static let alignEnd: LayoutParamKey = "centerVertical"
    static let alignBaseline: LayoutParamKey = "centerVertical"
}
struct AlignParentTopLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentTop
    let value: Void = ()
}
struct AlignParentBottomLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentBottom
    let value: Void = ()
}
struct AlignParentLeftLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentLeft
    let value: Void = ()
}
struct AlignParentRightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentRight
    let value: Void = ()
}
struct AlignParentStartLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentStart
    let value: Void = ()
}
struct AlignParentEndLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentEnd
    let value: Void = ()
}
struct CenterInParentLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .centerInParent
    let value: Void = ()
}
struct CenterHorizontalLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .centerHorizontal
    let value: Void = ()
}
struct CenterVerticalLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .centerVertical
    let value: Void = ()
}
struct AboveLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .above
    let value: Int32
}
struct BelowLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .below
    let value: Int32
}
struct ToLeftOfLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .toLeftOf
    let value: Int32
}
struct ToRightOfLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .toRightOf
    let value: Int32
}
struct ToStartOfLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .toStartOf
    let value: Int32
}
struct ToEndOfLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .toEndOf
    let value: Int32
}
struct AlignTopLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignTop
    let value: Int32
}
struct AlignBottomLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignBottom
    let value: Int32
}
struct AlignLeftLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignLeft
    let value: Int32
}
struct AlignRightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignRight
    let value: Int32
}
struct AlignStartLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignStart
    let value: Int32
}
struct AlignEndLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignEnd
    let value: Int32
}
struct AlignBaselineLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignBaseline
    let value: Int32
}
