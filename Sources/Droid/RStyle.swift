//
//  RStyle.swift
//  Droid
//
//  Created by Mihael Isaev on 30.09.2025.
//

public struct RStyle: Sendable {
    let value: String
    let resourseId: Int32

    @MainActor
    public init(stringLiteral value: String) {
        if value.hasPrefix("@style/") {
            self.value = value
            #if os(Android)
            self.resourseId = R().style[dynamicMember: value.components(separatedBy: "@style/").joined(separator: "").components(separatedBy: ".").joined(separator: "_")]
            #else
            self.resourseId = 0
            #endif
        } else if value.contains("R.style.") {
            func cleanupRValue(_ value: String) -> String {
                value.components(separatedBy: "R.style.").joined(separator: "")
            }
            func cleanupXMLValue(_ value: String) -> String {
                cleanupRValue(value).components(separatedBy: "_").joined(separator: ".")
            }
            if value.hasPrefix("R.style.") {
                self.value = "@style/" + cleanupXMLValue(value)
                #if os(Android)
                self.resourseId = R().style.resolveAttrResId(cleanupRValue(value))
                #else
                self.resourseId = 0
                #endif
            } else {
                let parts = value.split(separator: ".R.style.")
                if
                    parts.count == 2,
                    let className = parts.first?.components(separatedBy: ".").joined(separator: "/"),
                    let rightPart = parts.last
                {
                    let styleAttribute = String(rightPart)
                    self.value = "@style/" + cleanupXMLValue(styleAttribute)
                    #if os(Android)
                    self.resourseId = R(JClassName(stringLiteral: className)).style.resolveAttrResId(styleAttribute)
                    #else
                    self.resourseId = 0
                    #endif
                } else {
                    fatalError("Unable to parse style: \(value). It should either start from @style/ or contain R.style.")
                }
            }
        } else {
            fatalError("Unable to parse style: \(value). It should either start from @style/ or contain R.style.")
        }
    }
}

extension RStyle: @MainActor ExpressibleByStringLiteral {}

extension RStyle {
    // MARK: - Custom Application Theme
    
    /// The main custom theme defined in your application's `styles.xml`.
    /// Use this for your app's primary theme that defines brand colors, typography, and overall design system.
    public static let AppTheme: Self = "@style/AppTheme"
    
    // MARK: - AppCompat Themes (Backward Compatible)
    
    /// Base AppCompat theme - provides Material Design support back to API 7.
    /// Use for maximum compatibility across Android versions.
    public static let AppCompat: Self = "androidx.appcompat.R.style.Theme_AppCompat"
    
    /// AppCompat with automatic day/night theme switching based on system settings.
    /// Use for apps that should respect system dark mode preferences.
    public static let AppCompatDayNight: Self = "androidx.appcompat.R.style.Theme_AppCompat_DayNight"
    
    /// DayNight theme with dark action bar and light content area.
    /// Use when you want dark toolbar but light main content that follows day/night cycle.
    public static let AppCompatDayNightDarkActionBar: Self = "androidx.appcompat.R.style.Theme_AppCompat_DayNight_DarkActionBar"
    
    /// Dialog styled with day/night theming.
    /// Use for dialogs that should respect system dark mode.
    public static let AppCompatDayNightDialog: Self = "androidx.appcompat.R.style.Theme_AppCompat_DayNight_Dialog"
    
    /// Alert dialog specifically styled for day/night theming.
    /// Use for alert dialogs in apps with dark mode support.
    public static let AppCompatDayNightDialogAlert: Self = "androidx.appcompat.R.style.Theme_AppCompat_DayNight_Dialog_Alert"
    
    /// Dialog with minimum width constraint and day/night theming.
    /// Use for compact dialogs that need dark mode support.
    public static let AppCompatDayNightDialogMinWidth: Self = "androidx.appcompat.R.style.Theme_AppCompat_DayNight_Dialog_MinWidth"
    
