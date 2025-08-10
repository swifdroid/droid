// MARK: FrameLayout - Layout Params
extension View {
    /// Sets the gravity for the view within its container.
    ///
    /// Controls the alignment and positioning of the view within its parent container.
    ///
    /// - Parameters:
    ///   - value: Gravity flags (Gravity) combining one horizontal and one vertical constant
    ///
    /// Supported layouts:
    /// - FrameLayout: Primary gravity-based positioning system
    /// - LinearLayout: Affects view alignment in orientation axis
    /// - RelativeLayout: Used for view alignment rules
    /// - TableLayout: Controls cell content alignment
    /// - GridLayout: Manages cell content positioning
    /// - CoordinatorLayout: Influences anchored view placement
    /// - FlexboxLayout: Similar alignment concepts for flex items
    /// - AppBarLayout: Affects toolbar item positioning
    /// - DrawerLayout: Controls drawer view alignment
    /// - WindowManager: Used for window positioning in screen space
    @discardableResult
    public func gravityInParent(_ value: Gravity) -> Self {
        GravityLayoutParam(value: value).applyOrAppend(self)
    }
}