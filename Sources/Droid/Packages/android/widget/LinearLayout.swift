//
//  LinearLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class LinearLayoutClass: JClassName, @unchecked Sendable {}
    public var LinearLayout: LinearLayoutClass { .init(parent: self, name: "LinearLayout") }
}
extension AndroidPackage.WidgetPackage.LinearLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let linearLayout: Self = .init(.android.widget.LinearLayout.LayoutParams)
}

open class LinearLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .android.widget.LinearLayout }
    public override class var layoutParamsClass: LayoutParams.Class { .linearLayout }

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
            .gravity,
            .weight,
            .setMinHeight,
            .setMaxHeight
        ]
    }

    public enum Orientation: Int, Sendable {
        case horizontal, vertical
    }
}

// MARK: - LayoutParams

// MARK: Keys

extension LayoutParamKey {
    static let setOrder: Self = "setOrder"
    static let gravity: Self = "gravity"
    static let weight: Self = "weight"
}

// MARK: Order

struct OrderLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setOrder
    let value: Int
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}

// MARK: Gravity

struct GravityLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .gravity
    let value: Gravity
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: Int32(value.rawValue))
    }
}

// MARK: Weight

struct WeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .weight
    let value: Float
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

// MARK: - Properties

extension ViewPropertyKey {
    static let setBaselineAligned: ViewPropertyKey = "setBaselineAligned"
    static let setBaselineAlignedChildIndex: ViewPropertyKey = "setBaselineAlignedChildIndex"
    static let setDividerDrawable: ViewPropertyKey = "setDividerDrawable"
    static let setDividerPadding: ViewPropertyKey = "setDividerPadding"
    static let setGravity: ViewPropertyKey = "setGravity"
    static let setHorizontalGravity: ViewPropertyKey = "setHorizontalGravity"
    static let setMeasureWithLargestChildEnabled: ViewPropertyKey = "setMeasureWithLargestChildEnabled"
    static let setOrientation: ViewPropertyKey = "setOrientation"
    static let setShowDividers: ViewPropertyKey = "setShowDividers"
    static let setVerticalGravity: ViewPropertyKey = "setVerticalGravity"
    static let setWeightSum: ViewPropertyKey = "setWeightSum"
}

// MARK: BaselineAligned