    /// Large dialog with day/night theming, typically used on larger screens.
    /// Use for expansive dialogs on tablets or large screens with dark mode.
    public static let AppCompatDayNightDialogWhenLarge: Self = "androidx.appcompat.R.style.Theme_AppCompat_DayNight_DialogWhenLarge"
    
    /// DayNight theme without action bar - full screen applications.
    /// Use for games, media apps, or full-screen experiences with dark mode support.
    public static let AppCompatDayNightNoActionBar: Self = "androidx.appcompat.R.style.Theme_AppCompat_DayNight_NoActionBar"
    
    /// Base dialog theme without day/night support.
    /// Use for dialogs in apps that don't support dark mode.
    public static let AppCompatDialog: Self = "androidx.appcompat.R.style.Theme_AppCompat_Dialog"
    
    /// Standard alert dialog theme.
    /// Use for traditional alert dialogs with AppCompat styling.
    public static let AppCompatDialogAlert: Self = "androidx.appcompat.R.style.Theme_AppCompat_Dialog_Alert"
    
    /// Dialog with constrained minimum width.
    /// Use for compact dialogs that shouldn't be too wide.
    public static let AppCompatDialogMinWidth: Self = "androidx.appcompat.R.style.Theme_AppCompat_Dialog_MinWidth"
    
    /// Large dialog for bigger screens.
    /// Use when dialogs need more space on tablets or large displays.
    public static let AppCompatDialogWhenLarge: Self = "androidx.appcompat.R.style.Theme_AppCompat_DialogWhenLarge"
    
    /// Light variant of AppCompat theme.
    /// Use for apps that prefer light theme regardless of system settings.
    public static let AppCompatLight: Self = "androidx.appcompat.R.style.Theme_AppCompat_Light"
    
    /// Light theme with dark action bar - classic Android look.
    /// Use for traditional Android apps with light content and dark toolbar.
    public static let AppCompatLightDarkActionBar: Self = "androidx.appcompat.R.style.Theme_AppCompat_Light_DarkActionBar"
    
    /// Light-themed dialog.
    /// Use for dialogs that should always be light regardless of system theme.
    public static let AppCompatLightDialog: Self = "androidx.appcompat.R.style.Theme_AppCompat_Light_Dialog"
    
    /// Light-themed alert dialog.
    /// Use for alert dialogs that should always appear in light theme.
    public static let AppCompatLightDialogAlert: Self = "androidx.appcompat.R.style.Theme_AppCompat_Light_Dialog_Alert"
    
    /// Compact light dialog with minimum width.
    /// Use for small light-themed dialogs.
    public static let AppCompatLightDialogMinWidth: Self = "androidx.appcompat.R.style.Theme_AppCompat_Light_Dialog_MinWidth"
    
    /// Large light dialog for bigger screens.
    /// Use for expansive light dialogs on tablets.
    public static let AppCompatLightDialogWhenLarge: Self = "androidx.appcompat.R.style.Theme_AppCompat_Light_DialogWhenLarge"
    
    /// Light theme without action bar.
    /// Use for full-screen light applications.
    public static let AppCompatLightNoActionBar: Self = "androidx.appcompat.R.style.Theme_AppCompat_Light_NoActionBar"
    
    /// Base AppCompat theme without action bar.
    /// Use for full-screen applications that don't need a toolbar.
    public static let AppCompatNoActionBar: Self = "androidx.appcompat.R.style.Theme_AppCompat_NoActionBar"
    
    // MARK: - Material 3 Dark Themes
    
    /// Pure dark theme using Material Design 3 (Material You).
    /// Use for apps that want pure dark aesthetic with latest Material Design.
    public static let Material3Dark: Self = "com.google.android.material.R.style.Theme_Material3_Dark"
    
    /// Dark bottom sheet dialog with Material 3 styling.
    /// Use for bottom sheet dialogs in dark themed apps.
    public static let Material3DarkBottomSheetDialog: Self = "com.google.android.material.R.style.Theme_Material3_Dark_BottomSheetDialog"
    
