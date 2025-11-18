import FoundationEssentials

public protocol Stateable: AnyState {
    associatedtype Value
    
    var wrappedValue: Value { get set }
    
    func beginTrigger(_ trigger: @escaping () -> Void) -> HeldState
    func endTrigger(_ trigger: @escaping () -> Void) -> HeldState
    func listen(_ listener: @escaping (_ old: Value, _ new: Value) -> Void) -> HeldState
    func listen(_ listener: @escaping (_ value: Value) -> Void) -> HeldState
    func listen(_ listener: @escaping () -> Void) -> HeldState
}

fileprivate final class StateValueBox<Value: Sendable>: @unchecked Sendable {
    var value: Value
    init(value: Value) {
        self.value = value
    }
}

@MainActor
@propertyWrapper
public final class State<Value: Sendable>: @MainActor Stateable, StatesHolder, Sendable {
    private let _originalValue: Value
    private let _wrappedValue: StateValueBox<Value>
    public var wrappedValue: Value {
        get { _wrappedValue.value }
        set {
            let oldValue = _wrappedValue.value
            _wrappedValue.value = newValue
            for trigger in values.beginTriggers {
                trigger.value()
            }
            for listener in values.listeners {
                listener.value(oldValue, newValue)
            }
            for trigger in values.endTriggers {
                trigger.value()
            }
        }
    }
    
    public var projectedValue: State<Value> { self }
    public let statesValues: StatesHolderValuesBox = StatesHolderValuesBox()

    init (_ stateA: AnyState, _ stateB: AnyState, _ expression: @escaping () -> Value) {
        let value = expression()
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        stateA.listen { [weak self] in
            self?.wrappedValue = expression()
        }.hold(in: self)
        stateB.listen { [weak self] in
            self?.wrappedValue = expression()
        }.hold(in: self)
    }
    
    init <A, B>(_ stateA: State<A>, _ stateB: State<B>, _ expression: @escaping (A, B) -> Value) {
        let value = expression(stateA.wrappedValue, stateB.wrappedValue)
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        stateA.listen { [weak self, weak stateA, weak stateB] in
            guard let stateA = stateA, let stateB = stateB else { return }
            self?.wrappedValue = expression(stateA.wrappedValue, stateB.wrappedValue)
        }.hold(in: self)
        stateB.listen { [weak self, weak stateA, weak stateB] in
            guard let stateA = stateA, let stateB = stateB else { return }
            self?.wrappedValue = expression(stateA.wrappedValue, stateB.wrappedValue)
        }.hold(in: self)
    }
    
    init <A, B>(_ stateA: State<A>, _ stateB: State<B>, _ expression: @escaping (CombinedDeprecatedResult<A, B>) -> Value) {
        let value = expression(.init(left: stateA.wrappedValue, right: stateB.wrappedValue))
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        stateA.listen { [weak self, weak stateA, weak stateB] in
            guard let stateA = stateA, let stateB = stateB else { return }
            self?.wrappedValue = expression(.init(left: stateA.wrappedValue, right: stateB.wrappedValue))
        }.hold(in: self)
        stateB.listen { [weak self, weak stateA, weak stateB] in
            guard let stateA = stateA, let stateB = stateB else { return }
            self?.wrappedValue = expression(.init(left: stateA.wrappedValue, right: stateB.wrappedValue))
        }.hold(in: self)
    }
    
    public init(wrappedValue value: Value) {
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
    }
    
    public init (_ stateA: AnyState, _ expression: @escaping () -> Value) {
        let value = expression()
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        stateA.listen { [weak self] in
            self?.wrappedValue = expression()
        }.hold(in: self)
    }
    
    public init <A>(_ stateA: State<A>, _ expression: @escaping (A) -> Value) {
        let value = expression(stateA.wrappedValue)
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        stateA.listen { [weak self, weak stateA] in
        guard let value = stateA?.wrappedValue else { return }
            self?.wrappedValue = expression(value)
        }.hold(in: self)
    }
    
    public init <A>(_ stateA: State<A>, _ expressionTo: @escaping (A) -> Value, _ expressionFrom: @escaping (Value) -> A) {
        let value = expressionTo(stateA.wrappedValue)
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        var backwardChanged = false
        stateA.listen { [weak self, weak stateA] in
            guard !backwardChanged else {
                backwardChanged = false
                return
            }
            guard let value = stateA?.wrappedValue else { return }
            self?.wrappedValue = expressionTo(value)
        }.hold(in: self)
        self.listen { [weak stateA] old, new in
            backwardChanged = true
            stateA?.wrappedValue = expressionFrom(new)
        }.hold(in: self)
    }

    deinit {
        InnerLog.t("🟠🟠🟠 State deinit: \(_originalValue)")
        releaseStates()
    }
    
    public func reset() {
        let oldValue = _wrappedValue.value
        _wrappedValue.value = _originalValue
        for trigger in values.beginTriggers {
            trigger.value()
        }
        for listener in values.listeners {
            listener.value(oldValue, _wrappedValue.value)
        }
        for trigger in values.endTriggers {
            trigger.value()
        }
    }

    public func removeListener(id: UUID) {
        values.beginTriggers.removeValue(forKey: id)
        values.endTriggers.removeValue(forKey: id)
        values.listeners.removeValue(forKey: id)
    }
    
    public func removeAllListeners() {
        values.beginTriggers.removeAll()
        values.endTriggers.removeAll()
        values.listeners.removeAll()
    }
    
