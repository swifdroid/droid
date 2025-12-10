//
//  BadgeDrawable.swift
//  Droid
//
//  Created by Mihael Isaev on 8.12.2025.
//

#if os(Android)
import Android
#endif

extension ComGoogleAndroidPackage.MaterialPackage.BadgePackage {
    public class BadgeDrawableClass: JClassName, @unchecked Sendable {}
    
    public var BadgeDrawable: BadgeDrawableClass { .init(parent: self, name: "BadgeDrawable") }
}

/// `BadgeDrawable` contains all the layout and draw logic for a badge.
///
/// You can use `BadgeDrawable` to display dynamic information
/// such as a number of pending requests in a `BottomNavigationView`.
/// 
/// To create an instance of `BadgeDrawable`, use `create` or `createFromResource`.
/// 
/// [Learn more](https://developer.android.com/reference/com/google/android/material/badge/BadgeDrawable)
@MainActor
open class BadgeDrawable: Drawable, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.material.badge.BadgeDrawable }
}

// MARK: ClearNumber

extension BadgeDrawable {
    /// Clears the number displayed in the badge.
    public func clearNumber() {
        callVoidMethod(name: "clearNumber")
    }
}

// MARK: ClearText

extension BadgeDrawable {
    /// Clears the text displayed in the badge.
    public func clearText() {
        callVoidMethod(name: "clearText")
    }
}

// MARK: Create

extension BadgeDrawable {
    /// Creates an instance of BadgeDrawable with default values.
    public static func create(_ context: ActivityContext) -> BadgeDrawable? {
        guard
            let clazz = JClass.load(BadgeDrawable.className),
            let global = clazz.staticObjectMethod(
                name: "create",
                args: context.signed(as: .android.content.Context),
                returningClass: clazz
            )
        else { return nil }
        return BadgeDrawable(global)
    }
}

// MARK: GetAlpha

extension BadgeDrawable {
    /// Returns the alpha value of the badge.
    public func getAlpha() -> Int {
        Int(callIntMethod(name: "getAlpha") ?? 0)
    }
}

// MARK: GetBackgroundColor

extension BadgeDrawable {
    /// Returns this badge's background color.
    public func backgroundColor() -> GraphicsColor {
        GraphicsColor(integerLiteral: callIntMethod(name: "getBackgroundColor") ?? 0)
    }
}

// MARK: GetBadgeGravity

extension BadgeDrawable {
    /// Returns the gravity of the badge.
    public func badgeGravity() -> Gravity { // TODO: check if it works
        guard let value = callIntMethod(name: "getBadgeGravity") else { return .noGravity }
        return Gravity(rawValue: Int(value))
    }
}

// TODO: getBadgeNumberLocale

// MARK: GetBadgeTextColor

extension BadgeDrawable {
    /// Returns this badge's text color.
    public func badgeTextColor() -> GraphicsColor {
        GraphicsColor(integerLiteral: callIntMethod(name: "getBadgeTextColor") ?? 0)
    }
}

// MARK: GetContentDescription

extension BadgeDrawable {
    /// Returns the content description of the badge.
    public func contentDescription() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let str = object.callObjectMethod(name: "getContentDescription", returningClass: returningClazz)
        else { return nil }
        return JString(str).toString()
    }
}

// MARK: GetCustomBadgeParent

extension BadgeDrawable {
    /// Returns a `FrameLayout` that will set this `BadgeDrawable` as its foreground.
    public func customBadgeParent(_ context: ActivityContext) -> FrameLayout? {
        guard
            let returningClazz = JClass.load(FrameLayout.className),
            let global = object.callObjectMethod(name: "getCustomBadgeParent", returningClass: returningClazz)
        else { return nil }
        return .init(global, { [weak context] in
            InnerLog.t("🟡 BadgeDrawable.customBadgeParent(): getting context (\(context != nil))")
            return context
        })
    }
}

// MARK: GetHorizontalOffset

