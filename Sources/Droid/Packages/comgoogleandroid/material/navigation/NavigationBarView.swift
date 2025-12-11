//
//  NavigationBarView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.NavigationPackage {
    public class NavigationBarViewClass: JClassName, @unchecked Sendable {}
    
    public var NavigationBarView: NavigationBarViewClass { .init(parent: self, name: "NavigationBarView") }
}

/// Provides an abstract implementation of a navigation bar
/// that can be used to implementation such as
/// [Bottom Navigation](https://material.io/components/bottom-navigation)
/// or [Navigation rail](https://material.io/components/navigation-rail).
/// 
/// Navigation bars make it easy for users to explore and switch between top-level views in a single tap.
/// 
/// [Learn more](https://developer.android.com/reference/com/google/android/material/navigation/NavigationBarView)
@MainActor
open class NavigationBarView: FrameLayout, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.material.navigation.NavigationBarView }
    open override class var gradleDependencies: [AppGradleDependency] { [.material] }
}

extension NavigationBarView {
    public enum ActiveIndicatorWidth: Int32, Sendable {
        /// The active indicator width fills up the width of its parent.
        case matchParent = -1
        /// The active indicator width wraps its content.
        case wrapContent = -2
    }
    public enum LabelVisibility: Int32, Sendable {
        /// Labels are shown for all items.
        case labeled = 1
        /// Labels are shown for the selected item only.
        case selected = 2
        /// Labels are never shown.
        case unlabeled = 0
        /// Labels are shown for items when there are 3 or fewer items.
        /// When there are 4 or more items, labels are shown for the selected item only.
        case auto = -1
    }
}

extension NavigationBarView {
    /// Get the distance between the active indicator container and the item's label.
    public func activeIndicatorLabelPadding(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getActiveIndicatorLabelPadding") ?? 0
        return unit.fromPixels(value)
    }
    
    /// Returns an instance of `BadgeDrawable` associated with `menuItemId`, null if none was initialized.
    public func badge(at menuItemId: Int32) -> BadgeDrawable? {
        guard
            let clazz = JClass.load(BadgeDrawable.className),
            let global = instance?.callObjectMethod(
                name: "getBadge",
                args: menuItemId,
                returningClass: clazz
            )
        else { return nil }
        return BadgeDrawable(global)
    }
    
    /// Returns the text appearance used for the active menu item label
    /// when they are in the horizontal item layout
    /// (when the start icon value is `ITEM_ICON_GRAVITY_START`).
    @discardableResult
    public func horizontalItemTextAppearanceActive() -> Int32 {
        instance?.callIntMethod(
            name: "getHorizontalItemTextAppearanceActive"
        ) ?? 0
    }
    
    /// Returns the text appearance used for the inactive menu item labels
    /// when they are in the horizontal item layout
    /// (when the start icon value is `ITEM_ICON_GRAVITY_START`).
    @discardableResult
    public func horizontalItemTextAppearanceInactive() -> Int32 {
        instance?.callIntMethod(
            name: "getHorizontalItemTextAppearanceInactive"
        ) ?? 0
    }
    
    /// Get the horizontal distance between the icon and the item's label
    /// when the item is in the `ITEM_ICON_GRAVITY_START` configuration.
    public func iconLabelHorizontalSpacing(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getIconLabelHorizontalSpacing") ?? 0
        return unit.fromPixels(value)
    }

    /// Get the color of the active indicator drawable.
    public func getItemActiveIndicatorColor() -> ColorStateList? {
        guard
            let clazz = JClass.load(ColorStateList.className),
            let global = instance?.callObjectMethod(
                name: "getItemActiveIndicatorColor",
                returningClass: clazz
            )
        else { return nil }
        return ColorStateList(global)
    }

    /// Get the height of an item's active indicator
    /// when it is expanded to wrap the item content,
    /// ie. when it is in the `ITEM_ICON_GRAVITY_START` configuration.
    public func itemActiveIndicatorExpandedHeight(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getItemActiveIndicatorExpandedHeight") ?? 0
        return unit.fromPixels(value)
    }

    /// Get the margin that will be maintained at the start
    /// and end of the expanded active indicator away
    /// from the edges of its parent container.
    public func itemActiveIndicatorExpandedMarginHorizontal(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getItemActiveIndicatorExpandedMarginHorizontal") ?? 0
        return unit.fromPixels(value)
    }

