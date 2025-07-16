// MARK: GridLayout - Layout Params
extension View {
    // MARK: Cell Position & Span

    /// Sets the column specification for the view in a GridLayout.
    ///
    /// Defines the column behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - value: Column specification (Spec)
    ///
    /// Supported layouts:
    /// - GridLayout: Primary column definition mechanism
    /// - TableLayout: Similar column behavior for table cells
    @discardableResult
    public func columnSpec(_ value: String) -> Self { // TODO: Spec
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.columnSpec)//(value)) // TODO: Spec
        }
        return self
    }

    /// Sets the row specification for the view in a GridLayout.
    ///
    /// Defines the row behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - value: Row specification (Spec)
    ///
    /// Supported layouts:
    /// - GridLayout: Primary row definition mechanism
    /// - TableLayout: Similar row behavior for table cells
    @discardableResult
    public func rowSpec(_ value: String) -> Self { // TODO: Spec
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.rowSpec)//(value)) // TODO: Spec
        }
        return self
    }

    // MARK: Shortcut Fields (Alternative to Spec)

    /// Sets the column index for the view in a GridLayout.
    ///
    /// Positions the view in the specified zero-based grid column.
    ///
    /// - Parameters:
    ///   - value: Column index
    ///
    /// Supported layouts:
    /// - GridLayout: Primary column positioning
    /// - TableLayout: Similar column positioning
    @discardableResult
    public func column(_ value: Int) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.column(value))
        }
        return self
    }

    /// Sets the row index for the view in a GridLayout.
    ///
    /// Positions the view in the specified zero-based grid row.
    ///
    /// - Parameters:
    ///   - value: Row index
    ///
    /// Supported layouts:
    /// - GridLayout: Primary row positioning
    /// - TableLayout: Similar row positioning
    @discardableResult
    public func row(_ value: Int) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.row(value))
        }
        return self
    }

    /// Sets the number of columns the view spans in a GridLayout.
    ///
    /// Allows the view to occupy multiple adjacent columns.
    ///
    /// - Parameters:
    ///   - value: Number of columns to span
    ///
    /// Supported layouts:
    /// - GridLayout: Primary column spanning behavior
    /// - TableLayout: Similar column spanning for cells
    /// - FlexboxLayout: Similar concept with flex items
    @discardableResult
    public func columnSpan(_ value: Int) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.columnSpan(value))
        }
        return self
    }

    /// Sets the number of rows the view spans in a GridLayout.
    ///
    /// Allows the view to occupy multiple adjacent rows.
    ///
    /// - Parameters:
    ///   - value: Number of rows to span
    ///
    /// Supported layouts:
    /// - GridLayout: Primary row spanning behavior
    /// - TableLayout: Similar row spanning for cells
    /// - FlexboxLayout: Similar concept with flex items
    @discardableResult
    public func rowSpan(_ value: Int) -> Self {
        if let _ = instance {
            // TODO:
        } else {
            _layoutParamsToApply.append(.rowSpan(value))
        }
        return self
    }
}