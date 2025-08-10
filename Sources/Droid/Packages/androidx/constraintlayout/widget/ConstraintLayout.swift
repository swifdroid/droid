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
        #"implementation("androidx.constraintlayout:constraintlayout:2.2.1")"#
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

    open override func processLayoutParams(_ lp: LayoutParams, for subview: View) {
        super.processLayoutParams(lp, for: subview)
        let params = filteredLayoutParams()
        for param in params {
            switch param.key {
                // - Directional Constraints
                case .leftToLeft:
                    if let value = param.value as? LeftToLeftLayoutParam.Value {
                        // TODO: apply
                    }
                case .leftToRight:
                    if let value = param.value as? LeftToRightLayoutParam.Value {
                        // TODO: apply
                    }
                case .rightToLeft:
                    if let value = param.value as? RightToLeftLayoutParam.Value {
                        // TODO: apply
                    }
                case .rightToRight:
                    if let value = param.value as? RightToRightLayoutParam.Value {
                        // TODO: apply
                    }
                case .topToTop:
                    if let value = param.value as? TopToTopLayoutParam.Value {
                        // TODO: apply
                    }
                case .topToBottom:
                    if let value = param.value as? TopToBottomLayoutParam.Value {
                        // TODO: apply
                    }
                case .bottomToTop:
                    if let value = param.value as? BottomToTopLayoutParam.Value {
                        // TODO: apply
                    }
                case .bottomToBottom:
                    if let value = param.value as? BottomToBottomLayoutParam.Value {
                        // TODO: apply
                    }
                case .startToStart:
                    if let value = param.value as? StartToStartLayoutParam.Value {
                        // TODO: apply
                    }
                case .startToEnd:
                    if let value = param.value as? StartToEndLayoutParam.Value {
                        // TODO: apply
                    }
                case .endToStart:
                    if let value = param.value as? EndToStartLayoutParam.Value {
                        // TODO: apply
                    }
                case .endToEnd:
                    if let value = param.value as? EndToEndLayoutParam.Value {
                        // TODO: apply
                    }
                case .baselineToBaseline:
                    if let value = param.value as? BaselineToBaselineLayoutParam.Value {
                        // TODO: apply
                    }
                // - Dimensions
                case .matchConstraintDefaultWidth:
                    if let value = param.value as? MatchConstraintDefaultWidthLayoutParam.Value {
                        // TODO: apply
                    }
                case .matchConstraintDefaultHeight:
                    if let value = param.value as? MatchConstraintDefaultHeightLayoutParam.Value {
                        // TODO: apply
                    }
                case .matchConstraintMinWidth:
                    if let value = param.value as? MatchConstraintMinWidthLayoutParam.Value {
                        // TODO: apply
                    }
                case .matchConstraintMinHeight:
                    if let value = param.value as? MatchConstraintMinHeightLayoutParam.Value {
                        // TODO: apply
                    }
                case .matchConstraintMaxWidth:
                    if let value = param.value as? MatchConstraintMaxWidthLayoutParam.Value {
                        // TODO: apply
                    }
                case .matchConstraintMaxHeight:
                    if let value = param.value as? MatchConstraintMaxHeightLayoutParam.Value {
                        // TODO: apply
                    }
                case .matchConstraintPercentWidth:
                    if let value = param.value as? MatchConstraintPercentWidthLayoutParam.Value {
                        // TODO: apply
                    }
                case .matchConstraintPercentHeight:
                    if let value = param.value as? MatchConstraintPercentHeightLayoutParam.Value {
                        // TODO: apply
                    }
                // - Bias (Alignment)
                case .horizontalBias:
                    if let value = param.value as? HorizontalBiasLayoutParam.Value {
                        // TODO: apply
                    }
                case .verticalBias:
                    if let value = param.value as? VerticalBiasLayoutParam.Value {
                        // TODO: apply
                    }
                // - Chains & Barriers
                case .horizontalChainStyle:
                    if let value = param.value as? HorizontalChainStyleLayoutParam.Value {
                        // TODO: apply
                    }
                case .verticalChainStyle:
                    if let value = param.value as? VerticalChainStyleLayoutParam.Value {
                        // TODO: apply
                    }
                case .chainUseRtl:
                    if let value = param.value as? ChainUseRtlLayoutParam.Value {
                        // TODO: apply
                    }
                // - Circular Positioning
                case .circleConstraint:
                    if let value = param.value as? CircleConstraintLayoutParam.Value {
                        // TODO: apply
                    }
                case .circleRadius:
                    if let value = param.value as? CircleRadiusLayoutParam.Value {
                        // TODO: apply
                    }
                case .circleAngle:
                    if let value = param.value as? CircleAngleLayoutParam.Value {
                        // TODO: apply
                    }
                // - Aspect Ratio
                case .dimensionRatio:
                    if let value = param.value as? DimensionRatioLayoutParam.Value {
                        // TODO: apply
                    }
                // - View Visibility Behavior
                case .goneTopMargin:
                    if let value = param.value as? GoneTopMarginLayoutParam.Value {
                        // TODO: apply
                    }
                case .goneBottomMargin:
                    if let value = param.value as? GoneBottomMarginLayoutParam.Value {
                        // TODO: apply
                    }
                case .goneLeftMargin:
                    if let value = param.value as? GoneLeftMarginLayoutParam.Value {
                        // TODO: apply
                    }
                case .goneRightMargin:
                    if let value = param.value as? GoneRightMarginLayoutParam.Value {
                        // TODO: apply
                    }
                case .goneStartMargin:
                    if let value = param.value as? GoneStartMarginLayoutParam.Value {
                        // TODO: apply
                    }
                case .goneEndMargin:
                    if let value = param.value as? GoneEndMarginLayoutParam.Value {
                        // TODO: apply
                    }
                default: continue
            }
        }
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
}

