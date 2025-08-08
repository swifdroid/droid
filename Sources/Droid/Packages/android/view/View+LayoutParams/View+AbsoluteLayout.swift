// MARK: AbsoluteLayout - Layout Params
extension View {
    /// Sets the absolute X coordinate position of the view.
    ///
    /// Positions the view horizontally relative to its parent container's left edge.
    ///
    /// - Parameters:
    ///    - value: The horizontal position value in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - AbsoluteLayout: Direct pixel-perfect positioning
    /// - ActionMenuView: Positions overflow menu items absolutely
    /// - FrameLayout: Works with absolute child positioning
    /// - PercentFrameLayout: Supports percentage-based X positioning
    /// - WindowManager: Controls window placement in screen coordinates
    @discardableResult
    public func x(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(XLayoutParam(value: (value, unit)))
        }
        return self
    }

    /// Sets the absolute Y coordinate position of the view.
    ///
    /// Positions the view vertically relative to its parent container's top edge.
    ///
    /// - Parameters:
    ///    - value: The vertical position value in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - AbsoluteLayout: Direct pixel-perfect positioning
    /// - ActionMenuView: Positions overflow menu items absolutely
    /// - FrameLayout: Works with absolute child positioning
    /// - PercentFrameLayout: Supports percentage-based Y positioning
    /// - WindowManager: Controls window placement in screen coordinates
    @discardableResult
    public func y(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(YLayoutParam(value: (value, unit)))
        }
        return self
    }
}