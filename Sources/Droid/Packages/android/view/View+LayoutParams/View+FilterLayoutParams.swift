extension View {
    func filterSubviewLayoutParams(_ subview: View) -> [LayoutParamToApply] {
        InnerLog.t("🎂 filterSubviewLayoutParams begin (\(self.id) → \(subview.id))")
        InnerLog.t("🎂 filterSubviewLayoutParams count: \(subview._layoutParamsToApply.count)")
        var paramsToApply: [LayoutParamToApply] = []
        func void() {}
        for param in subview._layoutParamsToApply {
            switch param {
            // Margin
            case .leftMargin(let value, let unit):
                paramsToApply.append(.leftMargin(value, unit))
            case .topMargin(let value, let unit):
                paramsToApply.append(.topMargin(value, unit))
            case .rightMargin(let value, let unit):
                paramsToApply.append(.rightMargin(value, unit))
            case .bottomMargin(let value, let unit):
                paramsToApply.append(.bottomMargin(value, unit))
            case .startMargin(let value, let unit):
                paramsToApply.append(.startMargin(value, unit))
            case .endMargin(let value, let unit):
                paramsToApply.append(.endMargin(value, unit))
            default: void()
            }
            if self is ViewGroup {
                switch param {
                case .width(let value, let unit):
                    paramsToApply.append(.width(value, unit))
                case .height(let value, let unit):
                    paramsToApply.append(.height(value, unit))
                default: void()
                }
            }
            switch self {
                case is LinearLayout:
                    switch param {
                    case .weight(let value):
                        paramsToApply.append(.weight(value))
                    case .minHeight(let value, let unit):
                        paramsToApply.append(.minHeight(value, unit))
                    case .maxHeight(let value, let unit):
                        paramsToApply.append(.maxHeight(value, unit))
                    case .order(let value):
                        paramsToApply.append(.order(value))
                    case .gravity(let value):
                        paramsToApply.append(.gravity(value))
                    default: void()
                    }
                case is FrameLayout:
                    switch param {
                    case .weight(let value):
                        paramsToApply.append(.weight(value))
                    case .x(let value, let unit):
                        paramsToApply.append(.x(value, unit))
                    case .y(let value, let unit):
                        paramsToApply.append(.y(value, unit))
                    case .preventEdgeOffset(let value):
                        paramsToApply.append(.preventEdgeOffset(value))
                    case .minHeight(let value, let unit):
                        paramsToApply.append(.minHeight(value, unit))
                    case .maxHeight(let value, let unit):
                        paramsToApply.append(.maxHeight(value, unit))
                    case .minWidth(let value, let unit):
                        paramsToApply.append(.minWidth(value, unit))
                    case .maxWidth(let value, let unit):
                        paramsToApply.append(.maxWidth(value, unit))
                    default: void()
                    }
                case is AbsoluteLayout:
                    switch param {
                    case .x(let value, let unit):
                        paramsToApply.append(.x(value, unit))
                    case .y(let value, let unit):
                        paramsToApply.append(.y(value, unit))
                    case .minHeight(let value, let unit):
                        paramsToApply.append(.minHeight(value, unit))
                    case .maxHeight(let value, let unit):
                        paramsToApply.append(.maxHeight(value, unit))
                    default: void()
                    }
                case is RelativeLayout:
                    switch param {
                    case .preventEdgeOffset(let value):
                        paramsToApply.append(.preventEdgeOffset(value))
                    case .minHeight(let value, let unit):
                        paramsToApply.append(.minHeight(value, unit))
                    case .maxHeight(let value, let unit):
                        paramsToApply.append(.maxHeight(value, unit))
                    case .gravity(let value):
                        paramsToApply.append(.gravity(value))
                    case .alignParentTop:
                        paramsToApply.append(.alignParentTop)
                    case .alignParentBottom:
                        paramsToApply.append(.alignParentBottom)
                    case .alignParentLeft:
                        paramsToApply.append(.alignParentLeft)
                    case .alignParentRight:
                        paramsToApply.append(.alignParentRight)
                    case .alignParentStart:
                        paramsToApply.append(.alignParentStart)
                    case .alignParentEnd:
                        paramsToApply.append(.alignParentEnd)
                    case .centerInParent:
                        paramsToApply.append(.centerInParent)
                    case .centerHorizontal:
                        paramsToApply.append(.centerHorizontal)
                    case .centerVertical:
                        paramsToApply.append(.centerVertical)
                    case .above(let value):
                        paramsToApply.append(.above(value))
                    case .below(let value):
                        paramsToApply.append(.below(value))
                    case .toLeftOf(let value):
                        paramsToApply.append(.toLeftOf(value))
                    case .toRightOf(let value):
                        paramsToApply.append(.toRightOf(value))
                    case .toStartOf(let value):
                        paramsToApply.append(.toStartOf(value))
                    case .toEndOf(let value):
                        paramsToApply.append(.toEndOf(value))
                    case .alignTop(let value):
                        paramsToApply.append(.alignTop(value))
                    case .alignBottom(let value):
                        paramsToApply.append(.alignBottom(value))
                    case .alignLeft(let value):
                        paramsToApply.append(.alignLeft(value))
                    case .alignRight(let value):
                        paramsToApply.append(.alignRight(value))
                    case .alignStart(let value):
                        paramsToApply.append(.alignStart(value))
                    case .alignEnd(let value):
                        paramsToApply.append(.alignEnd(value))
                    case .alignBaseline(let value):
                        paramsToApply.append(.alignBaseline(value))
                    default: void()
                    }
                // case is ActionMenuView:
                // case is AppBarLayout:
                // case is CoordinatorLayout:
                // case is DrawerLayout:
                // case is FlexboxLayout:
                // case is GridLayout:
                // case is MotionLayout:
                // case is PercentLayout:
                // case is SlidingPaneLayout:
                // case is TableLayout:
                // case is WindowManager:
                case is ConstraintLayout:
                    switch param {
                    case .minHeight(let value, let unit):
                        paramsToApply.append(.minHeight(value, unit))
                    case .maxHeight(let value, let unit):
                        paramsToApply.append(.maxHeight(value, unit))
                    case .minWidth(let value, let unit):
                        paramsToApply.append(.minWidth(value, unit))
                    case .maxWidth(let value, let unit):
                        paramsToApply.append(.maxWidth(value, unit))
                    case .aspectRatio(let value):
                        paramsToApply.append(.aspectRatio(value))
                    case .leftToLeft(let id):
                        paramsToApply.append(.leftToLeft(id))
                    case .leftToRight(let id):
                        paramsToApply.append(.leftToRight(id))
                    case .rightToLeft(let id):
                        paramsToApply.append(.rightToLeft(id))
                    case .rightToRight(let id):
                        paramsToApply.append(.rightToRight(id))
                    case .topToTop(let id):
                        paramsToApply.append(.topToTop(id))
                    case .topToBottom(let id):
                        paramsToApply.append(.topToBottom(id))
                    case .bottomToTop(let id):
                        paramsToApply.append(.bottomToTop(id))
                    case .bottomToBottom(let id):
                        paramsToApply.append(.bottomToBottom(id))
                    case .startToStart(let id):
                        paramsToApply.append(.startToStart(id))
                    case .startToEnd(let id):
                        paramsToApply.append(.startToEnd(id))
                    case .endToStart(let id):
                        paramsToApply.append(.endToStart(id))
                    case .endToEnd(let id):
                        paramsToApply.append(.endToEnd(id))
                    case .baselineToBaseline(let id):
                        paramsToApply.append(.baselineToBaseline(id))
                    case .matchConstraintDefaultWidth(let id):
                        paramsToApply.append(.matchConstraintDefaultWidth(id))
                    case .matchConstraintDefaultHeight(let id):
                        paramsToApply.append(.matchConstraintDefaultHeight(id))
                    case .matchConstraintMinWidth(let id):
                        paramsToApply.append(.matchConstraintMinWidth(id))
                    case .matchConstraintMinHeight(let id):
                        paramsToApply.append(.matchConstraintMinHeight(id))
                    case .matchConstraintMaxWidth(let id):
                        paramsToApply.append(.matchConstraintMaxWidth(id))
                    case .matchConstraintMaxHeight(let id):
                        paramsToApply.append(.matchConstraintMaxHeight(id))
                    case .matchConstraintPercentWidth(let value):
                        paramsToApply.append(.matchConstraintPercentWidth(value))
                    case .matchConstraintPercentHeight(let value):
                        paramsToApply.append(.matchConstraintPercentHeight(value))
                    case .horizontalBias(let value):
                        paramsToApply.append(.horizontalBias(value))
                    case .verticalBias(let value):
                        paramsToApply.append(.verticalBias(value))
                    case .horizontalChainStyle(let value):
                        paramsToApply.append(.horizontalChainStyle(value))
                    case .verticalChainStyle(let value):
                        paramsToApply.append(.verticalChainStyle(value))
                    case .chainUseRtl(let value):
                        paramsToApply.append(.chainUseRtl(value))
                    case .circleConstraint(let id):
                        paramsToApply.append(.circleConstraint(id))
                    case .circleRadius(let value):
                        paramsToApply.append(.circleRadius(value))
                    case .circleAngle(let value):
                        paramsToApply.append(.circleAngle(value))
                    case .dimensionRatio(let value):
                        paramsToApply.append(.dimensionRatio(value))
                    case .goneTopMargin(let value, let unit):
                        paramsToApply.append(.goneTopMargin(value, unit))
                    case .goneBottomMargin(let value, let unit):
                        paramsToApply.append(.goneBottomMargin(value, unit))
                    case .goneLeftMargin(let value, let unit):
                        paramsToApply.append(.goneLeftMargin(value, unit))
                    case .goneRightMargin(let value, let unit):
                        paramsToApply.append(.goneRightMargin(value, unit))
                    case .goneStartMargin(let value, let unit):
                        paramsToApply.append(.goneStartMargin(value, unit))
                    case .goneEndMargin(let value, let unit):
                        paramsToApply.append(.goneEndMargin(value, unit))
                    default: void()
                    }
                default: void()
            }
        }
        return paramsToApply
    }
}