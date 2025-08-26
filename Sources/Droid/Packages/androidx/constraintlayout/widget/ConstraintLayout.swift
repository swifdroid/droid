//
//  ConstraintLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ConstraintLayoutPackage.WidgetPackage {
    public class ConstraintLayoutClass: JClassName, @unchecked Sendable {}
    public var ConstraintLayout: ConstraintLayoutClass { .init(parent: self, name: "ConstraintLayout") }
}
extension AndroidXPackage.ConstraintLayoutPackage.WidgetPackage.ConstraintLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let constraintLayout: Self = .init(.androidx.constraintlayout.widget.ConstraintLayout.LayoutParams)
}

open class ConstraintLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .androidx.constraintlayout.widget.ConstraintLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .constraintLayout }
    open override class var gradleDependencies: [String] { [
        #"implementation("androidx.constraintlayout:constraintlayout:2.2.1")"#,
        #"implementation("androidx.constraintlayout:constraintlayout-core:1.1.1")"#
    ] }

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
            // - Directional Constraints
            .leftToLeft,
            .leftToRight,
            .rightToLeft,
            .rightToRight,
            .topToTop,
            .topToBottom,
            .bottomToTop,
            .bottomToBottom,
            .startToStart,
            .startToEnd,
            .endToStart,
            .endToEnd,
            .baselineToBaseline,
            // - Dimensions
            .matchConstraintDefaultWidth,
            .matchConstraintDefaultHeight,
            .matchConstraintMinWidth,
            .matchConstraintMinHeight,
            .matchConstraintMaxWidth,
            .matchConstraintMaxHeight,
            .matchConstraintPercentWidth,
            .matchConstraintPercentHeight,
            // - Bias (Alignment)
            .horizontalBias,
            .verticalBias,
            // - Chains & Barriers
            .horizontalChainStyle,
            .verticalChainStyle,
            .chainUseRtl,
            // - Circular Positioning
            .circleConstraint,
            .circleRadius,
            .circleAngle,
            // - Aspect Ratio
            .dimensionRatio,
            // - View Visibility Behavior
            .goneTopMargin,
            .goneBottomMargin,
            .goneLeftMargin,
            .goneRightMargin,
            .goneStartMargin,
            .goneEndMargin
        ]
    }
}

extension LayoutParamKey {
    // - Directional Constraints
    static let leftToLeft: Self = "leftToLeft"
    static let leftToRight: Self = "leftToRight"
    static let rightToLeft: Self = "rightToLeft"
    static let rightToRight: Self = "rightToRight"
    static let topToTop: Self = "topToTop"
    static let topToBottom: Self = "topToBottom"
    static let bottomToTop: Self = "bottomToTop"
    static let bottomToBottom: Self = "bottomToBottom"
    static let startToStart: Self = "startToStart"
    static let startToEnd: Self = "startToEnd"
    static let endToStart: Self = "endToStart"
    static let endToEnd: Self = "endToEnd"
    static let baselineToBaseline: Self = "baselineToBaseline"
    // - Dimensions
    static let matchConstraintDefaultWidth: Self = "matchConstraintDefaultWidth"
    static let matchConstraintDefaultHeight: Self = "matchConstraintDefaultHeight"
    static let matchConstraintMinWidth: Self = "matchConstraintMinWidth"
    static let matchConstraintMinHeight: Self = "matchConstraintMinHeight"
    static let matchConstraintMaxWidth: Self = "matchConstraintMaxWidth"
    static let matchConstraintMaxHeight: Self = "matchConstraintMaxHeight"
    static let matchConstraintPercentWidth: Self = "matchConstraintPercentWidth"
    static let matchConstraintPercentHeight: Self = "matchConstraintPercentHeight"
    // - Bias (Alignment)
    static let horizontalBias: Self = "horizontalBias"
    static let verticalBias: Self = "verticalBias"
    // - Chains & Barriers
    static let horizontalChainStyle: Self = "horizontalChainStyle"
    static let verticalChainStyle: Self = "verticalChainStyle"
    static let chainUseRtl: Self = "chainUseRtl"
    // - Circular Positioning
    static let circleConstraint: Self = "circleConstraint"
    static let circleRadius: Self = "circleRadius"
    static let circleAngle: Self = "circleAngle"
    // - Aspect Ratio
    static let dimensionRatio: Self = "dimensionRatio"
    // - View Visibility Behavior
    static let goneTopMargin: Self = "goneTopMargin"
    static let goneBottomMargin: Self = "goneBottomMargin"
    static let goneLeftMargin: Self = "goneLeftMargin"
    static let goneRightMargin: Self = "goneRightMargin"
    static let goneStartMargin: Self = "goneStartMargin"
    static let goneEndMargin: Self = "goneEndMargin"
}

// MARK: - Directional Constraints

struct LeftToLeftLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .leftToLeft
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct LeftToRightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .leftToRight
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct RightToLeftLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .rightToLeft
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct RightToRightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .rightToRight
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct TopToTopLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .topToTop
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct TopToBottomLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .topToBottom
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct BottomToTopLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .bottomToTop
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct BottomToBottomLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .bottomToBottom
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct StartToStartLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .startToStart
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct StartToEndLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .startToEnd
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct EndToStartLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .endToStart
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct EndToEndLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .endToEnd
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct BaselineToBaselineLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .baselineToBaseline
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

// MARK: - Dimensions

struct MatchConstraintDefaultWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintDefaultWidth
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct MatchConstraintDefaultHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintDefaultHeight
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct MatchConstraintMinWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintMinWidth
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct MatchConstraintMinHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintMinHeight
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct MatchConstraintMaxWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintMaxWidth
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct MatchConstraintMaxHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintMaxHeight
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct MatchConstraintPercentWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintPercentWidth
    let value: Float
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct MatchConstraintPercentHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintPercentHeight
    let value: Float
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

// MARK: - Bias (Alignment)

struct HorizontalBiasLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .horizontalBias
    let value: Float
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct VerticalBiasLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .verticalBias
    let value: Float
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

// MARK: - Chains & Barriers

struct HorizontalChainStyleLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .horizontalChainStyle
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct VerticalChainStyleLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .verticalChainStyle
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct ChainUseRtlLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .chainUseRtl
    let value: Bool
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

// MARK: - Circular Positioning

struct CircleConstraintLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .circleConstraint
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct CircleRadiusLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .circleRadius
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

struct CircleAngleLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .circleAngle
    let value: Float
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

// MARK: - Aspect Ratio

struct DimensionRatioLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .dimensionRatio
    let value: String
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let str = env.newStringUTF(value),
            let string = str.box(env)?.object()
        else { return }
        lp.setField(env, name: key.rawValue, arg: string.object.signed(as: .java.lang.String))
        #endif
    }
}

// MARK: - View Visibility Behavior

struct GoneTopMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneTopMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
    }
}

struct GoneBottomMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneBottomMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
    }
}

struct GoneLeftMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneLeftMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
    }
}

struct GoneRightMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneRightMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
    }
}

struct GoneStartMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneStartMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
    }
}

struct GoneEndMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneEndMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
    }
}