    /// Get the width of an item's active indicator
    /// when it is expanded to wrap the item content,
    /// ie. when it is in the `ITEM_ICON_GRAVITY_START` configuration.
    public func itemActiveIndicatorExpandedWidth(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getItemActiveIndicatorExpandedWidth") ?? 0
        return unit.fromPixels(value)
    }

    /// Get the height of an item's active indicator.
    public func itemActiveIndicatorHeight(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getItemActiveIndicatorHeight") ?? 0
        return unit.fromPixels(value)
    }

    /// Get the margin that will be maintained at the start
    /// and end of the active indicator away
    /// from the edges of its parent container.
    public func itemActiveIndicatorMarginHorizontal(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getItemActiveIndicatorMarginHorizontal") ?? 0
        return unit.fromPixels(value)
    }

    // TODO: getItemActiveIndicatorShapeAppearance

    /// Get the width of an item's active indicator.
    public func itemActiveIndicatorWidth(_ unit: DimensionUnit = .dp) -> ActiveIndicatorWidth {
        let value = instance?.callIntMethod(name: "getItemActiveIndicatorWidth") ?? 0
        return ActiveIndicatorWidth(rawValue: value) ?? .wrapContent
    }

    /// Returns the background drawable of the menu items.
    public func itemBackground() -> Drawable? {
        guard
            let clazz = JClass.load(Drawable.className),
            let global = instance?.callObjectMethod(
                name: "getItemBackground",
                returningClass: clazz
            )
        else { return nil }
        return Drawable(global)
    }

    /// Returns the navigation items' layout gravity.
    public func itemGravity() -> Gravity {
        let value = instance?.callIntMethod(name: "getItemGravity") ?? 0
        return Gravity(rawValue: Int(value))
    }

    /// Returns the current item icon gravity.
    public func itemIconGravity() -> Gravity {
        let value = instance?.callIntMethod(name: "getItemIconGravity") ?? 0
        return Gravity(rawValue: Int(value))
    }

    /// Returns the size provided for the menu item icons.
    public func itemIconSize(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getItemIconSize") ?? 0
        return unit.fromPixels(value)
    }

    /// Returns the tint which is applied to our menu items' icons.
    public func itemIconTintList() -> ColorStateList? {
        guard
            let clazz = JClass.load(ColorStateList.className),
            let global = instance?.callObjectMethod(
                name: "getItemIconTintList",
                returningClass: clazz
            )
        else { return nil }
        return ColorStateList(global)
    }

    /// Get the distance from the bottom
    /// of an item's label to the bottom of the navigation bar item.
    public func itemPaddingBottom(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getItemPaddingBottom") ?? 0
        return unit.fromPixels(value)
    }

    /// Get the distance from the top of an item's
    /// icon/active indicator to the top of the navigation bar item.
    public func itemPaddingTop(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getItemPaddingTop") ?? 0
        return unit.fromPixels(value)
    }

    /// Returns the color used to create a ripple
    /// as the background drawable of the menu items.
    /// If a background is set using `setItemBackground`, this will return null.
    public func itemRippleColor() -> ColorStateList? {
        guard
            let clazz = JClass.load(ColorStateList.className),
            let global = instance?.callObjectMethod(
                name: "getItemRippleColor",
                returningClass: clazz
            )
        else { return nil }
        return ColorStateList(global)
    }

    /// Returns the text appearance used for the active menu item label.
    public func itemTextAppearanceActive() -> Int32 {
        instance?.callIntMethod(
            name: "getItemTextAppearanceActive"
        ) ?? 0
    }

    /// Returns the text appearance ID used for inactive menu item labels.
    public func itemTextAppearanceInactive() -> Int32 {
        instance?.callIntMethod(
            name: "getItemTextAppearanceInactive"
        ) ?? 0
    }

    /// Returns colors used for the different states
    /// (normal, selected, focused, etc.) of the menu item text.
    public func itemTextColor() -> ColorStateList? {
        guard
            let clazz = JClass.load(ColorStateList.className),
            let global = instance?.callObjectMethod(
                name: "getItemTextColor",
                returningClass: clazz
            )
        else { return nil }
        return ColorStateList(global)
    }

