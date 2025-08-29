//
//  Animation.swift
//  Droid
//
//  Created by Mihael Isaev on 24.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

/// Abstraction for an Animation that can be applied to Views, Surfaces, or other objects.
/// 
/// See the [animation package description file](https://developer.android.com/reference/android/view/animation/package-summary).
/// 
/// [Learn more](https://developer.android.com/reference/android/view/animation/Animation)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class Animation: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/view/animation/Animation" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

extension Animation {
    public enum Dimension: Int32 {
        /// Repeat the animation indefinitely.
        case infinite = -1
        /// The specified dimension is an absolute number of pixels.
        case absolute = 0
        /// The specified dimension holds a float and should be multiplied by the height or width of the object being animated.
        case relativeToSelf = 1
        /// The specified dimension holds a float and should be multiplied by the height or width of the parent of the object being animated.
        case relativeToParent = 2
    }

    public enum RepeatMode: Int32 {
        /// When the animation reaches the end and the repeat count is `INFINTE_REPEAT`
        /// or a positive value, the animation restarts from the beginning.
        case restart = 1
        /// When the animation reaches the end and the repeat count is `INFINTE_REPEAT`
        /// or a positive value, the animation plays backward (and then forward again).
        case reverse = 2
    }

    /// Can be used as the start time to indicate the start time should be the current time
    /// when `getTransformation(long, android.view.animation.Transformation)` is invoked
    /// for the first animation frame. This can is useful for short animations.
    public static let startOnFirstFrame: Int32 = -1

    public enum ZOrder: Int32 {
        /// Requests that the content being animated be forced under all other content for the duration of the animation.
        case bottom = -1
        /// Requests that the content being animated be kept in its current Z order.
        case normal = 0
        /// Requests that the content being animated be forced on top of all other content for the duration of the animation.
        case top = 1
    }

    /// Cancel the animation.
    /// 
    /// Cancelling an animation invokes the animation listener, if set, to notify the end of the animation.
    /// If you cancel an animation manually, you must call `reset()` before starting the animation again.
    public func cancel() {
        object.callVoidMethod(name: "cancel")
    }

    /// Compute a hint at how long the entire animation may last, in milliseconds.
    /// 
    /// Animations can be written to cause themselves to run for a different duration
    /// than what is computed here, but generally this should be accurate.
    public func computeDurationHint() -> Float! {
        object.callFloatMethod(name: "computeDurationHint")
    }

    /// Returns the background color to show behind the animating windows.
    /// 
    /// Will only show the background if showBackdrop was set to true.
    /// See [setShowBackdrop(boolean)](https://developer.android.com/reference/android/view/animation/Animation#setShowBackdrop(boolean)).
    public func backdropColor() -> GraphicsColor! {
        guard
            let value = object.callIntMethod(name: "getBackdropColor")
        else { return nil }
        return .init(integerLiteral: Int64(value))
    }

    /// How long this animation should last.
    public func duration() -> Int {
        Int(object.callLongMethod(name: "getDuration") ?? 0)
    }

    /// If `fillAfter` is true, this animation
    /// will apply its transformation after the end time of the animation.
    public func fillAfter() -> Bool {
        object.callBoolMethod(name: "getFillAfter") ?? false
    }

    /// If `fillBefore` is true, this animation will apply its transformation before the start time of the animation.
    /// 
    /// If `fillBefore` is false and fillEnabled is true, the transformation will not be applied until the start time of the animation.
    public func fillBefore() -> Bool {
        object.callBoolMethod(name: "getFillBefore") ?? false
    }

    /// Returns the timing interpolator that this animation uses.
    public func interpolator() -> TimeInterpolator! {
        guard
            let global = object.callObjectMethod(name: "getInterpolator", returning: .object(TimeInterpolator.className))
        else { return nil }
        return .init(global)
    }

    /// Defines how many times the animation should repeat. The default value is 0.
    public func repeatCount() -> Int {
        Int(object.callIntMethod(name: "getRepeatCount") ?? 0)
    }

    /// Defines what this animation should do when it reaches the end.
    public func repeatMode() -> RepeatMode {
        .init(rawValue: object.callIntMethod(name: "getRepeatMode") ?? 1) ?? .restart
    }

