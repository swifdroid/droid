// MARK: ActionMenuView - Layout Params
extension View {
    /// **ActionMenuViewParams**
    /// 
    /// Marks the view as an overflow menu item in an `ActionMenuView`.
    ///
    /// When set to `true`, the view will be displayed in the overflow menu instead of the main action bar.
    ///
    /// - Parameters:
    ///   - value: Boolean indicating whether the view is an overflow item.
    @discardableResult
    public func isOverflow(_ value: Bool = true) -> Self {
        IsOverflowButtonLayoutParam(value: value).applyOrAppend(self)
    }

    /// **ActionMenuViewParams**
    /// 
    /// Sets the number of cells used by the view in an `ActionMenuView`.
    ///
    /// Defines how many grid cells the view occupies in the action menu layout.
    ///
    /// - Parameters:
    ///   - value: Number of cells occupied (Int32).
    @discardableResult
    public func cellsUsed(_ value: Int32) -> Self {
        CellsUsedLayoutParam(value: value).applyOrAppend(self)
    }

    /// **ActionMenuViewParams**
    /// 
    /// Enables or disables extra pixels behavior for the view in an `ActionMenuView`.
    @discardableResult
    public func extraPixels(_ value: Bool = true) -> Self {
        ExtraPixelsLayoutParam(value: value).applyOrAppend(self)
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
    public func expandable(_ value: Bool = true) -> Self {
        ExpandableLayoutParam(value: value).applyOrAppend(self)
    }
}