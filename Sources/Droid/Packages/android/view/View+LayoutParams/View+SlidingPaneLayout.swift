// MARK: SlidingPaneLayout - Layout Params
extension View {
    /// Enables or disables sliding behavior for the pane view.
    ///
    /// When enabled, the view can be dragged or programmatically slid open/closed.
    ///
    /// - Parameters:
    ///   - value: Boolean to enable/disable sliding capability
    ///
    /// Supported layouts:
    /// - SlidingPaneLayout: Primary sliding behavior control
    /// - DrawerLayout: Similar concept for drawer sliding behavior
    /// - CoordinatorLayout: Similar behavior for anchored sliding views
    @discardableResult
    public func slideable(_ value: Bool) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(SlideableLayoutParam(value: value))
        }
        return self
    }

    // weight
}