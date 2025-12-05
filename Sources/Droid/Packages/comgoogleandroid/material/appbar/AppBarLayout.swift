//
//  AppBarLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage {
    public class AppBarLayoutClass: JClassName, @unchecked Sendable {}
    public var AppBarLayout: AppBarLayoutClass { .init(parent: self, name: "AppBarLayout") }
}
extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage.AppBarLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public class ScrollingViewBehaviorClass: JClassName, @unchecked Sendable {}
    public class ChildScrollEffectClass: JClassName, @unchecked Sendable {}
    public class CompressChildScrollEffectClass: JClassName, @unchecked Sendable {}
    public class LiftOnScrollProgressListenerClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
    public var ScrollingViewBehavior: ScrollingViewBehaviorClass { .init(parent: self, name: "ScrollingViewBehavior", isInnerClass: true) }
    public var ChildScrollEffect: ChildScrollEffectClass { .init(parent: self, name: "ChildScrollEffect", isInnerClass: true) }
    public var CompressChildScrollEffect: CompressChildScrollEffectClass { .init(parent: self, name: "CompressChildScrollEffect", isInnerClass: true) }
    public var LiftOnScrollProgressListener: LiftOnScrollProgressListenerClass { .init(parent: self, name: "LiftOnScrollProgressListener", isInnerClass: true) }
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
            .weight,
            .scrollEffect,
            .scrollFlags,
            .scrollInterpolator
        ]
    }
}

extension LayoutParamKey {
    static let scrollEffect: Self = "setScrollEffect"
    static let scrollFlags: Self = "setScrollFlags"
    static let scrollInterpolator: Self = "setScrollInterpolator"
}

// MARK: ScrollEffect

extension AppBarLayout {
    public enum ScrollEffect: Int32 {
        /// No effect should be placed on this view.
        /// It will scroll 1:1 with the AppBarLayout/scrolling content.
        case none = 0
        /// An effect that will "compress" this view as it hits
        /// the scroll ceiling (typically the top of the screen).
        /// This is a parallax effect that masks this view and decreases
        /// its scroll ratio in relation to the AppBarLayout's offset.
        case compress = 1
    }

    public enum ScrollFlag: Int32 {
        /// When entering (scrolling on screen) the view will scroll
        /// on any downwards scroll event, regardless of whether
        /// the scrolling view is also scrolling. This is commonly
        /// referred to as the 'quick return' pattern.
        case enterAlways = 4
        /// An additional flag for 'enterAlways' which modifies
        /// the returning view to only initially scroll back to
        /// it's collapsed height. Once the scrolling view has
        /// reached the end of it's scroll range, the remainder
        /// of this view will be scrolled into view. The collapsed
        /// height is defined by the view's minimum height.
        case enterAlwaysCollapsed = 8
        /// When exiting (scrolling off screen) the view will be
        /// scrolled until it is 'collapsed'. The collapsed height
        /// is defined by the view's minimum height.
        case exitUntilCollapsed = 2
        /// Disable scrolling on the view. This flag should not be
        /// combined with any of the other scroll flags.
        case noScroll = 0
        /// The view will be scroll in direct relation to scroll events.
        /// This flag needs to be set for any of the other flags to take effect.
        /// If any sibling views before this one do not have this flag,
        /// then this value has no effect.
        case scroll = 1
        /// Upon a scroll ending, if the view is only partially visible
        /// then it will be snapped and scrolled to its closest edge.
        /// For example, if the view only has its bottom 25% displayed,
        /// it will be scrolled off screen completely. Conversely,
        /// if its bottom 75% is visible then it will be scrolled fully into view.
        case snap = 16
        /// An additional flag to be used with 'snap'. If set, the view
        /// will be snapped to its top and bottom margins, as opposed
        /// to the edges of the view itself.
        case snapMargins = 32
    }
}

struct ScrollEffectLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .scrollEffect
    let value: AppBarLayout.ScrollEffect
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Set the scroll effect to be applied when the AppBarLayout's offset changes.
    @discardableResult
    public func scrollEffect(_ effect: AppBarLayout.ScrollEffect) -> Self {
        ScrollEffectLayoutParam(value: effect).applyOrAppend(self)
    }
}

