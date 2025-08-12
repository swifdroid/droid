//
//  AppBarLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage {
    public class AppBarLayoutClass: JClassName, @unchecked Sendable {}
    public var AppBarLayout: AppBarLayoutClass { .init(parent: self, name: "AppBarLayout") }
}
extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage.AppBarLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public class ScrollingViewBehaviorClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
    public var ScrollingViewBehavior: ScrollingViewBehaviorClass { .init(parent: self, name: "ScrollingViewBehavior", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let materialAppBarLayout: Self = .init(.comGoogleAndroid.material.appbar.AppBarLayout.LayoutParams)
}

open class AppBarLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.material.appbar.AppBarLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .materialAppBarLayout }
    open override class var gradleDependencies: [String] { [
        #"implementation("com.google.android.material:material:1.12.0")"#
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
            .weight
        ]
    }
}

extension LayoutParamKey {
    static let weight: Self = "weight"
}

// MARK: Weight

struct WeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .weight
    let value: Float
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

extension AppBarLayout {
    public final class ScrollingViewBehavior: Behavior, @unchecked Sendable {
        public override class var className: JClassName { .comGoogleAndroid.material.appbar.AppBarLayout.ScrollingViewBehavior }

        public func overlayTop(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
            OverlayTopBehaviorParam(value: (value, unit)).applyOrAppend(self)
        }

        public func leftAndRightOffset(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
            LeftAndRightOffsetBehaviorParam(value: (value, unit)).applyOrAppend(self)
        }

        public func topAndBottomOffset(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
            TopAndBottomOffsetBehaviorParam(value: (value, unit)).applyOrAppend(self)
        }

        public func verticalOffsetEnabled(_ value: Bool = true) -> Self {
            VerticalOffsetEnabledBehaviorParam(value: value).applyOrAppend(self)
        }

        public func horizontalOffsetEnabled(_ value: Bool = true) -> Self {
            HorizontalOffsetEnabledBehaviorParam(value: value).applyOrAppend(self)
        }
    }
}

extension Behavior.ParamKey {
    static let setOverlayTop: Self = "setOverlayTop"
    static let setLeftAndRightOffset: Self = "setLeftAndRightOffset"
    static let setTopAndBottomOffset: Self = "setTopAndBottomOffset"
    static let setVerticalOffsetEnabled: Self = "setVerticalOffsetEnabled"
    static let setHorizontalOffsetEnabled: Self = "setHorizontalOffsetEnabled"
}

// MARK: OverlayTop

struct OverlayTopBehaviorParam: Behavior.ParamToApply {
    let key: Behavior.ParamKey = .setOverlayTop
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ behavior: Behavior.BehaviorInstance) {
        behavior.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}

// MARK: LeftAndRightOffset

struct LeftAndRightOffsetBehaviorParam: Behavior.ParamToApply {
    let key: Behavior.ParamKey = .setLeftAndRightOffset
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ behavior: Behavior.BehaviorInstance) {
        behavior.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}

// MARK: TopAndBottomOffset

struct TopAndBottomOffsetBehaviorParam: Behavior.ParamToApply {
    let key: Behavior.ParamKey = .setTopAndBottomOffset
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ behavior: Behavior.BehaviorInstance) {
        behavior.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}

// MARK: VerticalOffsetEnabled

struct VerticalOffsetEnabledBehaviorParam: Behavior.ParamToApply {
    let key: Behavior.ParamKey = .setVerticalOffsetEnabled
    let value: Bool
    func apply(_ env: JEnv?, _ behavior: Behavior.BehaviorInstance) {
        behavior.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: HorizontalOffsetEnabled

struct HorizontalOffsetEnabledBehaviorParam: Behavior.ParamToApply {
    let key: Behavior.ParamKey = .setHorizontalOffsetEnabled
    let value: Bool
    func apply(_ env: JEnv?, _ behavior: Behavior.BehaviorInstance) {
        behavior.callVoidMethod(env, name: key.rawValue, args: value)
    }
}