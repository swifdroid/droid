//
//  RecyclerView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.RecyclerViewPackage.WidgetPackage {
    public class RecyclerViewClass: JClassName, @unchecked Sendable {}
    public var RecyclerView: RecyclerViewClass { .init(parent: self, name: "RecyclerView") }
    
    public class LinearLayoutManagerClass: JClassName, @unchecked Sendable {}
    public class GridLayoutManagerClass: JClassName, @unchecked Sendable {}
    public class StaggeredGridLayoutManagerClass: JClassName, @unchecked Sendable {}
    public var LinearLayoutManager: LinearLayoutManagerClass { .init(parent: self, name: "LinearLayoutManager") }
    public var GridLayoutManager: GridLayoutManagerClass { .init(parent: self, name: "GridLayoutManager") }
    public var StaggeredGridLayoutManager: StaggeredGridLayoutManagerClass { .init(parent: self, name: "StaggeredGridLayoutManager") }

    public class PagerSnapHelperClass: JClassName, @unchecked Sendable {}
    public var PagerSnapHelper: PagerSnapHelperClass { .init(parent: self, name: "PagerSnapHelper") }
}
extension AndroidXPackage.RecyclerViewPackage.WidgetPackage.RecyclerViewClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public class LayoutManagerClass: JClassName, @unchecked Sendable {}
    public class AdapterClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
    public var LayoutManager: LayoutManagerClass { .init(parent: self, name: "LayoutManager", isInnerClass: true) }
    public var Adapter: AdapterClass { .init(parent: self, name: "Adapter", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let recyclerLayout: Self = .init(.androidx.recyclerview.widget.RecyclerView.LayoutParams)
}

public final class RecyclerView: ViewGroup {
    /// The JNI class name
    public override class var className: JClassName { .androidx.recyclerview.widget.RecyclerView }
    public override class var layoutParamsClass: LayoutParams.Class { .recyclerLayout }
    public override class var gradleDependencies: [AppGradleDependency] { [.recyclerview] }

    var adapterInstance: RecyclerViewAdapterInstance?

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}

// MARK: SetLayoutManager

extension ViewPropertyKey {
    static let setLayoutManager: Self = "setLayoutManager"
}
final class SetLayoutManagerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setLayoutManager
    let value: LayoutManager
    init (_ value: LayoutManager) { self.value = value }
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        guard
            let lmInstance = value.instantiate(env, instance)
        else {
            return
        }
        instance.callVoidMethod(env, name: key.rawValue, args: lmInstance.object.signed(as: LayoutManager.className))
    }
}
extension RecyclerView {
    /// Set the `RecyclerView.LayoutManager` that this `RecyclerView` will use.
    @discardableResult
    public func layoutManager(_ layoutManager: LayoutManager) -> Self {
        SetLayoutManagerViewProperty(layoutManager).applyOrAppend(nil, self)
    }
}

// MARK: SetAdapter

extension ViewPropertyKey {
    static let setAdapter: Self = "setAdapter"
}
final class SetAdapterViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAdapter
    weak var recyclerView: RecyclerView?
    let adapter: AnyRecyclerViewAdapter
    init (_ recyclerView: RecyclerView, _ adapter: AnyRecyclerViewAdapter) {
        self.recyclerView = recyclerView
        self.adapter = adapter
    }
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        guard
            let adapterInstance = adapter.instantiate(instance)
        else { return }
        recyclerView?.adapterInstance = adapterInstance
        instance.callVoidMethod(env, name: key.rawValue, args: adapterInstance.object.signed(as: .androidx.recyclerview.widget.RecyclerView.Adapter))
    }
}
extension RecyclerView {
    /// Set a new adapter to provide child views on demand.
    @discardableResult
    public func adapter<V: View>(_ adapter: RecyclerViewAdapter<V>) -> Self {
        SetAdapterViewProperty(self, adapter).applyOrAppend(nil, self)
    }

