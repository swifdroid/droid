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

/// An animation that controls the rotation of an object.
/// 
/// This rotation takes place in the X-Y plane.
/// 
/// You can specify the point to use for the center of the rotation, where `(0,0)` is the top left point.
/// 
/// If not specified, `(0,0)` is the default rotation point.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/RotateAnimation)
public final class RotateAnimation: Animation, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/RotateAnimation" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `RotateAnimation` from code.
    /// 
    /// Default pivotX/pivotY point is (0,0).
    public init! (fromDegrees: Float, toDegrees: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.float, .float, returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [fromDegrees, toDegrees])
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Constructor to use when building an `RotateAnimation` from code.
    public init! (fromDegrees: Float, toDegrees: Float, pivotXType: Dimension, pivotX: Float, pivotYType: Dimension, pivotY: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.float, .float, .int, .float, .int, .float, returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [fromDegrees, toDegrees, pivotXType.rawValue, pivotX, pivotYType.rawValue, pivotY])
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// An animation that controls the scale of an object.
/// 
/// You can specify the point to use for the center of scaling.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/ScaleAnimation)
public final class ScaleAnimation: Animation, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/ScaleAnimation" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `ScaleAnimation` from code.
    public init! (fromX: Float, toX: Float, fromY: Float, toY: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.float, .float, .float, .float, returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [fromX, toX, fromY, toY])
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Constructor to use when building an `ScaleAnimation` from code.
    public init! (fromX: Float, toX: Float, fromY: Float, toY: Float, pivotX: Float, pivotY: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.float, .float, .float, .float, .float, .float, returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [fromX, toX, fromY, toY, pivotX, pivotY])
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Constructor to use when building an `ScaleAnimation` from code.
    public init! (fromX: Float, toX: Float, fromY: Float, toY: Float, pivotXType: Dimension, pivotX: Float, pivotYType: Dimension, pivotY: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.float, .float, .float, .float, .int, .float, .int, .float, returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [fromX, toX, fromY, toY, pivotXType.rawValue, pivotX, pivotYType.rawValue, pivotY])
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// An animation that controls the position of an object.
/// 
/// See the [full package](https://developer.android.com/reference/android/view/animation/package-summary)
/// description for details and sample code.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/TranslateAnimation)
public final class TranslateAnimation: Animation, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/TranslateAnimation" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `TranslateAnimation` from code.
    public init! (fromXDelta: Float, toXDelta: Float, fromYDelta: Float, toYDelta: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.float, .float, returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [fromXDelta, toXDelta, fromYDelta, toYDelta])
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Constructor to use when building an `TranslateAnimation` from code.
    public init! (
        fromXType: Dimension, fromXValue: Float,
        toXType: Dimension, toXValue: Float,
        fromYType: Dimension, fromYValue: Float,
        toYType: Dimension, toYValue: Float
    ) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.int, .float, .int, .float, .int, .float, .int, .float, returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [fromXType.rawValue, fromXValue, toXType.rawValue, toXValue, fromYType.rawValue, fromYValue, toYType.rawValue, toYValue])
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// This is the superclass for classes which provide basic support for animations which can be started, ended, and have AnimatorListeners added to them.
/// 
/// [Learn more](https://developer.android.com/reference/android/view/animation/Animator)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class Animator: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/view/animation/Animator" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

extension Animator {
    // TODO: addListener
    // TODO: addPauseListener

    /// Cancels the animation.
    /// 
    /// Unlike `end()` it causes the animation to stop in its tracks,
    /// sending an `.onAnimationCancel()` to its listeners,
    /// followed by an `.onAnimationEnd()` message.
    /// 
    /// This method must be called on the thread that is running the animation.
    public func cancel() {
        object.callVoidMethod(name: "cancel")
    }

    /// Creates and returns a copy of this object.
    /// 
    /// The precise meaning of "copy" may depend on the class of the object.
    public func clone() -> Animator! {
        guard
            let global = object.callObjectMethod(name: "clone", returning: .object(Animator.className))
        else { return nil }
        return .init(global)
    }

    /// Ends the animation.
    /// 
    /// This causes the animation to assign the end value of the property being animated,
    /// then calling the `.onAnimationEnd(Animator)` method on its listeners.
    /// 
    /// This method must be called on the thread that is running the animation.
    public func end() {
        object.callVoidMethod(name: "end")
    }

