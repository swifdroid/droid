//
//  MaterialButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
#if os(Android)
import Android
#endif

extension ComGoogleAndroidPackage.MaterialPackage.ButtonPackage {
    public class MaterialButtonClass: JClassName, @unchecked Sendable {}
    
    public var MaterialButton: MaterialButtonClass { .init(parent: self, name: "MaterialButton") }
}

/// A convenience class for creating a new Material button.
/// 
/// This class supplies updated Material styles for the button in the constructor. The widget will display the correct default Material styles without the use of the style flag.
/// 
/// All attributes from com.google.android.material.R.styleable#MaterialButton are supported. Do not use the android:background attribute. MaterialButton manages its own background drawable, and setting a new background means MaterialButton can no longer guarantee that the new attributes it introduces will function properly. If the default background is changed, MaterialButton cannot guarantee well-defined behavior.
/// 
/// For filled buttons, this class uses your theme's ?attr/colorPrimary for the background tint color and ?attr/colorOnPrimary for the text color. For unfilled buttons, this class uses ?attr/colorPrimary for the text color and transparent for the background tint.
/// 
/// Add icons to the start, center, or end of this button using the app:icon, app:iconPadding, app:iconTint, app:iconTintMode and app:iconGravity attributes.
/// 
/// If a start-aligned icon is added to this button, please use a style like one of the ".Icon" styles specified in the default MaterialButton styles. The ".Icon" styles adjust padding slightly to achieve a better visual balance. This style should only be used with a start-aligned icon button. If your icon is end-aligned, you cannot use a ".Icon" style and must instead manually adjust your padding such that the visual adjustment is mirrored.
/// 
/// Specify background tint using the app:backgroundTint and app:backgroundTintMode attributes, which accepts either a color or a color state list.
/// 
/// Ripple color / press state color can be specified using the app:rippleColor attribute. Ripple opacity will be determined by the Android framework when available. Otherwise, this color will be overlaid on the button at a 50% opacity when button is pressed.
/// 
/// Set the stroke color using the app:strokeColor attribute, which accepts either a color or a color state list. Stroke width can be set using the app:strokeWidth attribute.
/// 
/// Specify the radius of all four corners of the button using the app:cornerRadius attribute.
/// 
/// [Learn more](https://developer.android.com/reference/com/google/android/material/button/MaterialButton)
#if os(Android)
@MainActor
#endif
open class MaterialButton: AppCompatButton, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.material.button.MaterialButton }
    open override class var gradleDependencies: [AppGradleDependency] { [.material] }
}

extension MaterialButton {
    public enum IconGravity: Int32, @unchecked Sendable {
        /// Gravity used to position the icon at the end of the view.
        case end = 3
        /// Gravity used to position the icon at the start of the view.
        case start = 1
        /// Gravity used to position the icon in the center of the view at the end of the text
        case textEnd = 4
        /// Gravity used to position the icon in the center of the view at the start of the text
        case textStart = 2
        /// Gravity used to position the icon in the center of the view at the top of the text
        case textTop = 32
        /// Gravity used to position the icon at the top of the view.
        case top = 16
    }
}

// TODO: addOnCheckedChangeListener: implement MaterialButton.OnCheckedChangeListener https://developer.android.com/reference/com/google/android/material/button/MaterialButton.OnCheckedChangeListener

// MARK: clearOnCheckedChangeListeners

extension MaterialButton {
    /// Remove all previously added OnCheckedChangeListener(s).
    public func clearOnCheckedChangeListeners() {
        instance?.callVoidMethod(name: "clearOnCheckedChangeListeners")
    }
}

// TODO: getBackgroundTintList: implement ColorStateList https://developer.android.com/reference/android/content/res/ColorStateList
// TODO: getBackgroundTintMode: implement PorterDuff.Mode https://developer.android.com/reference/android/graphics/PorterDuff.Mode

// MARK: getCornerRadius

extension MaterialButton {
    /// Gets the corner radius for this button.
    public func cornerRadius() -> Int {
        Int(instance?.callIntMethod(name: "getCornerRadius") ?? 0)
    }
}

// MARK: getIcon

extension MaterialButton {
    /// Gets the icon shown for this button, if present.
    public func icon() -> Drawable? {
        guard
            let returningClazz = JClass.load(Drawable.className),
            let global = instance?.callObjectMethod(name: "getIcon", returningClass: returningClazz)
        else { return nil }
        return Drawable(global)
    }
}

// MARK: getIconGravity

extension MaterialButton {
    /// Gets the icon gravity for this button
    public func iconGravity() -> IconGravity {
        let value = instance?.callIntMethod(name: "getIconGravity") ?? 1
        return IconGravity(rawValue: value) ?? .start
    }
}

// MARK: getIconPadding

extension MaterialButton {
    /// Gets the padding between the button icon and the button text, if icon is present.
    public func iconPadding(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getIconPadding") ?? 0
        return unit.from(value)
    }
}

// MARK: getIconSize

extension MaterialButton {
    /// Returns the size of the icon if it was set in pixels, 0 otherwise.
    public func iconSize(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getIconSize") ?? 0
        return unit.from(value)
    }
}

// TODO: getIconTint: implement ColorStateList https://developer.android.com/reference/android/content/res/ColorStateList
// TODO: getIconTintMode: implement PorterDuff.Mode https://developer.android.com/reference/android/graphics/PorterDuff.Mode

// MARK: getInsetBottom

extension MaterialButton {
    /// Gets the bottom inset for this button
    public func insetBottom(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getInsetBottom") ?? 0
        return unit.from(value)
    }
}

// MARK: getInsetTop

extension MaterialButton {
    /// Gets the top inset for this button
    public func insetTop(_ unit: DimensionUnit = .dp) -> Int {
        let value = instance?.callIntMethod(name: "getInsetTop") ?? 0
        return unit.from(value)
    }
}

// TODO: getRippleColor: implement ColorStateList https://developer.android.com/reference/android/content/res/ColorStateList
// TODO: getShapeAppearanceModel: implement ShapeAppearanceModel https://developer.android.com/reference/com/google/android/material/shape/ShapeAppearanceModel
// TODO: getStrokeColor: implement ColorStateList https://developer.android.com/reference/android/content/res/ColorStateList