    /// Standard dark dialog with Material 3 design.
    /// Use for dialogs in dark Material 3 apps.
    public static let Material3DarkDialog: Self = "com.google.android.material.R.style.Theme_Material3_Dark_Dialog"
    
    /// Dark alert dialog with Material 3 styling.
    /// Use for alert dialogs in dark Material 3 apps.
    public static let Material3DarkDialogAlert: Self = "com.google.android.material.R.style.Theme_Material3_Dark_Dialog_Alert"
    
    /// Compact dark dialog with Material 3.
    /// Use for small dark dialogs with modern Material Design.
    public static let Material3DarkDialogMinWidth: Self = "com.google.android.material.R.style.Theme_Material3_Dark_Dialog_MinWidth"
    
    /// Large dark dialog for big screens with Material 3.
    /// Use for expansive dark dialogs on tablets with modern design.
    public static let Material3DarkDialogWhenLarge: Self = "com.google.android.material.R.style.Theme_Material3_Dark_DialogWhenLarge"
    
    /// Dark Material 3 theme without action bar.
    /// Use for full-screen dark apps with latest Material Design.
    public static let Material3DarkNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3_Dark_NoActionBar"
    
    /// Dark side sheet dialog (emerging from side) with Material 3.
    /// Use for navigation drawers or side panels in dark apps.
    public static let Material3DarkSideSheetDialog: Self = "com.google.android.material.R.style.Theme_Material3_Dark_SideSheetDialog"
    
    // MARK: - Material 3 DayNight Themes
    
    /// Material Design 3 with automatic day/night switching.
    /// Use for modern apps that want Material You with dark mode support.
    public static let Material3DayNight: Self = "com.google.android.material.R.style.Theme_Material3_DayNight"
    
    /// DayNight bottom sheet dialog with Material 3.
    /// Use for bottom sheets that respect system dark mode.
    public static let Material3DayNightBottomSheetDialog: Self = "com.google.android.material.R.style.Theme_Material3_DayNight_BottomSheetDialog"
    
    /// DayNight dialog with Material 3 design.
    /// Use for dialogs that follow system dark mode with modern design.
    public static let Material3DayNightDialog: Self = "com.google.android.material.R.style.Theme_Material3_DayNight_Dialog"
    
    /// DayNight alert dialog with Material 3.
    /// Use for alert dialogs that respect system theme with modern design.
    public static let Material3DayNightDialogAlert: Self = "com.google.android.material.R.style.Theme_Material3_DayNight_Dialog_Alert"
    
    /// Compact DayNight dialog with Material 3.
    /// Use for small dialogs that follow system dark mode.
    public static let Material3DayNightDialogMinWidth: Self = "com.google.android.material.R.style.Theme_Material3_DayNight_Dialog_MinWidth"
    
    /// Large DayNight dialog for big screens with Material 3.
    /// Use for expansive dialogs on tablets that respect system theme.
    public static let Material3DayNightDialogWhenLarge: Self = "com.google.android.material.R.style.Theme_Material3_DayNight_DialogWhenLarge"
    
    /// DayNight Material 3 without action bar.
    /// Use for full-screen apps with Material You and dark mode support.
    public static let Material3DayNightNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3_DayNight_NoActionBar"
    
    /// DayNight side sheet dialog with Material 3.
    /// Use for navigation drawers that respect system dark mode.
    public static let Material3DayNightSideSheetDialog: Self = "com.google.android.material.R.style.Theme_Material3_DayNight_SideSheetDialog"
    
    // MARK: - Material 3 Dynamic Colors Themes
    
    /// Dark theme with dynamic color theming (Material You).
    /// Use for apps that want to adapt to user's wallpaper colors in dark mode.
    public static let Material3DynamicColorsDark: Self = "com.google.android.material.R.style.Theme_Material3_DynamicColors_Dark"
    
    /// Dark dynamic colors theme without action bar.
    /// Use for full-screen apps that adapt to wallpaper in dark mode.
    public static let Material3DynamicColorsDarkNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3_DynamicColors_Dark_NoActionBar"
    
