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
        return .init(integerLiteral: value)
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
            let returningClazz = JClass.load(TimeInterpolator.className),
            let global = object.callObjectMethod(name: "getInterpolator", returningClass: returningClazz)
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
            let global = clazz.newObject(env, args: from, to)
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
            let global = clazz.newObject(env, args: shareInterpolator)
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
            let global = clazz.newObject(env, args: fromDegrees, toDegrees)
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
            let global = clazz.newObject(env, args: fromDegrees, toDegrees, pivotXType.rawValue, pivotX, pivotYType.rawValue, pivotY)
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
            let global = clazz.newObject(env, args: fromX, toX, fromY, toY)
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
            let global = clazz.newObject(env, args: fromX, toX, fromY, toY, pivotX, pivotY)
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
            let global = clazz.newObject(env, args: fromX, toX, fromY, toY, pivotXType.rawValue, pivotX, pivotYType.rawValue, pivotY)
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
            let global = clazz.newObject(env, args: fromXDelta, toXDelta, fromYDelta, toYDelta)
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
            let global = clazz.newObject(env, args: fromXType.rawValue, fromXValue, toXType.rawValue, toXValue, fromYType.rawValue, fromYValue, toYType.rawValue, toYValue)
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
            let returningClazz = JClass.load(Animator.className),
            let global = object.callObjectMethod(name: "clone", returningClass: returningClazz)
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
            let returningClazz = JClass.load(TimeInterpolator.className),
            let global = object.callObjectMethod(name: "getInterpolator", returningClass: returningClazz)
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
            let returningClazz = JClass.load(Animator.className),
            let global = object.callObjectMethod(name: "setDuration", args: Int32(duration), returningClass: returningClazz)
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
            let returningClazz = JClass.load("java/lang/Object"),
            let global = object.callObjectMethod(name: "getAnimatedValue", returningClass: returningClazz)
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
            let returningClazz = JClass.load("java/lang/Object"),
            let global = object.callObjectMethod(name: "getAnimatedValue", args: str.signedAsString(), returningClass: returningClazz)
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
            let returningClazz = JClass.load(JString.className),
            let str = object.callObjectMethod(name: "getPropertyName", returningClass: returningClazz)
        else { return nil }
        return JString(str).toString()
    }

    /// The target object whose property will be animated by this animation
    public func getTarget() -> JObject? {
        guard
            let returningClazz = JClass.load(JString.className)
        else { return nil }
        return object.callObjectMethod(name: "getTarget", returningClass: returningClazz)
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
}

/// An abstract class which is extended by default interpolators.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/BaseInterpolator)
open class BaseInterpolator: Interpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/BaseInterpolator" }
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
            let global = clazz.newObject(env)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// An interpolator where the rate of change starts out slowly and and then accelerates.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/AccelerateInterpolator)
public final class AccelerateInterpolator: BaseInterpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/AccelerateInterpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `AccelerateInterpolator` from code.
    public init! () {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Constructor to use when building an `AccelerateInterpolator` from code.
    public init! (factor: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: factor)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// An interpolator where the change starts backward then flings forward.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/AnticipateInterpolator)
public final class AnticipateInterpolator: BaseInterpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/AnticipateInterpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `AnticipateInterpolator` from code.
    public init! () {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Constructor to use when building an `AnticipateInterpolator` from code.
    public init! (tension: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: tension)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// An interpolator where the change starts backward then flings forward.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/AnticipateOvershootInterpolator)
public final class AnticipateOvershootInterpolator: BaseInterpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/AnticipateOvershootInterpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `AnticipateOvershootInterpolator` from code.
    public init! () {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Constructor to use when building an `AnticipateOvershootInterpolator` from code.
    public init! (tension: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: tension)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Constructor to use when building an `AnticipateOvershootInterpolator` from code.
    public init! (tension: Float, extraTension: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: tension, extraTension)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// An interpolator where the change bounces at the end.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/BounceInterpolator)
public final class BounceInterpolator: BaseInterpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/BounceInterpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `BounceInterpolator` from code.
    public init! () {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// Repeats the animation for a specified number of cycles.
/// 
/// The rate of change follows a sinusoidal pattern.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/CycleInterpolator)
public final class CycleInterpolator: BaseInterpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/CycleInterpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `CycleInterpolator` from code.
    public init! (cycles: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: cycles)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// An interpolator where the rate of change starts out quickly and and then decelerates.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/DecelerateInterpolator)
public final class DecelerateInterpolator: BaseInterpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/DecelerateInterpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `DecelerateInterpolator` from code.
    public init! () {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Constructor to use when building an `DecelerateInterpolator` from code.
    public init! (factor: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: factor)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// An interpolator where the rate of change is constant
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/LinearInterpolator)
public final class LinearInterpolator: BaseInterpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/LinearInterpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `LinearInterpolator` from code.
    public init! () {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// An interpolator where the change flings forward and overshoots the last value then comes back.
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/OvershootInterpolator)
public final class OvershootInterpolator: BaseInterpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/OvershootInterpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Constructor to use when building an `OvershootInterpolator` from code.
    public init! () {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Constructor to use when building an `OvershootInterpolator` from code.
    public init! (tension: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: tension)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// An interpolator that can traverse a `Path` that extends from Point `(0, 0)` to `(1, 1)`.
/// 
/// The x coordinate along the `Path` is the input value and the output is the y coordinate of the line at that point.
/// 
/// This means that the Path must conform to a function `y = f(x)`.
/// 
/// The `Path` must not have gaps in the x direction and must not loop back on itself such that there can be two points sharing the same x coordinate.
/// 
/// It is alright to have a disjoint line in the vertical direction:
/// ```
/// Path().lineTo(0.25, 0.25)
///          .moveTo(0.25, 0.5)
///          .lineTo(1.0, 1.0)
/// ```
/// 
/// [Lean more](https://developer.android.com/reference/android/view/animation/PathInterpolator)
public final class PathInterpolator: BaseInterpolator, @unchecked Sendable {
    public class override var className: JClassName { "android/view/animation/PathInterpolator" }

    public override init (_ object: JObject) {
        super.init(object)
    }

    /// Create an interpolator for an arbitrary `Path`.
    /// 
    /// The Path must begin at `(0, 0)` and end at `(1, 1)`.
    public init! (_ path: Path) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: path.object.signed(as: Path.className))
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Create an interpolator for a quadratic Bezier curve.
    /// 
    /// The end points `(0, 0)` and `(1, 1)` are assumed.
    public init! (controlX: Float, controlY: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: controlX, controlY)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }

    /// Create an interpolator for a quadratic Bezier curve.
    /// 
    /// The end points `(0, 0)` and `(1, 1)` are assumed.
    public init! (controlX1: Float, controlY1: Float, controlX2: Float, controlY2: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: controlX1, controlY1, controlX2, controlY2)
        else { return nil }
        super.init(global)
        #else
        return nil
        #endif
    }
}

/// Rect holds four integer coordinates for a rectangle.
/// 
/// The rectangle is represented by the coordinates of its 4 edges (left, top, right bottom).
/// 
/// These fields can be accessed directly.
/// 
/// Use `width()` and `height()` to retrieve the rectangle's width and height.
/// 
/// Note: most methods do not check to see that the coordinates are sorted correctly (i.e. left <= right and top <= bottom).
///
/// Note that the right and bottom coordinates are exclusive.
/// This means a `Rect` being drawn untransformed onto a `Canvas` will draw into the column
/// and row described by its left and top coordinates, but not those of its bottom and right.
/// 
/// [Learn more](https://developer.android.com/reference/android/graphics/Rect)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class Rect: JObjectable, @unchecked Sendable {
    public static var className: JClassName { "android/graphics/Rect" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    /// Create a new rectangle, initialized with the values in the specified rectangle (which is left unmodified).
    public init! () {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env)
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }

    /// Create a new rectangle with the specified coordinates.
    /// 
    /// Note: no range checking is performed, so the caller must ensure that left <= right and top <= bottom.
    public init! (
        left: Int,
        top: Int,
        right: Int,
        bottom: Int,
        _ unit: DimensionUnit = .dp
    ) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: unit.toPixels(Int32(left)), unit.toPixels(Int32(top)), unit.toPixels(Int32(right)), unit.toPixels(Int32(bottom)))
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }
}

