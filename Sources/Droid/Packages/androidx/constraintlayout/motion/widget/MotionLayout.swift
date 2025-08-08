//
//  MotionLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ConstraintLayoutPackage.MotionPackage.WidgetPackage {
    public class MotionLayoutClass: JClassName, @unchecked Sendable {}
    public var MotionLayout: MotionLayoutClass { .init(parent: self, name: "MotionLayout") }
}
extension AndroidXPackage.ConstraintLayoutPackage.MotionPackage.WidgetPackage.MotionLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let motionLayout: Self = .init(.androidx.constraintlayout.motion.widget.MotionLayout.LayoutParams)
}

class MotionLayout: ConstraintLayout, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .androidx.constraintlayout.motion.widget.MotionLayout }

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
            // - Motion Scene Parameters
            .motionDebug,
            .progress,
            .currentState,
            .motionTarget,
            // - Path/Animation Control
            .pathMotionArc,
            .motionStagger,
            .transitionEasing,
            // - Constraint Overrides
            .applyMotionScene,
            .constraintTag,
            // - Dimension Control
            .widthDefault,
            .heightDefault,
            // - Custom Attributes
            .mCustom
        ]
    }

    open override func processLayoutParams(_ lp: LayoutParams, for subview: View) {
        super.processLayoutParams(lp, for: subview)
        let params = filteredLayoutParams()
        for param in params {
            switch param.key {
                // - Motion Scene Parameters
                case .motionDebug:
                    if let value = param.value as? MotionDebugLayoutParam.Value {
                        // TODO: apply
                    }
                case .progress:
                    if let value = param.value as? ProgressLayoutParam.Value {
                        // TODO: apply
                    }
                case .currentState:
                    if let value = param.value as? CurrentStateLayoutParam.Value {
                        // TODO: apply
                    }
                case .motionTarget:
                    if let value = param.value as? MotionTargetLayoutParam.Value {
                        // TODO: apply
                    }
                // - Path/Animation Control
                case .pathMotionArc:
                    if let value = param.value as? PathMotionArcLayoutParam.Value {
                        // TODO: apply
                    }
                case .motionStagger:
                    if let value = param.value as? MotionStaggerLayoutParam.Value {
                        // TODO: apply
                    }
                case .transitionEasing:
                    if let value = param.value as? TransitionEasingLayoutParam.Value {
                        // TODO: apply
                    }
                // - Constraint Overrides
                case .applyMotionScene:
                    if let value = param.value as? ApplyMotionSceneLayoutParam.Value {
                        // TODO: apply
                    }
                case .constraintTag:
                    if let value = param.value as? ConstraintTagLayoutParam.Value {
                        // TODO: apply
                    }
                // - Dimension Control
                case .widthDefault:
                    if let value = param.value as? WidthDefaultLayoutParam.Value {
                        // TODO: apply
                    }
                case .heightDefault:
                    if let value = param.value as? HeightDefaultLayoutParam.Value {
                        // TODO: apply
                    }
                // - Custom Attributes
                case .mCustom:
                    if let value = param.value as? MCustomLayoutParam.Value {
                        // TODO: apply
                    }
                default: continue
            }
        }
    }
}

extension LayoutParamKey {
    // - Motion Scene Parameters
    static let motionDebug: LayoutParamKey = "motionDebug"
    static let progress: LayoutParamKey = "progress"
    static let currentState: LayoutParamKey = "currentState"
    static let motionTarget: LayoutParamKey = "motionTarget"
    // - Path/Animation Control
    static let pathMotionArc: LayoutParamKey = "pathMotionArc"
    static let motionStagger: LayoutParamKey = "motionStagger"
    static let transitionEasing: LayoutParamKey = "transitionEasing"
    // - Constraint Overrides
    static let applyMotionScene: LayoutParamKey = "applyMotionScene"
    static let constraintTag: LayoutParamKey = "constraintTag"
    // - Dimension Control
    static let widthDefault: LayoutParamKey = "widthDefault"
    static let heightDefault: LayoutParamKey = "heightDefault"
    // - Custom Attributes
    static let mCustom: LayoutParamKey = "mCustom"
}

// MARK: - Motion Scene Parameters

struct MotionDebugLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .motionDebug
    let value: Int32
}

struct ProgressLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .progress
    let value: Float
}

struct CurrentStateLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .currentState
    let value: Int32
}

struct MotionTargetLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .motionTarget
    let value: Int32
}

// MARK: - Path/Animation Control

struct PathMotionArcLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .pathMotionArc
    let value: Int32
}

struct MotionStaggerLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .motionStagger
    let value: Float
}

struct TransitionEasingLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .transitionEasing
    let value: String
}

// MARK: - Constraint Overrides

struct ApplyMotionSceneLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .applyMotionScene
    let value: Bool
}

struct ConstraintTagLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .constraintTag
    let value: String
}

// MARK: - Dimension Control

struct WidthDefaultLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .widthDefault
    let value: Int32
}

struct HeightDefaultLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .heightDefault
    let value: Int32
}

// MARK: - Custom Attributes

struct MCustomLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .mCustom
    let value: String
}
