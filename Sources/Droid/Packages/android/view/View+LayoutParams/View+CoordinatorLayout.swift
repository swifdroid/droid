// MARK: CoordinatorLayout - Layout Params
extension View {
    // MARK: Behavior-Assignment

    /// Sets the behavior for the view within a CoordinatorLayout.
    ///
    /// Defines how the view interacts with scrolling and other view changes.
    ///
    /// - Parameters:
    ///   - value: Behavior type
    ///
    /// Supported layouts:
    /// - CoordinatorLayout: Exclusive behavior control for coordinated views
    @discardableResult
    public func behavior(_ value: String) -> Self { // TODO: CoordinatorLayout.Behavior
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.behavior) // TODO: CoordinatorLayout.Behavior
        }
        return self
    }

    // MARK: Anchoring

    /// Sets the anchor view ID for this view's positioning.
    ///
    /// The view will be positioned relative to the specified anchor view.
    ///
    /// - Parameters:
    ///   - id: The view ID to use as anchor
    ///
    /// Supported layouts:
    /// - CoordinatorLayout: Controls view anchoring behavior
    /// - RelativeLayout: Similar anchor concept through layout rules
    @discardableResult
    public func anchorId(_ id: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.anchorId(id))
        }
        return self
    }

    /// Sets the gravity for the view relative to its anchor.
    ///
    /// Defines how the view is positioned relative to its anchor point.
    ///
    /// - Parameters:
    ///   - value: Gravity flags
    ///
    /// Supported layouts:
    /// - CoordinatorLayout: Controls anchored view positioning
    /// - FrameLayout: Similar gravity concept for child views
    /// - RelativeLayout: Uses gravity for view alignment
    @discardableResult
    public func anchorGravity(_ value: Gravity) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.anchorGravity(value))
        }
        return self
    }

    // MARK: Insets

    /// Sets the edges that should be dodged by other views.
    ///
    /// Defines which edges should avoid overlapping with this view.
    ///
    /// - Parameters:
    ///   - value: Edge flags
    ///
    /// Supported layouts:
    /// - CoordinatorLayout: Manages view overlap avoidance
    /// - DrawerLayout: Similar edge avoidance behavior
    @discardableResult
    public func dodgeInsetEdges(_ value: Int32) -> Self { // TODO: Edge flags type
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.dodgeInsetEdges(value)) // TODO: Edge flags type
        }
        return self
    }

    /// Sets the edges that should be inset for this view.
    ///
    /// Defines which edges should be inset from the parent's bounds.
    ///
    /// - Parameters:
    ///   - value: Edge flags
    ///
    /// Supported layouts:
    /// - CoordinatorLayout: Controls view insetting behavior
    /// - DrawerLayout: Similar edge insetting concept
    /// - WindowManager: Used for window insets in system UI
    @discardableResult
    public func insetEdge(_ value: Int32) -> Self { // TODO: Edge flags type
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.insetEdge(value)) // TODO: Edge flags type
        }
        return self
    }

    // MARK: Keyline

    /// Sets the keyline for view positioning.
    ///
    /// Defines the vertical guideline for view alignment.
    ///
    /// - Parameters:
    ///   - value: Keyline position
    ///
    /// Supported layouts:
    /// - CoordinatorLayout: Used for material design guideline alignment
    /// - MotionLayout: Similar concept for motion keyframes
    @discardableResult
    public func keyline(_ value: Int32) -> Self { // TODO: position type
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.keyline(value)) // TODO: position type
        }
        return self
    }
}