extension Rect {
    public func bottom(_ unit: DimensionUnit = .dp) -> Int {
        Int(unit.from(object.intField(name: "bottom") ?? 0))
    }

    public func left(_ unit: DimensionUnit = .dp) -> Int {
        Int(unit.from(object.intField(name: "left") ?? 0))
    }

    public func right(_ unit: DimensionUnit = .dp) -> Int {
        Int(unit.from(object.intField(name: "right") ?? 0))
    }

    public func top(_ unit: DimensionUnit = .dp) -> Int {
        Int(unit.from(object.intField(name: "top") ?? 0))
    }

    /// The horizontal center of the rectangle.
    /// 
    /// If the computed value is fractional, this method returns the largest integer that is less than the computed value.
    public func centerX(_ unit: DimensionUnit = .dp) -> Int {
        Int(unit.from(object.callIntMethod(name: "centerX") ?? 0))
    }

    /// The vertical center of the rectangle.
    /// 
    /// If the computed value is fractional, this method returns the largest integer that is less than the computed value.
    public func centerY(_ unit: DimensionUnit = .dp) -> Int {
        Int(unit.from(object.callIntMethod(name: "centerY") ?? 0))
    }

    /// Returns true iff the 4 specified sides of a rectangle are inside or equal to this rectangle.
    /// 
    /// i.e. is this rectangle a superset of the specified rectangle. An empty rectangle never contains another rectangle.
    public func contains(
        left: Int,
        top: Int,
        right: Int,
        bottom: Int,
        _ unit: DimensionUnit = .dp
    ) -> Bool {
        object.callBoolMethod(name: "contains", args: unit.toPixels(Int32(left)), unit.toPixels(Int32(top)), unit.toPixels(Int32(right)), unit.toPixels(Int32(bottom))) ?? false
    }

    /// Returns true iff the specified rectangle r is inside or equal to this rectangle.
    /// 
    /// An empty rectangle never contains another rectangle.
    public func contains(_ r: Rect) -> Bool {
        object.callBoolMethod(name: "contains", args: r.signed(as: Rect.className)) ?? false
    }

    /// Returns true if (x,y) is inside the rectangle.
    /// 
    /// The left and top are considered to be inside, while the right and bottom are not.
    /// 
    /// This means that for a x,y to be contained: left <= x < right and top <= y < bottom.
    /// 
    /// An empty rectangle never contains any point.
    public func contains(
        x: Int,
        y: Int,
        _ unit: DimensionUnit = .dp
    ) -> Bool {
        object.callBoolMethod(name: "contains", args: unit.toPixels(Int32(x)), unit.toPixels(Int32(y))) ?? false
    }

    /// Parcelable interface methods
    public func describeContents() -> Int {
        Int(object.callIntMethod(name: "describeContents") ?? 0)
    }

    // TODO: equals?

    /// The exact horizontal center of the rectangle as a float.
    public func exactCenterX(_ unit: DimensionUnit = .dp) -> Float {
        unit.from(object.callFloatMethod(name: "exactCenterX") ?? 0)
    }

    /// The exact vertical center of the rectangle as a float.
    public func exactCenterY(_ unit: DimensionUnit = .dp) -> Float {
        unit.from(object.callFloatMethod(name: "exactCenterY") ?? 0)
    }

    /// Return a string representation of the rectangle in a well-defined format.
    public func flattenToString() -> String? {
        guard
            let returningClazz = JClass.load(JString.className),
            let global = object.callObjectMethod(name: "flattenToString", returningClass: returningClazz)
        else { return nil }
        return JString(global).toString()
    }

    /// Returns a hash code value for the object.
    /// 
    /// This method is supported for the benefit of hash tables such as those provided by HashMap.
    public func hashCode() -> Int {
        Int(object.callIntMethod(name: "hashCode") ?? 0)
    }

    /// The rectangle's height.
    /// 
    /// This does not check for a valid rectangle (i.e. top <= bottom) so the result may be negative.
    public func height(_ unit: DimensionUnit = .dp) -> Int {
        Int(unit.from(object.callIntMethod(name: "height") ?? 0))
    }