    /// If `showBackdrop` is true and this animation is applied on a window,
    /// then the windows in the animation will animate with the background associated with this window behind them.
    /// 
    /// If no backdrop color is explicitly set, the backdrop's color comes from the `R.styleable.Theme_colorBackground`
    /// that is applied to this window through its theme.
    /// If multiple animating windows have `showBackdrop` set to true during an animation,
    /// the top most window with showBackdrop set to true and a valid background color takes precedence.
    public func showBackdrop() -> Bool {
        object.callBoolMethod(name: "getShowBackdrop") ?? false
    }

    /// When this animation should start, relative to StartTime
    public func startOffset() -> Int {
        Int(object.callLongMethod(name: "getStartOffset") ?? 0)
    }

    /// When this animation should start.
    /// 
    /// If the animation has not startet yet,
    /// this method might return `START_ON_FIRST_FRAME`.
    public func startTime() -> Int {
        Int(object.callLongMethod(name: "getStartTime") ?? 0)
    }

    // TODO: getTransformation

    /// Returns the Z ordering mode to use while running the animation
    /// as previously set by `setZAdjustment(int)`.
    public func zAdjustment() -> ZOrder {
        .init(rawValue: object.callIntMethod(name: "getZAdjustment") ?? 0) ?? .normal
    }

    /// Indicates whether this animation has ended or not.
    public func hasEnded() -> Bool {
        object.callBoolMethod(name: "hasEnded") ?? false
    }

    /// Indicates whether this animation has started or not.
    public func hasStarted() -> Bool {
        object.callBoolMethod(name: "hasStarted") ?? false
    }

