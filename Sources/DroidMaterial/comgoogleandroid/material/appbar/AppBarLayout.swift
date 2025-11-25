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

/// AppBarLayout is a vertical LinearLayout which implements
/// many of the features of material designs app bar concept,
/// namely scrolling gestures.
/// 
/// Children should provide their desired scrolling behavior
/// through setScrollFlags and the associated layout
/// xml attribute: `app:layout_scrollFlags`.
/// 
/// This view depends heavily on being used as a direct child within a `CoordinatorLayout`.
/// If you use `AppBarLayout` within a different `ViewGroup`, most of its functionality will not work.
/// 
/// `AppBarLayout` also requires a separate scrolling sibling in order to know when to scroll.
/// The binding is done through the `ScrollingViewBehavior` behavior class,
/// meaning that you should set your scrolling view's behavior
/// to be an instance of `ScrollingViewBehavior`.
/// A string resource containing the full class name is available.
///
/// [Learn more](https://developer.android.com/reference/com/google/android/material/appbar/AppBarLayout)
open class AppBarLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.material.appbar.AppBarLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .materialAppBarLayout }
    open override class var gradleDependencies: [AppGradleDependency] { [.material] }

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