    /// Insets the rectangle on all sides specified by the dimensions of `insets`.
    public func inset(
        left: Int,
        top: Int,
        right: Int,
        bottom: Int,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "inset", args: unit.toPixels(Int32(left)), unit.toPixels(Int32(top)), unit.toPixels(Int32(right)), unit.toPixels(Int32(bottom)))
    }

    /// Inset the rectangle by `(dx,dy)`.
    /// 
    /// If dx is positive, then the sides are moved inwards, making the rectangle narrower.
    /// 
    /// If dx is negative, then the sides are moved outwards, making the rectangle wider.
    /// 
    /// The same holds `true` for `dy` and the top and bottom.
    public func inset(
        dx: Int,
        dy: Int,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "inset", args: unit.toPixels(Int32(dx)), unit.toPixels(Int32(dy)))
    }

    /// If the rectangle specified by left,top,right,bottom intersects this rectangle,
    /// return true and set this rectangle to that intersection,
    /// otherwise return false and do not change this rectangle. No check is performed to see if either rectangle is empty.
    ///
    /// Note: To just test for intersection, use: `intersects()`
    public func intersect(
        left: Int,
        top: Int,
        right: Int,
        bottom: Int,
        _ unit: DimensionUnit = .dp
    ) -> Bool {
        object.callBoolMethod(name: "intersect", args: unit.toPixels(Int32(left)), unit.toPixels(Int32(top)), unit.toPixels(Int32(right)), unit.toPixels(Int32(bottom))) ?? false
    }

    /// If the specified rectangle intersects this rectangle,
    /// return true and set this rectangle to that intersection,
    /// otherwise return false and do not change this rectangle.
    /// 
    /// No check is performed to see if either rectangle is empty.
    /// 
    /// To just test for intersection, use `intersects()`
    public func intersect(_ r: Rect) -> Bool {
        object.callBoolMethod(name: "intersect", args: r.signed(as: Rect.className)) ?? false
    }

    /// Returns true if this rectangle intersects the specified rectangle.
    /// 
    /// In no event is this rectangle modified.
    /// 
    /// No check is performed to see if either rectangle is empty.
    /// 
    /// To record the intersection, use `intersect()` or `setIntersect()`.
    public func intersects(
        left: Int,
        top: Int,
        right: Int,
        bottom: Int,
        _ unit: DimensionUnit = .dp
    ) -> Bool {
        object.callBoolMethod(name: "intersects", args: unit.toPixels(Int32(left)), unit.toPixels(Int32(top)), unit.toPixels(Int32(right)), unit.toPixels(Int32(bottom))) ?? false
    }

    /// Returns true iff the two specified rectangles intersect.
    /// 
    /// In no event is this rectangle modified.
    /// 
    /// No check is performed to see if either rectangle is empty.
    /// 
    /// To record the intersection, use `intersect()` or `setIntersect()`.
    // public static func intersect(_ a: Rect, _ b: Rect) -> Bool { // TODO: make static
    //     object.callBoolMethod(name: "intersect", args: a.signed(as: Rect.className), b.signed(as: Rect.className)) ?? false
    // }

    /// Returns true if the rectangle is empty (left >= right or top >= bottom)
    public func isEmpty() -> Bool {
        object.callBoolMethod(name: "isEmpty") ?? false
    }

    /// Offset the rectangle by adding dx to its left and right coordinates,
    /// and adding dy to its top and bottom coordinates.
    public func offset(
        dx: Int,
        dy: Int,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "offset", args: unit.toPixels(Int32(dx)), unit.toPixels(Int32(dy)))
    }

    /// Offset the rectangle to a specific (left, top) position,
    /// keeping its width and height the same.
    public func offsetTo(
        newLeft: Int,
        newTop: Int,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "offsetTo", args: unit.toPixels(Int32(newLeft)), unit.toPixels(Int32(newTop)))
    }

    // TODO: readFromParcel

    /// Set the rectangle's coordinates to the specified values.
    /// 
    // Note: no range checking is performed, so it is up to the caller to ensure that left <= right and top <= bottom.
    public func set(
        left: Int,
        top: Int,
        right: Int,
        bottom: Int,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "set", args: unit.toPixels(Int32(left)), unit.toPixels(Int32(top)), unit.toPixels(Int32(right)), unit.toPixels(Int32(bottom)))
    }

    /// Copy the coordinates from src into this rectangle.
    public func set(_ src: Rect) {
        object.callVoidMethod(name: "set", args: src.signed(as: Rect.className))
    }

    /// Set the rectangle to (0,0,0,0)
    public func setEmpty() {
        object.callVoidMethod(name: "setEmpty")
    }

    /// If rectangles a and b intersect, return true and set this rectangle to that intersection,
    /// otherwise return false and do not change this rectangle.
    /// 
    /// No check is performed to see if either rectangle is empty.
    /// 
    /// To just test for intersection, use `intersects()`
    public func setIntersect(_ a: Rect, _ b: Rect) -> Bool {
        object.callBoolMethod(name: "setIntersect", args: a.signed(as: Rect.className), b.signed(as: Rect.className)) ?? false
    }

    /// Swap top/bottom or left/right if there are flipped (i.e. left > right and/or top > bottom).
    /// 
    /// This can be called if the edges are computed separately, and may have crossed over each other.
    /// 
    /// If the edges are already correct (i.e. left <= right and top <= bottom) then nothing is done.
    public func sort() {
        object.callVoidMethod(name: "sort")
    }

    // TODO: toShortString
    // TODO: unflattenFromString

    /// Update this Rect to enclose itself and the specified rectangle.
    /// 
    /// If the specified rectangle is empty, nothing is done.
    /// 
    /// If this rectangle is empty it is set to the specified rectangle.
    public func union(
        left: Int,
        top: Int,
        right: Int,
        bottom: Int,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "union", args: unit.toPixels(Int32(left)), unit.toPixels(Int32(top)), unit.toPixels(Int32(right)), unit.toPixels(Int32(bottom)))
    }

    /// Update this Rect to enclose itself and the specified rectangle.
    /// 
    /// If the specified rectangle is empty, nothing is done.
    /// 
    /// If this rectangle is empty it is set to the specified rectangle.
    public func union(_ r: Rect) {
        object.callVoidMethod(name: "union", args: r.signed(as: Rect.className))
    }

    /// Update this Rect to enclose itself and the [x,y] coordinate.
    /// 
    /// There is no check to see that this rectangle is non-empty.
    public func union(
        x: Int,
        y: Int,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "union", args: unit.toPixels(Int32(x)), unit.toPixels(Int32(y)))
    }

    /// The rectangle's width.
    /// 
    /// This does not check for a valid rectangle (i.e. left <= right) so the result may be negative.
    public func width(_ unit: DimensionUnit = .dp) -> Int {
        Int(unit.from(object.callIntMethod(name: "width") ?? 0))
    }

    // TODO: writeToParcel
}

