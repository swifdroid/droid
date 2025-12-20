//
//  WindowCompat.swift
//  Droid
//
//  Created by Mihael Isaev on 20.11.2025.
//

/// Helper for accessing features in Window.
/// 
/// [Learn more](https://developer.android.com/reference/androidx/core/view/WindowCompat)
@MainActor
public final class WindowCompat: JObjectable, @unchecked Sendable {
    /// The JNI class name
    nonisolated public static let className: JClassName = "androidx/core/view/WindowCompat"

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension WindowCompat {
    public enum Feature: Int32 {
        /// Flag for enabling the Action Bar.
        case actionBar = 8
        /// Flag for requesting an Action Bar that overlays window content.
        case actionBarOverlay = 9
        /// Flag for specifying the behavior of action modes when an Action Bar is not present.
        case actionModeOverlay = 10
    }
}

extension WindowCompat {
    /// Enables the content of the given window to reach the edges of the window
    /// without getting inset by system insets, and prevents the framework
    /// from placing color views behind system bars.
    // public static func enableEdgeToEdge(_ window: Window) {
    //     guard
    //         let clazz = JClass.load(WindowCompat.className)
    //     else { return }
    //     clazz.staticVoidMethod(
    //         name: "enableEdgeToEdge",
    //         args: window.signed(as: Window.className)
    //     )
    // } // enable when API 36 will be available

    // TODO: getInsetsController

    /// Sets whether the decor view should fit root-level content views for WindowInsetsCompat.
    /// 
    /// If set to false, the framework will not fit the content view to the insets
    /// and will just pass through the `WindowInsetsCompat` to the content view.
    /// 
    /// Please note: using the `setSystemUiVisibility` API in your app can conflict
    /// with this method. Please discontinue use of `setSystemUiVisibility`.
    public static func decorFitsSystemWindows(_ window: Window, _ decorFitsSystemWindows: Bool = true) {
        guard
            let clazz = JClass.load(WindowCompat.className)
        else { return }
        clazz.staticVoidMethod(
            name: "setDecorFitsSystemWindows",
            args: window.signed(as: Window.className), decorFitsSystemWindows
        )
    }
}