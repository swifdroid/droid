//
//  MaterialToolbar.swift
//  Droid
//
//  Created by Mihael Isaev on 21.11.2025.
//

/// A standard toolbar for use within application content.
/// 
/// [Learn more](https://developer.android.com/reference/com/google/android/material/appbar/MaterialToolbar)
public final class MaterialToolbar: Toolbar, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { "com/google/android/material/appbar/MaterialToolbar" }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}

// MARK: - Fields

// TODO: logoScaleType
// TODO: navigationIconTint

// MARK: - Methods

// MARK: clearNavigationIconTint

fileprivate struct ClearNavigationIconTintViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "clearNavigationIconTint"
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue)
    }
}
extension MaterialToolbar {
    /// Clears the tint list of the toolbar's navigation icon.
    /// 
    /// E.g., if the navigation icon is an XML based vector drawable,
    /// calling this method will clear the `android:tint`.
    @discardableResult
    public func clearNavigationIconTint() -> Self {
        ClearNavigationIconTintViewProperty().applyOrAppend(nil, self)
    }
}

// MARK: getLogoScaleType

extension MaterialToolbar {
    /// Returns scale type of logo's `ImageView`.
    public func logoScaleType() -> ImageView.ScaleType? {
        guard let enumOrdinal = instance?.callIntMethod(name: "getLogoScaleType") else { return nil }
        return .init(rawValue: Int(enumOrdinal))
    }
}

// MARK: getNavigationIconTint

extension MaterialToolbar {
    /// Gets the tint color of the toolbar's navigation icon,
    /// or null if no tint color has been set.
    public func navigationIconTint() -> GraphicsColor? {
        guard let clazz = JClass.load(JInteger.className) else { return nil }
        guard let object: JObject = instance?.callObjectMethod(name: "getNavigationIconTint", returningClass: clazz) else { return nil }
        guard let value = JInteger(object).intValue() else { return nil }
        return GraphicsColor(integerLiteral: value)
    }
}

// MARK: isLogoAdjustViewBounds

extension MaterialToolbar {
    /// Returns whether the logo's `ImageView` adjusts its bounds
    /// to preserve the aspect ratio of its drawable.
    public func isLogoAdjustViewBounds() -> Bool {
        instance?.callBoolMethod(name: "isLogoAdjustViewBounds") ?? false
    }
}

// MARK: isSubtitleCentered

extension MaterialToolbar {
    /// Returns whether the subtitle text corresponding to the `setSubtitle` method
    /// should be centered horizontally within the toolbar.
    public func isSubtitleCentered() -> Bool {
        instance?.callBoolMethod(name: "isSubtitleCentered") ?? false
    }
}

// MARK: isTitleCentered

extension MaterialToolbar {
    /// Returns whether the title text corresponding to the `setTitle` method
    /// should be centered horizontally within the toolbar.
    public func isTitleCentered() -> Bool {
        instance?.callBoolMethod(name: "isTitleCentered") ?? false
    }
}

// MARK: setLogoAdjustViewBounds

fileprivate struct ElevationViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLogoAdjustViewBounds"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension MaterialToolbar {
    /// Sets `ImageView.adjustViewBounds` for logo's `ImageView`.
    @discardableResult
    public func logoAdjustViewBounds(_ adjustViewBounds: Bool = true) -> Self {
        ElevationViewProperty(value: adjustViewBounds).applyOrAppend(nil, self)
    }
}

// MARK: setLogoScaleType

fileprivate struct LogoScaleTypeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLogoScaleType"
    let value: ImageView.ScaleType
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value.rawValue))
    }
}
extension MaterialToolbar {
    /// Sets `ImageView.ScaleType` for logo's `ImageView`.
    @discardableResult
    public func logoScaleType(_ scaleType: ImageView.ScaleType) -> Self {
        LogoScaleTypeViewProperty(value: scaleType).applyOrAppend(nil, self)
    }
}

// MARK: setNavigationIcon

fileprivate struct NavigationIconViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setNavigationIcon"
    let value: Drawable
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: Drawable.className))
    }
}
extension MaterialToolbar {
    /// Sets the navigation icon to a given drawable.
    @discardableResult
    public func navigationIcon(_ drawable: Drawable) -> Self {
        NavigationIconViewProperty(value: drawable).applyOrAppend(nil, self)
    }
}

// MARK: setNavigationIconTint

fileprivate struct NavigationIconTintViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setNavigationIconTint"
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension MaterialToolbar {
    /// Sets the color of the toolbar's navigation icon.
    @discardableResult
    public func navigationIconTint(_ color: GraphicsColor) -> Self {
        NavigationIconTintViewProperty(value: color).applyOrAppend(nil, self)
    }
}

// MARK: setSubtitleCentered

fileprivate struct SubtitleCenteredViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setSubtitleCentered"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension MaterialToolbar {
    /// Sets whether the subtitle text corresponding to the `setSubtitle` method
    /// should be centered horizontally within the toolbar.
    ///
    /// Note: it is not recommended to use centered titles in conjunction
    /// with a nested custom view, as there may be positioning and overlap issues.
    @discardableResult
    public func subtitleCentered(_ centered: Bool = true) -> Self {
        SubtitleCenteredViewProperty(value: centered).applyOrAppend(nil, self)
    }
}

// MARK: setTitleCentered

fileprivate struct TitleCenteredViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTitleCentered"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension MaterialToolbar {
    /// Sets whether the title text corresponding to the `setTitle` method
    /// should be centered horizontally within the toolbar.
    /// 
    /// Note: it is not recommended to use centered titles in conjunction
    /// with a nested custom view, as there may be positioning and overlap issues.
    @discardableResult
    public func titleCentered(_ centered: Bool = true) -> Self {
        TitleCenteredViewProperty(value: centered).applyOrAppend(nil, self)
    }
}