/// RectF holds four float coordinates for a rectangle.
/// 
/// The rectangle is represented by the coordinates of its 4 edges (left, top, right, bottom).
/// 
/// These fields can be accessed directly.
/// 
/// Use width() and height() to retrieve the rectangle's width and height.
/// 
/// Note: most methods do not check to see that the coordinates are sorted correctly (i.e. left <= right and top <= bottom).
/// 
/// [Learn more](https://developer.android.com/reference/android/graphics/RectF)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class RectF: JObjectable, @unchecked Sendable {
    public static var className: JClassName { "android/graphics/RectF" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    /// Create a new rectangle, initialized with the values in the specified rectangle (which is left unmodified).
    public init! () {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env)
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }

    /// Create a new rectangle with the specified coordinates.
    /// 
    /// Note: no range checking is performed, so the caller must ensure that left <= right and top <= bottom.
    public init! (
        left: Float,
        top: Float,
        right: Float,
        bottom: Float,
        _ unit: DimensionUnit = .dp
    ) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: unit.toPixels(left), unit.toPixels(top), unit.toPixels(right), unit.toPixels(bottom))
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }
}

extension RectF {
    public func bottom(_ unit: DimensionUnit = .dp) -> Float {
        unit.from(object.floatField(name: "bottom") ?? 0)
    }

    public func left(_ unit: DimensionUnit = .dp) -> Float {
        unit.from(object.floatField(name: "left") ?? 0)
    }

    public func right(_ unit: DimensionUnit = .dp) -> Float {
        unit.from(object.floatField(name: "right") ?? 0)
    }

    public func top(_ unit: DimensionUnit = .dp) -> Float {
        unit.from(object.floatField(name: "top") ?? 0)
    }

    /// The horizontal center of the rectangle.
    /// 
    /// If the computed value is fractional, this method returns the largest integer that is less than the computed value.
    public func centerX(_ unit: DimensionUnit = .dp) -> Float {
        unit.from(object.callFloatMethod(name: "centerX") ?? 0)
    }

    /// The vertical center of the rectangle.
    /// 
    /// If the computed value is fractional, this method returns the largest integer that is less than the computed value.
    public func centerY(_ unit: DimensionUnit = .dp) -> Float {
        unit.from(object.callFloatMethod(name: "centerY") ?? 0)
    }

    /// Returns true iff the 4 specified sides of a rectangle are inside or equal to this rectangle.
    /// 
    /// i.e. is this rectangle a superset of the specified rectangle. An empty rectangle never contains another rectangle.
    public func contains(
        left: Float,
        top: Float,
        right: Float,
        bottom: Float,
        _ unit: DimensionUnit = .dp
    ) -> Bool {
        object.callBoolMethod(name: "contains", args: unit.toPixels(left), unit.toPixels(top), unit.toPixels(right), unit.toPixels(bottom)) ?? false
    }

    /// Returns true iff the specified rectangle r is inside or equal to this rectangle.
    /// 
    /// An empty rectangle never contains another rectangle.
    public func contains(_ r: RectF) -> Bool {
        object.callBoolMethod(name: "contains", args: r.signed(as: RectF.className)) ?? false
    }

    /// Returns true if (x,y) is inside the rectangle.
    /// 
    /// The left and top are considered to be inside, while the right and bottom are not.
    /// 
    /// This means that for a x,y to be contained: left <= x < right and top <= y < bottom.
    /// 
    /// An empty rectangle never contains any point.
    public func contains(
        x: Float,
        y: Float,
        _ unit: DimensionUnit = .dp
    ) -> Bool {
        object.callBoolMethod(name: "contains", args: unit.toPixels(x), unit.toPixels(y)) ?? false
    }

    /// Parcelable interface methods
    public func describeContents() -> Int {
        Int(object.callIntMethod(name: "describeContents") ?? 0)
    }

    // TODO: equals?

    /// The exact horizontal center of the rectangle as a float.
    public func exactCenterX(_ unit: DimensionUnit = .dp) -> Float {
        unit.from(object.callFloatMethod(name: "exactCenterX") ?? 0)
    }

    /// Returns a hash code value for the object.
    /// 
    /// This method is supported for the benefit of hash tables such as those provided by HashMap.
    public func hashCode() -> Int {
        Int(object.callIntMethod(name: "hashCode") ?? 0)
    }

    /// The rectangle's height.
    /// 
    /// This does not check for a valid rectangle (i.e. top <= bottom) so the result may be negative.
    public func height(_ unit: DimensionUnit = .dp) -> Float {
        unit.from(object.callFloatMethod(name: "height") ?? 0)
    }