struct BaselineAlignedViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setBaselineAligned
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension LinearLayout {
    public func baselineAligned(_ value: Bool = true) -> Self {
        BaselineAlignedViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: BaselineAlignedChildIndex

struct BaselineAlignedChildIndexViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setBaselineAlignedChildIndex
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension LinearLayout {
    public func baselineAlignedChildIndex(_ index: Int) -> Self {
        BaselineAlignedChildIndexViewProperty(value: index).applyOrAppend(nil, self)
    }
}

// MARK: DividerDrawable

struct DividerDrawableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setDividerDrawable
    let value: Drawable
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.object.signed(as: Drawable.className))
    }
}
extension LinearLayout {
    public func dividerDrawable(_ value: Drawable) -> Self {
        DividerDrawableViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: DividerPadding

struct DividerPaddingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setDividerPadding
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension LinearLayout {
    public func dividerPadding(_ padding: Int, _ unit: DimensionUnit = .dp) -> Self {
        DividerPaddingViewProperty(value: (padding, unit)).applyOrAppend(nil, self)
    }
}

// MARK: Gravity

public struct Gravity: OptionSet, Sendable {
    public let rawValue: Int

    public init (rawValue: Int) {
        self.rawValue = rawValue
    }

    // MARK: - Axis Constants
    public static let noGravity = Gravity([])

    public static let axisSpecified = Gravity(rawValue: 0x0001)
    public static let axisPullBefore = Gravity(rawValue: 0x0002)
    public static let axisPullAfter = Gravity(rawValue: 0x0004)
    public static let axisClip = Gravity(rawValue: 0x0008)

    public static let axisXShift = 0
    public static let axisYShift = 4

    // MARK: - Absolute Gravity
    public static let top = Gravity(rawValue: (axisPullBefore.rawValue | axisSpecified.rawValue) << axisYShift)
    public static let bottom = Gravity(rawValue: (axisPullAfter.rawValue  | axisSpecified.rawValue) << axisYShift)
    public static let left = Gravity(rawValue: (axisPullBefore.rawValue | axisSpecified.rawValue) << axisXShift)
    public static let right = Gravity(rawValue: (axisPullAfter.rawValue  | axisSpecified.rawValue) << axisXShift)

    public static let centerVertical = Gravity(rawValue: axisSpecified.rawValue << axisYShift)
    public static let fillVertical = Gravity(rawValue: top.rawValue | bottom.rawValue)

    public static let centerHorizontal = Gravity(rawValue: axisSpecified.rawValue << axisXShift)
    public static let fillHorizontal = Gravity(rawValue: left.rawValue | right.rawValue)

    public static let center = Gravity(arrayLiteral: [centerVertical, centerHorizontal])
    public static let fill = Gravity(rawValue: fillVertical.rawValue | fillHorizontal.rawValue)

    public static let clipVertical = Gravity(rawValue: axisClip.rawValue << axisYShift)
    public static let clipHorizontal = Gravity(rawValue: axisClip.rawValue << axisXShift)

    // MARK: - Relative Layout Direction
    public static let relativeLayoutDirection = Gravity(rawValue: 0x00800000)

    public static let start = Gravity(arrayLiteral: [relativeLayoutDirection, left])
    public static let end = Gravity(arrayLiteral: [relativeLayoutDirection, right])

    // MARK: - Masks
    public static let horizontalGravityMask = Gravity(rawValue: (axisSpecified.rawValue | axisPullBefore.rawValue | axisPullAfter.rawValue) << axisXShift)
    public static let verticalGravityMask = Gravity(rawValue: (axisSpecified.rawValue | axisPullBefore.rawValue | axisPullAfter.rawValue) << axisYShift)
    public static let relativeHorizontalGravityMask = Gravity(arrayLiteral: [start, end])

    // MARK: - Display Clip
    public static let displayClipVertical = Gravity(rawValue: 0x10000000)
    public static let displayClipHorizontal = Gravity(rawValue: 0x01000000)
}
struct GravityViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setGravity
    let value: Gravity
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value.rawValue))
    }
}
extension LinearLayout {
    public func gravityForSubviews(_ value: Gravity) -> Self {
        GravityViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: HorizontalGravity

struct HorizontalGravityViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setHorizontalGravity
    let value: Gravity
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value.rawValue))
    }
}
extension LinearLayout {
    public func horizontalGravityForSubviews(_ value: Gravity) -> Self {
        HorizontalGravityViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: MeasureWithLargestChildEnabled

struct MeasureWithLargestChildEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setMeasureWithLargestChildEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension LinearLayout {
    public func measureWithLargestChildEnabled(_ value: Bool = true) -> Self {
        MeasureWithLargestChildEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Orientation

struct OrientationViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOrientation
    let value: LinearLayout.Orientation
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value.rawValue))
    }
}
extension LinearLayout {
    @discardableResult
    public func orientation(_ orientation: Orientation) -> Self {
        OrientationViewProperty(value: orientation).applyOrAppend(nil, self)
    }
}

// MARK: ShowDividers

public enum ShowDividerMode: Int32 {
    case none = 0x00000000
    case beginning = 0x00000001
    case middle = 0x00000002
    case end = 0x00000004
}
struct ShowDividersViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setShowDividers
    let value: ShowDividerMode
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension LinearLayout {
    @discardableResult
    public func showDividers(_ mode: ShowDividerMode) -> Self {
        ShowDividersViewProperty(value: mode).applyOrAppend(nil, self)
    }
}

// MARK: VerticalGravity

struct VerticalGravityViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setVerticalGravity
    let value: Gravity
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value.rawValue))
    }
}
extension LinearLayout {
    public func verticalGravityForSubviews(_ value: Gravity) -> Self {
        VerticalGravityViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: WeightSum

struct WeightSumViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setWeightSum
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension LinearLayout {
    public func weightSum(_ value: Float) -> Self {
        WeightSumViewProperty(value: value).applyOrAppend(nil, self)
    }
}