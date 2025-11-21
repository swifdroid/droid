@MainActor
public protocol AnyForEach: Sendable {
    var orientation: LinearLayout.Orientation? { get }
    var gravity: Gravity? { get }
    
    var count: Int { get }
    func allItems() -> [BodyBuilder.Result]
    func items(at index: Int) -> BodyBuilder.Result
    func subscribeToChanges(_ begin: @escaping () -> Void, _ handler: @escaping ([Int], [Int], [Int]) -> Void, _ end: @escaping () -> Void)
    func gravity(_ gravity: Gravity) -> Self
}

@MainActor
open class ForEach<Item: Sendable>: @unchecked Sendable, StatesHolder where Item: Hashable {
    public typealias Handler = @MainActor @Sendable (Int, Item) -> BodyBuilder.Result
    public typealias HandlerValue = @MainActor @Sendable (Item) -> BodyBuilder.Result
    public typealias HandlerSimple = @MainActor @Sendable () -> BodyBuilder.Result
    
    let items: State<[Item]>
    let block: Handler
    
    public let statesValues: StatesHolderValuesBox = StatesHolderValuesBox()
    
    public var orientation: LinearLayout.Orientation? { nil }
    public var gravity: Gravity?
    
    public init (_ items: [Item], @BodyBuilder block: @escaping Handler) {
        self.items = State(wrappedValue: items)
        self.block = block
    }
    
    public init (_ items: [Item], @BodyBuilder block: @escaping HandlerValue) {
        self.items = State(wrappedValue: items)
        self.block = { _, v in
            block(v)
        }
    }
    
    public init (_ items: [Item], @BodyBuilder block: @escaping HandlerSimple) {
        self.items = State(wrappedValue: items)
        self.block = { _,_ in
            block()
        }
    }
    
    public init (_ items: State<[Item]>, @BodyBuilder block: @escaping Handler) {
        self.items = items
        self.block = block
    }
    
    public init (_ items: State<[Item]>, @BodyBuilder block: @escaping HandlerValue) {
        self.items = items
        self.block = { _, v in
            block(v)
        }
    }
    
    public init (_ items: State<[Item]>, @BodyBuilder block: @escaping HandlerSimple) {
        self.items = items
        self.block = { _,_ in
            block()
        }
    }

    deinit {
        releaseStates()
    }
    
    // Mask: Gravity
    
    @discardableResult
    public func gravity(_ gravity: Gravity) -> Self {
        self.gravity = gravity
        return self
    }
}

extension ForEach: AnyForEach {
    public var count: Int { items.wrappedValue.count }
    
    public func allItems() -> [BodyBuilder.Result] {
        items.wrappedValue.enumerated().compactMap { [weak self] in
            self?.block($0.offset, $0.element)
        }
    }
    
    public func items(at index: Int) -> BodyBuilder.Result {
        guard index < items.wrappedValue.count else { return [] }
        return block(index, items.wrappedValue[index])
    }
    
    public func subscribeToChanges(_ begin: @escaping () -> Void, _ handler: @escaping ([Int], [Int], [Int]) -> Void, _ end: @escaping () -> Void) {
        items.beginTrigger(begin).hold(in: self)
        items.listen { old, new in
            let diff = old.difference(new)
            let deletions = diff.removed.compactMap { $0.index }
            let insertions = diff.inserted.compactMap { $0.index }
            let modifications = diff.modified.compactMap { $0.index }
            guard deletions.count > 0 || insertions.count > 0 || modifications.count > 0 else { return }
            handler(deletions, insertions, modifications)
        }.hold(in: self)
        items.endTrigger(end).hold(in: self)
    }
}

extension ForEach: BodyBuilderItemable {
    public var bodyBuilderItem: BodyBuilderItem {
        .forEach(self)
    }
}

extension ForEach where Item == Int {
    public convenience init (_ items: ClosedRange<Item>, @BodyBuilder block: @escaping Handler) {
        self.init(items.map { $0 }, block: block)
    }
    
    public convenience init (_ items: ClosedRange<Item>, @BodyBuilder block: @escaping HandlerValue) {
        self.init(items.map { $0 }, block: block)
    }
    
    public convenience init (_ items: ClosedRange<Item>, @BodyBuilder block: @escaping HandlerSimple) {
        self.init(items.map { $0 }, block: block)
    }
}

public class VForEach<Item>: ForEach<Item>, @unchecked Sendable where Item: Hashable {
    public override var orientation: LinearLayout.Orientation? { .vertical }
}

public class HForEach<Item>: ForEach<Item>, @unchecked Sendable where Item: Hashable {
    public override var orientation: LinearLayout.Orientation? { .horizontal }
}
