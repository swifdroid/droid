// MARK: ViewGroup - Layout Params
extension View {
    /// Sets the width of the view with flexible sizing options.
    ///
    /// Controls the view's width using either exact measurements or special sizing modes.
    ///
    /// - Parameters:
    ///    - value: Width in density-independent pixels, or: .matchParent, .wrapContent
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - ViewGroup: Base width control for all layouts
    /// - AbsoluteLayout: Uses exact pixel measurements
    /// - ConstraintLayout: Works with constraint-based sizing
    /// - FlexboxLayout: Controls main axis sizing in flex container
    /// - FrameLayout: Affects child view dimensions
    /// - LinearLayout: Influences weighted width distribution
    /// - RelativeLayout: Determines view positioning bounds
    /// - TableLayout: Governs cell column width
    /// - GridLayout: Controls grid item width
    /// - CoordinatorLayout: Affects anchored view dimensions
    /// - PercentFrameLayout: Percentage-based width calculation
    /// - PercentRelativeLayout: Percentage width relative to parent
    @discardableResult
    public func width(_ value: LayoutParams.LayoutSize, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.width(value, unit))
        }
        return self
    }

    /// Sets the height of the view with flexible sizing options.
    ///
    /// Controls the view's height using either exact measurements or special sizing modes.
    ///
    /// - Parameters:
    ///    - value: Height in density-independent pixels, or: .matchParent, .wrapContent
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - ViewGroup: Base height control for all layouts
    /// - AbsoluteLayout: Uses exact pixel measurements
    /// - ConstraintLayout: Works with constraint-based sizing
    /// - FlexboxLayout: Controls cross axis sizing in flex container
    /// - FrameLayout: Affects child view dimensions
    /// - LinearLayout: Influences weighted height distribution
    /// - RelativeLayout: Determines view positioning bounds
    /// - TableLayout: Governs cell row height
    /// - GridLayout: Controls grid item height
    /// - CoordinatorLayout: Affects anchored view dimensions
    /// - PercentFrameLayout: Percentage-based height calculation
    /// - PercentRelativeLayout: Percentage height relative to parent
    @discardableResult
    public func height(_ value: LayoutParams.LayoutSize, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.height(value, unit))
        }
        return self
    }
}