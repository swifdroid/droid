// MARK: Margin Layout Params
extension View {
    /// Sets the margins for the view.
    ///
    /// Defines the space between the view's edges and adjacent elements or parent container.
    @discardableResult
    public func margin(left: Int, top: Int, right: Int, bottom: Int, _ unit: DimensionUnit = .dp) -> Self {
        SetMarginsLayoutParam(value: (left, top, right, bottom, unit)).applyOrAppend(self)
    }

    /// Sets the margins for the view.
    ///
    /// Defines the space between the view's edges and adjacent elements or parent container.
    @discardableResult
    public func margin(h: Int, v: Int, _ unit: DimensionUnit = .dp) -> Self {
        margin(left: h, top: v, right: h, bottom: h, unit)
    }

    /// Sets the margins for the view.
    ///
    /// Defines the space between the view's edges and adjacent elements or parent container.
    @discardableResult
    public func margin(_ value: Int = 16, _ unit: DimensionUnit = .dp) -> Self {
        margin(left: value, top: value, right: value, bottom: value, unit)
    }

    /// Sets the start margin for the view.
    ///
    /// Defines the space between the view's start edge (left in LTR, right in RTL) and adjacent elements.
    ///
    /// - Parameters:
    ///    - value: The margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Handles RTL/LTR-aware spacing
    /// - FrameLayout: Creates RTL-aware space around children
    /// - LinearLayout: Controls RTL-aware spacing between items
    /// - RelativeLayout: Adjusts RTL-aware positioning
    /// - FlexboxLayout: Manages RTL-aware flex container spacing
    /// - GridLayout: Affects RTL-aware cell spacing
    @discardableResult
    public func startMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        StartMarginLayoutParam(value: (value, unit)).applyOrAppend(self)
    }

    /// Sets the end margin for the view.
    ///
    /// Defines the space between the view's end edge (right in LTR, left in RTL) and adjacent elements.
    ///
    /// - Parameters:
    ///    - value: The margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Handles RTL/LTR-aware spacing
    /// - FrameLayout: Creates RTL-aware space around children
    /// - LinearLayout: Controls RTL-aware spacing between items
    /// - RelativeLayout: Adjusts RTL-aware positioning
    /// - FlexboxLayout: Manages RTL-aware flex container spacing
    /// - GridLayout: Affects RTL-aware cell spacing
    @discardableResult
    public func endMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        EndMarginLayoutParam(value: (value, unit)).applyOrAppend(self)
    }
}