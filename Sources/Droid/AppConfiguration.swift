public final class AppConfiguration: Sendable {
    public enum Field: Sendable {
        case orientation
        case densityDpi
        case fontScale
        case uiMode
        case screenWidthDp
        case screenHeightDp
        case smallestScreenWidthDp
        case layoutDirection
        case colorMode
        case touchscreen
        case keyboard
        case keyboardHidden
        case hardKeyboardHidden
        case navigation
        case navigationHidden
        case mcc
        case mnc
        case screenLayout
        case grammaticalGender
        case displayMetricsDensityDpi
        case displayMetricsWidthPixels
        case displayMetricsHeightPixels
        case displayMetricsXdpi
        case displayMetricsYdpi
        case displayMetricsDensity
        case displayMetricsScaledDensity
    }

    private final class Values: @unchecked Sendable {
        // Basic display metrics
        var orientation: Orientation = .undefined
        var densityDpi: Int32 = 0
        var fontScale: Float = 0
        var uiMode: Int32 = 0
        // Screen dimensions
        var screenWidthDp: Int32 = 0
        var screenHeightDp: Int32 = 0
        var smallestScreenWidthDp: Int32 = 0
        // Layout direction
        var layoutDirection: Int32 = 0
        // Color mode
        var colorMode: Int32 = 0
        // Touchscreen
        var touchscreen: Int32 = 0
        // Keyboard/input
        var keyboard: Int32 = 0
        var keyboardHidden: Int32 = 0
        var hardKeyboardHidden: Int32 = 0
        var navigation: Int32 = 0
        var navigationHidden: Int32 = 0
        // Misc flags
        var mcc: Int32 = 0
        var mnc: Int32 = 0
        var screenLayout: Int32 = 0
        var grammaticalGender: Int32 = 0
        // Display Metrics
        var displayMetricsDensityDpi: Int32 = 0
        var displayMetricsWidthPixels: Int32 = 0
        var displayMetricsHeightPixels: Int32 = 0
        var displayMetricsXdpi: Float = 0
        var displayMetricsYdpi: Float = 0
        var displayMetricsDensity: Float = 0
        var displayMetricsScaledDensity: Float = 0

        init (_ array: [Int32]? = nil) {
            if let array {
                update(array)
            }
        }

        @discardableResult
        func update(_ array: [Int32]) -> [Field] {
            var updatedFields: Set<Field> = []
            for i in 0...25 {
                let newValue: Int32 = array[i]
                switch i {
                case 0:
                    let newValue = Orientation(rawValue: newValue) ?? .undefined
                    if orientation != newValue {
                        updatedFields.insert(.orientation)
                    }
                    orientation = newValue
                case 1:
                    if densityDpi != newValue {
                        updatedFields.insert(.densityDpi)
                    }
                    densityDpi = newValue
                case 2:
                    let newValue = Float(newValue) / 1000
                    if fontScale != newValue {
                        updatedFields.insert(.fontScale)
                    }
                    fontScale = newValue
                case 3:
                    if uiMode != newValue {
                        updatedFields.insert(.uiMode)
                    }
                    uiMode = newValue
                case 4:
                    if screenWidthDp != newValue {
                        updatedFields.insert(.screenWidthDp)
                    }
                    screenWidthDp = newValue
                case 5:
                    if screenHeightDp != newValue {
                        updatedFields.insert(.screenHeightDp)
                    }
                    screenHeightDp = newValue
                case 6:
                    if smallestScreenWidthDp != newValue {
                        updatedFields.insert(.smallestScreenWidthDp)
                    }
                    smallestScreenWidthDp = newValue
                case 7:
                    if layoutDirection != newValue {
                        updatedFields.insert(.layoutDirection)
                    }
                    layoutDirection = newValue
                case 8:
                    if colorMode != newValue {
                        updatedFields.insert(.colorMode)
                    }
                    colorMode = newValue
                case 9:
                    if touchscreen != newValue {
                        updatedFields.insert(.touchscreen)
                    }
                    touchscreen = newValue
                case 10:
                    if keyboard != newValue {
                        updatedFields.insert(.keyboard)
                    }
                    keyboard = newValue
                case 11:
                    if keyboardHidden != newValue {
                        updatedFields.insert(.keyboardHidden)
                    }
                    keyboardHidden = newValue
                case 12:
                    if hardKeyboardHidden != newValue {
                        updatedFields.insert(.hardKeyboardHidden)
                    }
                    hardKeyboardHidden = newValue
                case 13:
                    if navigation != newValue {
                        updatedFields.insert(.navigation)
                    }
                    navigation = newValue
                case 14:
                    if navigationHidden != newValue {
                        updatedFields.insert(.navigationHidden)
                    }
                    navigationHidden = newValue
                case 15:
                    if mcc != newValue {
                        updatedFields.insert(.mcc)
                    }
                    mcc = newValue
                case 16:
                    if mnc != newValue {
                        updatedFields.insert(.mnc)
                    }
                    mnc = newValue
                case 17:
                    if screenLayout != newValue {
                        updatedFields.insert(.screenLayout)
                    }
                    screenLayout = newValue
                case 18:
                    if grammaticalGender != newValue {
                        updatedFields.insert(.grammaticalGender)
                    }
                    grammaticalGender = newValue
                case 19:
                    if displayMetricsDensityDpi != newValue {
                        updatedFields.insert(.displayMetricsDensityDpi)
                    }
                    displayMetricsDensityDpi = newValue
                case 20:
                    if displayMetricsWidthPixels != newValue {
                        updatedFields.insert(.displayMetricsWidthPixels)
                    }
                    displayMetricsWidthPixels = newValue
                case 21:
                    if displayMetricsHeightPixels != newValue {
                        updatedFields.insert(.displayMetricsHeightPixels)
                    }
                    displayMetricsHeightPixels = newValue
                case 22:
                    let newValue = Float(newValue) / 1000
                    if displayMetricsXdpi != newValue {
                        updatedFields.insert(.displayMetricsXdpi)
                    }
                    displayMetricsXdpi = newValue
                case 23:
                    let newValue = Float(newValue) / 1000
                    if displayMetricsYdpi != newValue {
                        updatedFields.insert(.displayMetricsYdpi)
                    }
                    displayMetricsYdpi = newValue
                case 24:
                    let newValue = Float(newValue) / 1000
                    if displayMetricsDensity != newValue {
                        updatedFields.insert(.displayMetricsDensity)
                    }
                    displayMetricsDensity = newValue
                case 25:
                    let newValue = Float(newValue) / 1000
                    if displayMetricsScaledDensity != newValue {
                        updatedFields.insert(.displayMetricsScaledDensity)
                    }
                    displayMetricsScaledDensity = newValue
                default: break
                }
            }
            return Array(updatedFields)
        }
    }

    init () {}

    func update(_ new: [Int32]) -> [Field] {
        values.update(new)
    }

    // MARK: - Properties
    
    // MARK: Orientation

    public enum Orientation: Int32, Sendable {
        case undefined, portrait, landscape, square
    }

    private let values = Values()
    
    // MARK: Basic display metrics

    var orientation: Orientation { values.orientation }
    var densityDpi: Int32 { values.densityDpi }
    var fontScale: Float { values.fontScale }
    var uiMode: Int32 { values.uiMode }
    
    // MARK: Screen dimensions
    
    var screenWidthDp: Int32 { values.screenWidthDp }
    var screenHeightDp: Int32 { values.screenHeightDp }
    var smallestScreenWidthDp: Int32 { values.smallestScreenWidthDp }
    
    // MARK: Layout direction
    
    var layoutDirection: Int32 { values.layoutDirection }
    
    // MARK: Color mode
    
    var colorMode: Int32 { values.colorMode }
    
    // MARK: Touchscreen
    
    var touchscreen: Int32 { values.touchscreen }
    
    // MARK: Keyboard/input
    
    var keyboard: Int32 { values.keyboard }
    var keyboardHidden: Int32 { values.keyboardHidden }
    var hardKeyboardHidden: Int32 { values.hardKeyboardHidden }
    var navigation: Int32 { values.navigation }
    var navigationHidden: Int32 { values.navigationHidden }
    
    // MARK: Misc flags
    
    var mcc: Int32 { values.mcc }
    var mnc: Int32 { values.mnc }
    var screenLayout: Int32 { values.screenLayout }
    var grammaticalGender: Int32 { values.grammaticalGender }
    
    // MARK: Display Metrics
    
    var displayMetricsDensityDpi: Int32 { values.displayMetricsDensityDpi }
    var displayMetricsWidthPixels: Int32 { values.displayMetricsWidthPixels }
    var displayMetricsHeightPixels: Int32 { values.displayMetricsHeightPixels }
    var displayMetricsXdpi: Float { values.displayMetricsXdpi }
    var displayMetricsYdpi: Float { values.displayMetricsYdpi }
    var displayMetricsDensity: Float { values.displayMetricsDensity }
    var displayMetricsScaledDensity: Float { values.displayMetricsScaledDensity }
    
    
    // var isNightMode: Bool {
    //     let nightMask = getStaticIntField(className: "android/content/res/Configuration", 
    //                                     fieldName: "UI_MODE_NIGHT_MASK", 
    //                                     sig: "I")
    //     let nightYes = getStaticIntField(className: "android/content/res/Configuration", 
    //                                    fieldName: "UI_MODE_NIGHT_YES", 
    //                                    sig: "I")
    //     return (uiMode & nightMask) == nightYes
    // }
}