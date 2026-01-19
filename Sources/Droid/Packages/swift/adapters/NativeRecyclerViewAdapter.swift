//
//  NativeRecyclerViewAdapter.swift
//  
//
//  Created by Mihael Isaev on 12.08.2025.
//

#if canImport(Android)
import Android
#else
#if canImport(Glibc)
import Glibc
#endif
#endif
#if canImport(Logging)
import Logging
#endif
import FoundationEssentials

extension AppKitPackage.AdaptersPackage {
    public class RecyclerViewAdapterClass: JClassName, @unchecked Sendable {}
    public var RecyclerViewAdapter: RecyclerViewAdapterClass { .init(parent: self, name: "NativeRecyclerViewAdapter") }
}

final class RecyclerViewAdapterStore: @unchecked Sendable {
    private var adapters: [Int32: AnyRecyclerViewAdapter] = [:]

    static let shared = RecyclerViewAdapterStore()
    
    private var mutex = pthread_mutex_t()

    init () {
        mutex.activate(recursive: true)
    }

    deinit {
        mutex.destroy()
    }

    func add(_ adapter: AnyRecyclerViewAdapter) {
        mutex.lock()
        defer { mutex.unlock() }
        adapters[adapter.id] = adapter
    }
    
    func remove(id: Int32) {
        mutex.lock()
        defer { mutex.unlock() }
        adapters[id] = nil
    }
    
    func get(id: Int32) -> AnyRecyclerViewAdapter? {
        mutex.lock()
        defer { mutex.unlock() }
        return adapters[id]
    }
    
    #if canImport(Android)
    func find(id: Int32) -> AnyRecyclerViewAdapter? {
        mutex.lock()
        defer { mutex.unlock() }
        guard
            let adapter = adapters[id]
        else { return nil }
        return adapter
    }
    #endif
}

@MainActor
protocol AnyRecyclerViewAdapter: AnyObject, Sendable {
    nonisolated var id: Int32 { get }
    var itemsCountHandler: (() -> Int) { get }
    func _getItemViewTypeHandler(_ position: Int) -> Int
    func _createViewHolder(_ position: Int) -> JObject?
    func bindViewHolder(_ holder: AnyNativeRecyclerViewHolder, _ position: Int)
    func instantiate(_ context: View.ViewInstance) -> RecyclerViewAdapterInstance?
}

public final class RecyclerViewAdapter<V: Viewable, VT: RecyclerView.ViewType>: AnyRecyclerViewAdapter, @unchecked Sendable {
    /// Unique identifier
    let id: Int32 = DroidApp.getNextViewId()

    /// Action handler
    let itemsCountHandler: (() -> Int)
    let onCreateViewHolderHandler: ((VT) -> V)
    let onBindViewHolderHandler: ((V, Int) -> Void)
    let getItemViewTypeHandler: ((Int) -> VT)

    /// JNI Instance
    var instance: RecyclerViewAdapterInstance?

    weak var recyclerView: RecyclerView?

    public init (
        recyclerView: RecyclerView,
        count: @escaping (() -> Int),
        createView: @escaping (_ viewType: VT) -> V,
        bindView: @escaping (_ view: V, _ index: Int) -> Void,
        viewType: @escaping ((_ index: Int) -> VT) = { _ in return 0 }
    ) {
        self.recyclerView = recyclerView
        self.itemsCountHandler = count
        self.onCreateViewHolderHandler = createView
        self.onBindViewHolderHandler = bindView
        self.getItemViewTypeHandler = viewType
        RecyclerViewAdapterStore.shared.add(self)
    }

    func _createViewHolder(_ viewType: Int) -> JObject? {
        createViewHolder(.from(rawValue: viewType))
    }

    func createViewHolder(_ viewType: VT) -> JObject? {
        guard let instance: RecyclerViewAdapterInstance else {
            return nil
        }
        let view = onCreateViewHolderHandler(viewType)
        view.view.willMoveToParent()
        if let holder = NativeRecyclerViewHolder(instance, view) {
            return holder.object
        }
        return nil
    }