    /// Set a new adapter to provide child views on demand.
    @discardableResult
    public func adapter<V: View>(
        count: @escaping (() -> Int),
        createView: @escaping (_ index: Int) -> V,
        bindView: @escaping (_ view: V, _ index: Int) -> Void,
        viewType: @escaping ((_ index: Int) -> Int) = { _ in return 0 }
    ) -> Self {
        SetAdapterViewProperty(self, RecyclerViewAdapter(
            count: count,
            createView: createView,
            bindView: bindView,
            viewType: viewType
        )).applyOrAppend(nil, self)
    }

    /// Set a new adapter to provide child views on demand.
    @discardableResult
    public func adapter<V: View, I>(
        items: @autoclosure @escaping () -> [I],
        createView: @escaping (_ item: I, _ index: Int) -> V,
        bindView: @escaping (_ view: V, _ item: I, _ index: Int) -> Void,
        viewType: @escaping ((_ item: I, _ index: Int) -> Int) = { _, _ in return 0 }
    ) -> Self {
        SetAdapterViewProperty(self, RecyclerViewAdapter(
            count: { items().count },
            createView: { i in
                createView(items()[i], i)
            },
            bindView: { v, i in
                bindView(v, items()[i], i)
            },
            viewType: { i in
                viewType(items()[i], i)
            }
        )).applyOrAppend(nil, self)
    }

    /// Set a new adapter to provide child views on demand.
    @discardableResult
    public func adapter<V: View, I: AnyIdentable & Hashable>(
        items: @autoclosure @escaping () -> State<[I]>,
        createView: @escaping (_ item: I, _ index: Int) -> V,
        bindView: @escaping (_ view: V, _ item: I, _ index: Int) -> Void,
        viewType: @escaping ((_ item: I, _ index: Int) -> Int) = { _, _ in return 0 }
    ) -> Self {
        let adapter = RecyclerViewAdapter(
            count: { items().wrappedValue.count },
            createView: { i in
                createView(items().wrappedValue[i], i)
            },
            bindView: { v, i in
                bindView(v, items().wrappedValue[i], i)
            },
            viewType: { i in
                viewType(items().wrappedValue[i], i)
            }
        )
        items().listen { [weak self] (old: [I], new: [I]) in
            let diff = old.difference(new)

            // 1. Process removals in batches (reverse order)
            var currentRemovalRange: (start: Int, count: Int)? = nil
            for removal in diff.removed.sorted(by: { $0.index > $1.index }) {
                if let range = currentRemovalRange {
                    if removal.index == range.start - 1 {
                        // Extend current range
                        currentRemovalRange = (removal.index, range.count + 1)
                    } else {
                        // Notify current range and start new one
                        self?.notifyItemRangeRemoved(startAt: range.start, count: range.count)
                        currentRemovalRange = (removal.index, 1)
                    }
                } else {
                    currentRemovalRange = (removal.index, 1)
                }
            }
            // Notify any remaining range
            if let range = currentRemovalRange {
                self?.notifyItemRangeRemoved(startAt: range.start, count: range.count)
            }

            // 2. Process insertions in batches (normal order)
            var currentInsertionRange: (start: Int, count: Int)? = nil
            for insertion in diff.inserted.sorted(by: { $0.index < $1.index }) {
                if let range = currentInsertionRange {
                    if insertion.index == range.start + range.count {
                        // Extend current range
                        currentInsertionRange = (range.start, range.count + 1)
                    } else {
                        // Notify current range and start new one
                        self?.notifyItemRangeInserted(startAt: range.start, count: range.count)
                        currentInsertionRange = (insertion.index, 1)
                    }
                } else {
                    currentInsertionRange = (insertion.index, 1)
                }
            }
            // Notify any remaining range
            if let range = currentInsertionRange {
                self?.notifyItemRangeInserted(startAt: range.start, count: range.count)
            }

            // 3. Process modifications in batches
            var currentModificationRange: (start: Int, count: Int)? = nil
            for modification in diff.modified.sorted(by: { $0.index < $1.index }) {
                if let range = currentModificationRange {
                    if modification.index == range.start + range.count {
                        // Extend current range
                        currentModificationRange = (range.start, range.count + 1)
                    } else {
                        // Notify current range and start new one
                        self?.notifyItemRangeChanged(startAt: range.start, count: range.count)
                        currentModificationRange = (modification.index, 1)
                    }
                } else {
                    currentModificationRange = (modification.index, 1)
                }
            }
            // Notify any remaining range
            if let range = currentModificationRange {
                self?.notifyItemRangeChanged(startAt: range.start, count: range.count)
            }
        }.hold(in: self)
        return SetAdapterViewProperty(self, adapter).applyOrAppend(nil, self)
    }
}

