// MARK: Margin Layout Params
extension View {
    /// Sets the margins for the view.
    ///
    /// Defines the space between the view's top edge and adjacent elements or parent container.
    ///
    /// - Parameters:
    ///    - left: The left margin size in density-independent pixels
    ///    - top: The top margin size in density-independent pixels
    ///    - right: The right margin size in density-independent pixels
    ///    - bottom: The bottom margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Affects constraint-based spacing
    /// - FrameLayout: Creates space around child views
    /// - LinearLayout: Controls spacing between linear items
    /// - RelativeLayout: Adjusts view positioning relative to others
    /// - CoordinatorLayout: Manages view offsets in coordination
    /// - FlexboxLayout: Controls spacing in flex container
    /// - GridLayout: Affects cell spacing
    /// - TableLayout: Manages cell margins
    @discardableResult
    public func margins(_ left: Int, _ top: Int, _ right: Int, _ bottom: Int, _ unit: DimensionUnit = .dp) -> Self {
        SetMarginsLayoutParam(value: (left, top, right, bottom, unit)).applyOrAppend(self)
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