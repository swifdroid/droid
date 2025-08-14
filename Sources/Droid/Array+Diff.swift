extension Array {
    public struct DiffItem<V> {
        public let index: Int
        public let value: V
    }
    public struct DiffResult<T1, T2> {
        public let common: [(old: T1, new: T2)]
        public let removed: [DiffItem<T1>]
        public let inserted: [DiffItem<T2>]
        public let modified: [DiffItem<T2>]
        public init(common: [(T1, T2)] = [], removed: [DiffItem<T1>] = [], inserted: [DiffItem<T2>] = [], modified: [DiffItem<T2>] = []) {
            self.common = common
            self.removed = removed
            self.inserted = inserted
            self.modified = modified
        }
    }
    public func difference<T1: Hashable, T2: Hashable>(_ first: [T1], _ second: [T2], with compare: (Int,Int) -> Bool) -> DiffResult<T1, T2> {
        let combinations = first.compactMap { a in (a, second.first { b in compare(a.hashValue, b.hashValue) }) }
        let common = combinations.filter { $0.1 != nil }.compactMap { ($0.0, $0.1!) }
        var removed: [DiffItem<T1>] = combinations.filter { $0.1 == nil }.compactMap { a,_ in
            guard let index = first.firstIndex(where: { $0.hashValue == a.hashValue }) else { return nil }
            return DiffItem(index: index, value: a)
        }
        var inserted: [DiffItem<T2>] = second.filter { b in
            !common.contains { compare($0.0.hashValue, b.hashValue) }
        }.compactMap { b in
            guard let index = second.firstIndex(where: { $0.hashValue == b.hashValue }) else { return nil }
            return DiffItem(index: index, value: b)
        }
        var modified: [DiffItem<T2>] = []
//        print("1 removed: \(removed.map { $0.value.hashValue }), inserted: \(inserted.map { $0.value.hashValue }), modified: \(modified)   a.count: \(first.count)  b.count: \(second.count)")
        inserted.enumerated().forEach { ins in
            guard let _ins = ins.element as? AnyIdentable else { return }
            for rem in removed.enumerated() {
                if let _rem = rem.element as? AnyIdentable {
                    if _rem.identHash() == _ins.identHash() {
                        removed.remove(at: rem.offset)
                        inserted.remove(at: ins.offset)
                        modified.append(ins.element)
                        break
                    }
                }
            }
        }
//        print("2 modified: \(modified)")//removed: \(removed), inserted: \(inserted), modified: \(modified)")
//        print("1 removed: \(removed), inserted: \(inserted), modified: \(modified)   a.count: \(first.count)  b.count: \(second.count)")
//        if inserted.count > 0, first.count - removed.count == second.count {
//            modified = inserted
//            inserted = []
//        }
//        print("2 removed: \(removed), inserted: \(inserted), modified: \(modified)")
        return DiffResult(common: common, removed: removed, inserted: inserted, modified: modified)
    }
    public func difference<T1: AnyIdentable & Hashable, T2: AnyIdentable & Hashable>(_ first: [T1], _ second: [T2]) -> DiffResult<T1, T2> {
        // Create dictionaries mapping an item's unique identity hash to its index and value.
        // This allows for efficient O(1) lookups instead of repeated searches.
        let oldMap = Dictionary(uniqueKeysWithValues: first.enumerated().map { ($0.element.identHash(), (index: $0.offset, value: $0.element)) })
        let newMap = Dictionary(uniqueKeysWithValues: second.enumerated().map { ($0.element.identHash(), (index: $0.offset, value: $0.element)) })

        var common: [(old: T1, new: T2)] = []
        var removed: [DiffItem<T1>] = []
        var inserted: [DiffItem<T2>] = []
        var modified: [DiffItem<T2>] = []

        // 1. Check for removed, modified, and common items by iterating through the old collection.
        for (idHash, oldData) in oldMap {
            if let newData = newMap[idHash] {
                // The item exists in both lists. Now, check if it was modified.
                // An item is modified if its content (checked by full hashValue) OR its position has changed.
                let hasContentChanged = oldData.value.hashValue != newData.value.hashValue
                let hasPositionChanged = oldData.index != newData.index

                if hasContentChanged || hasPositionChanged {
                    modified.append(DiffItem(index: newData.index, value: newData.value))
                } else {
                    // Content and position are identical. This is a truly common item.
                    common.append((old: oldData.value, new: newData.value))
                }
            } else {
                // The item from the old list is not in the new list. It was removed.
                removed.append(DiffItem(index: oldData.index, value: oldData.value))
            }
        }

        // 2. Check for newly inserted items by iterating through the new collection.
        for (idHash, newData) in newMap {
            if oldMap[idHash] == nil {
                // The item from the new list did not exist in the old list. It was inserted.
                inserted.append(DiffItem(index: newData.index, value: newData.value))
            }
        }
        
        // Sorting the results makes the output more predictable and easier to work with.
        return DiffResult(
            common: common,
            removed: removed.sorted { $0.index < $1.index },
            inserted: inserted.sorted { $0.index < $1.index },
            modified: modified.sorted { $0.index < $1.index }
        )
    }
}
extension Array where Element: Hashable {
    public func difference<T2: Hashable>(_ new: [T2]) -> DiffResult<Element, T2> {
        difference(self, new, with: ==)
    }
}
extension Array where Element: AnyIdentable & Hashable {
    public func difference<T2: AnyIdentable & Hashable>(_ new: [T2]) -> DiffResult<Element, T2> {
        difference(self, new)
    }
}