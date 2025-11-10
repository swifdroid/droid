//
//  FloatingActionButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.FloatingActionButtonPackage {
    public class FloatingActionButtonClass: JClassName, @unchecked Sendable {}
    
    public var FloatingActionButton: FloatingActionButtonClass { .init(parent: self, name: "FloatingActionButton") }
}

/// Floating action buttons are used for a special type of promoted action.
/// They are distinguished by a circled icon floating above the UI and have special motion behaviors related to morphing,
/// launching, and the transferring anchor point.
///
/// Floating action buttons come in two sizes: the default and the mini.
/// The size can be controlled with the fabSize attribute.
/// 
/// As this class descends from `ImageView`, you can control the icon
/// which is displayed via `setImageDrawable(Drawable)`.
/// 
/// The background color of this view defaults to the your theme's `colorSecondary`.
/// If you wish to change this at runtime then you can do so via `setBackgroundTintList(ColorStateList)`.
/// 
/// For more information, see the [component developer guidance](https://github.com/material-components/material-components-android/blob/master/docs/components/FloatingActionButton.md) and [design guidelines](https://material.io/components/floating-action-button/overview).
#if os(Android)
@MainActor
#endif
open class FloatingActionButton: ImageButton, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.material.floatingactionbutton.FloatingActionButton }
    open override class var gradleDependencies: [AppGradleDependency] { [.material] }

    var textState: State<String>?

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}

extension FloatingActionButton {
    public enum Size: Int32 {
        /// Size which will change based on the window size.
        ///
        /// For small sized windows (largest screen dimension < 470dp) this will select a mini sized button (`.mini`),
        /// and for larger sized windows it will select a normal sized button (`.normal`).
        case auto = -1
        /// The normal sized button, 56dp. Will always be larger than `.mini`.
        case normal = 0
        /// The mini sized button, 40dp. Will always be smaller than `.normal`.
        case mini = 1
    }
}

// MARK: OnHideAnimationListener
// addOnHideAnimationListener

// MARK: OnShowAnimationListener
// addOnShowAnimationListener

// MARK: TransformationCallback
// addTransformationCallback

// MARK: ClearCustomSize

struct ClearCustomSizeProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "clearCustomSize"
    let value: Void = ()
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue)
    }
}
extension FloatingActionButton {
    /// Clears the custom size.
    /// 
    /// If called, custom sizing will not be used and the size will be calculated based on the value set using `setSize(int)` or the fabSize attribute.
    @discardableResult
    public func clearCustomSize() -> Self {
        ClearCustomSizeProperty().applyOrAppend(nil, self)
    }
}

// MARK: - Getters
// TODO: getters

// MARK: - Setters

extension FloatingActionButton {
    /// Hides the button.
    /// 
    /// This method will animate the button hide if the view has already been laid out.
    public func hide() {
        instance?.callVoidMethod(name: "hide")
    }

    // TODO: hide with callback
}

extension FloatingActionButton {
    /// 
    public func internalSetVisibility(_ visibility: ViewVisibility, fromUser: Bool) {
        instance?.callVoidMethod(name: "internalSetVisibility", args: visibility.rawValue, fromUser)
    }
}

extension FloatingActionButton {
    /// Returns whether this widget is expanded.
    public func isExpanded() -> Bool {
        instance?.callBoolMethod(name: "isExpanded") ?? false
    }
}

extension FloatingActionButton {
    public func isOrWillBeHidden() -> Bool {
        instance?.callBoolMethod(name: "isOrWillBeHidden") ?? false
    }
}

extension FloatingActionButton {
    public func isOrWillBeShown() -> Bool {
        instance?.callBoolMethod(name: "isOrWillBeShown") ?? false
    }
}

extension FloatingActionButton {
    public func jumpDrawablesToCurrentState() {
        instance?.callVoidMethod(name: "jumpDrawablesToCurrentState")
    }
}

extension FloatingActionButton {
    public func onTouchEvent(_ event: MotionEvent) -> Bool {
        instance?.callBoolMethod(name: "onTouchEvent", args: event.signed(as: MotionEvent.className)) ?? false
    }
}

