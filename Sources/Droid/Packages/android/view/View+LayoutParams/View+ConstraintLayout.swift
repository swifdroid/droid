// MARK: ConstraintLayout - Layout Params
extension View {
    // MARK: Directional Constraints

    /// Constrains the view's left edge to another view's left edge.
    ///
    /// Creates a horizontal alignment constraint between left edges of views.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Primary use for constraint-based positioning
    /// - RelativeLayout: Similar behavior using layout rules
    @discardableResult
    public func leftToLeft(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.leftToLeft(id))
        }
        return self
    }

    /// Constrains the view's left edge to another view's right edge.
    ///
    /// Positions the view's left edge adjacent to another view's right edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Primary use for constraint-based positioning
    /// - RelativeLayout: Similar behavior using layout rules
    @discardableResult
    public func leftToRight(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.leftToRight(id))
        }
        return self
    }

    /// Constrains the view's right edge to another view's left edge.
    ///
    /// Positions the view's right edge adjacent to another view's left edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Primary use for constraint-based positioning
    /// - RelativeLayout: Similar behavior using layout rules
    @discardableResult
    public func rightToLeft(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.rightToLeft(id))
        }
        return self
    }

    /// Constrains the view's right edge to another view's right edge.
    ///
    /// Creates a horizontal alignment constraint between right edges of views.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Primary use for constraint-based positioning
    /// - RelativeLayout: Similar behavior using layout rules
    @discardableResult
    public func rightToRight(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.rightToRight(id))
        }
        return self
    }

    /// Constrains the view's top edge to another view's top edge.
    ///
    /// Creates a vertical alignment constraint between top edges of views.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Primary use for constraint-based positioning
    /// - RelativeLayout: Similar behavior using layout rules
    @discardableResult
    public func topToTop(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.topToTop(id))
        }
        return self
    }

    /// Constrains the view's top edge to another view's bottom edge.
    ///
    /// Positions the view's top edge adjacent to another view's bottom edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Primary use for constraint-based positioning
    /// - RelativeLayout: Similar behavior using layout rules
    /// - LinearLayout: Implicitly creates this relationship in vertical orientation
    @discardableResult
    public func topToBottom(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.topToBottom(id))
        }
        return self
    }

    /// Constrains the view's bottom edge to another view's top edge.
    ///
    /// Positions the view below another view with bottom edge touching its top edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Creates vertical spacing constraint
    /// - RelativeLayout: Similar to layout_below attribute
    /// - LinearLayout: Naturally occurs in vertical orientation
    @discardableResult
    public func bottomToTop(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.bottomToTop(id))
        }
        return self
    }

    /// Constrains the view's bottom edge to another view's bottom edge.
    ///
    /// Aligns the bottom edges of both views vertically.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Creates bottom alignment constraint
    /// - RelativeLayout: Similar to alignBottom attribute
    /// - FrameLayout: Can be achieved with gravity settings
    @discardableResult
    public func bottomToBottom(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.bottomToBottom(id))
        }
        return self
    }

    /// Constrains the view's start edge to another view's start edge.
    ///
    /// Aligns the leading edges (left in LTR, right in RTL) of both views.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Creates RTL-aware start alignment
    /// - RelativeLayout: Similar to alignStart attribute
    /// - FlexboxLayout: Controls item alignment in container
    @discardableResult
    public func startToStart(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.startToStart(id))
        }
        return self
    }

    /// Constrains the view's start edge to another view's end edge.
    ///
    /// Positions view's start edge adjacent to another view's end edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Creates RTL-aware positioning
    /// - RelativeLayout: Similar to toEndOf attribute
    /// - FlexboxLayout: Affects item ordering in RTL
    @discardableResult
    public func startToEnd(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.startToEnd(id))
        }
        return self
    }

    /// Constrains the view's end edge to another view's start edge.
    ///
    /// Positions view's end edge adjacent to another view's start edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Creates RTL-aware positioning
    /// - RelativeLayout: Similar to toStartOf attribute
    /// - FlexboxLayout: Affects item ordering in RTL
    @discardableResult
    public func endToStart(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.endToStart(id))
        }
        return self
    }

    /// Constrains the view's end edge to another view's end edge.
    ///
    /// Aligns the trailing edges (right in LTR, left in RTL) of both views.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Creates RTL-aware end alignment
    /// - RelativeLayout: Similar to alignEnd attribute
    /// - FlexboxLayout: Controls item alignment in container
    @discardableResult
    public func endToEnd(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.endToEnd(id))
        }
        return self
    }

    /// Constrains the view's baseline to another view's baseline.
    ///
    /// Aligns text baselines of both views vertically.
    ///
    /// - Parameters:
    ///   - id: The view ID to constrain to
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Creates text baseline alignment
    /// - RelativeLayout: Similar to alignBaseline attribute
    /// - LinearLayout: Supports baseline alignment in vertical orientation
    @discardableResult
    public func baselineToBaseline(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.baselineToBaseline(id))
        }
        return self
    }

    // MARK: Dimensions

    /// Matches the view's default width to another view's width.
    ///
    /// Sets the view's width to match the referenced view's width by default.
    ///
    /// - Parameters:
    ///   - id: The view ID to match width with
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Primary use for constraint-based dimension matching
    /// - RelativeLayout: Similar behavior using layout rules
    @discardableResult
    public func matchConstraintDefaultWidth(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.matchConstraintDefaultWidth(id))
        }
        return self
    }

    /// Matches the view's default height to another view's height.
    ///
    /// Sets the view's height to match the referenced view's height by default.
    ///
    /// - Parameters:
    ///   - id: The view ID to match height with
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Primary use for constraint-based dimension matching
    /// - RelativeLayout: Similar behavior using layout rules
    @discardableResult
    public func matchConstraintDefaultHeight(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.matchConstraintDefaultHeight(id))
        }
        return self
    }

    /// Sets the minimum width constraint by matching another view's width.
    ///
    /// The view will never be narrower than the referenced view's width.
    ///
    /// - Parameters:
    ///   - id: The view ID to match minimum width with
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Creates minimum width constraint
    /// - FlexboxLayout: Controls minimum main size in flex container
    @discardableResult
    public func matchConstraintMinWidth(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.matchConstraintMinWidth(id))
        }
        return self
    }

    /// Sets the minimum height constraint by matching another view's height.
    ///
    /// The view will never be shorter than the referenced view's height.
    ///
    /// - Parameters:
    ///   - id: The view ID to match minimum height with
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Creates minimum height constraint
    /// - FlexboxLayout: Controls minimum cross size in flex container
    @discardableResult
    public func matchConstraintMinHeight(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.matchConstraintMinHeight(id))
        }
        return self
    }

    /// Sets the maximum width constraint by matching another view's width.
    ///
    /// The view will never be wider than the referenced view's width.
    ///
    /// - Parameters:
    ///   - id: The view ID to match maximum width with
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Creates maximum width constraint
    /// - FlexboxLayout: Controls maximum main size in flex container
    @discardableResult
    public func matchConstraintMaxWidth(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.matchConstraintMaxWidth(id))
        }
        return self
    }

    /// Sets the maximum height constraint by matching another view's height.
    ///
    /// The view will never be taller than the referenced view's height.
    ///
    /// - Parameters:
    ///   - id: The view ID to match maximum height with
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Creates maximum height constraint
    /// - FlexboxLayout: Controls maximum cross size in flex container
    @discardableResult
    public func matchConstraintMaxHeight(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.matchConstraintMaxHeight(id))
        }
        return self
    }

    /// Sets the view's width as a percentage of available space.
    ///
    /// The width will be calculated as a percentage of the parent's available width.
    ///
    /// - Parameters:
    ///   - value: The percentage value (0.0 to 1.0)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Percentage-based width constraint
    /// - PercentFrameLayout: Primary percentage dimension control
    /// - PercentRelativeLayout: Percentage-based sizing
    @discardableResult
    public func matchConstraintPercentWidth(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.matchConstraintPercentWidth(value))
        }
        return self
    }

    /// Sets the view's height as a percentage of available space.
    ///
    /// The height will be calculated as a percentage of the parent's available height.
    ///
    /// - Parameters:
    ///   - value: The percentage value (0.0 to 1.0)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Percentage-based height constraint
    /// - PercentFrameLayout: Primary percentage dimension control
    /// - PercentRelativeLayout: Percentage-based sizing
    @discardableResult
    public func matchConstraintPercentHeight(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.matchConstraintPercentHeight(value))
        }
        return self
    }

    // MARK: Bias (Alignment)

    /// Sets the horizontal bias for constrained views.
    ///
    /// Controls the horizontal positioning bias when both left and right constraints are set.
    ///
    /// - Parameters:
    ///   - value: Bias value between 0.0 (left) and 1.0 (right)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Primary use for bias positioning
    /// - RelativeLayout: Similar effect using gravity or margins
    @discardableResult
    public func horizontalBias(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.horizontalBias(value))
        }
        return self
    }

    /// Sets the vertical bias for constrained views.
    ///
    /// Controls the vertical positioning bias when both top and bottom constraints are set.
    ///
    /// - Parameters:
    ///   - value: Bias value between 0.0 (top) and 1.0 (bottom)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Primary use for bias positioning
    /// - RelativeLayout: Similar effect using gravity or margins
    @discardableResult
    public func verticalBias(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.verticalBias(value))
        }
        return self
    }

    // MARK: Chains & Barriers

    /// Sets the horizontal chain style for constrained views.
    ///
    /// Defines how views in a horizontal chain are positioned and spaced.
    ///
    /// - Parameters:
    ///   - value: Chain style constant (CHAIN_SPREAD, CHAIN_SPREAD_INSIDE, CHAIN_PACKED)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Exclusive chain layout feature
    @discardableResult
    public func horizontalChainStyle(_ value: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.horizontalChainStyle(value))
        }
        return self
    }

    /// Sets the vertical chain style for constrained views.
    ///
    /// Defines how views in a vertical chain are positioned and spaced.
    ///
    /// - Parameters:
    ///   - value: Chain style constant (CHAIN_SPREAD, CHAIN_SPREAD_INSIDE, CHAIN_PACKED)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Exclusive chain layout feature
    @discardableResult
    public func verticalChainStyle(_ value: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.verticalChainStyle(value))
        }
        return self
    }

    /// Enables RTL (right-to-left) support for chain layouts.
    ///
    /// When true, chains will respect RTL layout direction.
    ///
    /// - Parameters:
    ///   - value: Boolean to enable/disable RTL chain support (default: true)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Affects chain behavior in RTL contexts
    /// - FlexboxLayout: Similar RTL support for flex directions
    @discardableResult
    public func chainUseRtl(_ value: Bool = true) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.chainUseRtl(value))
        }
        return self
    }

    // MARK: Circular Positioning

    /// Creates circular positioning constraint relative to another view.
    ///
    /// Positions the view along a circular path around the referenced view.
    ///
    /// - Parameters:
    ///   - id: The view ID to circle around
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Exclusive circular positioning feature
    /// - MotionLayout: Similar path-based motion constraints
    @discardableResult
    public func circleConstraint(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.circleConstraint(id))
        }
        return self
    }

    /// Sets the radius for circular constraint positioning.
    ///
    /// Defines the distance from the center of the referenced view.
    ///
    /// - Parameters:
    ///   - value: Radius in density-independent pixels
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Used with circular constraints
    /// - MotionLayout: Similar path motion attributes
    @discardableResult
    public func circleRadius(_ value: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.circleRadius(value))
        }
        return self
    }

    /// Sets the angle for circular constraint positioning.
    ///
    /// Defines the angular position around the referenced view (0-360 degrees).
    ///
    /// - Parameters:
    ///   - value: Angle in degrees
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Used with circular constraints
    /// - MotionLayout: Similar path motion attributes
    @discardableResult
    public func circleAngle(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.circleAngle(value))
        }
        return self
    }

    // MARK: Aspect Ratio

    /// Sets the dimension ratio for the view.
    ///
    /// Constrains the view's dimensions to maintain a specific width:height ratio.
    ///
    /// - Parameters:
    ///   - value: Ratio string (e.g., "16:9" or "1.5")
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Maintains aspect ratio constraints
    /// - FlexboxLayout: Similar aspect ratio control for flex items
    @discardableResult
    public func dimensionRatio(_ value: String) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.dimensionRatio(value))
        }
        return self
    }

    // MARK: View Visibility Behavior

    /// Sets the top margin used when the view is marked as GONE.
    ///
    /// Defines the top margin that will be applied when the view's visibility is set to GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Affects layout when view is GONE
    /// - RelativeLayout: Similar behavior for gone view margins
    @discardableResult
    public func goneTopMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.goneTopMargin(value, unit))
        }
        return self
    }

    /// Sets the bottom margin used when the view is marked as GONE.
    ///
    /// Defines the bottom margin that will be applied when the view's visibility is set to GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Affects layout when view is GONE
    /// - RelativeLayout: Similar behavior for gone view margins
    @discardableResult
    public func goneBottomMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.goneBottomMargin(value, unit))
        }
        return self
    }

    /// Sets the left margin used when the view is marked as GONE.
    ///
    /// Defines the left margin that will be applied when the view's visibility is set to GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Affects layout when view is GONE
    /// - RelativeLayout: Similar behavior for gone view margins
    @discardableResult
    public func goneLeftMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.goneLeftMargin(value, unit))
        }
        return self
    }

    /// Sets the right margin used when the view is marked as GONE.
    ///
    /// Defines the right margin that will be applied when the view's visibility is set to GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Affects layout when view is GONE
    /// - RelativeLayout: Similar behavior for gone view margins
    @discardableResult
    public func goneRightMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.goneRightMargin(value, unit))
        }
        return self
    }

    /// Sets the start margin used when the view is marked as GONE.
    ///
    /// Defines the start margin (LTR/RTL-aware) applied when view's visibility is GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Affects RTL-aware gone margins
    /// - RelativeLayout: Similar RTL-aware gone margin behavior
    @discardableResult
    public func goneStartMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.goneStartMargin(value, unit))
        }
        return self
    }

    /// Sets the end margin used when the view is marked as GONE.
    ///
    /// Defines the end margin (LTR/RTL-aware) applied when view's visibility is GONE.
    ///
    /// - Parameters:
    ///    - value: Margin size in density-independent pixels
    ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Affects RTL-aware gone margins
    /// - RelativeLayout: Similar RTL-aware gone margin behavior
    @discardableResult
    public func goneEndMargin(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.goneEndMargin(value, unit))
        }
        return self
    }
}