// MARK: DataSetChanges

extension RecyclerView {
    // MARK: Notify

    /// Refreshes all views, similar to `tableView.reloadData()` on iOS
    public func notifyDataSetChanged() {
        adapterInstance?.callVoidMethod(nil, name: "notifyDataSetChanged")
    }

    // MARK: Insertion

    public func notifyItemInserted(at position: Int) {
        adapterInstance?.callVoidMethod(nil, name: "notifyItemInserted", args: Int32(position))
    }

    public func notifyItemRangeInserted(startAt: Int, count: Int) {
        adapterInstance?.callVoidMethod(nil, name: "notifyItemRangeInserted", args: Int32(startAt), Int32(count))
    }

    // MARK: Removal

    public func notifyItemRemoved(at position: Int) {
        adapterInstance?.callVoidMethod(nil, name: "notifyItemRemoved", args: Int32(position))
    }

    public func notifyItemRangeRemoved(startAt: Int, count: Int) {
        adapterInstance?.callVoidMethod(nil, name: "notifyItemRangeRemoved", args: Int32(startAt), Int32(count))
    }

    // MARK: Update

    public func notifyItemChanged(at position: Int) {
        adapterInstance?.callVoidMethod(nil, name: "notifyItemChanged", args: Int32(position))
    }

    public func notifyItemRangeChanged(startAt: Int, count: Int) {
        adapterInstance?.callVoidMethod(nil, name: "notifyItemRangeChanged", args: Int32(startAt), Int32(count))
    }

    // MARK: Move

    public func notifyItemMoved(fromPosition: Int, toPosition: Int) {
        adapterInstance?.callVoidMethod(nil, name: "notifyItemMoved", args: Int32(fromPosition), Int32(toPosition))
    }
}

// MARK: MakePaginable

extension ViewPropertyKey {
    static let makePaginable: Self = "makePaginable"
}
struct MakePaginableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .makePaginable
    let value: Void = ()
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        guard
            let env = env ?? JEnv.current(),
            let pager = PagerSnapHelper(env, instance)
        else { return }
        pager.attachToRecyclerView(env, instance)
    }
}
extension RecyclerView {
    @discardableResult
    public func paginable() -> Self {
        MakePaginableViewProperty().applyOrAppend(nil, self)
    }
}

// MARK: - Adapter

extension RecyclerView {
    @MainActor
    public final class Adapter: JObjectable, @unchecked Sendable {
        /// The JNI class name
        public class var className: JClassName { .androidx.recyclerview.widget.RecyclerView.Adapter }
        
        /// Object
        public let object: JObject

        public init(object: JObject) {
            self.object = object
        }

        public init? (_ env: JEnv, _ context: ActivityContext) {
            #if os(Android)
            guard
                let clazz = JClass.load(PagerSnapHelper.className),
                let global = clazz.newObject(env)
            else { return nil }
            self.object = global
            #else
            return nil
            #endif
        }