    /// Inset the rectangle by `(dx,dy)`.
    /// 
    /// If dx is positive, then the sides are moved inwards, making the rectangle narrower.
    /// 
    /// If dx is negative, then the sides are moved outwards, making the rectangle wider.
    /// 
    /// The same holds `true` for `dy` and the top and bottom.
    public func inset(
        dx: Float,
        dy: Float,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "inset", args: unit.toPixels(dx), unit.toPixels(dy))
    }

    /// If the rectangle specified by left,top,right,bottom intersects this rectangle,
    /// return true and set this rectangle to that intersection,
    /// otherwise return false and do not change this rectangle. No check is performed to see if either rectangle is empty.
    ///
    /// Note: To just test for intersection, use: `intersects()`
    public func intersect(
        left: Float,
        top: Float,
        right: Float,
        bottom: Float,
        _ unit: DimensionUnit = .dp
    ) -> Bool {
        object.callBoolMethod(name: "intersect", args: unit.toPixels(left), unit.toPixels(top), unit.toPixels(right), unit.toPixels(bottom)) ?? false
    }

    /// If the specified rectangle intersects this rectangle,
    /// return true and set this rectangle to that intersection,
    /// otherwise return false and do not change this rectangle.
    /// 
    /// No check is performed to see if either rectangle is empty.
    /// 
    /// To just test for intersection, use `intersects()`
    public func intersect(_ r: RectF) -> Bool {
        object.callBoolMethod(name: "intersect", args: r.signed(as: RectF.className)) ?? false
    }

    /// Returns true if this rectangle intersects the specified rectangle.
    /// 
    /// In no event is this rectangle modified.
    /// 
    /// No check is performed to see if either rectangle is empty.
    /// 
    /// To record the intersection, use `intersect()` or `setIntersect()`.
    public func intersects(
        left: Float,
        top: Float,
        right: Float,
        bottom: Float,
        _ unit: DimensionUnit = .dp
    ) -> Bool {
        object.callBoolMethod(name: "intersects", args: unit.toPixels(left), unit.toPixels(top), unit.toPixels(right), unit.toPixels(bottom)) ?? false
    }

    /// Returns true iff the two specified rectangles intersect.
    /// 
    /// In no event is this rectangle modified.
    /// 
    /// No check is performed to see if either rectangle is empty.
    /// 
    /// To record the intersection, use `intersect()` or `setIntersect()`.
    // public static func intersect(_ a: Rect, _ b: Rect) -> Bool { // TODO: make static
    //     object.callBoolMethod(name: "intersect", args: a.signed(as: Rect.className), b.signed(as: Rect.className)) ?? false
    // }

    /// Returns true if the rectangle is empty (left >= right or top >= bottom)
    public func isEmpty() -> Bool {
        object.callBoolMethod(name: "isEmpty") ?? false
    }

    /// Offset the rectangle by adding dx to its left and right coordinates,
    /// and adding dy to its top and bottom coordinates.
    public func offset(
        dx: Float,
        dy: Float,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "offset", args: unit.toPixels(dx), unit.toPixels(dy))
    }

    /// Offset the rectangle to a specific (left, top) position,
    /// keeping its width and height the same.
    public func offsetTo(
        newLeft: Float,
        newTop: Float,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "offsetTo", args: unit.toPixels(newLeft), unit.toPixels(newTop))
    }

    // TODO: readFromParcel

    /// Set the dst integer Rect by rounding "out" this rectangle,
    /// choosing the floor of top and left, and the ceiling of right and bottom.
    public func round(_ dst: Rect) {
        object.callVoidMethod(name: "round", args: dst.signed(as: Rect.className))
    }

    /// Set the rectangle's coordinates to the specified values.
    /// 
    // Note: no range checking is performed, so it is up to the caller to ensure that left <= right and top <= bottom.
    public func set(
        left: Float,
        top: Float,
        right: Float,
        bottom: Float,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "set", args: unit.toPixels(left), unit.toPixels(top), unit.toPixels(right), unit.toPixels(bottom))
    }

    /// Copy the coordinates from src into this rectangle.
    public func set(_ src: Rect) {
        object.callVoidMethod(name: "set", args: src.signed(as: Rect.className))
    }

    /// Copy the coordinates from src into this rectangle.
    public func set(_ src: RectF) {
        object.callVoidMethod(name: "set", args: src.signed(as: RectF.className))
    }

    /// Set the rectangle to (0,0,0,0)
    public func setEmpty() {
        object.callVoidMethod(name: "setEmpty")
    }

    /// If rectangles a and b intersect, return true and set this rectangle to that intersection,
    /// otherwise return false and do not change this rectangle.
    /// 
    /// No check is performed to see if either rectangle is empty.
    /// 
    /// To just test for intersection, use `intersects()`
    public func setIntersect(_ a: RectF, _ b: RectF) -> Bool {
        object.callBoolMethod(name: "setIntersect", args: a.signed(as: RectF.className), b.signed(as: RectF.className)) ?? false
    }

    /// Swap top/bottom or left/right if there are flipped (i.e. left > right and/or top > bottom).
    /// 
    /// This can be called if the edges are computed separately, and may have crossed over each other.
    /// 
    /// If the edges are already correct (i.e. left <= right and top <= bottom) then nothing is done.
    public func sort() {
        object.callVoidMethod(name: "sort")
    }

    // TODO: toShortString
    // TODO: unflattenFromString

    /// Update this Rect to enclose itself and the specified rectangle.
    /// 
    /// If the specified rectangle is empty, nothing is done.
    /// 
    /// If this rectangle is empty it is set to the specified rectangle.
    public func union(
        left: Float,
        top: Float,
        right: Float,
        bottom: Float,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "union", args: unit.toPixels(left), unit.toPixels(top), unit.toPixels(right), unit.toPixels(bottom))
    }

    /// Update this Rect to enclose itself and the specified rectangle.
    /// 
    /// If the specified rectangle is empty, nothing is done.
    /// 
    /// If this rectangle is empty it is set to the specified rectangle.
    public func union(_ r: RectF) {
        object.callVoidMethod(name: "union", args: r.signed(as: RectF.className))
    }

    /// Update this Rect to enclose itself and the [x,y] coordinate.
    /// 
    /// There is no check to see that this rectangle is non-empty.
    public func union(
        x: Float,
        y: Float,
        _ unit: DimensionUnit = .dp
    ) {
        object.callVoidMethod(name: "union", args: unit.toPixels(x), unit.toPixels(y))
    }

    /// The rectangle's width.
    /// 
    /// This does not check for a valid rectangle (i.e. left <= right) so the result may be negative.
    public func width(_ unit: DimensionUnit = .dp) -> Float {
        unit.from(object.callFloatMethod(name: "width") ?? 0)
    }

    // TODO: writeToParcel
}

/// The Path class encapsulates compound (multiple contour) geometric paths consisting of straight line segments,
/// quadratic curves, and cubic curves. It can be drawn with `canvas.drawPath(path, paint)`,
/// either filled or stroked (based on the paint's Style), or it can be used for clipping or to draw text on a path.
///
/// [Learn more](https://developer.android.com/reference/android/graphics/Path)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class Path: JObjectable, @unchecked Sendable {
    public static var className: JClassName { "android/graphics/Path" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    public init! () {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env)
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }

    public init! (_ src: Path) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let global = clazz.newObject(env, args: src.object.signed(as: Path.className))
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }
}

