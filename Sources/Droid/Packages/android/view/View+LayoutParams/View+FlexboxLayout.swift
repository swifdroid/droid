// MARK: FlexboxLayout - Layout Params
extension View {
    // MARK: Flex Item Attributes

    /// **FlexboxLayoutParams**
    /// 
    /// Sets the visual order of the view within the flex container.
    ///
    /// Controls the order in which views appear in the flex layout.
    ///
    /// - Parameters:
    ///   - value: Order priority (lower values appear first)
    @discardableResult
    public func order(_ value: Int) -> Self {
        OrderLayoutParam(value: value).applyOrAppend(self)
    }

    /// **FlexboxLayoutParams**
    /// 
    /// Sets the flex grow factor for the view.
    ///
    /// Determines how much the view will grow relative to siblings when extra space exists.
    ///
    /// - Parameters:
    ///   - value: Grow factor
    @discardableResult
    public func flexGrow(_ value: Float) -> Self {
        FlexGrowLayoutParam(value: value).applyOrAppend(self)
    }

    /// **FlexboxLayoutParams**
    /// 
    /// Sets the flex shrink factor for the view.
    ///
    /// Determines how much the view will shrink relative to siblings when space is constrained.
    ///
    /// - Parameters:
    ///   - value: Shrink factor
    @discardableResult
    public func flexShrink(_ value: Float) -> Self {
        FlexShrinkLayoutParam(value: value).applyOrAppend(self)
    }

    /// **FlexboxLayoutParams**
    /// 
    /// Sets the initial main size of the view as a percentage.
    ///
    /// Defines the initial size before remaining space is distributed.
    ///
    /// - Parameters:
    ///   - value: Percentage of parent's main size
    @discardableResult
    public func flexBasisPercent(_ value: Float) -> Self {
        FlexBasisPercentLayoutParam(value: value).applyOrAppend(self)
    }

    /// **FlexboxLayoutParams**
    /// 
    /// Sets the alignment for this view within its container.
    ///
    /// Overrides the container's alignment for this specific view.
    ///
    /// - Parameters:
    ///   - value: Alignment constant (ALIGN_SELF_AUTO, ALIGN_FLEX_START, etc.) (Int32)
    @discardableResult
    public func alignSelf(_ value: Int32) -> Self { // TODO: AlignmentConstant type
        AlignSelfLayoutParam(value: value).applyOrAppend(self) // TODO: AlignmentConstant type
    }

    // MARK: Wrapping Control

    /// **FlexboxLayoutParams**
    /// 
    /// Forces a line break before this view.
    ///
    /// When true, this view will start on a new line in the flex container.
    ///
    /// - Parameters:
    ///   - value: Boolean to force line break
    @discardableResult
    public func wrapBefore(_ value: Bool = true) -> Self {
        WrapBeforeLayoutParam(value: value).applyOrAppend(self)
    }

    // MARK: Minimum/Maximum Dimensions

    /// **FlexboxLayoutParams**
    /// 
    /// Sets the minimum width constraint for the view.
    ///
    /// The view will never be narrower than this width value.
    ///
    /// - Parameters:
    ///    - value: Width in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    @discardableResult
    public func minWidth(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        MinWidthLayoutParam(value: (value, unit)).applyOrAppend(self)
    }

    /// **FlexboxLayoutParams**
    /// 
    /// Sets the minimum height constraint for the view.
    ///
    /// The view will never be narrower than this height value.
    ///
    /// - Parameters:
    ///    - value: Height in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    @discardableResult
    public func minHeight(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        MinHeightLayoutParam(value: (value, unit)).applyOrAppend(self)
    }

    /// **FlexboxLayoutParams**
    /// 
    /// Sets the maximum width constraint for the view.
    ///
    /// The view will never be wider than this width value.
    ///
    /// - Parameters:
    ///    - value: Width in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    @discardableResult
    public func maxWidth(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        MaxWidthLayoutParam(value: (value, unit)).applyOrAppend(self)
    }

    /// **FlexboxLayoutParams**
    /// 
    /// Sets the maximum height constraint for the view.
    ///
    /// The view will never be wider than this height value.
    ///
    /// - Parameters:
    ///    - value: Height in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    @discardableResult
    public func maxHeight(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        MaxHeightLayoutParam(value: (value, unit)).applyOrAppend(self)
    }
}