    /// Gets the duration of the animation.
    public func duration() -> Int {
        Int(object.callLongMethod(name: "getDuration") ?? 0)
    }

    /// Returns the timing interpolator that this animation uses.
    public func interpolator() -> TimeInterpolator! {
        guard
            let global = object.callObjectMethod(name: "getInterpolator")
        else { return nil }
        return .init(global)
    }

    // TODO: getListeners

    /// The amount of time, in milliseconds, to delay processing the animation after `start()` is called.
    public func startDelay() -> Int {
        Int(object.callLongMethod(name: "getStartDelay") ?? 0)
    }

    /// Gets the total duration of the animation, accounting for animation sequences, start delay, and repeating.
    /// 
    /// Return `DURATION_INFINITE` if the duration is infinite.
    public func totalDuration() -> Int {
        Int(object.callLongMethod(name: "getTotalDuration") ?? 0)
    }

    /// Returns whether this animator is currently in a paused state.
    public func isPaused() -> Bool {
        object.callBoolMethod(name: "isPaused") ?? false
    }

    /// Returns whether this Animator is currently running
    /// (having been started and gone past any initial startDelay period and not yet ended).
    public func isRunning() -> Bool {
        object.callBoolMethod(name: "isRunning") ?? false
    }

    /// Returns whether this Animator has been started and not yet ended.
    /// 
    /// For reusable Animators (which most Animators are,
    /// apart from the one-shot animator produced by createCircularReveal()),
    /// this state is a superset of isRunning(), because an Animator
    /// with a nonzero `startDelay` will return true for isStarted() during the delay phase,
    /// whereas isRunning() will return true only after the delay phase is complete.
    /// 
    /// Non-reusable animators will always return true after they have been started,
    /// because they cannot return to a non-started state.
    public func isStarted() -> Bool {
        object.callBoolMethod(name: "isStarted") ?? false
    }

    /// Pauses a running animation.
    /// 
    /// This method should only be called on the same thread on which the animation was started.
    /// 
    /// If the animation has not yet been started or has since ended, then the call is ignored.
    /// 
    /// Paused animations can be resumed by calling resume().
    public func pause() {
        object.callVoidMethod(name: "pause")
    }

    /// Removes all `listeners` and `pauseListeners` from this object.
    public func removeAllListeners() {
        object.callVoidMethod(name: "removeAllListeners")
    }

    // TODO: removeListener
    // TODO: removePauseListener

    /// Resumes a paused animation, causing the animator to pick up where it left off when it was paused.
    /// 
    /// This method should only be called on the same thread on which the animation was started.
    /// 
    /// Calls to resume() on an animator that is not currently paused will be ignored.
    public func resume() {
        object.callVoidMethod(name: "resume")
    }

    /// Sets the duration of the animation.
    public func duration(_ duration: Int) -> Animator! {
        guard
            let global = object.callObjectMethod(name: "setDuration", args: Int32(duration), returning: .object(Animator.className))
        else { return nil }
        return .init(global)
    }

    /// The time interpolator used in calculating the elapsed fraction of the animation.
    /// 
    /// The interpolator determines whether the animation runs with linear or non-linear motion,
    /// such as acceleration and deceleration.
    /// 
    /// The default value is `AccelerateDecelerateInterpolator`.
    public func interpolator(_ interpolator: TimeInterpolator) {
        object.callVoidMethod(name: "setInterpolator", args: interpolator.signed(as: TimeInterpolator.className))
    }

    /// The amount of time, in milliseconds, to delay processing the animation after `start()` is called.
    public func startDelay(_ delay: Int) {
        object.callVoidMethod(name: "setStartDelay", args: Int32(delay))
    }

    /// Sets the target object whose property will be animated by this animation.
    /// 
    /// Not all subclasses operate on target objects (for example, `ValueAnimator`,
    /// but this method is on the superclass for the convenience of dealing generically
    /// with those subclasses that do handle targets.
    /// 
    /// **Note:** The target is stored as a weak reference internally to avoid leaking resources
    /// by having animators directly reference old targets.
    /// 
    /// Therefore, you should ensure that animator targets always have a hard reference elsewhere.
    public func target(_ target: JObjectable) {
        object.callVoidMethod(name: "setTarget", args: target.signed(as: "java/lang/Object"))
    }