    /// Initialize this animation with the dimensions of the object
    /// being animated as well as the objects parents.
    /// (This is to support animation sizes being specified relative to these dimensions.)
    /// 
    /// Objects that interpret Animations should call this method when the sizes
    /// of the object being animated and its parent are known,
    // and before calling `getTransformation(long, Transformation)`.
    public func initialize(
        width: Int,
        height: Int,
        parentWidth: Int,
        parentHeight: Int,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "initialize", args: unit.toPixels(Int32(width)), unit.toPixels(Int32(height)), unit.toPixels(Int32(parentWidth)), unit.toPixels(Int32(parentHeight)))
    }

    /// If `fillEnabled` is true, this animation will apply the value of `fillBefore`.
    public func isFillEnabled() -> Bool {
        object.callBoolMethod(name: "isFillEnabled") ?? false
    }

    /// Whether or not the animation has been initialized.
    public func isInitialized() -> Bool {
        object.callBoolMethod(name: "isInitialized") ?? false
    }

    /// Reset the initialization state of this animation.
    public func reset() {
        object.callVoidMethod(name: "reset")
    }

    /// Ensure that the duration that this animation will run is not longer than `durationMillis`.
    /// 
    /// In addition to adjusting the duration itself, this ensures that the repeat count also will not make it run longer than the given time.
    public func restrictDuration(_ durationInMilliseconds: Int) {
        object.callVoidMethod(name: "restrictDuration", args: Int64(durationInMilliseconds))
    }

    /// How much to scale the duration by.
    public func scaleCurrentDuration(_ scale: Float) {
        object.callVoidMethod(name: "scaleCurrentDuration", args: scale)
    }

    // TODO: setAnimationListener

    /// Set the color to use for the backdrop shown behind the animating windows.
    /// 
    /// Will only show the backdrop if `showBackdrop` was set to true.
    /// See [setShowBackdrop(boolean)](https://developer.android.com/reference/android/view/animation/Animation#setShowBackdrop(boolean)).
    public func backdropColor(_ backdropColor: GraphicsColor) {
        object.callVoidMethod(name: "setBackdropColor", args: backdropColor.value)
    }

    /// How long this animation should last. The duration cannot be negative.
    public func duration(_ durationInMilliseconds: Int) {
        object.callVoidMethod(name: "setDuration", args: Int64(durationInMilliseconds))
    }

    /// If `fillAfter` is true, the transformation that this animation performed will persist when it is finished.
    /// 
    /// Defaults to false if not set. Note that this applies to individual animations and when using an `AnimationSet` to chain animations.
    public func fillAfter(_ value: Bool = true) {
        object.callVoidMethod(name: "setFillAfter", args: value)
    }

    /// If `fillBefore` is true, this animation will apply its transformation before the start time of the animation.
    /// 
    /// Defaults to true if setFillEnabled(boolean) is not set to true. Note that this applies when using an AnimationSet to chain animations.
    /// The transformation is not applied before the AnimationSet itself starts.
    public func fillBefore(_ value: Bool = true) {
        object.callVoidMethod(name: "setFillBefore", args: value)
    }

    /// If `fillEnabled` is true, the animation will apply the value of fillBefore.
    /// 
    /// Otherwise, `fillBefore` is ignored and the animation transformation is always applied until the animation ends.
    public func fillEnabled(_ value: Bool = true) {
        object.callVoidMethod(name: "setFillEnabled", args: value)
    }

    /// The time interpolator used in calculating the elapsed fraction of the animation.
    /// 
    /// The interpolator determines whether the animation runs with linear or non-linear motion,
    /// such as acceleration and deceleration. The default value is `AccelerateDecelerateInterpolator`.
    /// 
    /// You could set your own or one of the following interpolators:
    ///    - AccelerateDecelerateInterpolator:	An interpolator where the rate of change starts and ends slowly but accelerates through the middle. 
    ///    - AccelerateInterpolator:	An interpolator where the rate of change starts out slowly and and then accelerates. 
    ///    - AnticipateInterpolator:	An interpolator where the change starts backward then flings forward. 
    ///    - AnticipateOvershootInterpolator:	An interpolator where the change starts backward then flings forward and overshoots the target value and finally goes back to the final value. 
    ///    - BaseInterpolator:	An abstract class which is extended by default interpolators. 
    ///    - BounceInterpolator:	An interpolator where the change bounces at the end. 
    ///    - CycleInterpolator:	Repeats the animation for a specified number of cycles. 
    ///    - DecelerateInterpolator:	An interpolator where the rate of change starts out quickly and and then decelerates. 
    ///    - Interpolator:	An interpolator defines the rate of change of an animation. 
    ///    - LinearInterpolator:	An interpolator where the rate of change is constant 
    ///    - OvershootInterpolator:	An interpolator where the change flings forward and overshoots the last value then comes back. 
    ///    - PathInterpolator:	An interpolator that can traverse a Path that extends from Point (0, 0) to (1, 1). 
    public func interpolator(_ value: TimeInterpolator) {
        object.callVoidMethod(name: "setInterpolator", args: value.signed(as: TimeInterpolator.className))
    }

    /// Sets how many times the animation should be repeated.
    /// 
    /// If the repeat count is 0, the animation is never repeated.
    /// 
    /// If the repeat count is greater than 0 or `INFINITE`, the repeat mode will be taken into account.
    /// 
    /// The repeat count is 0 by default.
    public func repeatCount(_ value: Int) {
        object.callVoidMethod(name: "setRepeatCount", args: Int32(value))
    }

    /// Defines what this animation should do when it reaches the end.
    /// 
    /// This setting is applied only when the repeat count is either greater than 0 or `INFINITE`.
    /// 
    /// Defaults to `RESTART`.
    public func repeatMode(_ value: RepeatMode) {
        object.callVoidMethod(name: "setRepeatMode", args: value.rawValue)
    }

    /// If `showBackdrop` is true and this animation is applied on a window,
    /// then the windows in the animation will animate with the background associated with this window behind them.
    /// 
    /// If no backdrop color is explicitly set, the backdrop's color comes from the `R.styleable.Theme_colorBackground`
    /// that is applied to this window through its theme. If multiple animating windows
    /// have `showBackdrop` set to true during an animation, the top most window
    /// with `showBackdrop` set to true and a valid background color takes precedence.
    public func showBackdrop(_ value: Bool = true) {
        object.callVoidMethod(name: "setShowBackdrop", args: value)
    }

    /// When this animation should start relative to the start time.
    /// 
    /// This is most useful when composing complex animations using an `AnimationSet`
    /// where some of the animations components start at different times.
    public func startOffset(_ value: Int) {
        object.callVoidMethod(name: "setStartOffset", args: Int64(value))
    }

    /// When this animation should start.
    /// 
    /// When the start time is set to `START_ON_FIRST_FRAME`,
    /// the animation will start the first time `getTransformation(long, android.view.animation.Transformation)` is invoked.
    /// 
    /// The time passed to this method should be obtained by calling `AnimationUtils.currentAnimationTimeMillis()`
    /// instead of `System.currentTimeMillis()`.
    public func startTime(_ value: Int) {
        object.callVoidMethod(name: "setStartTime", args: Int64(value))
    }

    /// Set the Z ordering mode to use while running the animation.
    public func zAdjustment(_ value: ZOrder) {
        object.callVoidMethod(name: "setZAdjustment", args: value.rawValue)
    }

    /// Convenience method to start the animation the first time `getTransformation(long, android.view.animation.Transformation)`is invoked.
    public func start() {
        object.callVoidMethod(name: "start")
    }

    /// Convenience method to start the animation at the current time in milliseconds.
    public func startNow() {
        object.callVoidMethod(name: "startNow")
    }

    /// Indicates whether or not this animation will affect the bounds of the animated view.
    /// 
    /// For instance, a fade animation will not affect the bounds whereas a 200% scale animation will.
    public func willChangeBounds() -> Bool {
        object.callBoolMethod(name: "willChangeBounds") ?? false
    }

    /// Indicates whether or not this animation will affect the transformation matrix.
    /// 
    /// For instance, a fade animation will not affect the matrix whereas a scale animation will.
    public func willChangeTransformationMatrix() -> Bool {
        object.callBoolMethod(name: "willChangeTransformationMatrix") ?? false
    }
}

