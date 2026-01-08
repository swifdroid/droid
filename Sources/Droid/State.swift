import FoundationEssentials

public protocol Stateable: AnyState {
    associatedtype Value
    
    var wrappedValue: Value { get set }
    
    func beginTrigger(_ trigger: @escaping () -> Void) -> StateListener
    func endTrigger(_ trigger: @escaping () -> Void) -> StateListener
    func listen(_ listener: @escaping (_ old: Value, _ new: Value) -> Void) -> StateListener
    func listen(_ listener: @escaping (_ value: Value) -> Void) -> StateListener
    func listen(_ listener: @escaping () -> Void) -> StateListener
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
    public let id: UUID = UUID()
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
        let valueExpression: () -> Value? = { [weak stateA, weak stateB] in
            guard let stateA, let stateB else { return nil }
            return expression(stateA.wrappedValue, stateB.wrappedValue)
        }
        let value = valueExpression()!
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        let closure: () -> Void = { [weak self] in
            guard let value = valueExpression() else { return }
            self?.wrappedValue = value
        }
        stateA.listen(closure).hold(in: self)
        stateB.listen(closure).hold(in: self)
    }
    
    init <A, B, C>(_ stateA: State<A>, _ stateB: State<B>, _ stateC: State<C>, _ expression: @escaping (A, B, C) -> Value) {
        let valueExpression: () -> Value? = { [weak stateA, weak stateB, weak stateC] in
            guard let stateA, let stateB, let stateC else { return nil }
            return expression(stateA.wrappedValue, stateB.wrappedValue, stateC.wrappedValue)
        }
        let value = valueExpression()!
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        let closure: () -> Void = { [weak self] in
            guard let value = valueExpression() else { return }
            self?.wrappedValue = value
        }
        stateA.listen(closure).hold(in: self)
        stateB.listen(closure).hold(in: self)
        stateC.listen(closure).hold(in: self)
    }

    init <A, B, C, D>(_ stateA: State<A>, _ stateB: State<B>, _ stateC: State<C>, _ stateD: State<D>, _ expression: @escaping (A, B, C, D) -> Value) {
        let valueExpression: () -> Value? = { [weak stateA, weak stateB, weak stateC, weak stateD] in
            guard let stateA, let stateB, let stateC, let stateD else { return nil }
            return expression(stateA.wrappedValue, stateB.wrappedValue, stateC.wrappedValue, stateD.wrappedValue)
        }
        let value = valueExpression()!
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        let closure: () -> Void = { [weak self] in
            guard let value = valueExpression() else { return }
            self?.wrappedValue = value
        }
        stateA.listen(closure).hold(in: self)
        stateB.listen(closure).hold(in: self)
        stateC.listen(closure).hold(in: self)
        stateD.listen(closure).hold(in: self)
    }

    init <A, B, C, D, E>(_ stateA: State<A>, _ stateB: State<B>, _ stateC: State<C>, _ stateD: State<D>, _ stateE: State<E>, _ expression: @escaping (A, B, C, D, E) -> Value) {
        let valueExpression: () -> Value? = { [weak stateA, weak stateB, weak stateC, weak stateD, weak stateE] in
            guard let stateA, let stateB, let stateC, let stateD, let stateE else { return nil }
            return expression(stateA.wrappedValue, stateB.wrappedValue, stateC.wrappedValue, stateD.wrappedValue, stateE.wrappedValue)
        }
        let value = valueExpression()!
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        let closure: () -> Void = { [weak self] in
            guard let value = valueExpression() else { return }
            self?.wrappedValue = value
        }
        stateA.listen(closure).hold(in: self)
        stateB.listen(closure).hold(in: self)
        stateC.listen(closure).hold(in: self)
        stateD.listen(closure).hold(in: self)
        stateE.listen(closure).hold(in: self)
    }

    init <A, B, C, D, E, F>(_ stateA: State<A>, _ stateB: State<B>, _ stateC: State<C>, _ stateD: State<D>, _ stateE: State<E>, _ stateF: State<F>, _ expression: @escaping (A, B, C, D, E, F) -> Value) {
        let valueExpression: () -> Value? = { [weak stateA, weak stateB, weak stateC, weak stateD, weak stateE, weak stateF] in
            guard let stateA, let stateB, let stateC, let stateD, let stateE, let stateF else { return nil }
            return expression(stateA.wrappedValue, stateB.wrappedValue, stateC.wrappedValue, stateD.wrappedValue, stateE.wrappedValue, stateF.wrappedValue)
        }
        let value = valueExpression()!
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        let closure: () -> Void = { [weak self] in
            guard let value = valueExpression() else { return }
            self?.wrappedValue = value
        }
        stateA.listen(closure).hold(in: self)
        stateB.listen(closure).hold(in: self)
        stateC.listen(closure).hold(in: self)
        stateD.listen(closure).hold(in: self)
        stateE.listen(closure).hold(in: self)
        stateF.listen(closure).hold(in: self)
    }

    init <A, B, C, D, E, F, G>(_ stateA: State<A>, _ stateB: State<B>, _ stateC: State<C>, _ stateD: State<D>, _ stateE: State<E>, _ stateF: State<F>, _ stateG: State<G>, _ expression: @escaping (A, B, C, D, E, F, G) -> Value) {
        let valueExpression: () -> Value? = { [weak stateA, weak stateB, weak stateC, weak stateD, weak stateE, weak stateF, weak stateG] in
            guard let stateA, let stateB, let stateC, let stateD, let stateE, let stateF, let stateG else { return nil }
            return expression(stateA.wrappedValue, stateB.wrappedValue, stateC.wrappedValue, stateD.wrappedValue, stateE.wrappedValue, stateF.wrappedValue, stateG.wrappedValue)
        }
        let value = valueExpression()!
        _originalValue = value
        _wrappedValue = StateValueBox(value: value)
        let closure: () -> Void = { [weak self] in
            guard let value = valueExpression() else { return }
            self?.wrappedValue = value
        }
        stateA.listen(closure).hold(in: self)
        stateB.listen(closure).hold(in: self)
        stateC.listen(closure).hold(in: self)
        stateD.listen(closure).hold(in: self)
        stateE.listen(closure).hold(in: self)
        stateF.listen(closure).hold(in: self)
        stateG.listen(closure).hold(in: self)
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
    
    public func beginTrigger(_ trigger: @escaping Trigger) -> StateListener {
        let id = UUID()
        values.beginTriggers[id] = trigger
        return StateListener(id, self)
    }
    
    public func endTrigger(_ trigger: @escaping Trigger) -> StateListener {
        let id = UUID()
        values.endTriggers[id] = trigger
        return StateListener(id, self)
    }
    
    public func listen(_ listener: @escaping Listener) -> StateListener {
        let id = UUID()
        values.listeners[id] = listener
        return StateListener(id, self)
    }
    
    public func listen(_ listener: @escaping SimpleListener) -> StateListener {
        let id = UUID()
        values.listeners[id] = { _, new in listener(new) }
        return StateListener(id, self)
    }
    
    public func listen(_ listener: @escaping () -> Void) -> StateListener {
        let id = UUID()
        values.listeners[id] = { _,_ in listener() }
        return StateListener(id, self)
    }
    
    /// Merges this state with another state so that they stay in sync.
    public func merge(with state: State<Value>) -> [StateListener] {
        self.wrappedValue = state.wrappedValue
        var justSetExternal = false
        var justSetInternal = false
        let listener1 = state.listen { [weak self] new in
            guard !justSetInternal else { return }
            justSetExternal = true
            self?.wrappedValue = new
            justSetExternal = false
        }
        let listener2 = self.listen { [weak state] new in
            guard !justSetExternal else { return }
            justSetInternal = true
            state?.wrappedValue = new
            justSetInternal = false
        }
        return [listener1, listener2]
    }
    
    /// Combines this state with another state into a `CombinedState` where then you can `map` the values.
    public func and<V>(_ state: State<V>) -> CombinedState<Value, V> {
        CombinedState(projectedValue, state)
    }

    public func release(with holder: StatesHolder) {
        holder.awaitRelease { [weak self] in
            self?.releaseStates()
        }
    }
}