    func bindViewHolder(_ holder: AnyNativeRecyclerViewHolder, _ position: Int) {
        // InnerLog.t("bindViewHolder 1 holder.id: \(holder.id)")
        guard let holder = holder as? NativeRecyclerViewHolder<V> else {
            InnerLog.c("bindViewHolder unexpected exit \(V.self) -> \(V.ViewType.self), unable to cast holder")
            return
        }
        guard let layoutManager = recyclerView?.layoutManager else {
            InnerLog.c("bindViewHolder unexpected exit, recyclerView.layoutManager is nil")
            return
        }
        if !holder.viewMovedToParent {
            if let instance = holder.view.view.instance {
                InnerLog.t("bindViewHolder instance present: layoutManager: \(layoutManager) layoutManager.viewHolderLayoutParamsClass: \(layoutManager.layoutParamsClass)")
                if let lp = instance.layoutParams(layoutManager.layoutParamsClass) {
                    InnerLog.t("bindViewHolder LP present")
                    instance.lpClassName = layoutManager.layoutParamsClass
                    holder.view.view.processLayoutParams(instance, lp, for: holder.view.view)
                    holder.view.view.layoutParams(lp)
                } else if let emptyLP = LayoutParams(layoutManager.viewHolderLayoutParamsClass) {
                    InnerLog.t("bindViewHolder LP missing, but created empty one")
                    instance.lpClassName = layoutManager.layoutParamsClass
                    holder.view.view.processLayoutParams(instance, emptyLP, for: holder.view.view)
                    holder.view.view.layoutParams(emptyLP)
                } else {
                    InnerLog.c("🔴🔴🔴 bindViewHolder LP missing")
                }
            } else {
                InnerLog.c("🔴🔴🔴 bindViewHolder instance missing")
            }
            holder.view.view.didMoveToParent()
            holder.viewMovedToParent = true
        }
        onBindViewHolderHandler(holder.view, position)
    }
    
    func _getItemViewTypeHandler(_ position: Int) -> Int {
        getItemViewTypeHandler(position).rawValue
    }

    func instantiate(_ viewInstance: View.ViewInstance) -> RecyclerViewAdapterInstance? {
        instance = RecyclerViewAdapterInstance(viewInstance, id)
        return instance
    }
}

@MainActor
final class RecyclerViewAdapterInstance: JObjectable, Contextable, @unchecked Sendable {
    /// The JNI class name
    static var className: JClassName { "stream/swift/droid/appkit/adapters/NativeRecyclerViewAdapter" }

    /// Context
    private(set) weak var context: ActivityContext?

    /// Object wrapper
    let object: JObject

    /// ID
    let id: Int32

    convenience init? (_ context: Contextable, _ id: Int32) {
        #if os(Android)
        guard let env = JEnv.current() else { return nil }
        self.init(env, context, id)
        #else
        return nil
        #endif
    }
    
    init? (_ env: JEnv, _ context: Contextable, _ id: Int32) {
        #if os(Android)
        guard let context = context.context else { return nil }
        guard
            let clazz = JClass.load(Self.className)
        else {
            return nil
        }
        guard
            let global = clazz.newObject(env, args: id)
        else {
            return nil
        }
        self.context = context
        self.object = global
        self.id = id
        #else
        return nil
        #endif
    }
}

#if os(Android)
import Foundation

@_cdecl("Java_stream_swift_droid_appkit_adapters_NativeRecyclerViewAdapter_nativeItemsCount")
public func NativeRecyclerViewAdapterItemsCount(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, nativeId: jint) -> jint {
    guard
        let adapter = RecyclerViewAdapterStore.shared.find(id: nativeId)
    else { return 0 }
    let result = MainActor.assumeIsolated {
        Int32(adapter.itemsCountHandler())
    }
    return jint(result)
}

@_cdecl("Java_stream_swift_droid_appkit_adapters_NativeRecyclerViewAdapter_nativeOnCreateViewHolder")
public func NativeRecyclerViewAdapterOnCreateViewHolder(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, nativeId: jint, parent: jobject, viewType: jint) -> jobject? {
    guard
        let adapter = RecyclerViewAdapterStore.shared.find(id: nativeId)
    else {
        return nil
    }
    let result = MainActor.assumeIsolated {
        adapter._createViewHolder(Int(viewType))
    }
    if let result {
        return result.ref.ref
    }
    return nil
}

@_cdecl("Java_stream_swift_droid_appkit_adapters_NativeRecyclerViewAdapter_nativeOnBindViewHolder")
public func NativeRecyclerViewAdapterOnBindViewHolder(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, nativeId: jint, holderId: jint, holder: jobject, position: jint) {
    guard
        let adapter = RecyclerViewAdapterStore.shared.find(id: nativeId)
    else {
        InnerLog.c("🔴🔴🔴 NativeRecyclerViewAdapterOnBindViewHolder adapter not found")
        return
    }
    guard
        let viewHolder = RecyclerViewHolderStore.shared.find(id: holderId)
    else {
        InnerLog.c("🔴🔴🔴 NativeRecyclerViewAdapterOnBindViewHolder holder not found")
        return
    }
    // InnerLog.t("NativeRecyclerViewAdapterOnBindViewHolder calling bindViewHolder with id: \(holderId)")
    MainActor.assumeIsolated {
        adapter.bindViewHolder(viewHolder, Int(position))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_adapters_NativeRecyclerViewAdapter_nativeGetItemViewType")
public func NativeRecyclerViewAdapterGetItemViewType(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, nativeId: jint, position: jint) -> jint {
    var result: Int32 = 0
    guard
        let adapter = RecyclerViewAdapterStore.shared.find(id: nativeId)
    else { return 0 }
    result = MainActor.assumeIsolated {
        Int32(adapter._getItemViewTypeHandler(Int(position)))
    }
    return jint(result)
}
#endif