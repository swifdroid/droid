//
//  NativeRecyclerViewHolder.swift
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
    public class RecyclerViewHolderClass: JClassName, @unchecked Sendable {}
    public var RecyclerViewHolder: RecyclerViewHolderClass { .init(parent: self, name: "NativeRecyclerViewHolder") }
}

final class RecyclerViewHolderStore: @unchecked Sendable {
    private var holders: [Int32: AnyNativeRecyclerViewHolder] = [:]

    static let shared = RecyclerViewHolderStore()

    private var mutex = pthread_mutex_t()

    init () {
        mutex.activate(recursive: true)
    }

    deinit {
        mutex.destroy()
    }
    
    func add(_ holder: AnyNativeRecyclerViewHolder) {
        mutex.lock()
        defer { mutex.unlock() }
        holders[holder.id] = holder
    }
    
    func remove(id: Int32) {
        mutex.lock()
        defer { mutex.unlock() }
        holders[id] = nil
    }
    
    func get(id: Int32) -> AnyNativeRecyclerViewHolder? {
        mutex.lock()
        defer { mutex.unlock() }
        return holders[id]
    }
    
    #if canImport(Android)
    func find(id: Int32) -> AnyNativeRecyclerViewHolder? {
        mutex.lock()
        defer { mutex.unlock() }
        guard
            let holder = holders[id]
        else { return nil }
        return holder
    }
    #endif
}

protocol AnyNativeRecyclerViewHolder: AnyObject, Sendable {
    var id: Int32 { get }
}

#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class NativeRecyclerViewHolder<V: View>: AnyNativeRecyclerViewHolder, JObjectable, @unchecked Sendable {
    /// The JNI class name
    static var className: JClassName { "stream/swift/droid/appkit/adapters/NativeRecyclerViewHolder" }

    /// Object wrapper
    public let object: JObject
    
    /// Unique identifier
    let id: Int32 = DroidApp.getNextViewId()

    /// View
    let view: V

    var viewMovedToParent = false

    public convenience init? (_ context: ActivityContext, _ view: V) {
        #if os(Android)
        guard let env = JEnv.current() else { return nil }
        self.init(env, context, view)
        #else
        return nil
        #endif
    }
    
    public init? (_ env: JEnv, _ context: ActivityContext, _ view: V) {
        #if os(Android)
        guard
            let clazz = JClass.load(Self.className)
        else {
            return nil
        }
        guard
            let viewInstance = view.setStatusAsContentView(context)
        else {
            return nil
        }
        guard
            let global = clazz.newObject(env, args: id, viewInstance.object.signed(as: .android.view.View))
        else {
            return nil
        }
        self.object = global
        self.view = view
        RecyclerViewHolderStore.shared.add(self)
        #else
        return nil
        #endif
    }
    
    // deinit {
    //     RecyclerViewHolderStore.shared.remove(id: id)
    // }
}