import Testing
import FoundationEssentials
@testable import Droid

// Simple example placeholder (keep if your test runner requires at least one top-level test)
@Test func example() async throws {
    // Example test
}

// MARK: - Helpers

private final class TestHolder: StatesHolder {
    let statesValues = StatesHolderValuesBox()
    deinit { releaseStates() }
}

private func weakify<T: AnyObject>(_ object: T) -> () -> T? {
    weak var weakRef = object
    return { weakRef }
}

// MARK: - State basic behavior

@Test("State - initial value")
@MainActor
func testInitialValue() {
    DroidApp.main()
    let state = State(wrappedValue: 10)
    #expect(state.wrappedValue == 10)
}

@Test("State - value update notifies listeners")
@MainActor
func testValueUpdate() {
    DroidApp.main()
    let testHolder = TestHolder()
    let state = State(wrappedValue: 1)
    var capturedOld: Int?
    var capturedNew: Int?

    state.listen { old, new in
        capturedOld = old
        capturedNew = new
    }.hold(in: testHolder)

    state.wrappedValue = 5

    #expect(capturedOld == 1)
    #expect(capturedNew == 5)
}

@Test("State - begin/end triggers")
@MainActor
func testTriggers() {
    DroidApp.main()
    let testHolder = TestHolder()
    let state = State(wrappedValue: 3)

    var begin = 0
    var end = 0

    state.beginTrigger { begin += 1 }.hold(in: testHolder)
    state.endTrigger { end += 1 }.hold(in: testHolder)

    state.wrappedValue = 6

    #expect(begin == 1)
    #expect(end == 1)
}

// MARK: - mapping

@Test("State.map produces a derived state")
@MainActor
func testMap() {
    DroidApp.main()
    let source = State(wrappedValue: 2)
    let mapped = source.map { $0 * 10 }

    #expect(mapped.wrappedValue == 20)

    source.wrappedValue = 5
    #expect(mapped.wrappedValue == 50)
}

@Test("State.map bidirectional")
@MainActor
func testBidirectionalMap() {
    DroidApp.main()
    let source = State(wrappedValue: 4)
    let mapped = source.map({ $0 * 2 }, { $0 / 2 })

    #expect(mapped.wrappedValue == 8)

    mapped.wrappedValue = 20
    #expect(source.wrappedValue == 10)
}

// MARK: - CombinedState

@Test("CombinedState maps two values")
@MainActor
func testCombined() {
    DroidApp.main()
    let a = State(wrappedValue: 2)
    let b = State(wrappedValue: 3)

    let combined = CombinedState(left: a, right: b)
    let sum = combined.map { $0 + $1 }

    #expect(sum.wrappedValue == 5)

    a.wrappedValue = 10
    #expect(sum.wrappedValue == 13)
}

// MARK: - Holding and releasing

@Test("HeldState removes listener on release")
@MainActor
func testHeldStateRelease() {
    DroidApp.main()
    let testHolder = TestHolder()
    let state = State(wrappedValue: 1)

    var count = 0
    state.listen { _ in count += 1 }.hold(in: testHolder)

    state.wrappedValue = 2
    #expect(count == 1)

    testHolder.releaseStates()

    state.wrappedValue = 3
    #expect(count == 1)   // no further calls
}

// MARK: - Memory tests (retain cycle detection)

@Test("State deinitializes when no references exist")
@MainActor
func testStateDeinit() {
    DroidApp.main()
    var state: State<Int>? = State(wrappedValue: 1)
    let weakRef = weakify(state!)

    #expect(weakRef() != nil)

    state = nil
    #expect(weakRef() == nil)
}

@Test("Mapped state deinitializes when parent is deallocated")
@MainActor
func testMappedStateDeinit() {
    DroidApp.main()
    var parent: State<Int>? = State(wrappedValue: 1)
    var mapped: State<String>? = parent!.map { "\($0)" }

    let weakParent = weakify(parent!)
    let weakMapped = weakify(mapped!)

    #expect(weakParent() != nil)
    #expect(weakMapped() != nil)

    parent = nil
    mapped = nil

    #expect(weakParent() == nil)
    #expect(weakMapped() == nil)
}

@Test("State held by a StatesHolder is released when holder deallocates")
@MainActor
func testHolderDeallocReleasesState() {
    DroidApp.main()
    var testHolder: TestHolder? = TestHolder()
    var state: State<Int>? = State(wrappedValue: 1)

    let weakState = weakify(state!)
    let weakHolder = weakify(testHolder!)
    state!.listen { _ in }.hold(in: testHolder!)

    #expect(weakState() != nil)
    #expect(weakHolder() != nil)

    testHolder = nil
    state = nil

    #expect(weakHolder() == nil)
    #expect(weakState() == nil)
}

@Test("listen { } does not retain holder")
@MainActor
func testNoRetainCycleBetweenStateAndHolder() {
    DroidApp.main()
    var testHolder: TestHolder? = TestHolder()
    var state: State<Int>? = State(wrappedValue: 1)

    let weakHolder = weakify(testHolder!)
    let weakState = weakify(state!)

    state!.listen { _ in }.hold(in: testHolder!)

    #expect(weakHolder() != nil)
    #expect(weakState() != nil)

    testHolder = nil

    #expect(weakHolder() == nil)

    state = nil
    #expect(weakState() == nil)
}

@Test("WeakStateBox does not retain State")
@MainActor
func testWeakStateBox() {
    DroidApp.main()
    var state: State<Int>? = State(wrappedValue: 10)
    let weakBox = WeakStateBox(state: state!)

    let weakState = weakify(state!)

    #expect(weakState() != nil)
    #expect(weakBox.state != nil)

    state = nil

    #expect(weakState() == nil)
    #expect(weakBox.state == nil)
}

