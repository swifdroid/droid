//
//  FlexboxLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension ComGoogleAndroidPackage {
    public class FlexboxLayoutClass: JClassName, @unchecked Sendable {}
    public var FlexboxLayout: FlexboxLayoutClass { .init(parent: self, name: "FlexboxLayout") }
}
extension ComGoogleAndroidPackage.FlexboxLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let flexboxLayout: Self = .init(.comGoogleAndroid.FlexboxLayout.LayoutParams)
}

open class FlexboxLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.FlexboxLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .flexboxLayout }
    open override class var gradleDependencies: [AppGradleDependency] { [.flexbox] }

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
            .setOrder,
            .setFlexGrow,
            .setFlexShrink,
            .setFlexBasisPercent,
            .setAlignSelf,
            .setWrapBefore,
            .setMinWidth,
            .setMaxWidth,
            .setMinHeight,
            .setMaxHeight
        ]
    }
}

extension LayoutParamKey {
    static let setFlexGrow: Self = "setFlexGrow"
    static let setFlexShrink: Self = "setFlexShrink"
    static let setFlexBasisPercent: Self = "setFlexBasisPercent"
    static let setAlignSelf: Self = "setAlignSelf"
    static let setWrapBefore: Self = "setWrapBefore"
    static let setMinWidth: Self = "minWidth"
    static let setMaxWidth: Self = "maxWidth"
    static let setMinHeight: Self = "minHeight"
    static let setMaxHeight: Self = "maxHeigh"
}

// MARK: FlexGrow

struct FlexGrowLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setFlexGrow
    let value: Float
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: FlexShrink

struct FlexShrinkLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setFlexShrink
    let value: Float
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: FlexBasisPercent

struct FlexBasisPercentLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setFlexBasisPercent
    let value: Float
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: AlignSelf

struct AlignSelfLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setAlignSelf
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: WrapBefore

struct WrapBeforeLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setWrapBefore
    let value: Bool
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: MinHeight

struct MinHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setMinHeight
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(nil, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}

// MARK: MaxHeight

struct MaxHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setMaxHeight
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(nil, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}

// MARK: MinWidth

struct MinWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setMinWidth
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(nil, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}

// MARK: MaxWidth

struct MaxWidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setMaxWidth
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(nil, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}

extension FlexboxLayout {
    public enum FlexDirection: Int32 {
        /// Main axis direction -> horizontal.
        ///
        /// Main start to main end -> Left to right (in LTR languages).
        ///
        /// Cross start to cross end -> Top to bottom
        case row
        
        /// Main axis direction -> horizontal.
        ///
        /// Main start to main end -> Right to left (in LTR languages).
        ///
        /// Cross start to cross end -> Top to bottom.
        case rowReverse
        
        /// Main axis direction -> vertical.
        ///
        /// Main start to main end -> Top to bottom.
        ///
        /// Cross start to cross end -> Left to right (In LTR languages).
        case column
        
        /// Main axis direction -> vertical.
        ///
        /// Main start to main end -> Bottom to top.
        ///
        /// Cross start to cross end -> Left to right (In LTR languages)
        case columnReverse
    }

    public enum FlexWrap: Int32 {
        /// The flex container is single-line.
        case noWrap

        /// The flex container is multi-line.
        case wrap

        /// The flex container is multi-line.
        ///
        /// The direction of the cross axis is opposed to the direction as the `wrap`.
        case wrapReverse
    }

    public enum AlignItems: Int32 {
        /// Flex item's edge is placed on the cross start line.
        case flexStart = 0

        /// Flex item's edge is placed on the cross end line.
        case flexEnd = 1

        /// Flex item's edge is centered along the cross axis.
        case center = 2

        /// Flex items are aligned based on their text's baselines.
        case baseline = 3

        /// Flex items are stretched to fill the flex line's cross size.
        case stretch = 4
    }
}