// MARK: RelativeLayout - Layout Params
extension View {
    // MARK: Relative to Parent

    /// Aligns the view to the top edge of its parent container.
    ///
    /// Positions the view's top edge flush with the parent's top edge.
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary top alignment control
    /// - FrameLayout: Similar behavior using top gravity
    /// - CoordinatorLayout: Similar anchored positioning
    /// - ConstraintLayout: Similar top alignment constraints
    @discardableResult
    public func alignParentTop() -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignParentTop)
        }
        return self
    }

    /// Aligns the view to the bottom edge of its parent container.
    ///
    /// Positions the view's bottom edge flush with the parent's bottom edge.
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary bottom alignment control
    /// - FrameLayout: Similar behavior using bottom gravity
    /// - CoordinatorLayout: Similar anchored positioning
    /// - ConstraintLayout: Similar bottom alignment constraints
    @discardableResult
    public func alignParentBottom() -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignParentBottom)
        }
        return self
    }

    /// Aligns the view to the left edge of its parent container.
    ///
    /// Positions the view's left edge flush with the parent's left edge.
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary left alignment control
    /// - FrameLayout: Similar behavior using left gravity
    /// - CoordinatorLayout: Similar anchored positioning
    /// - ConstraintLayout: Similar left alignment constraints
    @discardableResult
    public func alignParentLeft() -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignParentLeft)
        }
        return self
    }

    /// Aligns the view to the right edge of its parent container.
    ///
    /// Positions the view's right edge flush with the parent's right edge.
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary right alignment control
    /// - FrameLayout: Similar behavior using right gravity
    /// - CoordinatorLayout: Similar anchored positioning
    /// - ConstraintLayout: Similar right alignment constraints
    @discardableResult
    public func alignParentRight() -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignParentRight)
        }
        return self
    }

    /// Aligns the view to the start edge of its parent container (LTR/RTL-aware).
    ///
    /// Positions the view's start edge flush with the parent's start edge.
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary RTL-aware start alignment
    /// - FrameLayout: Similar behavior using start gravity
    /// - CoordinatorLayout: Similar anchored positioning
    /// - ConstraintLayout: Similar start alignment constraints
    @discardableResult
    public func alignParentStart() -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignParentStart)
        }
        return self
    }

    /// Aligns the view to the end edge of its parent container (LTR/RTL-aware).
    ///
    /// Positions the view's end edge flush with the parent's end edge.
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary RTL-aware end alignment
    /// - FrameLayout: Similar behavior using end gravity
    /// - CoordinatorLayout: Similar anchored positioning
    /// - ConstraintLayout: Similar end alignment constraints
    @discardableResult
    public func alignParentEnd() -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignParentEnd)
        }
        return self
    }

    /// Centers the view both horizontally and vertically within its parent.
    ///
    /// Positions the view at the exact center of the parent container.
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary center positioning
    /// - FrameLayout: Similar behavior using center gravity
    /// - CoordinatorLayout: Similar centered anchoring
    /// - ConstraintLayout: Similar center constraints
    @discardableResult
    public func centerInParent() -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.centerInParent)
        }
        return self
    }

    /// Centers the view horizontally within its parent.
    ///
    /// Aligns the view to the horizontal center of the parent container.
    ///
    /// Supported layouts:
    /// - RelativeLayout: Horizontal centering control
    /// - FrameLayout: Similar behavior using center_horizontal gravity
    /// - CoordinatorLayout: Similar horizontal anchoring
    /// - ConstraintLayout: Similar horizontal center constraints
    @discardableResult
    public func centerHorizontal() -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.centerHorizontal)
        }
        return self
    }

    /// Centers the view vertically within its parent.
    ///
    /// Aligns the view to the vertical center of the parent container.
    ///
    /// Supported layouts:
    /// - RelativeLayout: Vertical centering control
    /// - FrameLayout: Similar behavior using center_vertical gravity
    /// - CoordinatorLayout: Similar vertical anchoring
    /// - ConstraintLayout: Similar vertical center constraints
    @discardableResult
    public func centerVertical() -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.centerVertical)
        }
        return self
    }

    // MARK: Relative to Other Views

    /// Positions the view above the specified view.
    ///
    /// Places this view immediately above another view in the layout.
    ///
    /// - Parameters:
    ///   - id: The view ID to position above
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary relative positioning
    /// - ConstraintLayout: Similar behavior using topToBottom constraint
    @discardableResult
    public func above(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.above(id))
        }
        return self
    }

    /// Positions the view below the specified view.
    ///
    /// Places this view immediately below another view in the layout.
    ///
    /// - Parameters:
    ///   - id: The view ID to position below
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary relative positioning
    /// - ConstraintLayout: Similar behavior using bottomToTop constraint
    @discardableResult
    public func below(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.below(id))
        }
        return self
    }

    /// Positions the view to the left of the specified view.
    ///
    /// Places this view immediately to the left of another view.
    ///
    /// - Parameters:
    ///   - id: The view ID to position left of
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary relative positioning
    /// - ConstraintLayout: Similar behavior using leftToRight constraint
    @discardableResult
    public func toLeftOf(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.toLeftOf(id))
        }
        return self
    }

    /// Positions the view to the right of the specified view.
    ///
    /// Places this view immediately to the right of another view.
    ///
    /// - Parameters:
    ///   - id: The view ID to position right of
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary relative positioning
    /// - ConstraintLayout: Similar behavior using rightToLeft constraint
    @discardableResult
    public func toRightOf(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.toRightOf(id))
        }
        return self
    }

    /// Positions the view to the start of the specified view (LTR/RTL-aware).
    ///
    /// Places this view at the start side of another view.
    ///
    /// - Parameters:
    ///   - id: The view ID to position start of
    ///
    /// Supported layouts:
    /// - RelativeLayout: RTL-aware relative positioning
    /// - ConstraintLayout: Similar behavior using startToEnd constraint
    @discardableResult
    public func toStartOf(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.toStartOf(id))
        }
        return self
    }

    /// Positions the view to the end of the specified view (LTR/RTL-aware).
    ///
    /// Places this view at the end side of another view.
    ///
    /// - Parameters:
    ///   - id: The view ID to position end of
    ///
    /// Supported layouts:
    /// - RelativeLayout: RTL-aware relative positioning
    /// - ConstraintLayout: Similar behavior using endToStart constraint
    @discardableResult
    public func toEndOf(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.toEndOf(id))
        }
        return self
    }

    /// Aligns the view's top edge with another view's top edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary edge alignment
    /// - ConstraintLayout: Similar behavior using topToTop constraint
    @discardableResult
    public func alignTop(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignTop(id))
        }
        return self
    }

    /// Aligns the view's bottom edge with another view's bottom edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary edge alignment
    /// - ConstraintLayout: Similar behavior using bottomToBottom constraint
    @discardableResult
    public func alignBottom(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignBottom(id))
        }
        return self
    }

    /// Aligns the view's left edge with another view's left edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary edge alignment
    /// - ConstraintLayout: Similar behavior using leftToLeft constraint
    @discardableResult
    public func alignLeft(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignLeft(id))
        }
        return self
    }

    /// Aligns the view's right edge with another view's right edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    ///
    /// Supported layouts:
    /// - RelativeLayout: Primary edge alignment
    /// - ConstraintLayout: Similar behavior using rightToRight constraint
    @discardableResult
    public func alignRight(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignRight(id))
        }
        return self
    }

    /// Aligns the view's start edge with another view's start edge (LTR/RTL-aware).
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    ///
    /// Supported layouts:
    /// - RelativeLayout: RTL-aware edge alignment
    /// - ConstraintLayout: Similar behavior using startToStart constraint
    @discardableResult
    public func alignStart(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignStart(id))
        }
        return self
    }

    /// Aligns the view's end edge with another view's end edge (LTR/RTL-aware).
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    ///
    /// Supported layouts:
    /// - RelativeLayout: RTL-aware edge alignment
    /// - ConstraintLayout: Similar behavior using endToEnd constraint
    @discardableResult
    public func alignEnd(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignEnd(id))
        }
        return self
    }

    /// Aligns the view's baseline with another view's baseline.
///
/// Typically used for text alignment between views.
///
/// - Parameters:
///   - id: The view ID to align with
///
/// Supported layouts:
/// - RelativeLayout: Primary baseline alignment
/// - ConstraintLayout: Similar behavior using baselineToBaseline constraint
/// - LinearLayout: Supports baseline alignment in vertical orientation
    @discardableResult
    public func alignBaseline(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.alignBaseline(id))
        }
        return self
    }
}