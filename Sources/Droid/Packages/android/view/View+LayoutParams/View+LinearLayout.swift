// MARK: LinearLayout - Layout Params
extension View {
    /// Sets the weight of the view within a LinearLayout.
    ///
    /// Determines how much extra space in the layout should be allocated to the view.
    /// Higher weight values receive proportionally more space.
    ///
    /// - Parameters:
    ///   - value: The weight value
    ///
    /// Supported layouts:
    /// - LinearLayout: Primary weight-based space distribution
    /// - GridLayout: Similar weight concept for row/column sizing
    /// - FlexboxLayout: Similar behavior with flexGrow property
    /// - TableLayout: Affects cell sizing in weighted columns
    /// - ConstraintLayout: Similar space distribution with chains
    /// - FrameLayout: Can influence weighted view positioning
    @discardableResult
    public func weight(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(WeightLayoutParam(value: value))
        }
        return self
    }
}