enum LayoutParamToApply {
        // ViewGroup
        case width(LayoutParams.LayoutSize, DimensionUnit)
        case height(LayoutParams.LayoutSize, DimensionUnit)
        // MarginLayoutParams
        case leftMargin(Int, DimensionUnit)
        case topMargin(Int, DimensionUnit)
        case rightMargin(Int, DimensionUnit)
        case bottomMargin(Int, DimensionUnit)
        case startMargin(Int, DimensionUnit)
        case endMargin(Int, DimensionUnit)
        // FrameLayout
        case gravity(Gravity)
        // LinearLayout
        case weight(Float)
        // RelativeLayout
        // - Relative to Parent
        case alignParentTop
        case alignParentBottom
        case alignParentLeft
        case alignParentRight
        case alignParentStart
        case alignParentEnd
        case centerInParent
        case centerHorizontal
        case centerVertical
        // - Relative to Other Views
        case above(Int32)
        case below(Int32)
        case toLeftOf(Int32)
        case toRightOf(Int32)
        case toStartOf(Int32)
        case toEndOf(Int32)
        case alignTop(Int32)
        case alignBottom(Int32)
        case alignLeft(Int32)
        case alignRight(Int32)
        case alignStart(Int32)
        case alignEnd(Int32)
        case alignBaseline(Int32)
        // ConstraintLayout
        // - Directional Constraints
        case leftToLeft(Int32)
        case leftToRight(Int32)
        case rightToLeft(Int32)
        case rightToRight(Int32)
        case topToTop(Int32)
        case topToBottom(Int32)
        case bottomToTop(Int32)
        case bottomToBottom(Int32)
        case startToStart(Int32)
        case startToEnd(Int32)
        case endToStart(Int32)
        case endToEnd(Int32)
        case baselineToBaseline(Int32)
        // - Dimensions
        case matchConstraintDefaultWidth(Int32)
        case matchConstraintDefaultHeight(Int32)
        case matchConstraintMinWidth(Int32)
        case matchConstraintMinHeight(Int32)
        case matchConstraintMaxWidth(Int32)
        case matchConstraintMaxHeight(Int32)
        case matchConstraintPercentWidth(Float)
        case matchConstraintPercentHeight(Float)
        // - Bias (Alignment)
        case horizontalBias(Float)
        case verticalBias(Float)
        // - Chains & Barriers
        case horizontalChainStyle(Int32)
        case verticalChainStyle(Int32)
        case chainUseRtl(Bool)
        // - Circular Positioning
        case circleConstraint(Int32)
        case circleRadius(Int32)
        case circleAngle(Float)
        // - Aspect Ratio
        case dimensionRatio(String)
        // - View Visibility Behavior
        case goneTopMargin(Int, DimensionUnit)
        case goneBottomMargin(Int, DimensionUnit)
        case goneLeftMargin(Int, DimensionUnit)
        case goneRightMargin(Int, DimensionUnit)
        case goneStartMargin(Int, DimensionUnit)
        case goneEndMargin(Int, DimensionUnit)
        // GridLayout
        // - Cell Position & Span
        case columnSpec//(Spec)
        case rowSpec//(Spec)
        // - Shortcut Fields (Alternative to Spec)
        case column(Int)
        case row(Int)
        case columnSpan(Int)
        case rowSpan(Int)
        // TableLayout
        // case column(Int)
        case span(Int)
        // CoordinatorLayout
        // - Behavior-Assignment
        case behavior//(CoordinatorLayout.Behavior)
        // - Anchoring
        case anchorId(Int32)
        case anchorGravity(Gravity)
        // - Insets
        case dodgeInsetEdges(Int32)
        case insetEdge(Int32)
        // - Keyline
        case keyline(Int32)
        // AppBarLayout
        // - Scroll Flags
        case scrollFlags//(bitmask)
        // - Collapse
        case scrollEffect//(AppBarLayout.ChildScrollEffect)
        case liftOnScroll(Bool)
        // - Minimum/Maximum Height
        case minHeight(Int, DimensionUnit)
        case maxHeight(Int, DimensionUnit)
        // PercentFrameLayout, PercentRelativeLayout
        // - Percentage-Based Dimensions
        case widthPercent(Float)
        case heightPercent(Float)
        // - Percentage Margins
        case leftMarginPercent(Float)
        case topMarginPercent(Float)
        case rightMarginPercent(Float)
        case bottomMarginPercent(Float)
        case startMarginPercent(Float)
        case endMarginPercent(Float)
        // - Aspect Ratio
        case aspectRatio(Float)
        // MotionLayout
        // - Motion Scene Parameters
        case motionDebug(Int32)
        case progress(Float)
        case currentState(Int32)
        case motionTarget(Int32)
        // - Path/Animation Control
        case pathMotionArc(Int32)
        case motionStagger(Float)
        case transitionEasing(String)
        // - Constraint Overrides
        case applyMotionScene(Bool)
        case constraintTag(String)
        // - Dimension Control
        case widthDefault(Int32)
        case heightDefault(Int32)
        // - Custom Attributes
        case mCustom(String)
        // AbsoluteLayout
        case x(Int, DimensionUnit)
        case y(Int, DimensionUnit)
        // SlidingPaneLayout
        case slideable(Bool)
        // case weight(Float)
        // DrawerLayout
        case isPeeking(Bool)
        case onScreen(Float)
        // ActionMenuView
        case isOverflow(Bool)
        case cellsUsed(Int32)
        case expandable(Bool)
        case preventEdgeOffset(Bool)
        // WindowManager.
        // - Window Type & Flags
        case type(Int32)
        case flags//(bitmask)
        case privateFlags//(bitmask)
        // - Visual Effects
        case dimAmount(Float)
        case alpha(Float)
        case windowAnimations(Int32)
        case rotation(Float)
        // - Input & Focus
        case softInputMode(Int32)
        case screenOrientation(Int32)
        case preferredRefreshRate(Float)
        // - System UI Control
        case systemUiVisibility(Int32)
        case fitInsetsTypes(Int32)
        case layoutInDisplayCutoutMode(Int32)
        // FlexboxLayout
        // - Flex Item Attributes
        case order(Int)
        case flexGrow(Float)
        case flexShrink(Float)
        case flexBasisPercent(Float)
        case alignSelf(Int32)
        // - Wrapping Control
        case wrapBefore(Bool)
        // - Minimum/Maximum Dimensions
        case minWidth(Int, DimensionUnit)
        // case minHeight(Int32)
        case maxWidth(Int, DimensionUnit)
        // case maxHeight(Int32)
    }