public protocol OptionalStateValue {
    associatedtype Wrapped
    var optional: Wrapped? { get }
    static func unwrap(_ wrapped: Wrapped) -> Self
}

extension Optional: OptionalStateValue {
    public var optional: Wrapped? { self }
    public static func unwrap(_ wrapped: Wrapped) -> Self { wrapped }
}

extension State where Value: OptionalStateValue, Value: ExpressibleByNilLiteral, Value.Wrapped: Sendable {
    /// Merges this optional state with a non-optional state so that they stay in sync.
    public func mergeWithNonOptional(with state: State<Value.Wrapped>) -> [StateListener] {
        self.wrappedValue = .unwrap(state.wrappedValue)
        var justSetExternal = false
        var justSetInternal = false
        let listener1 = state.listen { [weak self] new in
            guard !justSetInternal else { return }
            justSetExternal = true
            self?.wrappedValue = .unwrap(new)
            justSetExternal = false
        }
        let listener2 = self.listen { [weak state] new in
            guard !justSetExternal else { return }
            guard let new = new.optional else { return }
            justSetInternal = true
            state?.wrappedValue = new
            justSetInternal = false
        }
        return [listener1, listener2]
    }
}

extension State: @MainActor Equatable, @MainActor Hashable {
    public static func == (lhs: State<Value>, rhs: State<Value>) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension State where Value: Equatable {
    /// Adds a listener that is only called when the value actually changes (i.e., old and new values are not equal).
    /// - Parameter listener: A closure called with the old and new values when a change occurs.
    /// - Returns: A `StateListener` handle for the listener.
    public func listenDistinct(_ listener: @escaping Listener) -> StateListener {
        listen { old, new in
            guard old != new else { return }
            listener(old, new)
        }
    }
    
    /// Adds a listener that is only called when the value actually changes (i.e., old and new values are not equal).
    /// - Parameter listener: A closure called with the new value when a change occurs.
    /// - Returns: A `StateListener` handle for the listener.
    public func listenDistinct(_ listener: @escaping SimpleListener) -> StateListener {
        listen { old, new in
            guard old != new else { return }
            listener(new)
        }
    }
}

// MARK: - CombinedState

/// Combines two states into one where you can `map` the values or combine with more states using `and`.
@MainActor
public class CombinedState<A: Sendable, B: Sendable>: @unchecked Sendable {
    let _a: State<A>
    let _b: State<B>
    