        public func attachToRecyclerView(_ env: JEnv? = nil, _ recyclerInstance: View.ViewInstance) {
            guard
                let env = env ?? JEnv.current()
            else { return }
            callVoidMethod(env, name: "attachToRecyclerView", args: recyclerInstance.object.signed(as: PagerSnapHelper.className))
        }
    }
}

// MARK: - PagerSnapHelper

@MainActor
public final class PagerSnapHelper: JObjectable, @unchecked Sendable {
    /// The JNI class name
    public class var className: JClassName { .androidx.recyclerview.widget.PagerSnapHelper }
    
    /// Object
    public let object: JObject

    public init(object: JObject) {
        self.object = object
    }

    public init? (_ env: JEnv, _ context: Contextable) {
        #if os(Android)
        guard
            let clazz = JClass.load(PagerSnapHelper.className),
            let global = clazz.newObject(env)
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }

    public func attachToRecyclerView(_ env: JEnv? = nil, _ recyclerInstance: View.ViewInstance) {
        guard
            let env = env ?? JEnv.current()
        else { return }
        callVoidMethod(env, name: "attachToRecyclerView", args: recyclerInstance.object.signed(as: PagerSnapHelper.className))
    }
}

// MARK: - LayoutManager

@MainActor
open class LayoutManager: @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { .androidx.recyclerview.widget.RecyclerView.LayoutManager }

    @MainActor
    public final class LayoutManagerInstance: JObjectable, @unchecked Sendable {
        /// Context
        public private(set) weak var context: ActivityContext?
        
        /// Object
        public let object: JObject

        public init? (_ env: JEnv, _ className: JClassName, _ context: Contextable, _ initWithContext: Bool, _ initializerItems: [JSignatureItemable]) {
            #if os(Android)
            guard
                let context = context.context,
                let clazz = JClass.load(className),
                let global = clazz.newObject(env, args: (initWithContext ? [context.object.signed(as: .android.content.Context)] : []) + initializerItems.map { $0.signatureItemWithValue })
            else { return nil }
            self.object = global
            self.context = context
            #else
            return nil
            #endif
        }
    }
    var instance: LayoutManagerInstance?
    var _paramsToApply: [ParamToApply] = []

    public var initializerItems: [JSignatureItemable] = []
    public var initializerRequiresContext = false

    public init () {}

    func instantiate(_ env: JEnv?, _ context: Contextable) -> LayoutManagerInstance? {
        guard
            let env = env ?? JEnv.current(),
            let instance = LayoutManagerInstance(env, Self.className, context, initializerRequiresContext, initializerItems)
        else {
            return nil
        }
        _paramsToApply.forEach { $0.apply(env, instance) }
        return instance
    }

    public struct ParamKey: ExpressibleByStringLiteral, Hashable, RawRepresentable, Sendable {
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }
    }

    public protocol ParamToApply {
        var key: ParamKey { get }
        @MainActor
        func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance)
        @MainActor
        func applyOrAppend<T: LayoutManager>(_ layoutManager: T) -> T
    }

    // MARK: Methods

    /// Sets whether the LayoutManager should be queried for views
    /// outside of its viewport while the UI thread is idle between frames.
    @discardableResult
    public func itemPrefetchEnabled(_ value: Bool = true) -> Self {
        ItemPrefetchEnabledLayoutManagerProperty(value: value).applyOrAppend(self)
    }
    
    /// Sets whether RecyclerView should use its own measurement cache for the children.
    ///
    /// This is a more aggressive cache than the framework uses.
    @discardableResult
    public func measurementCacheEnabled(_ value: Bool = true) -> Self {
        MeasurementCacheEnabledLayoutManagerProperty(value: value).applyOrAppend(self)
    }
}

extension LayoutManager.ParamToApply {
    @MainActor
    @discardableResult
    public func applyOrAppend<T: LayoutManager>(_ layoutManager: T) -> T {
        if let instance = layoutManager.instance {
            apply(nil, instance)
        } else {
            layoutManager._paramsToApply.append(self)
        }
        return layoutManager
    }
}