struct ScrollFlagsLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .scrollFlags
    let value: [AppBarLayout.ScrollFlag]
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        let combinedFlags = value.reduce(0) { $0 | $1.rawValue }
        lp.callVoidMethod(env, name: key.rawValue, args: combinedFlags)
    }
}
extension View {
    /// Set the scrolling flags.
    @discardableResult
    public func scrollFlags(_ flags: AppBarLayout.ScrollFlag...) -> Self {
        ScrollFlagsLayoutParam(value: flags).applyOrAppend(self)
    }
    /// Set the scrolling flags.
    @discardableResult
    public func scrollFlags(_ flags: [AppBarLayout.ScrollFlag]) -> Self {
        ScrollFlagsLayoutParam(value: flags).applyOrAppend(self)
    }
}

struct ScrollInterpolatorLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .scrollInterpolator
    let value: Interpolator
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(env, name: key.rawValue, args: value.signed(as: Interpolator.className))
    }
}
extension View {
    /// Set the interpolator to when scrolling the view associated with this `LayoutParams`.
    ///
    /// Parameters:
    ///   - interpolator: the interpolator to use, or null to use normal 1-to-1 scrolling.
    @discardableResult
    public func scrollInterpolator(_ interpolator: Interpolator) -> Self {
        ScrollInterpolatorLayoutParam(value: interpolator).applyOrAppend(self)
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

extension AppBarLayout {
    /// An effect class that should be implemented and used by AppBarLayout children to be given effects when the AppBarLayout's offset changes.
    ///
    /// [Learn more](https://developer.android.com/reference/com/google/android/material/appbar/AppBarLayout.ChildScrollEffect)
    public final class ChildScrollEffect: JObjectable, @unchecked Sendable {
        public static let className: JClassName = .comGoogleAndroid.material.appbar.AppBarLayout.ChildScrollEffect

        public let object: JObject

        public init (_ object: JObject) {
            self.object = object
        }

        public init? () {
            #if os(Android)
            guard
                let clazz = JClass.load(Self.className),
                let global = clazz.newObject()
            else { return nil }
            self.object = global
            #else
            return nil
            #endif
        }

        // TODO: onOffsetChanged
    }
}

extension AppBarLayout {
    /// A class which handles updating an `AppBarLayout` child,
    /// if marked with the `app:layout_scrollEffectcompress`,
    /// at each step in the `AppBarLayout`'s offset animation.
    ///
    /// Only a single `AppBarLayout` child should be given a compress effect.
    ///
    /// [Learn more](https://developer.android.com/reference/com/google/android/material/appbar/AppBarLayout.CompressChildScrollEffect)
    public final class CompressChildScrollEffect: JObjectable, @unchecked Sendable {
        public static let className: JClassName = .comGoogleAndroid.material.appbar.AppBarLayout.CompressChildScrollEffect

        public let object: JObject

        public init (_ object: JObject) {
            self.object = object
        }

        public init? () {
            #if os(Android)
            guard
                let clazz = JClass.load(Self.className),
                let global = clazz.newObject()
            else { return nil }
            self.object = global
            #else
            return nil
            #endif
        }

        // TODO: onOffsetChanged
    }
}

extension AppBarLayout {
    /// Definition for a callback to be invoked when the lift on scroll progress has changed.
    ///
    /// [Learn more](https://developer.android.com/reference/com/google/android/material/appbar/AppBarLayout.LiftOnScrollProgressListener)
    public final class LiftOnScrollProgressListener: JObjectable, @unchecked Sendable {
        public static let className: JClassName = .comGoogleAndroid.material.appbar.AppBarLayout.LiftOnScrollProgressListener

        public let object: JObject

        public init (_ object: JObject) {
            self.object = object
        }

        // TODO: onUpdate
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

// MARK: AppBarLayout.LayoutParams fields (TODO)

// extension View {
//     public var scrollEffect: AppBarLayout.ChildScrollEffect? {
//         guard
//             let clazz = JClass.load(AppBarLayout.ChildScrollEffect.className),
//             let global = instance?.layoutParams()?.objectField(name: "scrollEffect", returningClass: clazz)
//         else { return nil }
//         return AppBarLayout.ChildScrollEffect(global)
//     }
    
//     public var scrollFlags: Int32? {
//         instance?.layoutParams()?.intField(name: "scrollFlags")
//     }

//     public var scrollInterpolator: Interpolator? {
//         guard
//             let clazz = JClass.load(Interpolator.className),
//             let global = instance?.layoutParams()?.objectField(name: "scrollInterpolator", returningClass: clazz)
//         else { return nil }
//         return Interpolator(global)
//     }
// }