    /// DayNight theme with dynamic color theming.
    /// Use for apps that adapt to wallpaper colors and respect system dark mode.
    public static let Material3DynamicColorsDayNight: Self = "com.google.android.material.R.style.Theme_Material3_DynamicColors_DayNight"
    
    /// DayNight dynamic colors without action bar.
    /// Use for full-screen apps with wallpaper adaptation and dark mode support.
    public static let Material3DynamicColorsDayNightNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3_DynamicColors_DayNight_NoActionBar"
    
    /// Light theme with dynamic color theming.
    /// Use for apps that adapt to user's wallpaper colors in light mode.
    public static let Material3DynamicColorsLight: Self = "com.google.android.material.R.style.Theme_Material3_DynamicColors_Light"
    
    /// Light dynamic colors theme without action bar.
    /// Use for full-screen apps that adapt to wallpaper in light mode.
    public static let Material3DynamicColorsLightNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3_DynamicColors_Light_NoActionBar"
    
    // MARK: - Material 3 Light Themes
    
    /// Pure light theme using Material Design 3.
    /// Use for apps that want pure light aesthetic with latest Material Design.
    public static let Material3Light: Self = "com.google.android.material.R.style.Theme_Material3_Light"
    
    /// Light bottom sheet dialog with Material 3.
    /// Use for bottom sheet dialogs in light themed apps.
    public static let Material3LightBottomSheetDialog: Self = "com.google.android.material.R.style.Theme_Material3_Light_BottomSheetDialog"
    
    /// Standard light dialog with Material 3.
    /// Use for dialogs in light Material 3 apps.
    public static let Material3LightDialog: Self = "com.google.android.material.R.style.Theme_Material3_Light_Dialog"
    
    /// Light alert dialog with Material 3.
    /// Use for alert dialogs in light Material 3 apps.
    public static let Material3LightDialogAlert: Self = "com.google.android.material.R.style.Theme_Material3_Light_Dialog_Alert"
    
    /// Compact light dialog with Material 3.
    /// Use for small light dialogs with modern Material Design.
    public static let Material3LightDialogMinWidth: Self = "com.google.android.material.R.style.Theme_Material3_Light_Dialog_MinWidth"
    
    /// Large light dialog for big screens with Material 3.
    /// Use for expansive light dialogs on tablets with modern design.
    public static let Material3LightDialogWhenLarge: Self = "com.google.android.material.R.style.Theme_Material3_Light_DialogWhenLarge"
    
    /// Light Material 3 theme without action bar.
    /// Use for full-screen light apps with latest Material Design.
    public static let Material3LightNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3_Light_NoActionBar"
    
    /// Light side sheet dialog with Material 3.
    /// Use for navigation drawers or side panels in light apps.
    public static let Material3LightSideSheetDialog: Self = "com.google.android.material.R.style.Theme_Material3_Light_SideSheetDialog"
    
    // MARK: - Material 3 Expressive Themes (New Design Language)
    
    /// Expressive design language - dark variant with more dynamic shapes and motion.
    /// Use for apps wanting more playful, dynamic appearance in dark mode.
    public static let Material3ExpressiveDark: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Dark"
    
    /// Expressive dark dialog with dynamic design elements.
    /// Use for dialogs with expressive design in dark mode.
    public static let Material3ExpressiveDarkDialog: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Dark_Dialog"
    
    /// Expressive dark alert dialog.
    /// Use for alert dialogs with expressive styling in dark mode.
    public static let Material3ExpressiveDarkDialogAlert: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Dark_Dialog_Alert"
    
    /// Compact expressive dark dialog.
    /// Use for small dialogs with expressive design in dark mode.
    public static let Material3ExpressiveDarkDialogMinWidth: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Dark_Dialog_MinWidth"
    
    /// Large expressive dark dialog for big screens.
    /// Use for expansive dialogs with expressive design on tablets in dark mode.
    public static let Material3ExpressiveDarkDialogWhenLarge: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Dark_DialogWhenLarge"
    