struct LeftToRightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .leftToRight
    let value: Int32
}

struct RightToLeftLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .rightToLeft
    let value: Int32
}

struct RightToRightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .rightToRight
    let value: Int32
}

struct TopToTopLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .topToTop
    let value: Int32
}

struct TopToBottomLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .topToBottom
    let value: Int32
}

struct BottomToTopLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .bottomToTop
    let value: Int32
}

struct BottomToBottomLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .bottomToBottom
    let value: Int32
}

struct StartToStartLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .startToStart
    let value: Int32
}

struct StartToEndLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .startToEnd
    let value: Int32
}

struct EndToStartLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .endToStart
    let value: Int32
}

struct EndToEndLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .endToEnd
    let value: Int32
}

struct BaselineToBaselineLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .baselineToBaseline
    let value: Int32
}

// MARK: - Dimensions

struct MatchConstraintDefaultWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintDefaultWidth
    let value: Int32
}

struct MatchConstraintDefaultHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintDefaultHeight
    let value: Int32
}

struct MatchConstraintMinWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintMinWidth
    let value: Int32
}

struct MatchConstraintMinHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintMinHeight
    let value: Int32
}

struct MatchConstraintMaxWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintMaxWidth
    let value: Int32
}

struct MatchConstraintMaxHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintMaxHeight
    let value: Int32
}

struct MatchConstraintPercentWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintPercentWidth
    let value: Float
}

struct MatchConstraintPercentHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .matchConstraintPercentHeight
    let value: Float
}

// MARK: - Bias (Alignment)

struct HorizontalBiasLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .horizontalBias
    let value: Float
}

struct VerticalBiasLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .verticalBias
    let value: Float
}

// MARK: - Chains & Barriers

struct HorizontalChainStyleLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .horizontalChainStyle
    let value: Int32
}

struct VerticalChainStyleLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .verticalChainStyle
    let value: Int32
}

struct ChainUseRtlLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .chainUseRtl
    let value: Bool
}

// MARK: - Circular Positioning

struct CircleConstraintLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .circleConstraint
    let value: Int32
}

struct CircleRadiusLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .circleRadius
    let value: Int32
}

struct CircleAngleLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .circleAngle
    let value: Float
}

// MARK: - Aspect Ratio

struct DimensionRatioLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .dimensionRatio
    let value: String
}

// MARK: - View Visibility Behavior

struct GoneTopMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneTopMargin
    let value: (Int, DimensionUnit)
}

struct GoneBottomMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneBottomMargin
    let value: (Int, DimensionUnit)
}

struct GoneLeftMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneLeftMargin
    let value: (Int, DimensionUnit)
}

struct GoneRightMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneRightMargin
    let value: (Int, DimensionUnit)
}

struct GoneStartMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneStartMargin
    let value: (Int, DimensionUnit)
}

struct GoneEndMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .goneEndMargin
    let value: (Int, DimensionUnit)
}