    init (_ a: State<A>, _ b: State<B>) {
        self._a = a
        self._b = b
    }
    
    /// Allows to convert values of the combined states into a value in a new `State`.
    public func map<Result>(_ expression: @escaping (A, B) -> Result) -> State<Result> {
        .init(_a, _b, expression)
    }
    
    /// Combines this state with another state where then you can `map` the values.
    public func and<V>(_ state: State<V>) -> CombinedState3<A, B, V> {
        CombinedState3(self, state)
    }
}

/// Service struct to combine three states into one where you can `map` the values or combine with more states using `and`.
@MainActor
public class CombinedState3<A: Sendable, B: Sendable, C: Sendable>: @unchecked Sendable {
    let _box: CombinedState<A, B>
    let _c: State<C>
    
    init (_ box: CombinedState<A, B>, _ c: State<C>) {
        self._box = box
        self._c = c
    }
    
    /// Allows to convert values of the combined states into a value in a new `State`.
    public func map<Result>(_ expression: @escaping (A, B, C) -> Result) -> State<Result> {
        .init(_box._a, _box._b, _c, expression)
    }
    
    /// Combines this state with another state where then you can `map` the values.
    public func and<V>(_ state: State<V>) -> CombinedState4<A, B, C, V> {
        CombinedState4(self, state)
    }
}

/// Service struct to combine four states into one where you can `map` the values or combine with more states using `and`.
@MainActor
public class CombinedState4<A: Sendable, B: Sendable, C: Sendable, D: Sendable>: @unchecked Sendable {
    let _box: CombinedState3<A, B, C>
    let _d: State<D>
    
    init (_ box: CombinedState3<A, B, C>, _ d: State<D>) {
        self._box = box
        self._d = d
    }
    
    /// Allows to convert values of the combined states into a value in a new `State`.
    public func map<Result>(_ expression: @escaping (A, B, C, D) -> Result) -> State<Result> {
        .init(_box._box._a, _box._box._b, _box._c, _d, expression)
    }
    
    /// Combines this state with another state where then you can `map` the values.
    public func and<V>(_ state: State<V>) -> CombinedState5<A, B, C, D, V> {
        CombinedState5(self, state)
    }
}

/// Service struct to combine five states into one where you can `map` the values or combine with more states using `and`.
@MainActor
public class CombinedState5<A: Sendable, B: Sendable, C: Sendable, D: Sendable, E: Sendable>: @unchecked Sendable {
    let _box: CombinedState4<A, B, C, D>
    let _e: State<E>
    
    init (_ box: CombinedState4<A, B, C, D>, _ e: State<E>) {
        self._box = box
        self._e = e
    }
    
    /// Allows to convert values of the combined states into a value in a new `State`.
    public func map<Result>(_ expression: @escaping (A, B, C, D, E) -> Result) -> State<Result> {
        .init(_box._box._box._a, _box._box._box._b, _box._box._c, _box._d, _e, expression)
    }
    
    /// Combines this state with another state where then you can `map` the values.
    public func and<V>(_ state: State<V>) -> CombinedState6<A, B, C, D, E, V> {
        CombinedState6(self, state)
    }
}

/// Service struct to combine six states into one where you can `map` the values or combine with more states using `and`.
@MainActor
public class CombinedState6<A: Sendable, B: Sendable, C: Sendable, D: Sendable, E: Sendable, F: Sendable>: @unchecked Sendable {
    let _box: CombinedState5<A, B, C, D, E>
    let _f: State<F>
    
    init (_ box: CombinedState5<A, B, C, D, E>, _ f: State<F>) {
        self._box = box
        self._f = f
    }
    