extension LayoutManager.ParamKey {
    static let setItemPrefetchEnabled: Self = "setItemPrefetchEnabled"
    static let setMeasurementCacheEnabled: Self = "setMeasurementCacheEnabled"
}

// MARK: ItemPrefetchEnabled

struct ItemPrefetchEnabledLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setItemPrefetchEnabled
    let value: Bool
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: MeasurementCacheEnabled

struct MeasurementCacheEnabledLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = "setItemPrefetchEnabled"
    let value: Bool
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: - LinearLayoutManager

open class LinearLayoutManager: LayoutManager, @unchecked Sendable {
    open override class var className: JClassName { .androidx.recyclerview.widget.LinearLayoutManager }

    public init(orientation: LinearLayout.Orientation? = nil, reverseLayout: Bool? = nil) {
        super.init()
        initializerRequiresContext = true
        if let orientation {
            initializerItems.append(Int32(orientation.rawValue))
        }
        if let reverseLayout {
            initializerItems.append(reverseLayout)
        }
    }

    /// Sets the orientation of the layout.
    @discardableResult
    public func orientation(_ orientation: LinearLayout.Orientation) -> Self {
        OrientationLayoutManagerProperty(value: orientation).applyOrAppend(self)
    }

    /// When stack from end is set to `true`, the list fills its content in opposite direction,
    /// e.g. starting from the bottom of the view.
    @discardableResult
    public func stackFromEnd(_ value: Bool = true) -> Self {
        StackFromEndLayoutManagerProperty(value: value).applyOrAppend(self)
    }

    /// Used to reverse item traversal and layout order.
    @discardableResult
    public func reverseLayout(_ value: Bool = true) -> Self {
        ReverseLayoutLayoutManagerProperty(value: value).applyOrAppend(self)
    }

    /// Set whether LayoutManager will recycle its children when it is detached from RecyclerView.
    @discardableResult
    public func recycleChildrenOnDetach(_ value: Bool = true) -> Self {
        RecycleChildrenOnDetachLayoutManagerProperty(value: value).applyOrAppend(self)
    }

    /// Sets the number of items to prefetch
    /// which defines how many inner items should be prefetched
    /// when this RecyclerView is nested inside another RecyclerView.
    @discardableResult
    public func initialPrefetchItemCount(_ value: Int) -> Self {
        InitialPrefetchItemCountLayoutManagerProperty(value: value).applyOrAppend(self)
    }
    
    /// When smooth scrollbar is enabled, the position and size of the
    /// scrollbar thumb is computed based on the number of visible pixels in the visible items.
    ///
    /// This however assumes that all list items have similar or equal widths or heights (depending on list orientation).
    ///
    /// If you use a list in which items have different dimensions, the scrollbar will change appearance as the user scrolls through the list. To avoid this issue, you need to disable this property.
    @discardableResult
    public func smoothScrollbarEnabled(_ value: Bool = true) -> Self {
        SmoothScrollbarEnabledLayoutManagerProperty(value: value).applyOrAppend(self)
    }
}

extension LayoutManager.ParamKey {
    static let setOrientation: Self = "setOrientation"
    static let setStackFromEnd: Self = "setStackFromEnd"
    static let setReverseLayout: Self = "setReverseLayout"
    static let setRecycleChildrenOnDetach: Self = "setRecycleChildrenOnDetach"
    static let setInitialPrefetchItemCount: Self = "setInitialPrefetchItemCount"
    static let setSmoothScrollbarEnabled: Self = "setSmoothScrollbarEnabled"
}

// MARK: Orientation

struct OrientationLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setOrientation
    let value: LinearLayout.Orientation
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: Int32(value.rawValue))
    }
}

// MARK: StackFromEnd

struct StackFromEndLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setStackFromEnd
    let value: Bool
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: ReverseLayout