    /// Returns the max lines limit for the label text.
    public func labelMaxLines() -> Int {
        let value = instance?.callIntMethod(name: "getLabelMaxLines") ?? 1
        return Int(value)
    }

    /// Returns the current label visibility mode used by this `NavigationBarView`.
    public func labelVisibilityMode() -> LabelVisibility {
        let value = instance?.callIntMethod(name: "getLabelVisibilityMode") ?? 0
        return LabelVisibility(rawValue: value) ?? .auto
    }

    /// Returns the maximum number of items that can be displayed.
    public func maxItemCount() -> Int {
        let value = instance?.callIntMethod(name: "getMaxItemCount") ?? 5
        return Int(value)
    }

    /// Returns the Menu instance associated with this navigation bar.
    public func menu() -> Menu? {
        guard
            let clazz = JClass.load(Menu.className),
            let global = instance?.callObjectMethod(
                name: "getMenu",
                returningClass: clazz
            )
        else { return nil }
        return Menu(global)
    }

    /// Returns the `ViewGroup` instance associated with the menu view of this navigation bar.
    public func menuViewGroup() -> ViewGroup? {
        guard
            let instance,
            let clazz = JClass.load(ViewGroup.className),
            let global = instance.callObjectMethod(
                name: "getMenuView",
                returningClass: clazz
            )
        else { return nil }
        return ViewGroup(global, instance.contextLink)
    }

    /// Creates an instance of `BadgeDrawable` associated with `menuItemId` if none exists.
    /// 
    /// Initializes (if needed) and returns the associated instance of `BadgeDrawable` associated with `menuItemId`.
    public func getOrCreateBadge(at menuItemId: Int32) -> BadgeDrawable? {
        guard
            let clazz = JClass.load(BadgeDrawable.className),
            let global = instance?.callObjectMethod(
                name: "getOrCreateBadge",
                args: menuItemId,
                returningClass: clazz
            )
        else { return nil }
        return BadgeDrawable(global)
    }

    /// Returns whether or not the label text should scale with the system font size.
    public func scaleLabelTextWithFont() -> Bool {
        instance?.callBoolMethod(name: "getScaleLabelTextWithFont") ?? false
    }

    /// Returns the currently selected menu item ID, or zero if there is no menu.
    public func selectedItemId() -> Int32 {
        instance?.callIntMethod(name: "getSelectedItemId") ?? 0
    }

    /// Inflate a menu resource into this navigation view.
    /// 
    /// Existing items in the menu will not be modified or removed.
    public func inflateMenu(_ resId: Int32) {
        instance?.callVoidMethod(name: "inflateMenu", args: resId)
    }

    /// Get whether or not a selected item should show an active indicator.
    public func isItemActiveIndicatorEnabled() -> Bool {
        instance?.callBoolMethod(name: "isItemActiveIndicatorEnabled") ?? false
    }

    /// Removes the BadgeDrawable associated with `menuItemId`.
    /// 
    /// Do nothing if none exists.
    /// 
    /// Consider changing the visibility of the `BadgeDrawable` if you only want to hide it temporarily.
    public func removeBadge(at menuItemId: Int32) {
        instance?.callVoidMethod(name: "removeBadge", args: menuItemId)
    }
}

// MARK: SetActiveIndicatorLabelPadding

private struct ActiveIndicatorLabelPaddingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setActiveIndicatorLabelPadding"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension NavigationBarView {
    /// Set the distance between the active indicator container and the item's label.
    @discardableResult
    public func activeIndicatorLabelPadding(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ActiveIndicatorLabelPaddingViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetHorizontalItemTextAppearanceActive

private struct HorizontalItemTextAppearanceActiveViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setHorizontalItemTextAppearanceActive"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationBarView {
    /// Set the text appearance used for the active menu item label
    /// when they are in the horizontal item layout
    /// (when the start icon value is `ITEM_ICON_GRAVITY_START`).
    @discardableResult
    public func horizontalItemTextAppearanceActive(_ textAppearanceResId: Int32) -> Self {
        HorizontalItemTextAppearanceActiveViewProperty(value: textAppearanceResId).applyOrAppend(nil, self)
    }
}

// MARK: SetHorizontalItemTextAppearanceInactive

