// MARK: MotionLayout - Layout Params
extension View {
    // MARK: Motion Scene Parameters

    /// Sets the debug mode for motion layout visualization.
    ///
    /// Controls the visualization of motion paths and constraints during debugging.
    ///
    /// - Parameters:
    ///   - value: Debug flag
    ///
    /// Supported layouts:
    /// - MotionLayout: Exclusive debug visualization feature
    @discardableResult
    public func motionDebug(_ value: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.motionDebug(value))
        }
        return self
    }

    /// Sets the animation progress between constraint sets.
    ///
    /// Defines the current position in the animation transition (0.0 to 1.0).
    ///
    /// - Parameters:
    ///   - value: Progress value
    ///
    /// Supported layouts:
    /// - MotionLayout: Primary animation progress control
    /// - CoordinatorLayout: Similar concept for coordinated animations
    @discardableResult
    public func progress(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.progress(value))
        }
        return self
    }

    /// Sets the current constraint set state.
    ///
    /// Immediately transitions to the specified constraint set state.
    ///
    /// - Parameters:
    ///   - value: State ID
    ///
    /// Supported layouts:
    /// - MotionLayout: Primary state management
    /// - ConstraintLayout: Similar concept with constraint sets
    @discardableResult
    public func currentState(_ value: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.currentState(value))
        }
        return self
    }

    /// Sets the target view for motion constraints.
    ///
    /// Specifies which view's motion path should be followed.
    ///
    /// - Parameters:
    ///   - value: Target view ID
    ///
    /// Supported layouts:
    /// - MotionLayout: Exclusive motion path targeting
    @discardableResult
    public func motionTarget(_ value: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.motionTarget(value))
        }
        return self
    }

    // MARK: Path/Animation Control

    /// Sets the type of arc for motion path interpolation.
    ///
    /// Controls whether motion follows a straight line or curved arc.
    ///
    /// - Parameters:
    ///   - value: Arc type constant
    ///
    /// Supported layouts:
    /// - MotionLayout: Exclusive path arc control
    @discardableResult
    public func pathMotionArc(_ value: Int32) -> Self { // TODO: Arc type constant
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.pathMotionArc(value)) // TODO: Arc type constant
        }
        return self
    }

    /// Sets the stagger value for motion animation.
    ///
    /// Delays the animation of this view relative to others.
    ///
    /// - Parameters:
    ///   - value: Stagger delay factor
    ///
    /// Supported layouts:
    /// - MotionLayout: Primary stagger animation control
    /// - CoordinatorLayout: Similar behavior for coordinated animations
    @discardableResult
    public func motionStagger(_ value: Float) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.motionStagger(value))
        }
        return self
    }

    /// Sets the easing function for motion transitions.
    ///
    /// Defines the acceleration curve of the animation.
    ///
    /// - Parameters:
    ///   - value: Easing function name
    ///
    /// Supported layouts:
    /// - MotionLayout: Primary transition easing control
    /// - CoordinatorLayout: Similar easing for coordinated animations
    /// - WindowManager: Used for window transition animations
    @discardableResult
    public func transitionEasing(_ value: String) -> Self { // TODO: easing function enum
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.transitionEasing(value)) // TODO: easing function enum
        }
        return self
    }

    // MARK: Constraint Overrides

    /// Enables or disables motion scene application for the view.
    ///
    /// When true, the view will participate in motion scene animations.
    ///
    /// - Parameters:
    ///   - value: Boolean to enable/disable motion scene application
    ///
    /// Supported layouts:
    /// - MotionLayout: Primary motion scene participation control
    /// - ConstraintLayout: Similar concept for constraint sets
    @discardableResult
    public func applyMotionScene(_ value: Bool) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.applyMotionScene(value))
        }
        return self
    }

    /// Sets a tag for identifying constraints in motion scenes.
    ///
    /// Provides a way to reference specific constraints in motion scene files.
    ///
    /// - Parameters:
    ///   - value: Unique constraint identifier
    ///
    /// Supported layouts:
    /// - MotionLayout: Primary use for tagged constraints
    /// - ConstraintLayout: Similar tagging for constraint identification
    @discardableResult
    public func constraintTag(_ value: String) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.constraintTag(value))
        }
        return self
    }

    // MARK: Dimension Control

    /// Sets the default width behavior for the view in motion animations.
    ///
    /// Defines how the view's width should be calculated by default.
    ///
    /// - Parameters:
    ///   - value: Default width mode (WRAP_CONTENT, MATCH_CONSTRAINT, etc.)
    ///
    /// Supported layouts:
    /// - MotionLayout: Controls default width in motion transitions
    /// - ConstraintLayout: Similar default width behavior
    /// - FlexboxLayout: Similar concept for flex item sizing
    @discardableResult
    public func widthDefault(_ value: Int32) -> Self { // TODO: width mode enum, do the research
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.widthDefault(value)) // TODO: width mode enum, do the research
        }
        return self
    }

    /// Sets the default height behavior for the view in motion animations.
    ///
    /// Defines how the view's height should be calculated by default.
    ///
    /// - Parameters:
    ///   - value: Default height mode (WRAP_CONTENT, MATCH_CONSTRAINT, etc.)
    ///
    /// Supported layouts:
    /// - MotionLayout: Controls default height in motion transitions
    /// - ConstraintLayout: Similar default height behavior
    /// - FlexboxLayout: Similar concept for flex item sizing
    @discardableResult
    public func heightDefault(_ value: Int32) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.heightDefault(value))
        }
        return self
    }

    // MARK: Custom Attributes

    /// Sets custom motion attributes for the view.
    ///
    /// Allows specifying specialized motion parameters through string attributes.
    ///
    /// - Parameters:
    ///   - value: Custom motion attribute string
    ///
    /// Supported layouts:
    /// - MotionLayout: Primary use for custom motion attributes
    /// - CoordinatorLayout: Similar custom behavior attributes
    @discardableResult
    public func mCustom(_ value: String) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.mCustom(value))
        }
        return self
    }
}