struct ReverseLayoutLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setReverseLayout
    let value: Bool
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: RecycleChildrenOnDetach

struct RecycleChildrenOnDetachLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setRecycleChildrenOnDetach
    let value: Bool
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: InitialPrefetchItemCount

struct InitialPrefetchItemCountLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setInitialPrefetchItemCount
    let value: Int
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}

// MARK: SmoothScrollbarEnabled

struct SmoothScrollbarEnabledLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setSmoothScrollbarEnabled
    let value: Bool
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: - GridLayoutManager

open class GridLayoutManager: LinearLayoutManager, @unchecked Sendable {
    open override class var className: JClassName { .androidx.recyclerview.widget.GridLayoutManager }

    public init(spanCount: Int, orientation: LinearLayout.Orientation? = nil, reverseLayout: Bool? = nil) {
        super.init()
        initializerRequiresContext = true
        initializerItems.append(Int32(spanCount))
        if let orientation {
            initializerItems.append(Int32(orientation.rawValue))
        }
        if let reverseLayout {
            initializerItems.append(reverseLayout)
        }
    }

    /// Sets the number of spans to be laid out.
    ///
    /// If `orientation` is `VERTICAL`, this is the number of columns.
    ///
    /// If `orientation` is `HORIZONTAL`, this is the number of rows.
    @discardableResult
    public func spanCount(_ value: Int) -> Self {
        SpanCountLayoutManagerProperty(value: value).applyOrAppend(self)
    }
    
    /// When this flag is set, the scroll offset and scroll range calculations will take account of span information.
    ///
    /// This is will increase the accuracy of the scroll bar's size and offset but will require more calls to `GridLayoutManager.SpanSizeLookup.getSpanGroupIndex(int, int)`.
    ///
    /// This additional accuracy may or may not be needed, depending on the characteristics of your layout. 
    @discardableResult
    public func usingSpansToEstimateScrollbarDimensions(_ value: Bool = true) -> Self {
        UsingSpansToEstimateScrollbarDimensionsLayoutManagerProperty(value: value).applyOrAppend(self)
    }
}

extension LayoutManager.ParamKey {
    static let setSpanCount: Self = "setSpanCount"
    static let setSpanSizeLookup: Self = "setSpanSizeLookup"
    static let setUsingSpansToEstimateScrollbarDimensions: Self = "setUsingSpansToEstimateScrollbarDimensions"
}

// MARK: SpanCount

struct SpanCountLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setSpanCount
    let value: Int
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}

// MARK: SpanSizeLookup // TODO: implement SpanSizeLookup

// struct SpanSizeLookupLayoutManagerProperty: LayoutManager.ParamToApply {
//     let key: LayoutManager.ParamKey = .setSpanSizeLookup
//     let value: SpanSizeLookup
//     func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
//         layoutManager.callVoidMethod(env, name: key.rawValue, args: value.object.signed(as: ))
//     }
// }

// MARK: UsingSpansToEstimateScrollbarDimensions

struct UsingSpansToEstimateScrollbarDimensionsLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setUsingSpansToEstimateScrollbarDimensions
    let value: Bool
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: value)
    }
}

// MARK: - StaggeredGridLayoutManager

open class StaggeredGridLayoutManager: LayoutManager, @unchecked Sendable {
    open override class var className: JClassName { .androidx.recyclerview.widget.StaggeredGridLayoutManager }

    public init(spanCount: Int, orientation: LinearLayout.Orientation) {
        super.init()
        initializerRequiresContext = true
        initializerItems.append(Int32(spanCount))
        initializerItems.append(Int32(orientation.rawValue))
    }

    public enum GapHandlingStrategy: Int32 {
        /// Does not do anything to hide gaps.
        case none = 0
        /// Deprecated. No longer supported.
        case lazy = 1
        /// When scroll state is changed to `RecyclerView.SCROLL_STATE_IDLE`,
        /// StaggeredGrid will check if there are gaps in the because of full span items.
        /// If it finds, it will re-layout and move items to correct positions with animations.
        case moveItemsBetweenSpans = 2
    }
    
