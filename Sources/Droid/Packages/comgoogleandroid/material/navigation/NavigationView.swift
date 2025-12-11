//
//  NavigationView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.NavigationPackage {
    public class NavigationViewClass: JClassName, @unchecked Sendable {}
    
    public var NavigationView: NavigationViewClass { .init(parent: self, name: "NavigationView") }
}

/// Represents a standard navigation menu for application.
/// 
/// [Learn more](https://developer.android.com/reference/com/google/android/material/navigation/NavigationView)
@MainActor
open class NavigationView: FrameLayout {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.material.navigation.NavigationView }
    open override class var gradleDependencies: [AppGradleDependency] { [.material] }
}

// MARK: AddHeaderView

extension NavigationView {
    /// Adds a View as a header of the navigation menu.
    @discardableResult
    public func addHeaderView(_ view: View) -> Self {
        guard let instance = view.instance else { return self }
        self.instance?.callVoidMethod(name: "addHeaderView", args: instance.signed(as: .android.view.View))
        return self
    }
}

// MARK: CancelBackProgress

extension NavigationView {
    /// Call this method from `onBackCancelled` or `handleOnBackCancelled`
    /// so that the back handler can cancel the back animation.
    public func cancelBackProgress() {
        instance?.callVoidMethod(name: "cancelBackProgress")
    }
}

// TODO: draw

// MARK: GetCheckedItem

extension NavigationView {
    /// Returns the currently checked item in this navigation menu.
    public func checkedItem() -> MenuItem? {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = instance?.callObjectMethod(name: "getCheckedItem", returningClass: returningClazz)
        else { return nil }
        return MenuItem(global)
    }
}

// MARK: GetDividerInsetEnd

extension NavigationView {
    /// Get the distance between the end of a divider and the end of the NavigationView.
    public func dividerInsetEnd(_ unit: DimensionUnit = .dp) -> Int {
        guard let px = instance?.callIntMethod(name: "getDividerInsetEnd") else { return 0 }
        return unit.fromPixels(px)
    }
}

// MARK: GetDividerInsetStart

extension NavigationView {
    /// Get the distance between the start edge of the NavigationView and the start of a menu divider.
    public func dividerInsetStart(_ unit: DimensionUnit = .dp) -> Int {
        guard let value = instance?.callIntMethod(name: "getDividerInsetStart") else { return 0 }
        return unit.fromPixels(value)
    }
}

// MARK: GetHeaderCount

extension NavigationView {
    /// Returns the number of header views currently in the navigation menu.
    public func headerCount() -> Int {
        Int(instance?.callIntMethod(name: "getHeaderCount") ?? 0)
    }
}

// MARK: GetHeaderView

extension NavigationView {
    /// Gets the header view at the specified position.
    public func headerView(at position: Int) -> View? {
        guard
            let returningClazz = JClass.load(View.className),
            let global = instance?.callObjectMethod(name: "getHeaderView", args: Int32(position), returningClass: returningClazz)
        else { return nil }
        return .init(global, { [weak self] in
            InnerLog.t("🟡 NavigationView.headerView(): getting context (\(self?.instance?.context != nil))")
            return self?.instance?.context
        })
    }
}

// MARK: GetItemBackground

extension NavigationView {
    /// Returns the background drawable for our menu items.
    public func itemBackground() -> Drawable? {
        guard
            let returningClazz = JClass.load(Drawable.className),
            let global = instance?.callObjectMethod(name: "getItemBackground", returningClass: returningClazz)
        else { return nil }
        return Drawable(global)
    }
}

// MARK: GetItemHorizontalPadding