    /// This method tells the object to use appropriate information to extract ending values for the animation.
    /// 
    /// For example, a `AnimatorSet` object will pass this call to its child objects to tell them to set up the values.
    /// 
    /// A `ObjectAnimator` object will use the information it has about its target object and PropertyValuesHolder objects to get the start values for its properties.
    /// 
    /// A `ValueAnimator` object will ignore the request since it does not have enough information (such as a target object) to gather these values.
    public func setupEndValues() {
        object.callVoidMethod(name: "setupEndValues")
    }

    /// This method tells the object to use appropriate information to extract starting values for the animation.
    /// 
    /// For example, a `AnimatorSet` object will pass this call to its child objects to tell them to set up the values.
    /// 
    /// A `ObjectAnimator` object will use the information it has about its target object and PropertyValuesHolder objects to get the start values for its properties.
    /// 
    /// A `ValueAnimator` object will ignore the request since it does not have enough information (such as a target object) to gather these values.
    public func setupStartValues() {
        object.callVoidMethod(name: "setupStartValues")
    }

    /// Starts this animation.
    /// 
    /// If the animation has a nonzero startDelay, the animation will start running after that delay elapses.
    /// 
    /// A non-delayed animation will have its initial value(s) set immediately, followed by calls to `AnimatorListener.onAnimationStart(Animator)`
    /// for any listeners of this animator.
    /// 
    /// The animation started by calling this method will be run on the thread that called this method.
    /// 
    /// This thread should have a Looper on it (a runtime exception will be thrown if this is not the case).
    /// 
    /// Also, if the animation will animate properties of objects in the view hierarchy,
    /// then the calling thread should be the UI thread for that view hierarchy.
    public func start() {
        object.callVoidMethod(name: "start")
    }
}

/// This class plays a set of Animator objects in the specified order.
/// 
/// Animations can be set up to play together, in sequence, or after a specified delay.
///
/// There are two different approaches to adding animations to a AnimatorSet:
/// either the playTogether() or playSequentially() methods can be called to add a set of animations all at once,
/// or the AnimatorSet.play(Animator) can be used in conjunction with methods in the Builder class to add animations one by one.
///
/// It is possible to set up a AnimatorSet with circular dependencies between its animations.
/// 
/// For example, an animation a1 could be set up to start before animation a2, a2 before a3, and a3 before a1.
/// 
/// The results of this configuration are undefined, but will typically result in none of the affected animations being played.
/// 
/// Because of this (and because circular dependencies do not make logical sense anyway), circular dependencies should be avoided,
/// and the dependency flow of animations should only be in one direction.
public final class AnimatorSet: Animator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/AnimatorSet" }
}

extension AnimatorSet {
    // TODO: getChildAnimations

    /// Returns the milliseconds elapsed since the start of the animation.
    ///
    /// For ongoing animations, this method returns the current progress of the animation in terms of play time.
    /// 
    /// For an animation that has not yet been started: if the animation has been seeked to a certain time
    /// via setCurrentPlayTime(long), the seeked play time will be returned; otherwise, this method will return 0.
    public func currentPlayTime() -> Int {
        Int(object.callLongMethod(name: "getCurrentPlayTime") ?? 0)
    }

    /// This method creates a Builder object, which is used to set up playing constraints.
    /// 
    /// This initial play() method tells the Builder the animation that is the dependency for the succeeding commands to the Builder.
    /// For example, calling play(a1).with(a2) sets up the AnimatorSet to play a1 and a2 at the same time, play(a1).before(a2) sets up
    /// the AnimatorSet to play a1 first, followed by a2, and play(a1).after(a2) sets up the AnimatorSet to play a2 first, followed by a1.
    /// 
    /// Note that play() is the only way to tell the Builder the animation upon which the dependency is created,
    /// so successive calls to the various functions in Builder will all refer to the initial parameter supplied in play() as the dependency of the other animations.
    /// 
    /// For example, calling play(a1).before(a2).before(a3) will play both a2 and a3 when a1 ends; it does not set up a dependency between a2 and a3.
    public func play() {
        object.callVoidMethod(name: "play")
    }

    // TODO: playSequentially
    // TODO: playTogether

    /// Plays the AnimatorSet in reverse.
    /// 
    /// If the animation has been seeked to a specific play time using setCurrentPlayTime(long),
    /// it will play backwards from the point seeked when reverse was called.
    /// 
    /// Otherwise, then it will start from the end and play backwards.
    /// 
    /// This behavior is only set for the current animation;
    /// future playing of the animation will use the default behavior of playing forward.
    /// 
    /// Note: reverse is not supported for infinite AnimatorSet.
    public func reverse() {
        object.callVoidMethod(name: "reverse")
    }

