// MARK: ActionMenuView - Layout Params
extension View {
    /// Marks the view as an overflow menu item in an `ActionMenuView`.
    ///
    /// When set to `true`, the view will be displayed in the overflow menu instead of the main action bar.
    ///
    /// - Parameters:
    ///   - value: Boolean indicating whether the view is an overflow item.
    ///
    /// Supported layouts:
    /// - ActionMenuView: Exclusive to `ActionMenuView` for overflow menu handling.
    @discardableResult
    public func isOverflow(_ value: Bool) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.isOverflow(value))
        }
        return self
    }

    /// Sets the number of cells used by the view in an `ActionMenuView`.
    ///
    /// Defines how many grid cells the view occupies in the action menu layout.
    ///
    /// - Parameters:
    ///   - value: Number of cells occupied (Int32).
    ///
    /// Supported layouts:
    /// - ActionMenuView: Used for cell-based layout calculations.
    /// - GridLayout: Similar cell-spanning behavior for grid items.
    /// - TableLayout: Affects cell allocation in table rows.
    @discardableResult
    public func cellsUsed(_ value: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.cellsUsed(value))
        }
        return self
    }

    /// Enables or disables expandable behavior for the view in an `ActionMenuView`.
    ///
    /// When `true`, the view can expand to show additional content or options.
    ///
    /// - Parameters:
    ///   - value: Boolean to enable/disable expandable behavior.
    ///
    /// Supported layouts:
    /// - ActionMenuView: Used for expandable action items.
    /// - SlidingPaneLayout: Allows expandable/collapsible pane behavior.
    /// - DrawerLayout: Supports expandable/collapsible drawer views.
    @discardableResult
    public func expandable(_ value: Bool) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.expandable(value))
        }
        return self
    }

    /// Prevents edge offset adjustments for the view in an `ActionMenuView`.
    ///
    /// When `true`, the view will not be adjusted for edge alignment or padding.
    ///
    /// - Parameters:
    ///   - value: Boolean to prevent edge offset adjustments.
    ///
    /// Supported layouts:
    /// - ActionMenuView: Disables edge offset for precise positioning.
    /// - CoordinatorLayout: Overrides edge insets for child views.
    /// - FrameLayout: Skips edge padding adjustments.
    /// - RelativeLayout: Prevents automatic edge snapping.
    @discardableResult
    public func preventEdgeOffset(_ value: Bool) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.preventEdgeOffset(value))
        }
        return self
    }
}