    /// Expressive dark theme without action bar.
    /// Use for full-screen apps with expressive design in dark mode.
    public static let Material3ExpressiveDarkNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Dark_NoActionBar"
    
    /// Expressive design with DayNight support.
    /// Use for apps wanting expressive design that respects system dark mode.
    public static let Material3ExpressiveDayNight: Self = "com.google.android.material.R.style.Theme_Material3Expressive_DayNight"
    
    /// Large expressive DayNight dialog for big screens.
    /// Use for expansive dialogs with expressive design on tablets that respect system theme.
    public static let Material3ExpressiveDayNightDialogWhenLarge: Self = "com.google.android.material.R.style.Theme_Material3Expressive_DayNight_DialogWhenLarge"
    
    /// Expressive DayNight theme without action bar.
    /// Use for full-screen apps with expressive design and dark mode support.
    public static let Material3ExpressiveDayNightNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3Expressive_DayNight_NoActionBar"
    
    // MARK: - Material 3 Expressive Dynamic Colors Themes
    
    /// Expressive dark theme with dynamic color adaptation.
    /// Use for apps wanting expressive design that adapts to wallpaper in dark mode.
    public static let Material3ExpressiveDynamicColorsDark: Self = "com.google.android.material.R.style.Theme_Material3Expressive_DynamicColors_Dark"
    
    /// Expressive dark dynamic colors without action bar.
    /// Use for full-screen apps with expressive design and wallpaper adaptation in dark mode.
    public static let Material3ExpressiveDynamicColorsDarkNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3Expressive_DynamicColors_Dark_NoActionBar"
    
    /// Expressive DayNight theme with dynamic colors.
    /// Use for apps with expressive design that adapt to wallpaper and respect system theme.
    public static let Material3ExpressiveDynamicColorsDayNight: Self = "com.google.android.material.R.style.Theme_Material3Expressive_DynamicColors_DayNight"
    
    /// Expressive DayNight dynamic colors without action bar.
    /// Use for full-screen apps with expressive design, wallpaper adaptation, and dark mode support.
    public static let Material3ExpressiveDynamicColorsDayNightNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3Expressive_DynamicColors_DayNight_NoActionBar"
    
    /// Expressive light theme with dynamic color adaptation.
    /// Use for apps wanting expressive design that adapts to wallpaper in light mode.
    public static let Material3ExpressiveDynamicColorsLight: Self = "com.google.android.material.R.style.Theme_Material3Expressive_DynamicColors_Light"
    
    /// Expressive light dynamic colors without action bar.
    /// Use for full-screen apps with expressive design and wallpaper adaptation in light mode.
    public static let Material3ExpressiveDynamicColorsLightNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3Expressive_DynamicColors_Light_NoActionBar"
    
    // MARK: - Material 3 Expressive Light Themes
    
    /// Expressive design language - light variant.
    /// Use for apps wanting more playful, dynamic appearance in light mode.
    public static let Material3ExpressiveLight: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Light"
    
    /// Expressive light dialog.
    /// Use for dialogs with expressive design in light mode.
    public static let Material3ExpressiveLightDialog: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Light_Dialog"
    
    /// Expressive light alert dialog.
    /// Use for alert dialogs with expressive styling in light mode.
    public static let Material3ExpressiveLightDialogAlert: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Light_Dialog_Alert"
    
    /// Compact expressive light dialog.
    /// Use for small dialogs with expressive design in light mode.
    public static let Material3ExpressiveLightDialogMinWidth: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Light_Dialog_MinWidth"
    
    /// Large expressive light dialog for big screens.
    /// Use for expansive dialogs with expressive design on tablets in light mode.
    public static let Material3ExpressiveLightDialogWhenLarge: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Light_DialogWhenLarge"
    
    /// Expressive light theme without action bar.
    /// Use for full-screen apps with expressive design in light mode.
    public static let Material3ExpressiveLightNoActionBar: Self = "com.google.android.material.R.style.Theme_Material3Expressive_Light_NoActionBar"
}