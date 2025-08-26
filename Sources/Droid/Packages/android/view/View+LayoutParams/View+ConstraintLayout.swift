// MARK: ConstraintLayout - Layout Params
extension View {
    // MARK: Directional Constraints

    /// Constrains the view's left edge to another view's left edge.
    ///
    /// Creates a horizontal alignment constraint between left edges of views.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func leftToLeft(_ id: Int32 = 0) -> Self {
        LeftToLeftLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's left edge to another view's left edge.
    ///
    /// Creates a horizontal alignment constraint between left edge of the view and left edge of the parent.
    @discardableResult
    public func leftToParent() -> Self {
        LeftToLeftLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's left edge to another view's right edge.
    ///
    /// Positions the view's left edge adjacent to another view's right edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func leftToRight(_ id: Int32 = 0) -> Self {
        LeftToRightLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's left edge to another view's right edge.
    ///
    /// Positions the view's left edge adjacent to parent's right edge.
    @discardableResult
    public func leftToParentRight() -> Self {
        LeftToRightLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's right edge to another view's left edge.
    ///
    /// Positions the view's right edge adjacent to another view's left edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func rightToLeft(_ id: Int32 = 0) -> Self {
        RightToLeftLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's right edge to another view's left edge.
    ///
    /// Positions the view's right edge adjacent to parent's left edge.
    @discardableResult
    public func rightToParentLeft() -> Self {
        RightToLeftLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's right edge to another view's right edge.
    ///
    /// Creates a horizontal alignment constraint between right edges of views.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func rightToRight(_ id: Int32 = 0) -> Self {
        RightToRightLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's right edge to another view's right edge.
    ///
    /// Creates a horizontal alignment constraint between right edge of the view and right edge of the parent.
    @discardableResult
    public func rightToParent() -> Self {
        RightToRightLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's top edge to another view's top edge.
    ///
    /// Creates a vertical alignment constraint between top edges of views.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func topToTop(_ id: Int32 = 0) -> Self {
        TopToTopLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's top edge to another view's top edge.
    ///
    /// Creates a vertical alignment constraint between top edge of view and parent's top edge.
    @discardableResult
    public func topToParent() -> Self {
        TopToTopLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's top edge to another view's bottom edge.
    ///
    /// Positions the view's top edge adjacent to another view's bottom edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func topToBottom(_ id: Int32 = 0) -> Self {
        TopToBottomLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's top edge to another view's bottom edge.
    ///
    /// Positions the view's top edge adjacent to parent's bottom edge.
    @discardableResult
    public func topToParentBottom() -> Self {
        TopToBottomLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's bottom edge to another view's top edge.
    ///
    /// Positions the view below another view with bottom edge touching its top edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func bottomToTop(_ id: Int32 = 0) -> Self {
        BottomToTopLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's bottom edge to another view's top edge.
    ///
    /// Positions the view below parent view with bottom edge touching its top edge.
    @discardableResult
    public func bottomToParentTop() -> Self {
        BottomToTopLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's bottom edge to another view's bottom edge.
    ///
    /// Aligns the bottom edges of both views vertically.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func bottomToBottom(_ id: Int32 = 0) -> Self {
        BottomToBottomLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's bottom edge to another view's bottom edge.
    ///
    /// Aligns the bottom edge to parent's bottom edge.
    @discardableResult
    public func bottomToParent() -> Self {
        BottomToBottomLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's start edge to another view's start edge.
    ///
    /// Aligns the leading edges (left in LTR, right in RTL) of both views.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func startToStart(_ id: Int32 = 0) -> Self {
        StartToStartLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's start edge to another view's start edge.
    ///
    /// Aligns the leading edge to parent's leading edge (left in LTR, right in RTL).
    @discardableResult
    public func startToParent() -> Self {
        StartToStartLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's start edge to another view's end edge.
    ///
    /// Positions view's start edge adjacent to another view's end edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func startToEnd(_ id: Int32 = 0) -> Self {
        StartToEndLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's start edge to another view's end edge.
    ///
    /// Positions view's start edge adjacent to parent's end edge.
    @discardableResult
    public func startToParentEnd() -> Self {
        StartToEndLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's end edge to another view's start edge.
    ///
    /// Positions view's end edge adjacent to another view's start edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func endToStart(_ id: Int32 = 0) -> Self {
        EndToStartLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's end edge to another view's start edge.
    ///
    /// Positions view's end edge adjacent to parent's start edge.
    @discardableResult
    public func endToParentStart() -> Self {
        EndToStartLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's end edge to another view's end edge.
    ///
    /// Aligns the trailing edges (right in LTR, left in RTL) of both views.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func endToEnd(_ id: Int32 = 0) -> Self {
        EndToEndLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's end edge to another view's end edge.
    ///
    /// Aligns the trailing edge to parent's trailing edge (right in LTR, left in RTL).
    @discardableResult
    public func endToParent() -> Self {
        EndToEndLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Constrains the view's baseline to another view's baseline.
    ///
    /// Aligns text baselines of both views vertically.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to, or leave blank to constrain to parent
    @discardableResult
    public func baselineToBaseline(_ id: Int32 = 0) -> Self {
        BaselineToBaselineLayoutParam(value: id).applyOrAppend(self)
    }

    /// Constrains the view's baseline to another view's baseline.
    ///
    /// Aligns text baseline to parent's baseline.
    @discardableResult
    public func baselineToParent() -> Self {
        BaselineToBaselineLayoutParam(value: 0).applyOrAppend(self)
    }

    // MARK: Dimensions

    /// Matches the view's default width to another view's width.
    ///
    /// Sets the view's width to match the referenced view's width by default.
    ///
    /// - Parameters:
    ///   - id: The view ID to match width with, or leave blank to constrain to parent
    @discardableResult
    public func matchConstraintDefaultWidth(_ id: Int32 = 0) -> Self {
        MatchConstraintDefaultWidthLayoutParam(value: id).applyOrAppend(self)
    }

    /// Matches the view's default width to another view's width.
    ///
    /// Sets the view's width to match the parent's width by default.
    @discardableResult
    public func matchConstraintDefaultWidthToParent() -> Self {
        MatchConstraintDefaultWidthLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Matches the view's default height to another view's height.
    ///
    /// Sets the view's height to match the referenced view's height by default.
    ///
    /// - Parameters:
    ///   - id: The view ID to match height with, or leave blank to match with parent
    @discardableResult
    public func matchConstraintDefaultHeight(_ id: Int32 = 0) -> Self {
        MatchConstraintDefaultHeightLayoutParam(value: id).applyOrAppend(self)
    }

    /// Matches the view's default height to another view's height.
    ///
    /// Sets the view's height to match the parent's height by default.
    @discardableResult
    public func matchConstraintDefaultHeightToParent() -> Self {
        MatchConstraintDefaultHeightLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Sets the minimum width constraint by matching another view's width.
    ///
    /// The view will never be narrower than the referenced view's width.
    ///
    /// - Parameters:
    ///   - id: The view ID to match minimum width with, or leave blank to match with parent
    @discardableResult
    public func matchConstraintMinWidth(_ id: Int32 = 0) -> Self {
        MatchConstraintMinWidthLayoutParam(value: id).applyOrAppend(self)
    }

    /// Sets the minimum width constraint by matching another view's width.
    ///
    /// The view will never be narrower than the parent's width.
    @discardableResult
    public func matchConstraintMinWidthToParent() -> Self {
        MatchConstraintMinWidthLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Sets the minimum height constraint by matching another view's height.
    ///
    /// The view will never be shorter than the referenced view's height.
    ///
    /// - Parameters:
    ///   - id: The view ID to match minimum height with, or leave blank to match with parent
    @discardableResult
    public func matchConstraintMinHeight(_ id: Int32 = 0) -> Self {
        MatchConstraintMinHeightLayoutParam(value: id).applyOrAppend(self)
    }

    /// Sets the minimum height constraint by matching another view's height.
    ///
    /// The view will never be shorter than the parent's height.
    @discardableResult
    public func matchConstraintMinHeightToParent() -> Self {
        MatchConstraintMinHeightLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Sets the maximum width constraint by matching another view's width.
    ///
    /// The view will never be wider than the referenced view's width.
    ///
    /// - Parameters:
    ///   - id: The view ID to match maximum width with, or leave blank to match with parent
    @discardableResult
    public func matchConstraintMaxWidth(_ id: Int32 = 0) -> Self {
        MatchConstraintMaxWidthLayoutParam(value: id).applyOrAppend(self)
    }

    /// Sets the maximum width constraint by matching another view's width.
    ///
    /// The view will never be wider than the parent's width.
    @discardableResult
    public func matchConstraintMaxWidthToParent() -> Self {
        MatchConstraintMaxWidthLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Sets the maximum height constraint by matching another view's height.
    ///
    /// The view will never be taller than the referenced view's height.
    ///
    /// - Parameters:
    ///   - id: The view ID to match maximum height with, or leave blank to match with parent
    @discardableResult
    public func matchConstraintMaxHeight(_ id: Int32 = 0) -> Self {
        MatchConstraintMaxHeightLayoutParam(value: id).applyOrAppend(self)
    }

    /// Sets the maximum height constraint by matching another view's height.
    ///
    /// The view will never be taller than the parent's height.
    @discardableResult
    public func matchConstraintMaxHeightToParent() -> Self {
        MatchConstraintMaxHeightLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Sets the view's width as a percentage of available space.
    ///
    /// The width will be calculated as a percentage of the parent's available width.
    ///
    /// - Parameters:
    ///   - value: The percentage value (0.0 to 1.0)
    @discardableResult
    public func matchConstraintPercentWidth(_ value: Float) -> Self {
        MatchConstraintPercentWidthLayoutParam(value: value).applyOrAppend(self)
    }

    /// Sets the view's height as a percentage of available space.
    ///
    /// The height will be calculated as a percentage of the parent's available height.
    ///
    /// - Parameters:
    ///   - value: The percentage value (0.0 to 1.0)
    @discardableResult
    public func matchConstraintPercentHeight(_ value: Float) -> Self {
        MatchConstraintPercentHeightLayoutParam(value: value).applyOrAppend(self)
    }

    // MARK: Bias (Alignment)

    /// Sets the horizontal bias for constrained views.
    ///
    /// Controls the horizontal positioning bias when both left and right constraints are set.
    ///
    /// - Parameters:
    ///   - value: Bias value between 0.0 (left) and 1.0 (right)
    @discardableResult
    public func horizontalBias(_ value: Float) -> Self {
        HorizontalBiasLayoutParam(value: value).applyOrAppend(self)
    }

    /// Sets the vertical bias for constrained views.
    ///
    /// Controls the vertical positioning bias when both top and bottom constraints are set.
    ///
    /// - Parameters:
    ///   - value: Bias value between 0.0 (top) and 1.0 (bottom)
    @discardableResult
    public func verticalBias(_ value: Float) -> Self {
        VerticalBiasLayoutParam(value: value).applyOrAppend(self)
    }

    // MARK: Chains & Barriers

    /// Sets the horizontal chain style for constrained views.
    ///
    /// Defines how views in a horizontal chain are positioned and spaced.
    ///
    /// - Parameters:
    ///   - value: Chain style
    @discardableResult
    public func horizontalChainStyle(_ value: ConstraintLayout.ChainStyle) -> Self {
        HorizontalChainStyleLayoutParam(value: value.rawValue).applyOrAppend(self)
    }

    /// Sets the vertical chain style for constrained views.
    ///
    /// Defines how views in a vertical chain are positioned and spaced.
    ///
    /// - Parameters:
    ///   - value: Chain style
    @discardableResult
    public func verticalChainStyle(_ value: ConstraintLayout.ChainStyle) -> Self {
        VerticalChainStyleLayoutParam(value: value.rawValue).applyOrAppend(self)
    }

    /// Enables RTL (right-to-left) support for chain layouts.
    ///
    /// When true, chains will respect RTL layout direction.
    ///
    /// - Parameters:
    ///   - value: Boolean to enable/disable RTL chain support (default: true)
    @discardableResult
    public func chainUseRtl(_ value: Bool = true) -> Self {
        ChainUseRtlLayoutParam(value: value).applyOrAppend(self)
    }

    // MARK: Circular Positioning

    /// Creates circular positioning constraint relative to another view.
    ///
    /// Positions the view along a circular path around the referenced view.
    ///
    /// - Parameters:
    ///   - id: The view ID to circle around, or leave blank to match with parent
    @discardableResult
    public func circleConstraint(_ id: Int32 = 0) -> Self {
        CircleConstraintLayoutParam(value: id).applyOrAppend(self)
    }

    /// Creates circular positioning constraint relative to another view.
    ///
    /// Positions the view along a circular path around the parent.
    @discardableResult
    public func circleConstraintToParent() -> Self {
        CircleConstraintLayoutParam(value: 0).applyOrAppend(self)
    }

    /// Sets the radius for circular constraint positioning.
    ///
    /// Defines the distance from the center of the referenced view.
    ///
    /// - Parameters:
    ///   - value: Radius in density-independent pixels
    ///   - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    @discardableResult
    public func circleRadius(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        CircleRadiusLayoutParam(value: (value, unit)).applyOrAppend(self)
    }

    /// Sets the angle for circular constraint positioning.
    ///
    /// Defines the angular position around the referenced view (0-360 degrees).
    ///
    /// - Parameters:
    ///   - value: Angle in degrees
    @discardableResult
    public func circleAngle(_ value: Float) -> Self {
        CircleAngleLayoutParam(value: value).applyOrAppend(self)
    }

    // MARK: Aspect Ratio

    /// Sets the dimension ratio for the view.
    ///
    /// Constrains the view's dimensions to maintain a specific width:height ratio.
    ///
    /// - Parameters:
    ///   - value: Ratio string (e.g., "16:9" or "1.5")
    @discardableResult
    public func dimensionRatio(_ value: String) -> Self {
        DimensionRatioLayoutParam(value: value).applyOrAppend(self)
    }

    // MARK: View Visibility Behavior

    /// Sets the top margin used when the view is marked as GONE.
    ///
    /// Defines the top margin that will be applied when the view's visibility is set to GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    @discardableResult
    public func goneTopMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        GoneTopMarginLayoutParam(value: (value, unit)).applyOrAppend(self)
    }

    /// Sets the bottom margin used when the view is marked as GONE.
    ///
    /// Defines the bottom margin that will be applied when the view's visibility is set to GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    @discardableResult
    public func goneBottomMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        GoneBottomMarginLayoutParam(value: (value, unit)).applyOrAppend(self)
    }

    /// Sets the left margin used when the view is marked as GONE.
    ///
    /// Defines the left margin that will be applied when the view's visibility is set to GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    @discardableResult
    public func goneLeftMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        GoneLeftMarginLayoutParam(value: (value, unit)).applyOrAppend(self)
    }

    /// Sets the right margin used when the view is marked as GONE.
    ///
    /// Defines the right margin that will be applied when the view's visibility is set to GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    @discardableResult
    public func goneRightMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        GoneRightMarginLayoutParam(value: (value, unit)).applyOrAppend(self)
    }

    /// Sets the start margin used when the view is marked as GONE.
    ///
    /// Defines the start margin (LTR/RTL-aware) applied when view's visibility is GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    @discardableResult
    public func goneStartMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        GoneStartMarginLayoutParam(value: (value, unit)).applyOrAppend(self)
    }

    /// Sets the end margin used when the view is marked as GONE.
    ///
    /// Defines the end margin (LTR/RTL-aware) applied when view's visibility is GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    @discardableResult
    public func goneEndMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        GoneEndMarginLayoutParam(value: (value, unit)).applyOrAppend(self)
    }
}
// TODO: center constraints via `ConstraintSet`