extension Path {
    /// Add the specified arc to the path as a new contour.
    public func addArc(oval: RectF, startAngle: Float, sweepAngle: Float) {
        object.callVoidMethod(name: "addArc", args: oval.signed(as: RectF.className), startAngle, sweepAngle)
    }

    /// Add the specified arc to the path as a new contour.
    public func addArc(
        left: Float,
        top: Float,
        right: Float,
        bottom: Float,
        startAngle: Float,
        sweepAngle: Float
    ) {
        object.callVoidMethod(name: "addArc", args: left, top, right, bottom, startAngle, sweepAngle)
    }

    /// Add a closed circle contour to the path
    public func addCircle(x: Float, y: Float, radius: Float, direction: Direction) {
        object.callVoidMethod(name: "addCircle", args: x, y, radius, direction.signed(as: Direction.className))
    }

    /// Add a closed oval contour to the path
    public func addOval(oval: RectF, direction: Direction) {
        object.callVoidMethod(name: "addOval", args: oval.signed(as: RectF.className), direction.signed(as: Direction.className))
    }

    /// Add a closed oval contour to the path
    public func addOval(
        left: Float,
        top: Float,
        right: Float,
        bottom: Float,
        direction: Direction
    ) {
        object.callVoidMethod(name: "addOval", args: left, top, right, bottom, direction.signed(as: Direction.className))
    }

    // TODO: addPath with Matrix

    /// Add a copy of src to the path
    public func addPath(_ src: Path) {
        object.callVoidMethod(name: "addPath", args: src.signed(as: Path.className))
    }

    /// Add a copy of src to the path, offset by (dx,dy)
    public func addPath(_ src: Path, dx: Float, dy: Float) {
        object.callVoidMethod(name: "addPath", args: src.signed(as: Path.className), dx, dy)
    }

    /// Add a closed rectangle contour to the path
    public func addRect(_ rect: RectF, direction: Direction) {
        object.callVoidMethod(name: "addRect", args: rect.signed(as: RectF.className), direction.signed(as: Direction.className))
    }

    /// Add a closed rectangle contour to the path
    public func addRect(
        left: Float,
        top: Float,
        right: Float,
        bottom: Float,
        direction: Direction
    ) {
        object.callVoidMethod(name: "addRect", args: left, top, right, bottom, direction.signed(as: Direction.className))
    }

    /// Add a closed round-rectangle contour to the path
    public func addaddRoundRectRect(
        left: Float,
        top: Float,
        right: Float,
        bottom: Float,
        rx: Float,
        ry: Float,
        direction: Direction
    ) {
        object.callVoidMethod(name: "addRoundRect", args: left, top, right, bottom, rx, ry, direction.signed(as: Direction.className))
    }

    // TODO: addRoundRect with float[] radii

    /// Add a closed round-rectangle contour to the path
    public func addRoundRect(_ rect: RectF, rx: Float, ry: Float, direction: Direction) {
        object.callVoidMethod(name: "addRoundRect", args: rect.signed(as: RectF.className), rx, ry, direction.signed(as: Direction.className))
    }

    // TODO: addRoundRect with float[] radii
    // TODO: approximate

    /// Append the specified arc to the path as a new contour.
    /// 
    /// If the start of the path is different from the path's current last point,
    /// then an automatic `lineTo()` is added to connect the current contour to the start of the arc.
    /// 
    /// However, if the path is empty, then we call `moveTo()` with the first point of the arc.
    public func arcTo(
        oval: RectF,
        startAngle: Float,
        sweepAngle: Float,
        forceMoveTo: Bool
    ) {
        object.callVoidMethod(name: "arcTo", args: oval.signed(as: RectF.className), startAngle, sweepAngle, forceMoveTo)
    }

    /// Append the specified arc to the path as a new contour.
    /// 
    /// If the start of the path is different from the path's current last point,
    /// then an automatic `lineTo()` is added to connect the current contour to the start of the arc.
    /// 
    /// However, if the path is empty, then we call `moveTo()` with the first point of the arc.
    public func arcTo(
        left: Float,
        top: Float,
        right: Float,
        bottom: Float,
        startAngle: Float,
        sweepAngle: Float,
        forceMoveTo: Bool
    ) {
        object.callVoidMethod(name: "arcTo", args: left, top, right, bottom, startAngle, sweepAngle, forceMoveTo)
    }

    /// Append the specified arc to the path as a new contour.
    /// 
    /// If the start of the path is different from the path's current last point,
    /// then an automatic `lineTo()` is added to connect the current contour to the start of the arc.
    /// 
    /// However, if the path is empty, then we call `moveTo()` with the first point of the arc.
    public func arcTo(
        oval: RectF,
        startAngle: Float,
        sweepAngle: Float
    ) {
        object.callVoidMethod(name: "arcTo", args: oval.signed(as: RectF.className), startAngle, sweepAngle)
    }

    /// Close the current contour.
    /// 
    /// If the current point is not equal to the first point of the contour, a line segment is automatically added.
    public func close() {
        object.callVoidMethod(name: "close")
    }

    /// Compute the bounds of the control points of the path, and write the answer into bounds.
    /// 
    /// If the path contains 0 or 1 points, the bounds is set to `(0,0,0,0)`
    public func computeBounds(bounds: RectF) {
        object.callVoidMethod(name: "computeBounds", args: bounds.signed(as: RectF.className))
    }

    /// Compute the bounds of the control points of the path, and write the answer into bounds.
    /// 
    /// If the path contains 0 or 1 points, the bounds is set to `(0,0,0,0)`
    public func computeBounds(bounds: RectF, exact: Bool) {
        object.callVoidMethod(name: "computeBounds", args: bounds.signed(as: RectF.className), exact)
    }

    /// Add a quadratic bezier from the last point, approaching control point (x1,y1),
    /// and ending at (x2,y2), weighted by weight. If no moveTo() call has been made for this contour,
    /// the first point is automatically set to (0,0).
    ///
    /// A weight of 1 is equivalent to calling quadTo(float, float, float, float)
    /// 
    /// A weight of 0 is equivalent to calling lineTo(float, float) to (x1, y1) followed by lineTo(float, float) to (x2, y2).
    public func conicTo(x1: Float, y1: Float, x2: Float, y2: Float, weight: Float) {
        object.callVoidMethod(name: "conicTo", args: x1, y1, x2, y2, weight)
    }

