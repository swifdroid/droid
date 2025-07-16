// MARK: PercentFrameLayout/PercentRelativeLayout - Layout Params
extension View {
    // MARK: Percentage-Based Dimensions

    /// Sets the width as a percentage of the parent container's width.
    ///
    /// The view's width will be calculated as a percentage of available space.
    ///
    /// - Parameters:
    ///   - value: Percentage value between 0.0 and 1.0
    ///
    /// Supported layouts:
    /// - PercentFrameLayout: Primary percentage-based sizing
    /// - PercentRelativeLayout: Percentage-based dimension control
    /// - ConstraintLayout: Similar behavior with percentage constraints
    /// - FlexboxLayout: Percentage-based flex item sizing
    @discardableResult
    public func widthPercent(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.widthPercent(value))
        }
        return self
    }

    /// Sets the height as a percentage of the parent container's height.
    ///
    /// The view's height will be calculated as a percentage of available space.
    ///
    /// - Parameters:
    ///   - value: Percentage value between 0.0 and 1.0
    ///
    /// Supported layouts:
    /// - PercentFrameLayout: Primary percentage-based sizing
    /// - PercentRelativeLayout: Percentage-based dimension control
    /// - ConstraintLayout: Similar behavior with percentage constraints
    /// - FlexboxLayout: Percentage-based flex item sizing
    @discardableResult
    public func heightPercent(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.heightPercent(value))
        }
        return self
    }

    // MARK: Percentage Margins

    /// Sets the left margin as a percentage of the parent container's width.
    ///
    /// The left margin will be calculated as a percentage of parent width.
    ///
    /// - Parameters:
    ///   - value: Percentage value between 0.0 and 1.0
    ///
    /// Supported layouts:
    /// - PercentRelativeLayout: Primary percentage margin control
    /// - PercentFrameLayout: Percentage-based positioning
    @discardableResult
    public func leftMarginPercent(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.leftMarginPercent(value))
        }
        return self
    }

    /// Sets the top margin as a percentage of the parent container's height.
    ///
    /// The top margin will be calculated as a percentage of parent height.
    ///
    /// - Parameters:
    ///   - value: Percentage value between 0.0 and 1.0
    ///
    /// Supported layouts:
    /// - PercentRelativeLayout: Primary percentage margin control
    /// - PercentFrameLayout: Percentage-based positioning
    @discardableResult
    public func topMarginPercent(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.topMarginPercent(value))
        }
        return self
    }

    /// Sets the right margin as a percentage of the parent container's width.
    ///
    /// The right margin will be calculated as a percentage of parent width.
    ///
    /// - Parameters:
    ///   - value: Percentage value between 0.0 and 1.0
    ///
    /// Supported layouts:
    /// - PercentRelativeLayout: Primary percentage margin control
    /// - PercentFrameLayout: Percentage-based positioning
    @discardableResult
    public func rightMarginPercent(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.rightMarginPercent(value))
        }
        return self
    }

    /// Sets the bottom margin as a percentage of the parent container's height.
    ///
    /// The bottom margin will be calculated as a percentage of parent height.
    ///
    /// - Parameters:
    ///   - value: Percentage value between 0.0 and 1.0
    ///
    /// Supported layouts:
    /// - PercentRelativeLayout: Primary percentage margin control
    /// - PercentFrameLayout: Percentage-based positioning
    @discardableResult
    public func bottomMarginPercent(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.bottomMarginPercent(value))
        }
        return self
    }

    /// Sets the start margin as a percentage of the parent container's width.
    ///
    /// The start margin (LTR/RTL-aware) will be calculated as a percentage.
    ///
    /// - Parameters:
    ///   - value: Percentage value between 0.0 and 1.0
    ///
    /// Supported layouts:
    /// - PercentRelativeLayout: Primary percentage margin control
    /// - PercentFrameLayout: Percentage-based positioning
    @discardableResult
    public func startMarginPercent(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.startMarginPercent(value))
        }
        return self
    }

    /// Sets the end margin as a percentage of the parent container's width.
    ///
    /// The end margin (LTR/RTL-aware) will be calculated as a percentage.
    ///
    /// - Parameters:
    ///   - value: Percentage value between 0.0 and 1.0
    ///
    /// Supported layouts:
    /// - PercentRelativeLayout: Primary percentage margin control
    /// - PercentFrameLayout: Percentage-based positioning
    @discardableResult
    public func endMarginPercent(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.endMarginPercent(value))
        }
        return self
    }

    // MARK: Aspect Ratio

    /// Sets the aspect ratio constraint for the view.
    ///
    /// Constrains the view's dimensions to maintain a specific width:height ratio.
    ///
    /// - Parameters:
    ///   - value: Aspect ratio (width/height)
    ///
    /// Supported layouts:
    /// - ConstraintLayout: Maintains aspect ratio constraints
    /// - FlexboxLayout: Similar aspect ratio control
    /// - PercentFrameLayout: Ratio-based sizing
    /// - PercentRelativeLayout: Ratio-based dimension control
    @discardableResult
    public func aspectRatio(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.aspectRatio(value))
        }
        return self
    }
}