extension FloatingActionButton {
    // TODO: removeOnHideAnimationListener
}

extension FloatingActionButton {
    // TODO: removeOnShowAnimationListener
}

extension FloatingActionButton {
    // TODO: removeTransformationCallback
}

// MARK: - Setters

// MARK: CompatElevation

struct CompatElevationProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCompatElevation"
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Updates the backward compatible elevation.
    @discardableResult
    public func compatElevation(_ elevation: Float) -> Self {
        CompatElevationProperty(value: elevation).applyOrAppend(nil, self)
    }
}

// MARK: CompatElevationResource

struct CompatElevationResourceProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCompatElevationResource"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Updates the backward compatible elevation.
    @discardableResult
    public func compatElevationResource(_ resourceId: Int32) -> Self {
        CompatElevationResourceProperty(value: resourceId).applyOrAppend(nil, self)
    }
}

// MARK: CompatHoveredFocusedTranslationZ

struct CompatHoveredFocusedTranslationZProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCompatHoveredFocusedTranslationZ"
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Updates the backward compatible hovered/focused translationZ.
    @discardableResult
    public func compatHoveredFocusedTranslationZ(_ translationZ: Float) -> Self {
        CompatHoveredFocusedTranslationZProperty(value: translationZ).applyOrAppend(nil, self)
    }
}

// MARK: CompatHoveredFocusedTranslationZResource

struct CompatHoveredFocusedTranslationZResourceProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCompatHoveredFocusedTranslationZResource"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Updates the backward compatible hovered/focused translationZ.
    @discardableResult
    public func compatHoveredFocusedTranslationZResource(_ resourceId: Int32) -> Self {
        CompatHoveredFocusedTranslationZResourceProperty(value: resourceId).applyOrAppend(nil, self)
    }
}

// MARK: CompatPressedTranslationZ

struct CompatPressedTranslationZProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCompatPressedTranslationZ"
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Updates the backward compatible pressed translationZ.
    @discardableResult
    public func compatPressedTranslationZ(_ translationZ: Float) -> Self {
        CompatPressedTranslationZProperty(value: translationZ).applyOrAppend(nil, self)
    }
}

// MARK: CompatPressedTranslationZResource

struct CompatPressedTranslationZResourceProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCompatPressedTranslationZResource"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Updates the backward compatible pressed translationZ.
    @discardableResult
    public func compatPressedTranslationZResource(_ resourceId: Int32) -> Self {
        CompatPressedTranslationZResourceProperty(value: resourceId).applyOrAppend(nil, self)
    }
}

// MARK: CustomSize

struct CustomSizeProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCustomSize"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension FloatingActionButton {
    /// Sets the size of the button to be a custom value in pixels.
    @discardableResult
    public func customSize(_ size: Int, _ unit: DimensionUnit = .dp) -> Self {
        CustomSizeProperty(value: (size, unit)).applyOrAppend(nil, self)
    }
}

// MARK: EnsureMinTouchTargetSize

struct EnsureMinTouchTargetSizeProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setEnsureMinTouchTargetSize"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Sets whether this FloatingActionButton should expand its bounds (if needed) to meet the minimum touch target size.
    @discardableResult
    public func ensureMinTouchTargetSize(_ value: Bool = true) -> Self {
        EnsureMinTouchTargetSizeProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Expanded

struct ExpandedProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setExpanded"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Sets the expanded state on this widget.
    @discardableResult
    public func expanded(_ value: Bool = true) -> Self {
        ExpandedProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ExpandedComponentIdHint

struct ExpandedComponentIdHintProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setExpandedComponentIdHint"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Sets the expanded component id hint, which may be used by a Behavior to determine whether it should handle this widget's state change.
    @discardableResult
    public func expandedComponentIdHint(_ value: Int32) -> Self {
        ExpandedComponentIdHintProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Gravity

struct GravityViewLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = "gravity"
    let value: Gravity
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(nil, name: key.rawValue, arg: Int32(value.rawValue))
    }
}
extension FloatingActionButton {
    @discardableResult
    public func gravity(_ value: Gravity) -> Self {
        GravityViewLayoutParam(value: value).applyOrAppend(self)
    }
}

// MARK: HideMotionSpec
// TODO: implement setHideMotionSpec

// MARK: HideMotionSpecResource

struct HideMotionSpecResourceProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setHideMotionSpecResource"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Updates the motion spec for the hide animation.
    @discardableResult
    public func hideMotionSpecResource(_ resourceId: Int32) -> Self {
        HideMotionSpecResourceProperty(value: resourceId).applyOrAppend(nil, self)
    }
}