/// An animation that controls the alpha level of an object.
/// 
/// Useful for fading things in and out. This animation ends up changing the alpha property of a `Transformation`.
/// 
/// [Learn more](https://developer.android.com/reference/android/view/animation/AlphaAnimation)
public final class AlphaAnimation: Animation, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/AlphaAnimation" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `AlphaAnimation` from code.
    public init! (from: Float, to: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.float, .float, returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [from, to])
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// Represents a group of Animations that should be played together.
/// The transformation of each individual animation are composed together into a single transform.
/// If `AnimationSet` sets any properties that its children also set (for example, duration or `fillBefore`),
/// the values of `AnimationSet` override the child values.
/// 
/// The way that `AnimationSet` inherits behavior from Animation is important to understand.
/// Some of the Animation attributes applied to `AnimationSet` affect the `AnimationSet` itself,
/// some are pushed down to the children, and some are ignored, as follows:
/// 
///    - `duration`, `repeatMode`, `fillBefore`, `fillAfter`: These properties, when set on an `AnimationSet` object,
/// will be pushed down to all child animations.
///    - `repeatCount`, `fillEnabled`: These properties are ignored for `AnimationSet`.
///    - `startOffset`, `shareInterpolator`: These properties apply to the `AnimationSet` itself.
/// 
/// Starting with `Build.VERSION_CODES.ICE_CREAM_SANDWICH`,
/// the behavior of these properties is the same in XML resources and at runtime
/// (prior to that release, the values set in XML were ignored for `AnimationSet`).
/// That is, calling `setDuration(500)` on an `AnimationSet` has the same effect
/// as declaring `android:duration="500"` in an XML resource for an `AnimationSet` object.
///
/// [Lean more](https://developer.android.com/reference/android/view/animation/AnimationSet)
public final class AnimationSet: Animation, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/AnimationSet" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `AnimationSet` from code.
    public init! (shareInterpolator: Bool) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.boolean, returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [shareInterpolator])
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

extension AnimationSet {
    /// Add a child animation to this animation set.
    /// 
    /// The transforms of the child animations are applied in the order that they were added
    public func addAnimation(_ value: Animation) {
        object.callVoidMethod(name: "addAnimation", args: value.signed(as: Animation.className))
    }

    // TODO: getAnimations
}
