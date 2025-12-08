// MARK: CoordinatorLayout - Layout Params
extension View {
    // MARK: Behavior-Assignment

    /// **CoordinatorLayoutParams**
    /// 
    /// Sets the behavior for the view within a CoordinatorLayout.
    ///
    /// Defines how the view interacts with scrolling and other view changes.
    ///
    /// - Parameters:
    ///   - value: Behavior type
    @discardableResult
    public func behavior(_ value: Behavior) -> Self {
        BehaviorLayoutParam(value: value).applyOrAppend(self)
    }

    // MARK: Anchoring

    /// **CoordinatorLayoutParams**
    /// 
    /// Sets the anchor view ID for this view's positioning.
    ///
    /// The view will be positioned relative to the specified anchor view.
    ///
    /// - Parameters:
    ///   - id: The view ID to use as anchor
    @discardableResult
    public func anchorId(_ id: Int32) -> Self {
        AnchorIdLayoutParam(value: id).applyOrAppend(self)
    }

    /// **CoordinatorLayoutParams**
    /// 
    /// Sets the gravity for the view relative to its anchor.
    ///
    /// Defines how the view is positioned relative to its anchor point.
    ///
    /// - Parameters:
    ///   - value: Gravity flags
    @discardableResult
    public func anchorGravity(_ value: Gravity) -> Self {
        AnchorGravityLayoutParam(value: value).applyOrAppend(self)
    }

    // MARK: Insets

    /// **CoordinatorLayoutParams**
    /// 
    /// Sets the edges that should be dodged by other views.
    ///
    /// Defines which edges should avoid overlapping with this view.
    ///
    /// - Parameters:
    ///   - value: Edge flags
    @discardableResult
    public func dodgeInsetEdges(_ value: Gravity) -> Self { // TODO: Edge flags type
        DodgeInsetEdgesLayoutParam(value: value).applyOrAppend(self) // TODO: Edge flags type
    }

    /// **CoordinatorLayoutParams**
    /// 
    /// Sets the edges that should be inset for this view.
    ///
    /// Defines which edges should be inset from the parent's bounds.
    ///
    /// - Parameters:
    ///   - value: Edge flags
    @discardableResult
    public func insetEdge(_ value: Gravity) -> Self { // TODO: Edge flags type
        InsetEdgeLayoutParam(value: value).applyOrAppend(self) // TODO: Edge flags type
    }

    // MARK: Keyline

    /// **CoordinatorLayoutParams**
    /// 
    /// Sets the keyline for view positioning.
    ///
    /// Defines the vertical guideline for view alignment.
    ///
    /// - Parameters:
    ///   - value: Keyline position
    @discardableResult
    public func keyline(_ value: Int32) -> Self { // TODO: position type
        KeylineLayoutParam(value: value).applyOrAppend(self) // TODO: position type
    }
}