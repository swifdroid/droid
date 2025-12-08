// MARK: RelativeLayout - Layout Params
extension View {
    // MARK: Relative to Parent

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view to the top edge of its parent container.
    ///
    /// Positions the view's top edge flush with the parent's top edge.
    @discardableResult
    public func alignParentTop() -> Self {
        AlignParentTopLayoutParam().applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view to the bottom edge of its parent container.
    ///
    /// Positions the view's bottom edge flush with the parent's bottom edge.
    @discardableResult
    public func alignParentBottom() -> Self {
        AlignParentBottomLayoutParam().applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view to the left edge of its parent container.
    ///
    /// Positions the view's left edge flush with the parent's left edge.
    @discardableResult
    public func alignParentLeft() -> Self {
        AlignParentLeftLayoutParam().applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view to the right edge of its parent container.
    ///
    /// Positions the view's right edge flush with the parent's right edge.
    @discardableResult
    public func alignParentRight() -> Self {
        AlignParentRightLayoutParam().applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view to the start edge of its parent container (LTR/RTL-aware).
    ///
    /// Positions the view's start edge flush with the parent's start edge.
    @discardableResult
    public func alignParentStart() -> Self {
        AlignParentStartLayoutParam().applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view to the end edge of its parent container (LTR/RTL-aware).
    ///
    /// Positions the view's end edge flush with the parent's end edge.
    @discardableResult
    public func alignParentEnd() -> Self {
        AlignParentEndLayoutParam().applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Centers the view both horizontally and vertically within its parent.
    ///
    /// Positions the view at the exact center of the parent container.
    @discardableResult
    public func centerInParent() -> Self {
        CenterInParentLayoutParam().applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Centers the view horizontally within its parent.
    ///
    /// Aligns the view to the horizontal center of the parent container.
    @discardableResult
    public func centerHorizontal() -> Self {
        CenterHorizontalLayoutParam().applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Centers the view vertically within its parent.
    ///
    /// Aligns the view to the vertical center of the parent container.
    @discardableResult
    public func centerVertical() -> Self {
        CenterVerticalLayoutParam().applyOrAppend(self)
    }

    // MARK: Relative to Other Views

    /// **RelativeLayoutParams**
    /// 
    /// Positions the view above the specified view.
    ///
    /// Places this view immediately above another view in the layout.
    ///
    /// - Parameters:
    ///   - id: The view ID to position above
    @discardableResult
    public func above(_ id: Int32) -> Self {
        AboveLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Positions the view below the specified view.
    ///
    /// Places this view immediately below another view in the layout.
    ///
    /// - Parameters:
    ///   - id: The view ID to position below
    @discardableResult
    public func below(_ id: Int32) -> Self {
        BelowLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Positions the view to the left of the specified view.
    ///
    /// Places this view immediately to the left of another view.
    ///
    /// - Parameters:
    ///   - id: The view ID to position left of
    @discardableResult
    public func toLeftOf(_ id: Int32) -> Self {
        ToLeftOfLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Positions the view to the right of the specified view.
    ///
    /// Places this view immediately to the right of another view.
    ///
    /// - Parameters:
    ///   - id: The view ID to position right of
    @discardableResult
    public func toRightOf(_ id: Int32) -> Self {
        ToRightOfLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Positions the view to the start of the specified view (LTR/RTL-aware).
    ///
    /// Places this view at the start side of another view.
    ///
    /// - Parameters:
    ///   - id: The view ID to position start of
    @discardableResult
    public func toStartOf(_ id: Int32) -> Self {
        ToStartOfLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Positions the view to the end of the specified view (LTR/RTL-aware).
    ///
    /// Places this view at the end side of another view.
    ///
    /// - Parameters:
    ///   - id: The view ID to position end of
    @discardableResult
    public func toEndOf(_ id: Int32) -> Self {
        ToEndOfLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view's top edge with another view's top edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    @discardableResult
    public func alignTop(_ id: Int32) -> Self {
        AlignTopLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view's bottom edge with another view's bottom edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    @discardableResult
    public func alignBottom(_ id: Int32) -> Self {
        AlignBottomLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view's left edge with another view's left edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    @discardableResult
    public func alignLeft(_ id: Int32) -> Self {
        AlignLeftLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view's right edge with another view's right edge.
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    @discardableResult
    public func alignRight(_ id: Int32) -> Self {
        AlignRightLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view's start edge with another view's start edge (LTR/RTL-aware).
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    @discardableResult
    public func alignStart(_ id: Int32) -> Self {
        AlignStartLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view's end edge with another view's end edge (LTR/RTL-aware).
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    @discardableResult
    public func alignEnd(_ id: Int32) -> Self {
        AlignEndLayoutParam(id: id).applyOrAppend(self)
    }

    /// **RelativeLayoutParams**
    /// 
    /// Aligns the view's baseline with another view's baseline.
    ///
    /// Typically used for text alignment between views.
    ///
    /// - Parameters:
    ///   - id: The view ID to align with
    @discardableResult
    public func alignBaseline(_ id: Int32) -> Self {
        AlignBaselineLayoutParam(id: id).applyOrAppend(self)
    }
}