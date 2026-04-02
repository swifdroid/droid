// MARK: TableRow - Layout Params
extension View {
    /// TableRow.LayoutParams
    ///
    /// Places this cell at the specified zero-based column index in a TableRow.
    ///
    /// - Parameter value: Zero-based column index.
    @discardableResult
    public func column(_ value: Int) -> Self {
        ColumnLayoutParam(value: value).applyOrAppend(self)
    }

    /// TableRow.LayoutParams
    ///
    /// Sets the number of columns the cell should span in a TableRow.
    ///
    /// Allows a table cell to occupy multiple adjacent columns.
    ///
    /// - Parameter value: Number of columns to span.
    @discardableResult
    public func span(_ value: Int) -> Self {
        SpanLayoutParam(value: value).applyOrAppend(self)
    }
}
