//
//  AppCompatWidgetAppCompatButton.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatButtonClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatButton: AppCompatButtonClass { .init(parent: self, name: "AppCompatButton") }
}

/// A Button which supports compatible features on older versions of the platform, including:
/// - Allows dynamic tint of its background via the background tint methods in androidx.core.view.ViewCompat.
/// - Allows setting of the background tint using backgroundTint and backgroundTintMode.
/// - Allows setting of the font family using fontFamily
/// 
/// This will automatically be used when you use Button in your layouts and the top-level activity / dialog is provided by appcompat. You should only need to manually use this class when writing custom views.
/// 
/// [Learn more](https://developer.android.com/reference/androidx/appcompat/widget/AppCompatButton)
open class AppCompatButton: Button, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .androidx.appcompat.widget.AppCompatButton }
}

extension AppCompatButton {
    public func isEmojiCompatEnabled() -> Bool {
        instance?.callBoolMethod(name: "isEmojiCompatEnabled") ?? false
    }
}

// MARK: setEmojiCompatEnabled

struct EmojiCompatEnabledProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setEmojiCompatEnabled"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Configure emoji fallback behavior using EmojiCompat.
    /// 
    /// When enabled, this View will attempt to use EmojiCompat to enabled missing emojis.
    /// When disabled, this View will not display missing emojis using EmojiCompat.
    /// EmojiCompat must be correctly configured on a device for this to have an effect,
    /// which will happen by default if a correct downloadable fonts provider is installed on the device.
    /// If you manually configure EmojiCompat by calling EmojiCompat init after this View is constructed,
    /// you may call this method again to enable EmojiCompat on this text view.
    /// 
    /// For more information about EmojiCompat configuration see the emoji2 module.
    @discardableResult
    public func emojiCompatEnabled(_ value: Bool = true) -> Self {
        EmojiCompatEnabledProperty(value: value).applyOrAppend(nil, self)
    }
}