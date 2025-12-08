// MARK: TableLayout - Layout Params
extension View {
    // TODO: ??? column (already present?)

    /// **TableLayoutParams**
    /// 
    /// Sets the number of columns the cell should span in a TableLayout.
    ///
    /// Allows a table cell to occupy multiple adjacent columns.
    ///
    /// - Parameters:
    ///   - value: Number of columns to span (minimum 1)
    @discardableResult
    public func span(_ value: Int) -> Self {
        SpanLayoutParam(value: value).applyOrAppend(self)
    }
}