extension NavigationView {
    /// Returns the horizontal (left and right) padding applied to menu items.
    public func itemHorizontalPadding(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getItemHorizontalPadding") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetItemIconPadding

extension NavigationView {
    /// Returns the padding in pixels between the icon (if present) and the text of menu items.
    public func itemIconPadding(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getItemIconPadding") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetItemIconTintList

extension NavigationView {
    /// Returns the tint which is applied to our menu items' icons.
    public func itemIconTintList() -> ColorStateList? {
        guard
            let returningClazz = JClass.load(ColorStateList.className),
            let global = instance?.callObjectMethod(name: "getItemIconTintList", returningClass: returningClazz)
        else { return nil }
        return ColorStateList(global)
    }
}

// MARK: GetItemMaxLines

extension NavigationView {
    /// Gets the android:maxLines attribute of the text view in the menu item.
    public func itemMaxLines() -> Int {
        Int(instance?.callIntMethod(name: "getItemMaxLines") ?? 0)
    }
}

// MARK: GetItemTextColor

extension NavigationView {
    /// Returns the tint which is applied to our menu items' icons.
    public func itemTextColor() -> ColorStateList? {
        guard
            let returningClazz = JClass.load(ColorStateList.className),
            let global = instance?.callObjectMethod(name: "getItemTextColor", returningClass: returningClazz)
        else { return nil }
        return ColorStateList(global)
    }
}

// MARK: GetItemVerticalPadding

extension NavigationView {
    /// Returns the vertical (top and bottom) padding applied to menu items.
    public func itemVerticalPadding(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getItemVerticalPadding") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetMenu

extension NavigationView {
    /// Returns the menu instance associated with this navigation menu.
    public func menu() -> Menu? {
        guard
            let returningClazz = JClass.load(Menu.className),
            let global = instance?.callObjectMethod(name: "getMenu", returningClass: returningClazz)
        else { return nil }
        return Menu(global)
    }
}

// MARK: GetSubheaderInsetEnd

extension NavigationView {
    /// Get the distance between the end of a menu subheader and the end of the NavigationView.
    public func subheaderInsetEnd(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getSubheaderInsetEnd") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: GetSubheaderInsetStart

extension NavigationView {
    /// Get the distance between the start edge of the NavigationView and the start of a menu subheader.
    public func subheaderInsetStart(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getSubheaderInsetStart") ?? 0
        return unit.fromPixels(value)
    }
}

// MARK: HandleBackInvoked

extension NavigationView {
    /// Call this method from `onBackInvoked` or `handleOnBackPressed`
    /// so that the back handler can complete the back animation,
    /// or handle back without progress in certain cases.
    public func handleBackInvoked() {
        instance?.callVoidMethod(name: "handleBackInvoked")
    }
}

// MARK: IsBottomInsetScrimEnabled

extension NavigationView {
    /// Whether or not the NavigationView will draw a scrim behind the window's bottom inset.
    public func isBottomInsetScrimEnabled() -> Bool {
        instance?.callBoolMethod(name: "isBottomInsetScrimEnabled") ?? false
    }
}

// MARK: IsEndInsetScrimEnabled

extension NavigationView {
    /// Whether or not the NavigationView will draw a scrim behind the window's end inset.
    public func isEndInsetScrimEnabled() -> Bool {
        instance?.callBoolMethod(name: "isEndInsetScrimEnabled") ?? false
    }
}

// MARK: IsStartInsetScrimEnabled

extension NavigationView {
    /// Whether or not the NavigationView will draw a scrim behind the window's start inset.
    public func isStartInsetScrimEnabled() -> Bool {
        instance?.callBoolMethod(name: "isStartInsetScrimEnabled") ?? false
    }
}

// MARK: IsTopInsetScrimEnabled

extension NavigationView {
    /// Whether or not the NavigationView will draw a scrim behind the window's top inset.
    public func isTopInsetScrimEnabled() -> Bool {
        instance?.callBoolMethod(name: "isTopInsetScrimEnabled") ?? false
    }
}

// MARK: RemoveHeaderView

extension NavigationView {
    /// Removes a previously-added header view.
    public func removeHeaderView(_ view: View) {
        instance?.callVoidMethod(name: "removeHeaderView", args: view.instance?.signed(as: .android.view.View))
    }
}

// MARK: SetBottomInsetScrimEnabled

private struct BottomInsetScrimEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setBottomInsetScrimEnabled"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationView {
    /// Set whether or not the NavigationView should draw a scrim
    /// behind the window's bottom inset (typically the navigation bar)
    @discardableResult
    public func bottomInsetScrimEnabled(_ value: Bool = true) -> Self {
        BottomInsetScrimEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetCheckedItem

private struct CheckedItemViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCheckedItem"
    let value: MenuItem
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: MenuItem.className))
    }
}
extension NavigationView {
    /// Sets the currently checked item in this navigation menu.
    @discardableResult
    public func checkedItem(_ item: MenuItem) -> Self {
        CheckedItemViewProperty(value: item).applyOrAppend(nil, self)
    }
}

// MARK: SetDividerInsetEnd

private struct DividerInsetEndViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setDividerInsetEnd"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        let px = value.1.toPixels(Int32(value.0))
        instance.callVoidMethod(env, name: key.rawValue, args: px)
    }
}
extension NavigationView {
    /// Set the distance between the end of a divider and the end of the NavigationView.
    @discardableResult
    public func dividerInsetEnd(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        DividerInsetEndViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetDividerInsetStart

private struct DividerInsetStartViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setDividerInsetStart"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        let px = value.1.toPixels(Int32(value.0))
        instance.callVoidMethod(env, name: key.rawValue, args: px)
    }
}
extension NavigationView {
    /// Set the distance between the start edge of the NavigationView and the start of a menu divider.
    @discardableResult
    public func dividerInsetStart(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        DividerInsetStartViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetDrawBottomInsetForeground

private struct DrawBottomInsetForegroundViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setDrawBottomInsetForeground"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationView {
    /// Set whether or not the NavigationView should draw a scrim
    /// behind the window's bottom inset (typically the navigation bar)
    @discardableResult
    public func drawBottomInsetForeground(_ value: Bool = true) -> Self {
        DrawBottomInsetForegroundViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetDrawLeftInsetForeground

private struct DrawLeftInsetForegroundViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setDrawLeftInsetForeground"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationView {
    /// Set whether or not the NavigationView should draw a scrim
    /// behind the window's left inset (typically the navigation bar)
    @discardableResult
    public func drawLeftInsetForeground(_ value: Bool = true) -> Self {
        DrawLeftInsetForegroundViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetDrawRightInsetForeground

private struct DrawRightInsetForegroundViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setDrawRightInsetForeground"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationView {
    /// Set whether or not the NavigationView should draw a scrim
    /// behind the window's right inset (typically the navigation bar)
    @discardableResult
    public func drawRightInsetForeground(_ value: Bool = true) -> Self {
        DrawRightInsetForegroundViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetDrawTopInsetForeground

private struct DrawTopInsetForegroundViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setDrawTopInsetForeground"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationView {
    /// Set whether or not the NavigationView should draw a scrim
    /// behind the window's top inset (typically the status bar)
    @discardableResult
    public func drawTopInsetForeground(_ value: Bool = true) -> Self {
        DrawTopInsetForegroundViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemBackground

private struct ItemBackgroundViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemBackground"
    let value: Drawable?
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: Drawable.className))
    }
}
extension NavigationView {
    /// Set the background of our menu items to a given resource.
    /// The resource should refer to a Drawable object or null
    /// to use the default background set on this navigation menu.
    @discardableResult
    public func itemBackground(_ drawable: Drawable?) -> Self {
        ItemBackgroundViewProperty(value: drawable).applyOrAppend(nil, self)
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
extension NavigationView {
    /// Set the background of our menu items to the given resource.
    /// This overrides the default background set to items and it's styling.
    @discardableResult
    public func itemBackgroundResource(_ resId: Int32) -> Self {
        ItemBackgroundResourceViewProperty(value: resId).applyOrAppend(nil, self)
    }
}

// MARK: SetItemHorizontalPadding

private struct ItemHorizontalPaddingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemHorizontalPadding"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        let px = value.1.toPixels(Int32(value.0))
        instance.callVoidMethod(env, name: key.rawValue, args: px)
    }
}
extension NavigationView {
    /// Set the horizontal (left and right) padding applied to menu items.
    @discardableResult
    public func itemHorizontalPadding(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ItemHorizontalPaddingViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetItemHorizontalPaddingResource

private struct ItemHorizontalPaddingResourceViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemHorizontalPaddingResource"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationView {
    /// Set the horizontal (left and right) padding applied to menu items.
    @discardableResult
    public func itemHorizontalPaddingResource(_ resId: Int32) -> Self {
        ItemHorizontalPaddingResourceViewProperty(value: resId).applyOrAppend(nil, self)
    }
}

// MARK: SetItemIconPadding

private struct ItemIconPaddingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemIconPadding"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        let px = value.1.toPixels(Int32(value.0))
        instance.callVoidMethod(env, name: key.rawValue, args: px)
    }
}
extension NavigationView {
    /// Set the padding in pixels between the icon (if present) and the text of menu items.
    @discardableResult
    public func itemIconPadding(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ItemIconPaddingViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetItemIconPaddingResource

private struct ItemIconPaddingResourceViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemIconPaddingResource"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationView {
    /// Set the padding in pixels between the icon (if present) and the text of menu items.
    @discardableResult
    public func itemIconPaddingResource(_ resId: Int32) -> Self {
        ItemIconPaddingResourceViewProperty(value: resId).applyOrAppend(nil, self)
    }
}

// MARK: SetItemIconSize

private struct ItemIconSizeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemIconSize"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        let px = value.1.toPixels(Int32(value.0))
        instance.callVoidMethod(env, name: key.rawValue, args: px)
    }
}
extension NavigationView {
    /// Sets the size to be used for the menu item icons.
    /// If no icons are set, calling this method will do nothing.
    @discardableResult
    public func itemIconSize(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ItemIconSizeViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetItemIconTintList

private struct ItemIconTintListViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemIconTintList"
    let value: ColorStateList?
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: ColorStateList.className))
    }
}
extension NavigationView {
    /// Set the tint which is applied to our menu items' icons.
    @discardableResult
    public func itemIconTintList(_ value: ColorStateList?) -> Self {
        ItemIconTintListViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemMaxLines

private struct ItemMaxLinesViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemMaxLines"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension NavigationView {
    /// Sets the `android:maxLines` attribute of the text view in the menu item.
    @discardableResult
    public func itemMaxLines(_ value: Int) -> Self {
        ItemMaxLinesViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemTextAppearance

private struct ItemTextAppearanceViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemTextAppearance"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationView {
    /// Set the text appearance of the menu items to a given resource.
    @discardableResult
    public func itemTextAppearance(_ resId: Int32) -> Self {
        ItemTextAppearanceViewProperty(value: resId).applyOrAppend(nil, self)
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
extension NavigationView {
    /// Sets whether the active menu item label is bold.
    @discardableResult
    public func itemTextAppearanceActiveBoldEnabled(_ value: Bool = true) -> Self {
        ItemTextAppearanceActiveBoldEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemTextColor

private struct ItemTextColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemTextColor"
    let value: ColorStateList?
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: ColorStateList.className))
    }
}
extension NavigationView {
    /// Set the text color to be used on our menu items.
    @discardableResult
    public func itemTextColor(_ value: ColorStateList?) -> Self {
        ItemTextColorViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetItemVerticalPadding

private struct ItemVerticalPaddingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemVerticalPadding"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        let px = value.1.toPixels(Int32(value.0))
        instance.callVoidMethod(env, name: key.rawValue, args: px)
    }
}
extension NavigationView {
    /// Set the vertical (top and bottom) padding applied to menu items.
    @discardableResult
    public func itemVerticalPadding(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ItemVerticalPaddingViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetItemVerticalPaddingResource

private struct ItemVerticalPaddingResourceViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setItemVerticalPaddingResource"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationView {
    /// Set the vertical (top and bottom) padding applied to menu items.
    @discardableResult
    public func itemVerticalPaddingResource(_ resId: Int32) -> Self {
        ItemVerticalPaddingResourceViewProperty(value: resId).applyOrAppend(nil, self)
    }
}

// TODO: setNavigationItemSelectedListener

// MARK: SetScrimInsetForeground

private struct ScrimInsetForegroundViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setScrimInsetForeground"
    let value: Drawable?
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: Drawable.className))
    }
}
extension NavigationView {
    /// Sets the drawable used for the inset foreground.
    @discardableResult
    public func scrimInsetForeground(_ drawable: Drawable?) -> Self {
        ScrimInsetForegroundViewProperty(value: drawable).applyOrAppend(nil, self)
    }
}

