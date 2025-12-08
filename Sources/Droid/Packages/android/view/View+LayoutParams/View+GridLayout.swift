// MARK: GridLayout - Layout Params
extension View {
    // MARK: Cell Position & Span

    /// **GridLayoutParams**
    /// 
    /// Sets the column specification for the view in a GridLayout.
    ///
    /// Defines the column behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    @discardableResult
    public func columnSpec(start: Int) -> Self {
        ColumnSpecLayoutParam(value: .one(Int32(start))).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the column specification for the view in a GridLayout.
    ///
    /// Defines the column behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - size: the size
    @discardableResult
    public func columnSpec(start: Int, size: Int) -> Self {
        ColumnSpecLayoutParam(value: .two(Int32(start), Int32(size))).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the column specification for the view in a GridLayout.
    ///
    /// Defines the column behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - weight: the weight
    @discardableResult
    public func columnSpec(start: Int, weight: Float) -> Self {
        ColumnSpecLayoutParam(value: .three(Int32(start), weight)).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the column specification for the view in a GridLayout.
    ///
    /// Defines the column behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - alignment: the alignment
    @discardableResult
    public func columnSpec(start: Int, alignment: GridLayout.Alignment) -> Self {
        ColumnSpecLayoutParam(value: .four(Int32(start), alignment)).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the column specification for the view in a GridLayout.
    ///
    /// Defines the column behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - size: the size
    ///   - weight: the weight
    @discardableResult
    public func columnSpec(start: Int, size: Int, weight: Float) -> Self {
        ColumnSpecLayoutParam(value: .five(Int32(start), Int32(size), weight)).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the column specification for the view in a GridLayout.
    ///
    /// Defines the column behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - size: the size
    ///   - alignment: the alignment
    @discardableResult
    public func columnSpec(start: Int, size: Int, alignment: GridLayout.Alignment) -> Self {
        ColumnSpecLayoutParam(value: .six(Int32(start), Int32(size), alignment)).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the column specification for the view in a GridLayout.
    ///
    /// Defines the column behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - alignment: the alignment
    ///   - weight: the weight
    @discardableResult
    public func columnSpec(start: Int, alignment: GridLayout.Alignment, weight: Float) -> Self {
        ColumnSpecLayoutParam(value: .seven(Int32(start), alignment, weight)).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the column specification for the view in a GridLayout.
    ///
    /// Defines the column behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - size: the size
    ///   - alignment: the alignment
    ///   - weight: the weight
    @discardableResult
    public func columnSpec(start: Int, size: Int, alignment: GridLayout.Alignment, weight: Float) -> Self {
        ColumnSpecLayoutParam(value: .eight(Int32(start), Int32(size), alignment, weight)).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the row specification for the view in a GridLayout.
    ///
    /// Defines the row behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    @discardableResult
    public func rowSpec(start: Int) -> Self {
        RowSpecLayoutParam(value: .one(Int32(start))).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the row specification for the view in a GridLayout.
    ///
    /// Defines the row behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - size: the size
    @discardableResult
    public func rowSpec(start: Int, size: Int) -> Self {
        RowSpecLayoutParam(value: .two(Int32(start), Int32(size))).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the row specification for the view in a GridLayout.
    ///
    /// Defines the row behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - weight: the weight
    @discardableResult
    public func rowSpec(start: Int, weight: Float) -> Self {
        RowSpecLayoutParam(value: .three(Int32(start), weight)).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the row specification for the view in a GridLayout.
    ///
    /// Defines the row behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - alignment: the alignment
    @discardableResult
    public func rowSpec(start: Int, alignment: GridLayout.Alignment) -> Self {
        RowSpecLayoutParam(value: .four(Int32(start), alignment)).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the row specification for the view in a GridLayout.
    ///
    /// Defines the row behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - size: the size
    ///   - weight: the weight
    @discardableResult
    public func rowSpec(start: Int, size: Int, weight: Float) -> Self {
        RowSpecLayoutParam(value: .five(Int32(start), Int32(size), weight)).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the row specification for the view in a GridLayout.
    ///
    /// Defines the row behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - size: the size
    ///   - alignment: the alignment
    @discardableResult
    public func rowSpec(start: Int, size: Int, alignment: GridLayout.Alignment) -> Self {
        RowSpecLayoutParam(value: .six(Int32(start), Int32(size), alignment)).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the row specification for the view in a GridLayout.
    ///
    /// Defines the row behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - alignment: the alignment
    ///   - weight: the weight
    @discardableResult
    public func rowSpec(start: Int, alignment: GridLayout.Alignment, weight: Float) -> Self {
        RowSpecLayoutParam(value: .seven(Int32(start), alignment, weight)).applyOrAppend(self)
    }

    /// **GridLayoutParams**
    /// 
    /// Sets the row specification for the view in a GridLayout.
    ///
    /// Defines the row behavior including size, weight, and alignment.
    ///
    /// - Parameters:
    ///   - start: the start
    ///   - size: the size
    ///   - alignment: the alignment
    ///   - weight: the weight
    @discardableResult
    public func rowSpec(start: Int, size: Int, alignment: GridLayout.Alignment, weight: Float) -> Self {
        RowSpecLayoutParam(value: .eight(Int32(start), Int32(size), alignment, weight)).applyOrAppend(self)
    }
}