    /// Allows to convert values of the combined states into a value in a new `State`.
    public func map<Result>(_ expression: @escaping (A, B, C, D, E, F) -> Result) -> State<Result> {
        .init(_box._box._box._box._a, _box._box._box._box._b, _box._box._box._c, _box._box._d, _box._e, _f, expression)
    }
    
    /// Combines this state with another state where then you can `map` the values.
    public func and<V>(_ state: State<V>) -> CombinedState7<A, B, C, D, E, F, V> {
        CombinedState7(self, state)
    }
}

/// Service struct to combine seven states into one where you can `map` the values or combine with more states using `and`.
@MainActor
public class CombinedState7<A: Sendable, B: Sendable, C: Sendable, D: Sendable, E: Sendable, F: Sendable, G: Sendable>: @unchecked Sendable {
    let _box: CombinedState6<A, B, C, D, E, F>
    let _g: State<G>
    
    init (_ box: CombinedState6<A, B, C, D, E, F>, _ g: State<G>) {
        self._box = box
        self._g = g
    }
    
    /// Allows to convert values of the combined states into a value in a new `State`.
    public func map<Result>(_ expression: @escaping (A, B, C, D, E, F, G) -> Result) -> State<Result> {
        .init(_box._box._box._box._box._a, _box._box._box._box._box._b, _box._box._box._box._c, _box._box._box._d, _box._box._e, _box._f, _g, expression)
    }
}

public final class StatesHolderValuesBox: @unchecked Sendable {
    /// Holds the states and their associated weak references to manage their lifecycle.
    var heldStates: [UUID : WeakStateBox] = [:]
    /// Callbacks to be executed upon release of states.
    var callbacks: [() -> Void] = []
}

// MARK: - StatesHolder

public protocol StatesHolder: AnyObject {
    var statesValues: StatesHolderValuesBox { get }
    
    func awaitRelease(_ callback: @escaping () -> Void)
}
extension StatesHolder {
    /// Releases all held states and invokes any registered callbacks.
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

    /// Releases listeners associated with the specified state.
    public func releaseState(_ state: AnyState) {
        let listeners = statesValues.heldStates.filter { $0.value.state?.id == state.id }
        for (id, _) in listeners {
            state.removeListener(id: id)
        }
    }

    public func awaitRelease(_ callback: @escaping () -> Void) {
        statesValues.callbacks.append(callback)
    }
}

// MARK: - TempStatesHolder

/// A temporary states holder that releases its states upon deinitialization.
@MainActor
public final class TempStatesHolder: StatesHolder, @unchecked Sendable {
    public let statesValues: StatesHolderValuesBox = StatesHolderValuesBox()
    init() {}
    deinit { releaseStates() }
}

// MARK: - StateListener

public final class WeakStateBox {
    private(set) weak var state: AnyState?
    init(state: AnyState) { self.state = state }
}

/// A handle to a state listener that can be used to release the listener when no longer needed.
public struct StateListener {
    /// Unique identifier for the state listener.
    let id: UUID
    /// Weak reference to the state associated with the listener.
    let state: WeakStateBox

    init (_ id: UUID, _ state: AnyState) {
        self.id = id
        self.state = WeakStateBox(state: state)
    }

    /// Holds the state listener in the specified states holder.
    /// **The holder will manage the lifecycle of the listener.**
    public func hold(in holder: StatesHolder) {
        holder.statesValues.heldStates[id] = state
    }

    /// Releases the state listener, removing it from the associated state.
    /// **This is for manual management of the listener's lifecycle.**
    public func cancel() {
        state.state?.removeListener(id: id)
    }
}

extension Array where Element == StateListener {
    /// Holds all state listeners in the specified states holder.
    /// 
    /// **The holder will manage the lifecycle of the listeners.**
    public func hold(in holder: StatesHolder) {
        for listener in self {
            listener.hold(in: holder)
        }
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
    var id: UUID { get }

    func listen(_ listener: @escaping () -> Void) -> StateListener
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

// MARK: - Universal Value Holder

/// Universal value holder, could be a simple(plain) value or a State value.
/// Used to simplify APIs that can accept both static and dynamic values.
@MainActor
public protocol StateValuable {
    associatedtype Value: Sendable
    
    var simpleValue: Value { get }
    var stateValue: State<Value>? { get }
}

extension State: StateValuable {
    public var simpleValue: Value { wrappedValue }
    public var stateValue: State<Value>? { self }
}

extension String: StateValuable {
    public var simpleValue: String { self }
    public var stateValue: State<String>? { nil }
}

extension Int: StateValuable {
    public var simpleValue: Int { self }
    public var stateValue: State<Int>? { nil }
}

extension Double: StateValuable {
    public var simpleValue: Double { self }
    public var stateValue: State<Double>? { nil }
}

extension Bool: StateValuable {
    public var simpleValue: Bool { self }
    public var stateValue: State<Bool>? { nil }
}