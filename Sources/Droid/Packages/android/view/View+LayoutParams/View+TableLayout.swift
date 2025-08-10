// MARK: TableLayout - Layout Params
extension View {
    // column (already present above)

    /// Sets the number of columns the cell should span in a TableLayout.
    ///
    /// Allows a table cell to occupy multiple adjacent columns.
    ///
    /// - Parameters:
    ///   - value: Number of columns to span (minimum 1)
    ///
    /// Supported layouts:
    /// - TableLayout: Primary column spanning behavior
    /// - GridLayout: Similar column spanning capability
    /// - FlexboxLayout: Similar concept with flex items spanning multiple lines
    @discardableResult
    public func span(_ value: Int) -> Self {
        SpanLayoutParam(value: value).applyOrAppend(self)
    }
}