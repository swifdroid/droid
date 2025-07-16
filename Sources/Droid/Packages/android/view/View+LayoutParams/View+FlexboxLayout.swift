// MARK: FlexboxLayout - Layout Params
extension View {
    // MARK: Flex Item Attributes

    /// Sets the visual order of the view within the flex container.
    ///
    /// Controls the order in which views appear in the flex layout.
    ///
    /// - Parameters:
    ///   - value: Order priority (lower values appear first)
    ///
    /// Supported layouts:
    /// - FlexboxLayout: Primary ordering mechanism
    /// - GridLayout: Similar ordering in grid cells
    /// - LinearLayout: Affects drawing order
    @discardableResult
    public func order(_ value: Int) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.order(value))
        }
        return self
    }

    /// Sets the flex grow factor for the view.
    ///
    /// Determines how much the view will grow relative to siblings when extra space exists.
    ///
    /// - Parameters:
    ///   - value: Grow factor
    ///
    /// Supported layouts:
    /// - FlexboxLayout: Primary flex growth control
    /// - LinearLayout: Similar weight concept
    /// - ConstraintLayout: Similar behavior with chains
    @discardableResult
    public func flexGrow(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.flexGrow(value))
        }
        return self
    }

    /// Sets the flex shrink factor for the view.
    ///
    /// Determines how much the view will shrink relative to siblings when space is constrained.
    ///
    /// - Parameters:
    ///   - value: Shrink factor
    ///
    /// Supported layouts:
    /// - FlexboxLayout: Primary flex shrinking control
    /// - LinearLayout: Similar behavior with weighted views
    @discardableResult
    public func flexShrink(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.flexShrink(value))
        }
        return self
    }

    /// Sets the initial main size of the view as a percentage.
    ///
    /// Defines the initial size before remaining space is distributed.
    ///
    /// - Parameters:
    ///   - value: Percentage of parent's main size
    ///
    /// Supported layouts:
    /// - FlexboxLayout: Percentage-based flex basis
    /// - PercentFrameLayout: Similar percentage sizing
    /// - PercentRelativeLayout: Percentage-based dimensions
    @discardableResult
    public func flexBasisPercent(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.flexBasisPercent(value))
        }
        return self
    }

    /// Sets the alignment for this view within its container.
    ///
    /// Overrides the container's alignment for this specific view.
    ///
    /// - Parameters:
    ///   - value: Alignment constant (ALIGN_SELF_AUTO, ALIGN_FLEX_START, etc.) (Int32)
    ///
    /// Supported layouts:
    /// - FlexboxLayout: Individual view alignment override
    /// - GridLayout: Similar cell-specific alignment
    @discardableResult
    public func alignSelf(_ value: Int32) -> Self { // TODO: AlignmentConstant type
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignSelf(value)) // TODO: AlignmentConstant type
        }
        return self
    }

    // MARK: Wrapping Control

    /// Forces a line break before this view.
    ///
    /// When true, this view will start on a new line in the flex container.
    ///
    /// - Parameters:
    ///   - value: Boolean to force line break
    ///
    /// Supported layouts:
    /// - FlexboxLayout: Controls line wrapping behavior
    /// - GridLayout: Similar row-breaking behavior
    @discardableResult
    public func wrapBefore(_ value: Bool) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.wrapBefore(value))
        }
        return self
    }

    // MARK: Minimum/Maximum Dimensions

    /// Sets the minimum width constraint for the view.
    ///
    /// The view will never be narrower than this width value.
    ///
    /// - Parameters:
    ///    - value: Width in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - FlexboxLayout: Minimum main size constraint
    /// - ConstraintLayout: Works with constraint-based system
    /// - FrameLayout: Enforces minimum width
    @discardableResult
    public func minWidth(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.minWidth(value, unit))
        }
        return self
    }

    // minHeight

    /// Sets the maximum width constraint for the view.
    ///
    /// The view will never be wider than this width value.
    ///
    /// - Parameters:
    ///    - value: Width in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - FlexboxLayout: Maximum main size constraint
    /// - ConstraintLayout: Works with constraint-based system
    /// - FrameLayout: Enforces maximum width
    @discardableResult
    public func maxWidth(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.maxWidth(value, unit))
        }
        return self
    }

    // maxHeight
}