// MARK: ImageDrawable

struct ImageDrawableProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setImageDrawable"
    let value: Drawable
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: Drawable.className))
    }
}
extension FloatingActionButton {
    @discardableResult
    public func imageDrawable(_ value: Drawable) -> Self {
        ImageDrawableProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ImageResource

struct ImageResourceProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setImageResource"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    @discardableResult
    public func imageResource(_ value: Int32) -> Self {
        ImageResourceProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: MaxImageSize

struct MaxImageSizeProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setMaxImageSize"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension FloatingActionButton {
    /// Sets the max image size for this button.
    @discardableResult
    public func maxImageSize(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        MaxImageSizeProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: RippleColor

struct RippleColorProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setRippleColor"
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension FloatingActionButton {
    /// Sets the ripple color for this button.
    /// 
    /// When running on devices with KitKat or below, we draw this color as a filled circle rather than a ripple.
    @discardableResult
    public func rippleColor(_ value: GraphicsColor) -> Self {
        RippleColorProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ShapeAppearanceModel

struct ShapeAppearanceModelProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setShapeAppearanceModel"
    let value: ShapeAppearanceModel
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: ShapeAppearanceModel.className))
    }
}
extension FloatingActionButton {
    /// Sets the `ShapeAppearanceModel` for this button.
    @discardableResult
    public func shapeAppearanceModel(_ value: ShapeAppearanceModel) -> Self {
        ShapeAppearanceModelProperty(value: value).applyOrAppend(nil, self)
    }
}

// TODO: setShowMotionSpec

// MARK: ShowMotionSpecResource

struct ShowMotionSpecResourceProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setShowMotionSpecResource"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Updates the motion spec for the show animation.
    @discardableResult
    public func showMotionSpecResource(_ resourceId: Int32) -> Self {
        ShowMotionSpecResourceProperty(value: resourceId).applyOrAppend(nil, self)
    }
}

// MARK: Size

struct SizeProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setSize"
    let value: FloatingActionButton.Size
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension FloatingActionButton {
    /// Sets the size of the button.
    /// 
    /// The options relate to the options available on the material design specification.
    @discardableResult
    public func size(_ resourceId: FloatingActionButton.Size) -> Self {
        SizeProperty(value: resourceId).applyOrAppend(nil, self)
    }
}

// TODO: setSupportBackgroundTintList
// TODO: setSupportBackgroundTintMode
// TODO: setSupportImageTintList
// TODO: setSupportImageTintMode

// MARK: UseCompatPadding

struct UseCompatPaddingProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setUseCompatPadding"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension FloatingActionButton {
    /// Set whether FloatingActionButton should add inner padding
    /// on platforms Lollipop and after, to ensure consistent dimensions on all platforms.
    @discardableResult
    public func useCompatPadding(_ value: Bool = true) -> Self {
        UseCompatPaddingProperty(value: value).applyOrAppend(nil, self)
    }
}

extension FloatingActionButton {
    /// Returns whether this fab will expand its bounds (if needed) to meet the minimum touch target size.
    public func shouldEnsureMinTouchTargetSize() -> Bool {
        instance?.callBoolMethod(name: "shouldEnsureMinTouchTargetSize") ?? false
    }
}

extension FloatingActionButton {
    /// Shows the button.
    /// 
    /// This method will animate the button show if the view has already been laid out.
    public func show() {
        instance?.callVoidMethod(name: "show")
    }

    // TODO: implement show with callback
}