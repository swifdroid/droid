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

@MainActor
public final class NativeRecyclerViewHolder<V: Viewable>: AnyNativeRecyclerViewHolder, JObjectable, @unchecked Sendable {
    /// The JNI class name
    static var className: JClassName { "stream/swift/droid/appkit/adapters/NativeRecyclerViewHolder" }

    /// Object wrapper
    public let object: JObject
    
    /// Unique identifier
    let id: Int32 = DroidApp.getNextViewId()

    /// View
    let view: V

    var viewMovedToParent = false

    public convenience init? (_ context: Contextable, _ view: V) {
        #if os(Android)
        guard let env = JEnv.current() else { return nil }
        self.init(env, context, view)
        #else
        return nil
        #endif
    }
    
    public init? (_ env: JEnv, _ context: Contextable, _ view: V) {
        // InnerLog.t("🟡 NativeRecyclerViewHolder: init 1")
        #if os(Android)
        guard let context = context.context else {
            InnerLog.c("🔴 NativeRecyclerViewHolder: init 1.1 exit, missing context")
            return nil
        }
        // InnerLog.t("🟡 NativeRecyclerViewHolder: init 2")
        guard
            let clazz = JClass.load(Self.className)
        else {
            InnerLog.c("🔴 NativeRecyclerViewHolder: init 2.1 exit, missing clazz")
            return nil
        }
        // InnerLog.t("🟡 NativeRecyclerViewHolder: init 3")
        guard
            let viewInstance = view.view.setStatusAsContentView({ [weak context] in
                // InnerLog.t("🟡 NativeRecyclerViewHolder: getting context for view (\(context != nil))")
                return context
            })
        else {
            InnerLog.c("🔴 NativeRecyclerViewHolder: init 3.1 exit, missing context")
            return nil
        }
        // InnerLog.t("🟡 NativeRecyclerViewHolder: init 4")
        guard
            let global = clazz.newObject(env, args: id, viewInstance.object.signed(as: .android.view.View))
        else {
            InnerLog.c("🔴 NativeRecyclerViewHolder: init 4.1 exit, newObject failed")
            return nil
        }
        // InnerLog.t("🟡 NativeRecyclerViewHolder: init 5")
        self.object = global
        self.view = view
        RecyclerViewHolderStore.shared.add(self)
        #else
        return nil
        #endif
    }
}