private struct HorizontalItemTextAppearanceInactiveViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setHorizontalItemTextAppearanceInactive"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationBarView {
    /// Set the text appearance used for the inactive menu item labels
    /// when they are in the horizontal item layout
    /// (when the start icon value is `ITEM_ICON_GRAVITY_START`).
    @discardableResult
    public func horizontalItemTextAppearanceInactive(_ textAppearanceResId: Int32) -> Self {
        HorizontalItemTextAppearanceInactiveViewProperty(value: textAppearanceResId).applyOrAppend(nil, self)
    }
}

// MARK: SetIconLabelHorizontalSpacing

private struct IconLabelHorizontalSpacingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setIconLabelHorizontalSpacing"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension NavigationBarView {
    /// Set the horizontal distance between the icon and the item's label
    /// when the item is in the `ITEM_ICON_GRAVITY_START` configuration.
    @discardableResult
    public func iconLabelHorizontalSpacing(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        IconLabelHorizontalSpacingViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetItemActiveIndicatorColor

private struct ItemActiveIndicatorColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemActiveIndicatorColor"
    let value: ColorStateList
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: ColorStateList.className))
    }
}
extension NavigationBarView {
    /// Set the color of the active indicator drawable.
    @discardableResult
    public func itemActiveIndicatorColor(_ value: ColorStateList) -> Self {
        ItemActiveIndicatorColorViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemActiveIndicatorEnabled

private struct ItemActiveIndicatorEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemActiveIndicatorEnabled"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationBarView {
    /// Set whether or not a selected item should show an active indicator.
    @discardableResult
    public func itemActiveIndicatorEnabled(_ value: Bool = true) -> Self {
        ItemActiveIndicatorEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemActiveIndicatorExpandedHeight

private struct ItemActiveIndicatorExpandedHeightViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemActiveIndicatorExpandedHeight"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension NavigationBarView {
    /// Set the height of an item's active indicator
    /// when it is expanded to wrap the item content,
    /// ie. when it is in the `ITEM_ICON_GRAVITY_START` configuration.
    @discardableResult
    public func itemActiveIndicatorExpandedHeight(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ItemActiveIndicatorExpandedHeightViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetItemActiveIndicatorExpandedMarginHorizontal

private struct ItemActiveIndicatorExpandedMarginHorizontalViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemActiveIndicatorExpandedMarginHorizontal"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension NavigationBarView {
    /// Set the margin that will be maintained at the start
    /// and end of the expanded active indicator away
    /// from the edges of its parent container.
    @discardableResult
    public func itemActiveIndicatorExpandedMarginHorizontal(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ItemActiveIndicatorExpandedMarginHorizontalViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetItemActiveIndicatorExpandedPadding

private struct ItemActiveIndicatorExpandedWidthViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemActiveIndicatorExpandedWidth"
    let value: (Int, Int, Int, Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.4.toPixels(Int32(value.0)), value.4.toPixels(Int32(value.1)), value.4.toPixels(Int32(value.2)), value.4.toPixels(Int32(value.3)))
    }
}
extension NavigationBarView {
    /// Set the width of an item's active indicator
    /// when it is expanded to wrap the item content,
    /// ie. when it is in the `ITEM_ICON_GRAVITY_START` configuration.
    @discardableResult
    public func itemActiveIndicatorExpandedWidth(
        left: Int,
        top: Int,
        right: Int,
        bottom: Int,
        _ unit: DimensionUnit = .dp
    ) -> Self {
        ItemActiveIndicatorExpandedWidthViewProperty(
            value: (left, top, right, bottom, unit)
        ).applyOrAppend(nil, self)
    }

    /// Set the width of an item's active indicator
    /// when it is expanded to wrap the item content,
    /// ie. when it is in the `ITEM_ICON_GRAVITY_START` configuration.
    @discardableResult
    public func itemActiveIndicatorExpandedWidth(
        h: Int,
        v: Int,
        _ unit: DimensionUnit = .dp
    ) -> Self {
        ItemActiveIndicatorExpandedWidthViewProperty(
            value: (h, v, h, v, unit)
        ).applyOrAppend(nil, self)
    }

    /// Set the width of an item's active indicator
    /// when it is expanded to wrap the item content,
    /// ie. when it is in the `ITEM_ICON_GRAVITY_START` configuration.
    @discardableResult
    public func itemActiveIndicatorExpandedWidth(
        _ value: Int,
        _ unit: DimensionUnit = .dp
    ) -> Self {
        ItemActiveIndicatorExpandedWidthViewProperty(
            value: (value, value, value, value, unit)
        ).applyOrAppend(nil, self)
    }
}

// MARK: SetItemActiveIndicatorExpandedWidth

private struct ItemActiveIndicatorWidthViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemActiveIndicatorWidth"
    let value: NavigationBarView.ActiveIndicatorWidth
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension NavigationBarView {
    /// Set the width of an item's active indicator
    /// when it is expanded to wrap the item content,
    /// ie. when it is in the `ITEM_ICON_GRAVITY_START` configuration.
    @discardableResult
    public func itemActiveIndicatorWidth(_ value: NavigationBarView.ActiveIndicatorWidth) -> Self {
        ItemActiveIndicatorWidthViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemActiveIndicatorHeight

private struct ItemActiveIndicatorHeightViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemActiveIndicatorHeight"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension NavigationBarView {
    /// Set the height of an item's active indicator.
    @discardableResult
    public func itemActiveIndicatorHeight(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ItemActiveIndicatorHeightViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetItemActiveIndicatorMarginHorizontal

private struct ItemActiveIndicatorMarginHorizontalViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemActiveIndicatorMarginHorizontal"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension NavigationBarView {
    /// Set the margin that will be maintained at the start
    /// and end of the active indicator away
    /// from the edges of its parent container.
    @discardableResult
    public func itemActiveIndicatorMarginHorizontal(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ItemActiveIndicatorMarginHorizontalViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// TODO: setItemActiveIndicatorShapeAppearance

// MARK: SetItemBackground

private struct ItemBackgroundViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemBackground"
    let value: Drawable
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: Drawable.className))
    }
}
extension NavigationBarView {
    /// Set the background of our menu items to the given drawable.
    ///
    /// This will remove any ripple backgrounds created by `setItemRippleColor`.
    @discardableResult
    public func itemBackground(_ value: Drawable) -> Self {
        ItemBackgroundViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemBackgroundResource

private struct ItemBackgroundResourceViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemBackgroundResource"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationBarView {
    /// Set the background of our menu items to the given resource ID.
    ///
    /// This will remove any ripple backgrounds created by `setItemRippleColor`.
    @discardableResult
    public func itemBackgroundResource(_ value: Int32) -> Self {
        ItemBackgroundResourceViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemGravity

private struct ItemGravityViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemGravity"
    let value: Gravity
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value.rawValue))
    }
}
extension NavigationBarView {
    /// Set the navigation items' layout gravity.
    @discardableResult
    public func itemGravity(_ value: Gravity) -> Self {
        ItemGravityViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemIconGravity

private struct ItemIconGravityViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemIconGravity"
    let value: Gravity
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value.rawValue))
    }
}
extension NavigationBarView {
    /// Set the item icon gravity.
    @discardableResult
    public func itemIconGravity(_ value: Gravity) -> Self {
        ItemIconGravityViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemIconSize

private struct ItemIconSizeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemIconSize"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension NavigationBarView {
    /// Set the size to provide for the menu item icons.
    ///
    /// For best image resolution, use an icon with the same size set in this method.
    @discardableResult
    public func itemIconSize(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ItemIconSizeViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetItemIconSizeRes

private struct ItemIconSizeResViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemIconSizeRes"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationBarView {
    /// Set the size to provide for the menu item icons.
    ///
    /// For best image resolution, use an icon with the same size set in this method.
    @discardableResult
    public func itemIconSizeRes(_ resId: Int32) -> Self {
        ItemIconSizeResViewProperty(value: resId).applyOrAppend(nil, self)
    }
}

// MARK: SetItemIconTintList

private struct ItemIconTintListViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemIconTintList"
    let value: ColorStateList
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: ColorStateList.className))
    }
}
extension NavigationBarView {
    /// Set the tint list which is applied to our menu items' icons.
    @discardableResult
    public func itemIconTintList(_ value: ColorStateList) -> Self {
        ItemIconTintListViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// TODO: setItemOnTouchListener

// MARK: SetItemPaddingBottom

private struct ItemPaddingBottomViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemPaddingBottom"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension NavigationBarView {
    /// Set the distance from the bottom
    /// of an item's label to the bottom of the navigation bar item.
    @discardableResult
    public func itemPaddingBottom(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ItemPaddingBottomViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetItemPaddingTop

private struct ItemPaddingTopViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemPaddingTop"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension NavigationBarView {
    /// Set the distance from the top of an item's
    /// icon/active indicator to the top of the navigation bar item.
    @discardableResult
    public func itemPaddingTop(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ItemPaddingTopViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetItemRippleColor

private struct ItemRippleColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemRippleColor"
    let value: ColorStateList
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: ColorStateList.className))
    }
}
extension NavigationBarView {
    /// Set the background of our menu items to be a ripple with the given colors.
    @discardableResult
    public func itemRippleColor(_ value: ColorStateList) -> Self {
        ItemRippleColorViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemTextAppearanceActive

private struct ItemTextAppearanceActiveViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemTextAppearanceActive"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationBarView {
    /// Set the text appearance used for the active menu item label.
    @discardableResult
    public func itemTextAppearanceActive(_ textAppearanceResId: Int32) -> Self {
        ItemTextAppearanceActiveViewProperty(value: textAppearanceResId).applyOrAppend(nil, self)
    }
}

// MARK: SetItemTextAppearanceActiveBoldEnabled

private struct ItemTextAppearanceActiveBoldEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemTextAppearanceActiveBoldEnabled"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationBarView {
    /// Sets whether the active menu item labels are bold.
    @discardableResult
    public func itemTextAppearanceActiveBoldEnabled(_ value: Bool = true) -> Self {
        ItemTextAppearanceActiveBoldEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemTextAppearanceInactive

private struct ItemTextAppearanceInactiveViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemTextAppearanceInactive"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationBarView {
    /// Sets the text appearance to be used for inactive menu item labels.
    @discardableResult
    public func itemTextAppearanceInactive(_ textAppearanceResId: Int32) -> Self {
        ItemTextAppearanceInactiveViewProperty(value: textAppearanceResId).applyOrAppend(nil, self)
    }
}

// MARK: SetItemTextColor

private struct ItemTextColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemTextColor"
    let value: ColorStateList
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: ColorStateList.className))
    }
}
extension NavigationBarView {
    /// Set the colors to be used for the different states
    /// (normal, selected, focused, etc.) of the menu item text.
    @discardableResult
    public func itemTextColor(_ value: ColorStateList) -> Self {
        ItemTextColorViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetLabelFontScalingEnabled

private struct LabelFontScalingEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLabelFontScalingEnabled"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationBarView {
    /// Set whether or not the label text should scale with the system font size.
    @discardableResult
    public func labelFontScalingEnabled(_ value: Bool = true) -> Self {
        LabelFontScalingEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetLabelMaxLines

private struct LabelMaxLinesViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLabelMaxLines"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension NavigationBarView {
    /// Set the max lines limit for the label text.
    @discardableResult
    public func labelMaxLines(_ value: Int) -> Self {
        LabelMaxLinesViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetLabelVisibilityMode

private struct LabelVisibilityModeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLabelVisibilityMode"
    let value: NavigationBarView.LabelVisibility
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension NavigationBarView {
    /// Sets the navigation items' label visibility mode.
    ///
    /// The label is either always shown, never shown, or only shown when activated.
    /// Also supports "auto" mode, which uses the item count to determine whether to show or hide the label.
    @discardableResult
    public func labelVisibilityMode(_ value: NavigationBarView.LabelVisibility) -> Self {
        LabelVisibilityModeViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// TODO: setOnItemReselectedListener
// TODO: setOnItemSelectedListener

// MARK: SetSelectedItemId

private struct SelectedItemIdViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setSelectedItemId"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationBarView {
    /// Set the selected menu item ID.
    /// This behaves the same as tapping on an item.
    @discardableResult
    public func selectedItemId(_ value: Int32) -> Self {
        SelectedItemIdViewProperty(value: value).applyOrAppend(nil, self)
    }
}

extension NavigationBarView {
    /// Returns whether or not submenus are supported.
    public func isSubMenuSupported() -> Bool {
        instance?.callBoolMethod(name: "isSubMenuSupported") ?? false
    }
}