    /// Sets the position of the animation to the specified point in time.
    /// 
    /// This time should be between 0 and the total duration of the animation, including any repetition.
    /// 
    /// If the animation has not yet been started, then it will not advance forward after it is set to this time;
    /// it will simply set the time to this value and perform any appropriate actions based on that time.
    /// 
    /// If the animation is already running, then setCurrentPlayTime() will set the current playing time to this value and continue playing from that point.
    /// 
    /// On Build.VERSION_CODES.UPSIDE_DOWN_CAKE and above, an AnimatorSet that hasn't been start()ed,
    /// will issue Animator.AnimatorListener.onAnimationStart(Animator, boolean) and Animator.AnimatorListener.onAnimationEnd(Animator, boolean) events.
    public func currentPlayTime(_ playTime: Int) {
        object.callVoidMethod(name: "setCurrentPlayTime", args: Int64(playTime))
    }
}

/// This class provides a simple timing engine for running animations which calculate animated values and set them on target objects.
///
/// There is a single timing pulse that all animations use. It runs in a custom handler to ensure that property changes happen on the UI thread.
/// 
/// By default, ValueAnimator uses non-linear time interpolation, via the AccelerateDecelerateInterpolator class,
/// which accelerates into and decelerates out of an animation. This behavior can be changed by calling `ValueAnimator.setInterpolator(TimeInterpolator)`.
public final class ValueAnimator: Animator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/ValueAnimator" }
}

extension ValueAnimator {
    // TODO: static areAnimatorsEnabled

    /// Returns the current animation fraction,
    /// which is the elapsed/interpolated fraction used in the most recent frame update on the animation.
    public func animatedFraction() -> Float {
        object.callFloatMethod(name: "getAnimatedFraction") ?? 0
    }

    /// The most recent value calculated by this `ValueAnimator` when there is just one property being animated.
    /// 
    /// This value is only sensible while the animation is running.
    /// 
    /// The main purpose for this read-only property is to retrieve the value from the ValueAnimator
    /// during a call to AnimatorUpdateListener.onAnimationUpdate(ValueAnimator),
    /// which is called during each animation frame, immediately after the value is calculated.
    public func animatedValue() -> JObject? {
        guard
            let global = object.callObjectMethod(name: "getAnimatedValue", returning: .object("java/lang/Object"))
        else { return nil }
        return global
    }

    /// The most recent value calculated by this `ValueAnimator` for `propertyName`.
    /// 
    /// This value is only sensible while the animation is running.
    /// 
    /// The main purpose for this read-only property is to retrieve the value from the ValueAnimator
    /// during a call to AnimatorUpdateListener.onAnimationUpdate(ValueAnimator),
    /// which is called during each animation frame, immediately after the value is calculated.
    public func animatedValue(_ propertyName: String) -> JObject? {
        guard
            let str = JString(from: propertyName),
            let global = object.callObjectMethod(name: "getAnimatedValue", args: str.signedAsString(), returning: .object("java/lang/Object"))
        else { return nil }
        return global
    }

    /// Gets the current position of the animation in time,
    /// which is equal to the current time minus the time that the animation started.
    /// 
    /// An animation that is not yet started will return a value of zero,
    /// unless the animation has has its play time set via setCurrentPlayTime(long)
    /// or setCurrentFraction(float), in which case it will return the time that was set.
    public func currentPlayTime() -> Int {
        Int(object.callLongMethod(name: "getCurrentPlayTime") ?? 0)
    }

    // TODO: static getDurationScale
    // public func durationScale() -> Float {
    //     object.callFloatMethod(name: "getDurationScale") ?? 0
    // }
    // TODO: getFrameDelay

    /// Defines how many times the animation should repeat. The default value is 0.
    public func repeatCount() -> Int {
        Int(object.callIntMethod(name: "getRepeatCount") ?? 0)
    }

    /// Defines what this animation should do when it reaches the end.
    public func repeatMode() -> Animation.RepeatMode {
        .init(rawValue: object.callIntMethod(name: "getRepeatMode") ?? 1) ?? .restart
    }

    // TODO: getValues
    // TODO: ofArgb
    // TODO: ofFloat
    // TODO: ofInt
    // TODO: ofObject
    // TODO: ofPropertyValuesHolder
    
    public func removeAllUpdateListeners() {
        object.callVoidMethod(name: "removeAllUpdateListeners")
    }

