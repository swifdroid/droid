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
#if canImport(AndroidLooper)
import AndroidLooper
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

#if canImport(AndroidLooper)
@UIThreadActor
#endif
protocol AnyRecyclerViewAdapter: AnyObject, Sendable {
    nonisolated var id: Int32 { get }
    var itemsCountHandler: (() -> Int) { get }
    var getItemViewTypeHandler: ((Int) -> Int) { get }
    func createViewHolder(_ position: Int) -> JObject?
    func bindViewHolder(_ holder: AnyNativeRecyclerViewHolder, _ position: Int)
    func instantiate(_ context: View.ViewInstance) -> RecyclerViewAdapterInstance?
}

public final class RecyclerViewAdapter<V: View>: AnyRecyclerViewAdapter, @unchecked Sendable {
    /// Unique identifier
    let id: Int32 = DroidApp.getNextViewId()

    /// Action handler
    let itemsCountHandler: (() -> Int)
    let onCreateViewHolderHandler: ((Int) -> V)
    let onBindViewHolderHandler: ((V, Int) -> Void)
    let getItemViewTypeHandler: ((Int) -> Int)

    /// JNI Instance
    var instance: RecyclerViewAdapterInstance?

    public init (
        count: @escaping (() -> Int),
        createView: @escaping (Int) -> V,
        bindView: @escaping (V, Int) -> Void,
        viewType: @escaping ((Int) -> Int) = { _ in return 0 }
    ) {
        self.itemsCountHandler = count
        self.onCreateViewHolderHandler = createView
        self.onBindViewHolderHandler = bindView
        self.getItemViewTypeHandler = viewType
        RecyclerViewAdapterStore.shared.add(self)
    }

    func createViewHolder(_ position: Int) -> JObject? {
        guard let instance else {
            return nil
        }
        let view = onCreateViewHolderHandler(position)
        view.willMoveToParent()
        if let holder = NativeRecyclerViewHolder(instance.context, view) {
            return holder.object
        }
        return nil
    }

    func bindViewHolder(_ holder: AnyNativeRecyclerViewHolder, _ position: Int) {
        guard let holder = holder as? NativeRecyclerViewHolder<V> else { return }
        if !holder.viewMovedToParent {
            holder.view.didMoveToParent()
            holder.viewMovedToParent = true
        }
        onBindViewHolderHandler(holder.view, position)
    }
    
    // deinit {
    //     NativeRecyclerViewAdapter.store.remove(id: id)
    // }

    func instantiate(_ context: View.ViewInstance) -> RecyclerViewAdapterInstance? {
        instance = RecyclerViewAdapterInstance(context.context, id)
        return instance
    }
}

final class RecyclerViewAdapterInstance: JObjectable, Sendable {
    /// The JNI class name
    static var className: JClassName { "stream/swift/droid/appkit/adapters/NativeRecyclerViewAdapter" }

    /// Context
    let context: ActivityContext

    /// Object wrapper
    let object: JObject

    /// ID
    let id: Int32

    convenience init? (_ context: ActivityContext, _ id: Int32) {
        #if os(Android)
        guard let env = JEnv.current() else { return nil }
        self.init(env, context, id)
        #else
        return nil
        #endif
    }
    
    init? (_ env: JEnv, _ context: ActivityContext, _ id: Int32) {
        #if os(Android)
        guard
            let classLoader = context.getClassLoader()
        else {
            return nil
        }
        guard
            let clazz = classLoader.loadClass(Self.className)
        else {
            return nil
        }
        guard
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.int, returning: .void))
        else {
            return nil
        }
        guard
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [id])
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
    let result = UIThreadActor.assumeIsolated {
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
    let result = UIThreadActor.assumeIsolated {
        adapter.createViewHolder(Int(viewType))
    }
    if let result {
        return result.ref.ref
    }
    return nil
}

@_cdecl("Java_stream_swift_droid_appkit_adapters_NativeRecyclerViewAdapter_nativeOnBindViewHolder")
public func NativeRecyclerViewAdapterOnBindViewHolder(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, nativeId: jint, holderId: jint, holder: jobject, position: jint) {
    guard
        let adapter = RecyclerViewAdapterStore.shared.find(id: nativeId),
        let viewHolder = RecyclerViewHolderStore.shared.find(id: holderId)
    else { return }
    Task { @UIThreadActor in
        adapter.bindViewHolder(viewHolder, Int(position))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_adapters_NativeRecyclerViewAdapter_nativeGetItemViewType")
public func NativeRecyclerViewAdapterGetItemViewType(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, nativeId: jint, position: jint) -> jint {
    var result: Int32 = 0
    guard
        let adapter = RecyclerViewAdapterStore.shared.find(id: nativeId)
    else { return 0 }
    result = UIThreadActor.assumeIsolated {
        Int32(adapter.getItemViewTypeHandler(Int(position)))
    }
    return jint(result)
}

extension UIThreadActor {
    static func assumeIsolated<T : Sendable>(
      _ operation: @UIThreadActor () throws -> T,
      file: StaticString = #fileID, line: UInt = #line
  ) rethrows -> T {
    typealias YesActor = @UIThreadActor () throws -> T
    typealias NoActor = () throws -> T

    // To do the unsafe cast, we have to pretend it's @escaping.
    return try withoutActuallyEscaping(operation) {
      (_ fn: @escaping YesActor) throws -> T in
      let rawFn = unsafeBitCast(fn, to: NoActor.self)
      return try rawFn()
    }
  }
}
#endif