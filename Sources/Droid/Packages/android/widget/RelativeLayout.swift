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
}

extension LayoutParamKey {
    // MARK: Relative to Parent
    static let alignParentTop: Self = "alignParentTop"
    static let alignParentBottom: Self = "alignParentBottom"
    static let alignParentLeft: Self = "alignParentLeft"
    static let alignParentRight: Self = "alignParentRight"
    static let alignParentStart: Self = "alignParentStart"
    static let alignParentEnd: Self = "alignParentEnd"
    static let centerInParent: Self = "centerInParent"
    static let centerHorizontal: Self = "centerHorizontal"
    static let centerVertical: Self = "centerVertical"
    // MARK: Relative to Other Views
    static let above: Self = "centerVertical"
    static let below: Self = "centerVertical"
    static let toLeftOf: Self = "centerVertical"
    static let toRightOf: Self = "centerVertical"
    static let toStartOf: Self = "centerVertical"
    static let toEndOf: Self = "centerVertical"
    static let alignTop: Self = "centerVertical"
    static let alignBottom: Self = "centerVertical"
    static let alignLeft: Self = "centerVertical"
    static let alignRight: Self = "centerVertical"
    static let alignStart: Self = "centerVertical"
    static let alignEnd: Self = "centerVertical"
    static let alignBaseline: Self = "centerVertical"
}
struct AlignParentTopLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentTop
    let verb: Int32 = 10
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, 0)
    }
}
struct AlignParentBottomLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentBottom
    let verb: Int32 = 12
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, 0)
    }
}
struct AlignParentLeftLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentLeft
    let verb: Int32 = 9
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, 0)
    }
}
struct AlignParentRightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentRight
    let verb: Int32 = 11
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, 0)
    }
}
struct AlignParentStartLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentStart
    let verb: Int32 = 20
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, 0)
    }
}
struct AlignParentEndLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignParentEnd
    let verb: Int32 = 21
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, 0)
    }
}
struct CenterInParentLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .centerInParent
    let verb: Int32 = 13
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, 0)
    }
}
struct CenterHorizontalLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .centerHorizontal
    let verb: Int32 = 14
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, 0)
    }
}
struct CenterVerticalLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .centerVertical
    let verb: Int32 = 15
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, 0)
    }
}
struct AboveLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .above
    let verb: Int32 = 2
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct BelowLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .below
    let verb: Int32 = 3
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct ToLeftOfLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .toLeftOf
    let verb: Int32 = 0
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct ToRightOfLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .toRightOf
    let verb: Int32 = 1
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct ToStartOfLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .toStartOf
    let verb: Int32 = 16
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct ToEndOfLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .toEndOf
    let verb: Int32 = 17
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct AlignTopLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignTop
    let verb: Int32 = 6
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct AlignBottomLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignBottom
    let verb: Int32 = 8
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct AlignLeftLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignLeft
    let verb: Int32 = 5
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct AlignRightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignRight
    let verb: Int32 = 7
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct AlignStartLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignStart
    let verb: Int32 = 18
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct AlignEndLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignEnd
    let verb: Int32 = 19
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
struct AlignBaselineLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignBaseline
    let verb: Int32 = 4
    let id: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: "addRule", args: verb, id)
    }
}