    // TODO: removeUpdateListener
    
    /// Plays the AnimatorSet in reverse.
    /// 
    /// If the animation has been seeked to a specific play time using setCurrentPlayTime(long),
    /// it will play backwards from the point seeked when reverse was called.
    /// 
    /// Otherwise, then it will start from the end and play backwards.
    /// 
    /// This behavior is only set for the current animation;
    /// future playing of the animation will use the default behavior of playing forward.
    /// 
    /// Note: reverse is not supported for infinite AnimatorSet.
    public func reverse() {
        object.callVoidMethod(name: "reverse")
    }
    
    /// Sets the position of the animation to the specified fraction.
    /// 
    /// This fraction should be between 0 and the total fraction of the animation, including any repetition.
    /// 
    /// That is, a fraction of 0 will position the animation at the beginning, a value of 1 at the end,
    /// and a value of 2 at the end of a reversing animator that repeats once.
    /// 
    /// If the animation has not yet been started, then it will not advance forward after it is set to this fraction;
    /// it will simply set the fraction to this value and perform any appropriate actions based on that fraction.
    /// 
    /// If the animation is already running, then setCurrentFraction() will set the current fraction to this value and continue playing from that point.
    /// 
    /// Animator.AnimatorListener events are not called due to changing the fraction; those events are only processed while the animation is running.
    public func currentFraction(_ fraction: Float) {
        object.callVoidMethod(name: "setCurrentFraction", args: fraction)
    }

    /// Sets the position of the animation to the specified point in time.
    /// 
    /// This time should be between 0 and the total duration of the animation, including any repetition.
    /// 
    /// If the animation has not yet been started, then it will not advance forward after it is set to this time;
    /// it will simply set the time to this value and perform any appropriate actions based on that time.
    /// 
    /// If the animation is already running, then setCurrentPlayTime() will set the current playing time to this value and continue playing from that point.
    /// 
    /// On Build.VERSION_CODES.UPSIDE_DOWN_CAKE and above, an AnimatorSet that hasn't been start()ed,
    /// will issue Animator.AnimatorListener.onAnimationStart(Animator, boolean) and Animator.AnimatorListener.onAnimationEnd(Animator, boolean) events.
    public func currentPlayTime(_ playTime: Int) {
        object.callVoidMethod(name: "setCurrentPlayTime", args: Int64(playTime))
    }

    // TODO: setEvaluator
    // TODO: setFloatValues
    // TODO: static setFrameDelay
    // TODO: setIntValues
    // TODO: setObjectValues
    
    /// Sets how many times the animation should be repeated.
    /// 
    /// If the repeat count is 0, the animation is never repeated.
    /// 
    /// If the repeat count is greater than 0 or INFINITE, the repeat mode will be taken into account.
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
    public func repeatMode(_ value: Animation.RepeatMode) {
        object.callVoidMethod(name: "setRepeatMode", args: value.rawValue)
    }

    // TODO: setValues
}

/// This subclass of ValueAnimator provides support for animating properties on target objects.
/// 
/// The constructors of this class take parameters to define the target object that will be animated
/// as well as the name of the property that will be animated.
/// 
/// Appropriate set/get functions are then determined internally and the animation will call these functions as necessary to animate the property.
public final class ObjectAnimator: Animator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/ObjectAnimator" }
}

extension ObjectAnimator {
    /// Gets the name of the property that will be animated.
    /// 
    /// This name will be used to derive a setter function that will be called to set animated values.
    /// 
    /// For example, a property name of foo will result in a call to the function setFoo() on the target object.
    /// 
    /// If either valueFrom or valueTo is null, then a getter function will also be derived and called.
    ///
    /// If this animator was created with a Property object instead of the string name of a property,
    /// then this method will return the name of that Property object instead.
    /// 
    /// If this animator was created with one or more PropertyValuesHolder objects,
    /// then this method will return the name of that object (if there was just one)
    /// or a comma-separated list of all of the names (if there are more than one).
    public func propertyName() -> String! {
        guard
            let str = object.callObjectMethod(name: "getPropertyName", returning: .object(JString.className))
        else { return nil }
        return JString(str).toString()
    }

    /// The target object whose property will be animated by this animation
    public func getTarget() -> JObject? {
        object.callObjectMethod(name: "getTarget")
    }

