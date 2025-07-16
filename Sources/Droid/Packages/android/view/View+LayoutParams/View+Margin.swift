// MARK: Margin Layout Params
extension View {
    /// Sets the left margin for the view.
    ///
    /// Defines the space between the view's left edge and adjacent elements or parent container.
    ///
    /// - Parameters:
    ///    - value: The margin size in density-independent pixels
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
    public func leftMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.leftMargin(value, unit))
        }
        return self
    }

    /// Sets the top margin for the view.
    ///
    /// Defines the space between the view's top edge and adjacent elements or parent container.
    ///
    /// - Parameters:
    ///    - value: The margin size in density-independent pixels
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
    public func topMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.topMargin(value, unit))
        }
        return self
    }

    /// Sets the right margin for the view.
    ///
    /// Defines the space between the view's right edge and adjacent elements or parent container.
    ///
    /// - Parameters:
    ///    - value: The margin size in density-independent pixels
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
    public func rightMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.rightMargin(value, unit))
        }
        return self
    }

    /// Sets the bottom margin for the view.
    ///
    /// Defines the space between the view's bottom edge and adjacent elements or parent container.
    ///
    /// - Parameters:
    ///    - value: The margin size in density-independent pixels
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
    public func bottomMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.bottomMargin(value, unit))
        }
        return self
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
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.startMargin(value, unit))
        }
        return self
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
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.endMargin(value, unit))
        }
        return self
    }
}