// MARK: - reset()

@Test("State.reset resets to original value and notifies listeners")
@MainActor
func testReset() {
    DroidApp.main()
    let testHolder = TestHolder()
    let state = State(wrappedValue: 5)
    var lastValue: Int?

    state.listen { _, new in lastValue = new }.hold(in: testHolder)
    state.wrappedValue = 99
    #expect(lastValue == 99)

    state.reset()
    #expect(state.wrappedValue == 5)
    #expect(lastValue == 5)
}

// MARK: - Additional tests requested

// Chained mapped states (multiple levels)
@Test("Chained mapped states propagate changes across chain")
@MainActor
func testChainedMappedStates() {
    DroidApp.main()
    let base = State(wrappedValue: 1)
    let m1 = base.map { $0 + 1 }        // 2
    let m2 = m1.map { $0 * 2 }         // 4
    let m3 = m2.map { "\($0)" }        // "4"
    let m4 = m3.map { $0.count }       // 1
    let m5 = m4.map { $0 * 10 }        // 10

    #expect(m5.wrappedValue == 10)

    base.wrappedValue = 5
    // Re-evaluate expected:
    // base 5 -> m1 6 -> m2 12 -> m3 "12" -> m4 2 -> m5 20
    #expect(m5.wrappedValue == 20)
}

// Stress test: rapid-fire updates
@Test("Stress: rapid-fire updates")
@MainActor
func stressRapidFireUpdates() {
    DroidApp.main()
    let state = State(wrappedValue: 0)
    let testHolder = TestHolder()
    var lastObserved = 0
    var observedCount = 0

    state.listen { _, new in
        lastObserved = new
        observedCount += 1
    }.hold(in: testHolder)

    let iterations = 5_000
    for i in 1...iterations {
        state.wrappedValue = i
    }

    #expect(lastObserved == iterations)
    #expect(observedCount == iterations)
}

// Interdependent / looped mappings (guarded to avoid infinite loops)
@Test("Interdependent states (no infinite loop, converge)")
@MainActor
func testInterdependentLoop() {
    DroidApp.main()
    let testHolder = TestHolder()
    let a = State(wrappedValue: 1)
    let b = State(wrappedValue: 1)
    // Use flags to prevent infinite ping-pong
    final class Flag { var v = false }
    let flagA = Flag()
    let flagB = Flag()

    // a listens to b
    b.listen { _, new in
        guard !flagA.v else {
            flagA.v = false
            return
        }
        flagB.v = true
        a.wrappedValue = new + 1
    }.hold(in: testHolder)

    // b listens to a
    a.listen { _, new in
        guard !flagB.v else {
            flagB.v = false
            return
        }
        flagA.v = true
        b.wrappedValue = new + 1
    }.hold(in: testHolder)

    // trigger change
    a.wrappedValue = 10

    // They should have converged after the guarded updates.
    // Expect b == a + 1 or similar depending on ordering; check they are finite and not NaN.
    #expect(a.wrappedValue < 1000)
    #expect(b.wrappedValue < 1000)
    #expect(a.wrappedValue >= 0)
    #expect(b.wrappedValue >= 0)
}

// Performance-ish measurement using Date (simple)
@Test("Performance: updating many listeners")
@MainActor
func performanceManyListeners() {
    DroidApp.main()
    let state = State(wrappedValue: 0)
    let holder = TestHolder()
    let listeners = 200
    var last = 0

    for _ in 0..<listeners {
        state.listen { _, new in last = new }.hold(in: holder)
    }

    let iterations = 5_000
    let start = Date()
    for i in 0..<iterations {
        state.wrappedValue = i
    }
    let duration = Date().timeIntervalSince(start)
    InnerLog.t("performanceManyListeners duration: \(duration) sec")

    // assert roughly that this runs in reasonable time on CI; adjust threshold if necessary
    #expect(duration < 5.0)
    #expect(last == iterations - 1)
}

// Array<AnyState>.map test
@Test("Array<AnyState>.map sums values")
@MainActor
func testArrayAnyStateMap() {
    DroidApp.main()
    let s1 = State(wrappedValue: 1)
    let s2 = State(wrappedValue: 2)
    let s3 = State(wrappedValue: 3)
    let arr: [AnyState] = [s1 as AnyState, s2 as AnyState, s3 as AnyState]

    let sumState = arr.map { s1.wrappedValue + s2.wrappedValue + s3.wrappedValue }
    // initial sum 6
    #expect(sumState.wrappedValue == 6)

    s2.wrappedValue = 10
    #expect(sumState.wrappedValue == 14)
}

// Memory: chained mapping deinit test
@Test("Chained mapped states deinit when owners dealloc")
@MainActor
func testChainedDeinit() {
    DroidApp.main()
    var base: State<Int>? = State(wrappedValue: 1)
    var m1: State<Int>? = base!.map { $0 + 1 }
    var m2: State<Int>? = m1!.map { $0 * 2 }
    var m3: State<String>? = m2!.map { "\($0)" }

    let weakBase = weakify(base!)
    let weakM1 = weakify(m1!)
    let weakM2 = weakify(m2!)
    let weakM3 = weakify(m3!)

    #expect(weakBase() != nil)
    #expect(weakM1() != nil)
    #expect(weakM2() != nil)
    #expect(weakM3() != nil)

    base = nil
    m1 = nil
    m2 = nil
    m3 = nil

    #expect(weakBase() == nil)
    #expect(weakM1() == nil)
    #expect(weakM2() == nil)
    #expect(weakM3() == nil)
}