    /// Add a cubic bezier from the last point, approaching control points (x1,y1) and (x2,y2),
    /// and ending at (x3,y3). If no moveTo() call has been madefor this contour,
    /// the first point is automatically set to (0,0).
    public func cubicTo(x1: Float, y1: Float, x2: Float, y2: Float, x3: Float, y3: Float) {
        object.callVoidMethod(name: "conicTo", args: x1, y1, x2, y2, x3, y3)
    }

    // TODO: getFillType

    /// Returns the generation ID of this path.
    /// 
    /// The generation ID changes whenever the path is modified.
    /// 
    /// This can be used as an efficient way to check if a path has changed.
    public func generationId() -> Int {
        Int(object.callIntMethod(name: "getGenerationId") ?? 0)
    }

    // TODO: getPathIterator

    /// Hint to the path to prepare for adding more points.
    /// 
    /// This can allow the path to more efficiently allocate its storage.
    public func incReserve(extraPtCount: Int) {
        object.callVoidMethod(name: "incReserve", args: Int32(extraPtCount))
    }

    /// This method will linearly interpolate from this path to `otherPath`
    /// given the interpolation parameter `t`, returning the result in `interpolatedPath`.
    /// 
    /// Interpolation will only succeed if the structures of the two paths match exactly,
    /// as discussed in `isInterpolatable()`.
    public func interpolate(
        otherPath: Path,
        t: Float,
        interpolatedPath: Path
    ) -> Bool {
        object.callBoolMethod(name: "interpolate", args: otherPath.signed(as: Path.className), t, interpolatedPath.signed(as: Path.className)) ?? false
    }

    /// Returns true if the path is empty (contains no lines or curves)
    public func isEmpty() -> Bool {
        object.callBoolMethod(name: "isEmpty") ?? false
    }

    /// Two paths can be interpolated, by calling `interpolate(Path, Float, Path)`,
    /// if they have exactly the same structure.
    /// 
    /// That is, both paths must have the same operations, in the same order.
    /// 
    /// If any of the operations are of type `PathIterator.VERB_CONIC`, then the weights of those conics must also match.
    public func isInterpolatable(otherPath: Path) -> Bool {
        object.callBoolMethod(name: "isInterpolatable", args: otherPath.signed(as: Path.className)) ?? false
    }

    /// Returns true if the filltype is one of the `INVERSE` variants
    public func isInverseFillType() -> Bool {
        object.callBoolMethod(name: "isInverseFillType") ?? false
    }

    /// Returns true if the path specifies a rectangle.
    /// 
    /// If so, and if rect is not null, set rect to the bounds of the path.
    /// 
    /// If the path does not specify a rectangle, return false and ignore rect.
    public func isRect(rect: RectF) -> Bool {
        object.callBoolMethod(name: "isRect", args: rect.signed(as: RectF.className)) ?? false
    }

    /// Add a line from the last point to the specified point (x,y).
    /// 
    /// If no moveTo() call has been made for this contour, the first point is automatically set to (0,0).
    public func lineTo(x: Float, y: Float) {
        object.callVoidMethod(name: "lineTo", args: x, y)
    }

    /// Set the beginning of the next contour to the point (x,y).
    public func moveTo(x: Float, y: Float) {
        object.callVoidMethod(name: "moveTo", args: x, y)
    }

    /// Offset the path by (dx,dy)
    public func offset(dx: Float, dy: Float, dst: Path) {
        object.callVoidMethod(name: "offset", args: dx, dy, dst.signed(as: Path.className))
    }

    /// Offset the path by (dx,dy)
    public func offset(dx: Float, dy: Float) {
        object.callVoidMethod(name: "offset", args: dx, dy)
    }

    /// Set this path to the result of applying the Op to the two specified paths.
    /// 
    /// The resulting path will be constructed from non-overlapping contours.
    /// 
    /// The curve order is reduced where possible so that cubics may be turned into quadratics, and quadratics maybe turned into lines.
    public func op(path1: Path, path2: Path, op: Op) {
        object.callVoidMethod(name: "op", args: path1.signed(as: Path.className), path2.signed(as: Path.className), op.signed(as: Op.className))
    }

    /// Set this path to the result of applying the Op to the two specified paths.
    /// 
    /// The resulting path will be constructed from non-overlapping contours.
    /// 
    /// The curve order is reduced where possible so that cubics may be turned into quadratics, and quadratics maybe turned into lines.
    public func op(path: Path, op: Op) {
        object.callVoidMethod(name: "op", args: path.signed(as: Path.className), op.signed(as: Op.className))
    }

    /// Add a quadratic bezier from the last point, approaching control point (x1,y1),
    /// and ending at (x2,y2). If no moveTo() call has been made for this contour,
    /// the first point is automatically set to (0,0).
    public func quadTo(x1: Float, y1: Float, x2: Float, y2: Float) {
        object.callVoidMethod(name: "quadTo", args: x1, y1, x2, y2)
    }

    /// Same as conicTo, but the coordinates are considered relative to the last point on this contour.
    /// 
    /// If there is no previous point, then a moveTo(0,0) is inserted automatically.
    public func rConicTo(
        dx1: Float,
        dy1: Float,
        dx2: Float,
        dy2: Float,
        weight: Float
    ) {
        object.callVoidMethod(name: "quadTo", args: dx1, dy1, dx2, dy2, weight)
    }

    /// Same as cubicTo, but the coordinates are considered relative to the current point on this contour.
    /// 
    /// If there is no previous point, then a moveTo(0,0) is inserted automatically.
    public func rCubicTo(x1: Float, y1: Float, x2: Float, y2: Float, x3: Float, y3: Float) {
        object.callVoidMethod(name: "rCubicTo", args: x1, y1, x2, y2, x3, y3)
    }

    /// Same as lineTo, but the coordinates are considered relative to the last point on this contour.
    /// 
    /// If there is no previous point, then a moveTo(0,0) is inserted automatically.
    public func rLineTo(dx: Float, dy: Float) {
        object.callVoidMethod(name: "rLineTo", args: dx, dy)
    }

