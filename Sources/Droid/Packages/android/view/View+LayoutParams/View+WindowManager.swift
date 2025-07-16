// MARK: WindowManager - Layout Params
extension View {
    // MARK: Window Type & Flags

    /// Sets the window type for system window management.
    ///
    /// Determines the window's z-ordering and overlay behavior.
    ///
    /// - Parameters:
    ///   - value: Window type constant (TYPE_APPLICATION, TYPE_SYSTEM_ALERT, etc.)
    ///
    /// Supported layouts:
    /// - WindowManager: Exclusive window type control
    @discardableResult
    public func type(_ value: Int32) -> Self { // TODO: Window type constant
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.type(value)) // TODO: Window type constant
        }
        return self
    }

    /// Sets the window behavior flags.
    ///
    /// Controls window characteristics like focusability and touch behavior.
    ///
    /// - Parameters:
    ///   - value: Bitmask of FLAG_* constants
    ///
    /// Supported layouts:
    /// - WindowManager: Exclusive window flag control
    @discardableResult
    public func flags(_ value: String) -> Self { // TODO: bitmask
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.flags) // TODO: bitmask
        }
        return self
    }

    /// Sets the private window behavior flags.
    ///
    /// Controls internal window manager behavior and optimizations.
    ///
    /// - Parameters:
    ///   - value: Bitmask of PRIVATE_FLAG_* constants
    ///
    /// Supported layouts:
    /// - WindowManager: Exclusive private flag control
    @discardableResult
    public func privateFlags(_ value: String) -> Self { // TODO: bitmask
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.privateFlags) // TODO: bitmask
        }
        return self
    }

    // MARK: Visual Effects

    /// Sets the dim amount behind the window.
    ///
    /// Controls how much the content behind the window is dimmed.
    ///
    /// - Parameters:
    ///   - value: Dim amount (0.0 to 1.0)
    ///
    /// Supported layouts:
    /// - WindowManager: Exclusive dimming control
    /// - DialogLayout: Similar dimming behavior for dialogs
    @discardableResult
    public func dimAmount(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.dimAmount(value))
        }
        return self
    }

    /// Sets the window transparency.
    ///
    /// Controls the opacity of the entire window.
    ///
    /// - Parameters:
    ///   - value: Alpha value (0.0 to 1.0)
    ///
    /// Supported layouts:
    /// - WindowManager: Primary window transparency control
    /// - ViewGroup: Affects view hierarchy transparency
    @discardableResult
    public func alpha(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alpha(value))
        }
        return self
    }

    /// Sets the window animation style.
    ///
    /// Defines the enter/exit animations for the window.
    ///
    /// - Parameters:
    ///   - value: Animation style resource ID
    ///
    /// Supported layouts:
    /// - WindowManager: Exclusive window animation control
    /// - Activity: Similar transition animation concepts
    @discardableResult
    public func windowAnimations(_ value: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.windowAnimations(value))
        }
        return self
    }

    /// Sets the window rotation in degrees.
    ///
    /// Rotates the window's content around its pivot point.
    ///
    /// - Parameters:
    ///   - value: Rotation angle in degrees
    ///
    /// Supported layouts:
    /// - WindowManager: Primary window rotation control
    /// - View: Similar view-level rotation
    @discardableResult
    public func rotation(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.rotation(value))
        }
        return self
    }

    // MARK: Input & Focus

    /// Sets the soft input mode behavior.
    ///
    /// Controls how the window interacts with the soft keyboard.
    ///
    /// - Parameters:
    ///   - value: SOFT_INPUT_* constant
    ///
    /// Supported layouts:
    /// - WindowManager: Exclusive input mode control
    /// - Dialog: Similar keyboard interaction behavior
    @discardableResult
    public func softInputMode(_ value: Int32) -> Self { // TODO:: type enum
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.softInputMode(value)) // TODO:: type enum
        }
        return self
    }

    /// Sets the preferred screen orientation.
    ///
    /// Requests a specific orientation for the window.
    ///
    /// - Parameters:
    ///   - value: SCREEN_ORIENTATION_* constant
    ///
    /// Supported layouts:
    /// - WindowManager: Exclusive orientation control
    /// - Activity: Similar orientation request behavior
    @discardableResult
    public func screenOrientation(_ value: Int32) -> Self { // TODO: type enum
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.screenOrientation(value)) // TODO: type enum
        }
        return self
    }

    /// Sets the preferred display refresh rate.
    ///
    /// Requests a specific refresh rate for the window.
    ///
    /// - Parameters:
    ///   - value: Refresh rate in Hz
    ///
    /// Supported layouts:
    /// - WindowManager: Exclusive refresh rate control
    @discardableResult
    public func preferredRefreshRate(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.preferredRefreshRate(value))
        }
        return self
    }

    // MARK: System UI Control

    /// Sets the system UI visibility flags.
    ///
    /// Controls decor elements like status/navigation bars.
    ///
    /// - Parameters:
    ///   - value: SYSTEM_UI_FLAG_* bitmask
    ///
    /// Supported layouts:
    /// - WindowManager: Primary system UI control
    /// - View: Similar system UI visibility flags
    @discardableResult
    public func systemUiVisibility(_ value: Int32) -> Self { // TODO: type enum
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.systemUiVisibility(value)) // TODO: type enum
        }
        return self
    }

    /// Sets which inset types the window should fit.
    ///
    /// Controls how the window avoids system UI elements.
    ///
    /// - Parameters:
    ///   - value: Bitmask of inset types
    ///
    /// Supported layouts:
    /// - WindowManager: Exclusive inset behavior control
    @discardableResult
    public func fitInsetsTypes(_ value: Int32) -> Self { // TODO: type enum bitmask
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.fitInsetsTypes(value)) // TODO: type enum bitmask
        }
        return self
    }

    /// Sets the display cutout handling mode.
    ///
    /// Controls how the window interacts with screen notches.
    ///
    /// - Parameters:
    ///   - value: LAYOUT_IN_DISPLAY_CUTOUT_MODE_* constant
    ///
    /// Supported layouts:
    /// - WindowManager: Exclusive cutout mode control
    @discardableResult
    public func layoutInDisplayCutoutMode(_ value: Int32) -> Self { // TODO: type enum
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.layoutInDisplayCutoutMode(value)) // TODO: type enum
        }
        return self
    }
}