    /// `autoCancel` controls whether an `ObjectAnimator` will be canceled automatically
    /// when any other `ObjectAnimator` with the same target and properties is started.
    /// 
    /// Setting this flag may make it easier to run different animators on the same target object
    /// without having to keep track of whether there are conflicting animators that need to be manually canceled.
    /// 
    /// Canceling animators must have the same exact set of target properties, in the same order.
    public func autoCancel(_ value: Bool = true) {
        object.callVoidMethod(name: "setAutoCancel", args: value)
    }

    // TODO: setFloatValues
    // TODO: setIntValues
    // TODO: setObjectValues
    // TODO: setProperty

    /// Sets the name of the property that will be animated.
    /// 
    /// This name is used to derive a setter function that will be called to set animated values.
    /// 
    /// For example, a property name of foo will result in a call to the function setFoo() on the target object.
    /// 
    /// If either valueFrom or valueTo is null, then a getter function will also be derived and called.
    ///
    /// 
    /// For best performance of the mechanism that calls the setter function determined by the name of the property being animated,
    /// use float or int typed values, and make the setter function for those properties have a void return value.
    ///
    /// This will cause the code to take an optimized path for these constrained circumstances.
    /// 
    /// Other property types and return types will work, but will have more overhead in processing the requests due to normal reflection mechanisms.
    /// 
    /// Note that the setter function derived from this property name must take the same parameter type as the valueFrom and valueTo properties,
    /// otherwise the call to the setter function will fail.
    /// 
    /// If this ObjectAnimator has been set up to animate several properties together, using more than one PropertyValuesHolder objects,
    /// then setting the propertyName simply sets the propertyName in the first of those PropertyValuesHolder objects.
    public func propertyName(_ name: String) {
        guard
            let str = JString(from: name)
        else { return }
        object.callVoidMethod(name: "setPropertyName", args: str.signedAsString())
    }
}

/// This class provides a simple callback mechanism to listeners that is synchronized with all other animators in the system.
/// 
/// There is no duration, interpolation, or object value-setting with this Animator. Instead, it is simply started,
/// after which it proceeds to send out events on every animation frame to its TimeListener (if set), with information about this animator,
/// the total elapsed time, and the elapsed time since the previous animation frame.
public final class TimeAnimator: Animator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/TimeAnimator" }
}

extension TimeAnimator {
    /// Sets the position of the animation to the specified point in time.
    /// 
    /// This time should be between 0 and the total duration of the animation, including any repetition.
    /// 
    /// If the animation has not yet been started, then it will not advance forward after it is set to this time;
    /// it will simply set the time to this value and perform any appropriate actions based on that time.
    /// 
    /// If the animation is already running, then setCurrentPlayTime() will set the current playing time to this value and continue playing from that point.
    /// 
    /// On Build.VERSION_CODES.UPSIDE_DOWN_CAKE and above, an AnimatorSet that hasn't been start()ed,
    /// will issue Animator.AnimatorListener.onAnimationStart(Animator, boolean) and Animator.AnimatorListener.onAnimationEnd(Animator, boolean) events.
    public func currentPlayTime(_ playTime: Int) {
        object.callVoidMethod(name: "setCurrentPlayTime", args: Int64(playTime))
    }

    // TODO: setTimeListener
}

/// [Learn more](https://developer.android.com/reference/android/view/animation/TimeInterpolator)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class TimeInterpolator: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/view/animation/TimeInterpolator" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

extension TimeInterpolator {
    /// Maps a value representing the elapsed fraction of an animation
    /// to a value that represents the interpolated fraction.
    /// 
    /// This interpolated value is then multiplied by the change in value of an animation
    /// to derive the animated value at the current elapsed animation time.
    public func getInterpolation(_ input: Float) -> Float! {
        object.callFloatMethod(name: "getInterpolation", args: input)
    }
}

/// An interpolator defines the rate of change of an animation.
/// 
/// This allows the basic animation effects (alpha, scale, translate, rotate) to be accelerated, decelerated, repeated, etc.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/Interpolator)
open class Interpolator: TimeInterpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/Interpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }
}

/// An abstract class which is extended by default interpolators.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/BaseInterpolator)
open class BaseInterpolator: Interpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/BaseInterpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }
}

/// An interpolator where the rate of change starts and ends slowly but accelerates through the middle.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/AccelerateDecelerateInterpolator)
public final class AccelerateDecelerateInterpolator: BaseInterpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/AccelerateDecelerateInterpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `AccelerateDecelerateInterpolator` from code.
    public init! () {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [])
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}