    /// Sets the gap handling strategy.
    ///
    /// If the gapStrategy parameter is different than the current strategy,
    /// calling this method will trigger a layout request.
    @discardableResult
    public func gapStrategy(_ value: GapHandlingStrategy) -> Self {
        GapStrategyLayoutManagerProperty(value: value).applyOrAppend(self)
    }

    /// Used to reverse item traversal and layout order.
    @discardableResult
    public func reverseLayout(_ value: Bool = true) -> Self {
        ReverseLayoutLayoutManagerProperty(value: value).applyOrAppend(self)
    }
}

extension LayoutManager.ParamKey {
    static let setGapStrategy: Self = "setGapStrategy"
}

// MARK: GapStrategy

struct GapStrategyLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setGapStrategy
    let value: StaggeredGridLayoutManager.GapHandlingStrategy
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}

// MARK: - FlexboxLayoutManager

extension ComGoogleAndroidPackage {
    public class FlexboxClass: JClassName, @unchecked Sendable {}
    public var flexbox: FlexboxClass { .init(parent: self, name: "flexbox") }
}
extension ComGoogleAndroidPackage.FlexboxClass {
    public class FlexboxLayoutManagerClass: JClassName, @unchecked Sendable {}
    public var FlexboxLayoutManager: FlexboxLayoutManagerClass { .init(parent: self, name: "FlexboxLayoutManager") }
}

open class FlexboxLayoutManager: LinearLayoutManager, @unchecked Sendable {
    open override class var className: JClassName { .comGoogleAndroid.flexbox.FlexboxLayoutManager }

    public init(flexDirection: FlexboxLayout.FlexDirection? = nil, flexWrap: FlexboxLayout.FlexWrap? = nil) {
        super.init()
        initializerRequiresContext = true
        if let flexDirection {
            initializerItems.append(Int32(flexDirection.rawValue))
        }
        if let flexWrap {
            initializerItems.append(Int32(flexWrap.rawValue))
        }
    }

    @discardableResult
    public func alignItems(_ value: FlexboxLayout.AlignItems) -> Self {
        AlignItemsLayoutManagerProperty(value: value).applyOrAppend(self)
    }
    
    @discardableResult
    public func flexDirection(_ value: FlexboxLayout.FlexDirection) -> Self {
        FlexDirectionLayoutManagerProperty(value: value).applyOrAppend(self)
    }
    
    @discardableResult
    public func flexWrap(_ value: FlexboxLayout.FlexWrap) -> Self {
        FlexWrapLayoutManagerProperty(value: value).applyOrAppend(self)
    }
    
    @discardableResult
    public func flexLines(_ value: Int) -> Self {
        FlexLinesLayoutManagerProperty(value: value).applyOrAppend(self)
    }
}

extension LayoutManager.ParamKey {
    static let setAlignItems: Self = "setAlignItems"
    static let setFlexDirection: Self = "setFlexDirection"
    static let setFlexWrap: Self = "setFlexWrap"
    static let setFlexLines: Self = "setFlexLines"
}

// MARK: AlignItems

struct AlignItemsLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setAlignItems
    let value: FlexboxLayout.AlignItems
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}

// MARK: FlexDirection

struct FlexDirectionLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setFlexDirection
    let value: FlexboxLayout.FlexDirection
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}

// MARK: FlexWrap

struct FlexWrapLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setFlexDirection
    let value: FlexboxLayout.FlexWrap
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}

// MARK: FlexLines

struct FlexLinesLayoutManagerProperty: LayoutManager.ParamToApply {
    let key: LayoutManager.ParamKey = .setFlexLines
    let value: Int
    func apply(_ env: JEnv?, _ layoutManager: LayoutManager.LayoutManagerInstance) {
        layoutManager.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}