    public typealias Trigger = () -> Void
    public typealias Listener = (_ old: Value, _ new: Value) -> Void
    public typealias SimpleListener = (_ value: Value) -> Void
    
    private final class ValuesBox: @unchecked Sendable {
        var beginTriggers: [UUID: Trigger] = [:]
        var endTriggers: [UUID: Trigger] = [:]
        var listeners: [UUID: Listener] = [:]
    }

    private let values: ValuesBox = ValuesBox()
    
    public func beginTrigger(_ trigger: @escaping Trigger) -> HeldState {
        let id = UUID()
        values.beginTriggers[id] = trigger
        return HeldState(id, self)
    }
    
    public func endTrigger(_ trigger: @escaping Trigger) -> HeldState {
        let id = UUID()
        values.endTriggers[id] = trigger
        return HeldState(id, self)
    }
    
    public func listen(_ listener: @escaping Listener) -> HeldState {
        let id = UUID()
        values.listeners[id] = listener
        return HeldState(id, self)
    }
    
    public func listen(_ listener: @escaping SimpleListener) -> HeldState {
        let id = UUID()
        values.listeners[id] = { _, new in listener(new) }
        return HeldState(id, self)
    }
    
    public func listen(_ listener: @escaping () -> Void) -> HeldState {
        let id = UUID()
        values.listeners[id] = { _,_ in listener() }
        return HeldState(id, self)
    }
    
    public func merge(with state: State<Value>) {
        self.wrappedValue = state.wrappedValue
        var justSetExternal = false
        var justSetInternal = false
        state.listen { [weak self] new in
            guard !justSetInternal else { return }
            justSetExternal = true
            self?.wrappedValue = new
            justSetExternal = false
        }.hold(in: self)
        self.listen { [weak state] new in
            guard !justSetExternal else { return }
            justSetInternal = true
            state?.wrappedValue = new
            justSetInternal = false
        }.hold(in: self)
    }
    
    public func and<V>(_ state: State<V>) -> CombinedState<Value, V> {
        CombinedState(left: projectedValue, right: state)
    }

    public func release(with holder: StatesHolder) {
        holder.awaitRelease { [weak self] in
            self?.releaseStates()
        }
    }
}

// MARK: - CombinedState

@MainActor
public class CombinedState<A: Sendable, B: Sendable>: @unchecked Sendable {
    let _left: State<A>
    let _right: State<B>
    public var left: A { _left.wrappedValue }
    public var right: B { _right.wrappedValue }
    
    init (left: State<A>, right: State<B>) {
        self._left = left
        self._right = right
    }
    
    public func map<Result>(_ expression: @escaping () -> Result) -> State<Result> {
        .init(_left, _right, expression)
    }
    
    public func map<Result>(_ expression: @escaping (A, B) -> Result) -> State<Result> {
        .init(_left, _right, expression)
    }
}

public struct CombinedDeprecatedResult<A, B> {
    public let left: A
    public let right: B
}

public final class StatesHolderValuesBox: @unchecked Sendable {
    var heldStates: [UUID : WeakStateBox] = [:]
    var callbacks: [() -> Void] = []
}

// MARK: - StatesHolder

public protocol StatesHolder: AnyObject {
    var statesValues: StatesHolderValuesBox { get }
    
    func awaitRelease(_ callback: @escaping () -> Void)
}
extension StatesHolder {
    public func releaseStates(
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        for (id, box) in statesValues.heldStates {
            box.state?.removeListener(id: id)
        }
        statesValues.heldStates.removeAll()
        for callback in statesValues.callbacks {
            callback()
        }
        statesValues.callbacks.removeAll()
        InnerLog.t("🟠🟠🟠 StatesHolder.releaseStates file:\(file) function:\(function) line: \(line)")
    }

    public func awaitRelease(_ callback: @escaping () -> Void) {
        statesValues.callbacks.append(callback)
    }
}

// MARK: - HeldState

public final class WeakStateBox {
    private(set) weak var state: AnyState?
    init(state: AnyState) { self.state = state }
}

public struct HeldState {
    let id: UUID
    let state: WeakStateBox

    init (_ id: UUID, _ state: AnyState) {
        self.id = id
        self.state = WeakStateBox(state: state)
    }

    public func hold(in holder: StatesHolder) {
        holder.statesValues.heldStates[id] = state
    }
}

// MARK: - Expressable

extension State {
    public func map<Result>(_ expression: @escaping () -> Result) -> State<Result> {
        .init(self, expression)
    }
    
    public func map<Result>(_ expression: @escaping (Value) -> Result) -> State<Result> {
        .init(self, expression)
    }
    
    public func map<Result>(_ expressionTo: @escaping (Value) -> Result, _ expressionFrom: @escaping (Result) -> Value) -> State<Result> {
        .init(self, expressionTo, expressionFrom)
    }
}

// MARK: Any States to Expressable

public protocol AnyState: AnyObject {
    func listen(_ listener: @escaping () -> Void) -> HeldState
    func removeListener(id: UUID)
}

extension Array where Element == AnyState {
    @MainActor
    public func map<Result>(_ expression: @escaping () -> Result) -> State<Result> {
        let state = State<Result>.init(wrappedValue: expression())
        for s in self {
            s.listen { [weak state] in
                state?.wrappedValue = expression()
            }.hold(in: state)
        }
        return state
    }
}