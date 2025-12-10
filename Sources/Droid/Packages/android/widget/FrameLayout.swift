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
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    public override init(id: Int32? = nil, _ object: JObject, _ contextLink: @escaping () -> ActivityContext?) {
        super.init(id: id, object, contextLink)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            .width,
            .height,
            .gravity
        ]
    }
}

extension LayoutParamKey {
    static let x: Self = "x"
    static let y: Self = "y"
}

struct XLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .x
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: "x", arg: value.1.toPixels(Int32(value.0)))
    }
}

struct YLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .y
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: "y", arg: value.1.toPixels(Int32(value.0)))
    }
}