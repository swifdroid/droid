// MARK: DrawerLayout - Layout Params
extension View {
    /// Enables or disables the peeking behavior for a drawer view.
    ///
    /// When enabled, the drawer will show a portion of its content while closed.
    ///
    /// - Parameters:
    ///   - value: Boolean to enable/disable peeking behavior
    ///
    /// Supported layouts:
    /// - DrawerLayout: Exclusive peeking behavior for drawer views
    /// - SlidingPaneLayout: Similar partial visibility when collapsed
    @discardableResult
    public func isPeeking(_ value: Bool) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(IsPeekingLayoutParam(value: value))
        }
        return self
    }

    /// Sets the percentage of the view that should remain on screen when closed.
    ///
    /// Defines how much of the drawer remains visible in the closed state.
    ///
    /// - Parameters:
    ///   - value: Percentage of visible content (0.0 to 1.0)
    ///
    /// Supported layouts:
    /// - DrawerLayout: Controls drawer visibility when closed
    /// - SlidingPaneLayout: Similar concept for pane visibility
    /// - CoordinatorLayout: Can affect partially visible anchored views
    @discardableResult
    public func onScreen(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(OnScreenLayoutParam(value: value))
        }
        return self
    }
}