    /// Set the beginning of the next contour relative to the last point on the previous contour.
    /// 
    /// If there is no previous contour, this is treated the same as moveTo().
    public func rMoveTo(dx: Float, dy: Float) {
        object.callVoidMethod(name: "rMoveTo", args: dx, dy)
    }

    /// Same as quadTo, but the coordinates are considered relative to the last point on this contour.
    /// 
    /// If there is no previous point, then a moveTo(0,0) is inserted automatically.
    public func rQuadTo(
        dx1: Float,
        dy1: Float,
        dx2: Float,
        dy2: Float
    ) {
        object.callVoidMethod(name: "rQuadTo", args: dx1, dy1, dx2, dy2)
    }

    /// Clear any lines and curves from the path, making it empty.
    /// 
    /// This does NOT change the fill-type setting.
    public func reset() {
        object.callVoidMethod(name: "reset")
    }

    /// Rewinds the path: clears any lines and curves from the path but keeps the internal data structure for faster reuse.
    public func rewind() {
        object.callVoidMethod(name: "rewind")
    }

    /// Replace the contents of this with the contents of src.
    public func set(_ src: Path) {
        object.callVoidMethod(name: "set", args: src.signed(as: Path.className))
    }

    /// Set the path's fill type.
    /// 
    /// This defines how "inside" is computed.
    public func fillType(_ ft: FillType) {
        object.callVoidMethod(name: "setFillType", args: ft.signed(as: FillType.className))
    }

    /// Sets the last point of the path.
    public func lastPoint(dx: Float, dy: Float) {
        object.callVoidMethod(name: "setLastPoint", args: dx, dy)
    }

    /// Toggles the `INVERSE` state of the filltype
    public func toggleInverseFillType() {
        object.callVoidMethod(name: "toggleInverseFillType")
    }

    // TODO: transform with Matrix
}

extension Path {
    /// Specifies how closed shapes (e.g. rects, ovals) are oriented when they are added to a path.
    /// 
    /// [Learn more](https://developer.android.com/reference/android/graphics/Path.Direction)
    #if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    public final class Direction: JObjectable, Sendable {
        public static var className: JClassName { "android/graphics/Path$Direction" }

        public let object: JObject

        public init (_ object: JObject) {
            self.object = object
        }

        private static func byOrdinal(_ index: Int) -> JObject! {
            #if os(Android)
            guard
                let env = JEnv.current(),
                let clazz = JClass.load(Direction.className),
                let methodId = env.getStaticMethodId(clazz: clazz, name: "values", sig: .returning(.object(array: true, Direction.className))),
                let returningClazz = JClass.load(Direction.className.asArray()),
                let valuesArray = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, returningClass: returningClazz),
                let element = env.getObjectArrayElement(JObjectArray(valuesArray, length: 2), index: Int32(index))
            else { return nil }
            return element
            #else
            return nil
            #endif
        }

        public static func clockwise() -> Direction! {
            Direction(byOrdinal(0))
        }

        public static func counterClockwise() -> Direction! {
            Direction(byOrdinal(1))
        }

        // TODO: implement some kind of cache for these enum values
    }

    /// The logical operations that can be performed when combining two paths.
    /// 
    /// [Learn more](https://developer.android.com/reference/android/graphics/Path.Op)
    #if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    public final class Op: JObjectable, @unchecked Sendable {
        public static var className: JClassName { "android/graphics/Path$Op" }

        public let object: JObject

        public init (_ object: JObject) {
            self.object = object
        }

        private static func byOrdinal(_ index: Int) -> JObject! {
            #if os(Android)
            guard
                let env = JEnv.current(),
                let clazz = JClass.load(Op.className),
                let methodId = env.getStaticMethodId(clazz: clazz, name: "values", sig: .returning(.object(array: true, Op.className))),
                let returningClazz = JClass.load(Op.className.asArray()),
                let valuesArray = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, returningClass: returningClazz),
                let element = env.getObjectArrayElement(JObjectArray(valuesArray, length: 2), index: Int32(index))
            else { return nil }
            return element
            #else
            return nil
            #endif
        }

        /// Subtract the second path from the first path
        public static func difference() -> Op! {
            Op(byOrdinal(0))
        }

        /// Intersection of the two paths
        public static func intersect() -> Op! {
            Op(byOrdinal(1))
        }

        /// Union of the two paths
        public static func union() -> Op! {
            Op(byOrdinal(2))
        }

        /// Exclusive OR of the two paths
        public static func xor() -> Op! {
            Op(byOrdinal(3))
        }

        /// Subtract the first path from the second path
        public static func reverseDifference() -> Op! {
            Op(byOrdinal(4))
        }

        // TODO: implement some kind of cache for these enum values
    }

    /// Enum for the ways a path may be filled.
    /// 
    /// [Learn more](https://developer.android.com/reference/android/graphics/Path.FillType)
    #if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    public final class FillType: JObjectable, @unchecked Sendable {
        public static var className: JClassName { "android/graphics/Path$FillType" }

        public let object: JObject

        public init (_ object: JObject) {
            self.object = object
        }

        private static func byOrdinal(_ index: Int) -> JObject! {
            #if os(Android)
            guard
                let env = JEnv.current(),
                let clazz = JClass.load(FillType.className),
                let methodId = env.getStaticMethodId(clazz: clazz, name: "values", sig: .returning(.object(array: true, FillType.className))),
                let returningClazz = JClass.load(FillType.className.asArray()),
                let valuesArray = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, returningClass: returningClazz),
                let element = env.getObjectArrayElement(JObjectArray(valuesArray, length: 2), index: Int32(index))
            else { return nil }
            return element
            #else
            return nil
            #endif
        }

        /// Non-zero winding rule (default)
        public static func winding() -> Op! {
            Op(byOrdinal(0))
        }

        /// Even-odd winding rule
        public static func evenOdd() -> Op! {
            Op(byOrdinal(1))
        }

        /// Inverse non-zero winding rule
        public static func inverseWinding() -> Op! {
            Op(byOrdinal(2))
        }

        /// Inverse even-odd winding rule
        public static func inverseEvenOdd() -> Op! {
            Op(byOrdinal(3))
        }

        // TODO: implement some kind of cache for these enum values
    }
}