//
//  CoordinatorLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.CoordinatorLayoutPackage.WidgetPackage {
    public class CoordinatorLayoutClass: JClassName, @unchecked Sendable {}
    public var CoordinatorLayout: CoordinatorLayoutClass { .init(parent: self, name: "CoordinatorLayout") }
}
extension AndroidXPackage.CoordinatorLayoutPackage.WidgetPackage.CoordinatorLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let coordinatorLayout: Self = .init(.androidx.coordinatorlayout.widget.CoordinatorLayout.LayoutParams)
}

open class CoordinatorLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .androidx.coordinatorlayout.widget.CoordinatorLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .coordinatorLayout }
    open override class var gradleDependencies: [String] { [
        #"implementation("androidx.coordinatorlayout:coordinatorlayout:1.3.0")"#
    ] }

    open override func layoutParamsForSubviews() -> LayoutParams? {
        let lp = super.layoutParamsForSubviews()
        lp?.setAnchorId(-1) // prevents "Unable to resolve anchor ID #0x0", applicable only if LayoutParams was initialized without arguments
        return lp
    }

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
            .behavior,
            .anchorId,
            .anchorGravity,
            .dodgeInsetEdges,
            .insetEdge,
            .keyline
        ]
    }

    open override func processLayoutParams(_ lp: LayoutParams, for subview: View) {
        super.processLayoutParams(lp, for: subview)
        let params = filteredLayoutParams()
        for param in params {
            switch param.key {
                case .behavior:
                    if let value = param.value as? BehaviorLayoutParam.Value {
                        // TODO: apply
                    }
                case .anchorId:
                    if let value = param.value as? AnchorIdLayoutParam.Value {
                        // TODO: apply
                    }
                case .anchorGravity:
                    if let value = param.value as? AnchorGravityLayoutParam.Value {
                        // TODO: apply
                    }
                case .dodgeInsetEdges:
                    if let value = param.value as? DodgeInsetEdgesLayoutParam.Value {
                        // TODO: apply
                    }
                case .insetEdge:
                    if let value = param.value as? InsetEdgeLayoutParam.Value {
                        // TODO: apply
                    }
                case .keyline:
                    if let value = param.value as? KeylineLayoutParam.Value {
                        // TODO: apply
                    }
                default: continue
            }
        }
    }
}

extension LayoutParamKey {
    static let behavior: LayoutParamKey = "behavior"
    static let anchorId: LayoutParamKey = "anchorId"
    static let anchorGravity: LayoutParamKey = "anchorGravity"
    static let dodgeInsetEdges: LayoutParamKey = "dodgeInsetEdges"
    static let insetEdge: LayoutParamKey = "insetEdge"
    static let keyline: LayoutParamKey = "keyline"
}

struct BehaviorLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .behavior
    let value: Void = () // TODO: CoordinatorLayout.Behavior
}

struct AnchorIdLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .anchorId
    let value: Int32
}

struct AnchorGravityLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .anchorGravity
    let value: Gravity
}

struct DodgeInsetEdgesLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .dodgeInsetEdges
    let value: Int32
}

struct InsetEdgeLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .insetEdge
    let value: Int32
}

struct KeylineLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .keyline
    let value: Int32
}