extension BadgeDrawable {
    /// Returns how much this badge is being horizontally offset towards the center of its anchor.
    ///
    /// This returns the horizontal offset for badges without text.
    /// If offset for badges with text and without text are different
    /// consider using `getHorizontalOffsetWithoutText` or `getHorizontalOffsetWithText`.
    public func horizontalOffset(_ unit: DimensionUnit = .dp) -> Int {
        let value = callIntMethod(name: "getHorizontalOffset") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetHorizontalOffsetWithText

extension BadgeDrawable {
    /// Returns how much this badge is being horizontally offset
    /// towards the center of its anchor when this badge has text.
    public func horizontalOffsetWithText(_ unit: DimensionUnit = .dp) -> Int {
        let value = callIntMethod(name: "getHorizontalOffsetWithText") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetHorizontalOffsetWithoutText

extension BadgeDrawable {
    /// Returns how much this badge is being horizontally offset
    /// towards the center of its anchor when this badge does not have text (is a dot).
    public func horizontalOffsetWithoutText(_ unit: DimensionUnit = .dp) -> Int {
        let value = callIntMethod(name: "getHorizontalOffsetWithoutText") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetHorizontalPadding

extension BadgeDrawable {
    /// Returns the horizontal padding of the badge.
    public func horizontalPadding(_ unit: DimensionUnit = .dp) -> Int {
        let value = callIntMethod(name: "getHorizontalPadding") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetIntrinsicHeight

extension BadgeDrawable {
    /// Returns the height at which the badge would like to be laid out.
    public func getIntrinsicHeight(_ unit: DimensionUnit = .dp) -> Int {
        let value = callIntMethod(name: "getIntrinsicHeight") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetIntrinsicWidth

extension BadgeDrawable {
    /// Returns the width at which the badge would like to be laid out.
    public func getIntrinsicWidth(_ unit: DimensionUnit = .dp) -> Int {
        let value = callIntMethod(name: "getIntrinsicWidth") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetLargeFontVerticalOffsetAdjustment

extension BadgeDrawable {
    /// Returns how much this badge is being vertically moved away the center
    /// of its anchor when the badge has text and the font scale is at max.
    /// 
    /// Note that this is not the total vertical offset.
    public func largeFontVerticalOffsetAdjustment(_ unit: DimensionUnit = .dp) -> Int {
        let value = callIntMethod(name: "getLargeFontVerticalOffsetAdjustment") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetMaxCharacterCount

extension BadgeDrawable {
    /// Returns this badge's max character count.
    public func maxCharacterCount() -> Int {
        Int(callIntMethod(name: "getMaxCharacterCount") ?? 0)
    }
}

// MARK: GetMaxNumber

extension BadgeDrawable {
    /// Returns this badge's max number. If maxCharacterCount is set, it will override this number.
    public func maxNumber() -> Int {
        Int(callIntMethod(name: "getMaxNumber") ?? 0)
    }
}

// MARK: GetNumber

extension BadgeDrawable {
    /// Returns the badge's number. Only non-negative integer numbers
    /// will be returned because the setter clamps negative values to 0.
    ///
    /// **WARNING**: Do not call this method if you are planning to compare to `BADGE_NUMBER_NONE`
    public func number() -> Int {
        Int(callIntMethod(name: "getNumber") ?? 0)
    }
}

// MARK: GetOpacity

extension BadgeDrawable {
    /// Returns the opacity/transparency of this badge.
    public func opacity() -> Int {
        Int(callIntMethod(name: "getOpacity") ?? 0)
    }
}

// TODO: getState

// MARK: GetText

extension BadgeDrawable {
    /// Returns the badge's text.
    public func text() -> String? {
        guard
            let returningClazz = JClass.load(JString.className),
            let str = object.callObjectMethod(name: "getText", returningClass: returningClazz)
        else { return nil }
        return JString(str).string()
    }
}

// MARK: GetVerticalOffset

extension BadgeDrawable {
    /// Returns how much this badge is being vertically offset away from the center of its anchor.
    ///
    /// This returns the vertical offset for badges without text.
    /// If offset for badges with text and without text are different
    /// consider using `getVerticalOffsetWithoutText` or `getVerticalOffsetWithText`.
    public func verticalOffset(_ unit: DimensionUnit = .dp) -> Int {
        let value = callIntMethod(name: "getVerticalOffset") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetVerticalOffsetWithText

extension BadgeDrawable {
    /// Returns how much this badge is being vertically offset
    /// away from the center of its anchor when this badge has text.
    public func verticalOffsetWithText(_ unit: DimensionUnit = .dp) -> Int {
        let value = callIntMethod(name: "getVerticalOffsetWithText") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetVerticalOffsetWithoutText

extension BadgeDrawable {
    /// Returns how much this badge is being vertically offset
    /// away from the center of its anchor when this badge does not have text (is a dot).
    public func verticalOffsetWithoutText(_ unit: DimensionUnit = .dp) -> Int {
        let value = callIntMethod(name: "getVerticalOffsetWithoutText") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetVerticalPadding

extension BadgeDrawable {
    /// Returns the vertical padding of the badge.
    public func verticalPadding(_ unit: DimensionUnit = .dp) -> Int {
        let value = callIntMethod(name: "getVerticalPadding") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: HasNumber

extension BadgeDrawable {
    /// Returns whether this badge will display a number.
    public func hasNumber() -> Bool {
        callBoolMethod(name: "hasNumber") ?? false
    }
}

// MARK: HasText

extension BadgeDrawable {
    /// Returns whether this badge will display text.
    public func hasText() -> Bool {
        callBoolMethod(name: "hasText") ?? false
    }
}

// MARK: IsStateful

extension BadgeDrawable {
    /// Returns whether this badge is stateful.
    public func isStateful() -> Bool {
        callBoolMethod(name: "isStateful") ?? false
    }
}

// MARK: OnStateChange

extension BadgeDrawable {
    /// Called when the state of this badge has changed.
    public func onStateChange(_ state: [Int32]) -> Bool {
        callBoolMethod(name: "onStateChange", args: state) ?? false
    }
}

// MARK: SetBadgeFixedEdge

extension BadgeDrawable {
    public enum BadgeFixedEdge: Int32, Sendable {
        case start = 0
        case end = 1
    }
}
extension BadgeDrawable {
    /// Sets this badge's fixed edge.
    /// The badge does not grow in the direction of the fixed edge.
    @discardableResult
    public func badgeFixedEdge(_ value: BadgeFixedEdge) -> Self {
        callVoidMethod(name: "setBadgeFixedEdge", args: value.rawValue)
        return self
    }
}

// MARK: SetBadgeGravity

extension BadgeDrawable {
    /// Sets this badge's gravity with respect to its anchor view.
    @discardableResult
    public func badgeGravity(_ gravity: Gravity) -> Self {
        callVoidMethod(name: "setBadgeGravity", args: Int32(gravity.rawValue))
        return self
    }
}

// TODO: setBadgeNumberLocale

// MARK: SetBadgeTextColor

extension BadgeDrawable {
    /// Sets this badge's text color.
    @discardableResult
    public func badgeTextColor(_ color: GraphicsColor) -> Self {
        callVoidMethod(name: "setBadgeTextColor", args: color.value)
        return self
    }
}

// MARK: SetBadgeWithTextShapeAppearance

extension BadgeDrawable {
    /// Sets this badge with text's shape appearance resource.
    @discardableResult
    public func badgeWithTextShapeAppearance(_ resId: Int32) -> Self {
        callVoidMethod(name: "setBadgeWithTextShapeAppearance", args: resId)
        return self
    }
}

// MARK: SetBadgeWithTextShapeAppearanceOverlay

extension BadgeDrawable {
    /// Sets this badge with text's shape appearance overlay resource.
    @discardableResult
    public func badgeWithTextShapeAppearanceOverlay(_ resId: Int32) -> Self {
        callVoidMethod(name: "setBadgeWithTextShapeAppearanceOverlay", args: resId)
        return self
    }
}

// MARK: SetBadgeWithoutTextShapeAppearance

extension BadgeDrawable {
    /// Sets this badge without text's shape appearance resource.
    @discardableResult
    public func badgeWithoutTextShapeAppearance(_ resId: Int32) -> Self {
        callVoidMethod(name: "setBadgeWithoutTextShapeAppearance", args: resId)
        return self
    }
}

// MARK: SetBadgeWithoutTextShapeAppearanceOverlay

extension BadgeDrawable {
    /// Sets this badge without text's shape appearance overlay resource.
    @discardableResult
    public func badgeWithoutTextShapeAppearanceOverlay(_ resId: Int32) -> Self {
        callVoidMethod(name: "setBadgeWithoutTextShapeAppearanceOverlay", args: resId)
        return self
    }
}

// TODO: setColorFilter

// MARK: SetContentDescriptionExceedsMaxBadgeNumberStringResource

extension BadgeDrawable {
    /// Sets the content description string resource
    /// for when the badge number exceeds the max badge number.
    @discardableResult
    public func contentDescriptionExceedsMaxBadgeNumberStringResource(_ resId: Int32) -> Self {
        callVoidMethod(name: "setContentDescriptionExceedsMaxBadgeNumberStringResource", args: resId)
        return self
    }
}

// MARK: SetContentDescriptionForText

extension BadgeDrawable {
    /// Specifies the content description if the text is set for the badge.
    /// If the text is set for the badge and the content description is null, the badge text will be used as the content description by default.
    @discardableResult
    public func contentDescriptionForText(_ description: String) -> Self {
        callVoidMethod(name: "setContentDescriptionForText", args: description)
        return self
    }
}

// MARK: SetContentDescriptionNumberless

extension BadgeDrawable {
    /// Specifies the content description if no text or number is set for the badge.
    @discardableResult
    public func contentDescriptionNumberless(_ description: String) -> Self {
        callVoidMethod(name: "setContentDescriptionNumberless", args: description)
        return self
    }
}

// MARK: SetContentDescriptionQuantityStringsResource

extension BadgeDrawable {
    /// Specifies the content description if the number is set for the badge.
    @discardableResult
    public func contentDescriptionQuantityStringsResource(_ resId: Int32) -> Self {
        callVoidMethod(name: "setContentDescriptionQuantityStringsResource", args: resId)
        return self
    }
}

// MARK: SetHorizontalOffset

extension BadgeDrawable {
    /// Sets how much to horizontally move this badge towards the center of its anchor.
    ///
    /// This sets the horizontal offset for badges without text (dots) and with text.
    @discardableResult
    public func horizontalOffset(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        callVoidMethod(name: "setHorizontalOffset", args: unit.toPixels(Int32(value)))
        return self
    }
}

// MARK: SetHorizontalOffsetWithText

extension BadgeDrawable {
    /// Sets how much to horizontally move this badge towards
    /// the center of its anchor when this badge has text.
    @discardableResult
    public func horizontalOffsetWithText(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        callVoidMethod(name: "setHorizontalOffsetWithText", args: unit.toPixels(Int32(value)))
        return self
    }
}

// MARK: SetHorizontalOffsetWithoutText

extension BadgeDrawable {
    /// Sets how much to horizontally move this badge towards the center
    /// of its anchor when this badge does not have text (is a dot).
    @discardableResult
    public func horizontalOffsetWithoutText(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        callVoidMethod(name: "setHorizontalOffsetWithoutText", args: unit.toPixels(Int32(value)))
        return self
    }
}

// MARK: SetHorizontalPadding

extension BadgeDrawable {
    /// Sets how much horizontal padding to add to the badge when it has label contents.
    /// 
    /// Note that badges have a minimum width as specified by `com.google.android.material.R.styleable#Badge_badgeWidth`.
    @discardableResult
    public func horizontalPadding(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        callVoidMethod(name: "setHorizontalPadding", args: unit.toPixels(Int32(value)))
        return self
    }
}

// MARK: SetLargeFontVerticalOffsetAdjustment

extension BadgeDrawable {
    /// Sets how much to vertically move this badge away the center
    /// of its anchor when this badge has text and the font scale is at max size.
    /// This is in conjunction with the vertical offset with text.
    @discardableResult
    public func largeFontVerticalOffsetAdjustment(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        callVoidMethod(name: "setLargeFontVerticalOffsetAdjustment", args: unit.toPixels(Int32(value)))
        return self
    }
}

// MARK: SetMaxCharacterCount

extension BadgeDrawable {
    /// Sets this badge's max character count.
    @discardableResult
    public func maxCharacterCount(_ value: Int) -> Self {
        callVoidMethod(name: "setMaxCharacterCount", args: Int32(value))
        return self
    }
}

// MARK: SetMaxNumber

extension BadgeDrawable {
    /// Sets this badge's max number. If maxCharacterCount is set, it will override this number.
    @discardableResult
    public func maxNumber(_ value: Int) -> Self {
        callVoidMethod(name: "setMaxNumber", args: Int32(value))
        return self
    }
}

// MARK: SetNumber

extension BadgeDrawable {
    /// Sets the badge's number. Only non-negative integer numbers are supported.
    /// 
    /// If the number is negative, it will be clamped to 0.
    /// 
    /// The specified value will be displayed, unless its number of digits exceeds `maxCharacterCount`
    /// in which case a truncated version will be shown.
    @discardableResult
    public func number(_ value: Int) -> Self {
        callVoidMethod(name: "setNumber", args: Int32(value))
        return self
    }
}

// MARK: SetText

extension BadgeDrawable {
    /// Sets the badge's text.
    /// 
    /// The specified text will be displayed, unless its length
    /// exceeds `maxCharacterCount` in which case a truncated version will be shown.
    @discardableResult
    public func text(_ value: String) -> Self {
        callVoidMethod(name: "setText", args: value)
        return self
    }
}

// MARK: SetTextAppearance

extension BadgeDrawable {
    /// Sets this badge's text appearance resource.
    @discardableResult
    public func textAppearance(_ resId: Int32) -> Self {
        callVoidMethod(name: "setTextAppearance", args: resId)
        return self
    }
}

// MARK: SetVerticalOffset

extension BadgeDrawable {
    /// Sets how much to vertically move this badge away from the center of its anchor.
    ///
    /// This sets the vertical offset for badges without text (dots) and with text.
    @discardableResult
    public func verticalOffset(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        callVoidMethod(name: "setVerticalOffset", args: unit.toPixels(Int32(value)))
        return self
    }
}

// MARK: SetVerticalOffsetWithText

extension BadgeDrawable {
    /// Sets how much to vertically move this badge away from the center
    /// of its anchor when this badge has text.
    @discardableResult
    public func verticalOffsetWithText(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        callVoidMethod(name: "setVerticalOffsetWithText", args: unit.toPixels(Int32(value)))
        return self
    }
}

// MARK: SetVerticalOffsetWithoutText

extension BadgeDrawable {
    /// Sets how much to vertically move this badge away from the center
    /// of its anchor when this badge does not have text (is a dot).
    @discardableResult
    public func verticalOffsetWithoutText(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        callVoidMethod(name: "setVerticalOffsetWithoutText", args: unit.toPixels(Int32(value)))
        return self
    }
}

// MARK: SetVerticalPadding

extension BadgeDrawable {
    /// Sets how much (in pixels) vertical padding to add to the badge when it has label contents.
    /// 
    /// Note that badges have a minimum height as specified by `com.google.android.material.R.styleable#Badge_badgeHeight`.
    @discardableResult
    public func verticalPadding(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        callVoidMethod(name: "setVerticalPadding", args: unit.toPixels(Int32(value)))
        return self
    }
}

// MARK: SetVisible

extension BadgeDrawable {
    /// Convenience wrapper method for `setVisible`
    /// with the `restart` parameter hardcoded to `false`.
    @discardableResult
    public func visible(_ value: Bool = true) -> Self {
        callVoidMethod(name: "setVisible", args: value)
        return self
    }
}

// MARK: UpdateBadgeCoordinates

extension BadgeDrawable {
    /// Calculates and updates this badge's center coordinates based on its anchor's bounds.
    /// 
    /// Internally also updates this `BadgeDrawable` BadgeDrawable's bounds,
    /// because they are dependent on the center coordinates.
    public func updateBadgeCoordinates(_ anchorView: View) {
        guard let instance = anchorView.instance else { return }
        callVoidMethod(name: "updateBadgeCoordinates", args: instance.signed(as: .android.view.View))
    }

    /// Calculates and updates this badge's center coordinates based on its anchor's bounds.
    /// 
    /// Internally also updates this `BadgeDrawable` BadgeDrawable's bounds,
    /// because they are dependent on the center coordinates.
    public func updateBadgeCoordinates(_ anchorView: View, _ customBadgeParent: FrameLayout) {
        guard
            let anchorInstance = anchorView.instance,
            let customBadgeParentInstance = customBadgeParent.instance
        else { return }
        callVoidMethod(
            name: "updateBadgeCoordinates",
            args: anchorInstance.signed(as: .android.view.View), customBadgeParentInstance.signed(as: FrameLayout.className)
        )
    }
}