// MARK: SetStartInsetScrimEnabled

private struct StartInsetScrimEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setStartInsetScrimEnabled"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationView {
    /// Set whether or not the NavigationView
    /// should draw a scrim behind the window's start inset.
    @discardableResult
    public func startInsetScrimEnabled(_ value: Bool = true) -> Self {
        StartInsetScrimEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetSubheaderInsetEnd

private struct SubheaderInsetEndViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setSubheaderInsetEnd"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        let px = value.1.toPixels(Int32(value.0))
        instance.callVoidMethod(env, name: key.rawValue, args: px)
    }
}
extension NavigationView {
    /// Set the distance between the end of a menu subheader and the end of the NavigationView.
    @discardableResult
    public func subheaderInsetEnd(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        SubheaderInsetEndViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetSubheaderInsetStart

private struct SubheaderInsetStartViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setSubheaderInsetStart"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        let px = value.1.toPixels(Int32(value.0))
        instance.callVoidMethod(env, name: key.rawValue, args: px)
    }
}
extension NavigationView {
    /// Set the distance between the start edge of the NavigationView and the start of a menu subheader.
    @discardableResult
    public func subheaderInsetStart(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        SubheaderInsetStartViewProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetTopInsetScrimEnabled

private struct TopInsetScrimEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTopInsetScrimEnabled"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension NavigationView {
    /// Set whether or not the NavigationView
    /// should draw a scrim behind the window's top inset (typically the status bar).
    @discardableResult
    public func topInsetScrimEnabled(_ value: Bool = true) -> Self {
        TopInsetScrimEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// TODO: startBackProgress
// TODO: updateBackProgress
