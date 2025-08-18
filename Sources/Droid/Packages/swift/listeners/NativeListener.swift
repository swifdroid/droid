//
//  NativeListener.swift
//  Droid
//
//  Created by Mihael Isaev on 18.08.2025.
//

#if os(Android)
import Android
#if canImport(AndroidLooper)
import AndroidLooper
#endif

protocol AnyNativeListener: AnyObject {
    static var className: JClassName { get }
    var id: Int32 { get }
    var instance: ListenerInstance? { get set }
}

extension AnyNativeListener {
    var stringId: String { "\(Self.className.name)\(id)" }
    static func stringId(_ id: Int32) -> String {
        "\(className.name)\(id)"
    }
}

extension AnyNativeListener {
    func addIntoStore() {
        ListenerStore.shared.add(self)
    }

    func attach(to view: View.ViewInstance) {
        instance = .init(view.id, view.context, Self.className)
    }
}

class NativeListener: @unchecked Sendable {
    /// Unique identifier
    let id: Int32

    /// JNI Instance
    var instance: ListenerInstance?

    public init (_ id: Int32) {
        self.id = id
        if let s = self as? AnyNativeListener {
            s.addIntoStore()
        }
    }
    
    // deinit {
    //     ListenerStore.shared.remove(id: id)
    // }
}

// MARK: - Instance

class ListenerInstance: @unchecked Sendable {
    /// Object wrapper
    public let object: JObject

    public convenience init? (_ id: Int32, _ context: ActivityContext, _ className: JClassName) {
        guard let env = JEnv.current() else { return nil }
        self.init(env, id, context, className)
    }
    
    public init? (_ env: JEnv, _ id: Int32, _ context: ActivityContext, _ className: JClassName) {
        guard
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.int, returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [id])
        else { return nil }
        self.object = global
    }
}

// MARK: - Store

final class ListenerStore: @unchecked Sendable {
    static let shared = ListenerStore()

    var listeners: [String: AnyNativeListener] = [:]

    var mutex = pthread_mutex_t()

    init () {
        mutex.activate(recursive: true)
    }

    deinit {
        mutex.destroy()
    }

    func add<L: AnyNativeListener>(_ listener: L) {
        mutex.lock()
        defer { mutex.unlock() }
        listeners[listener.stringId] = listener
    }
    
    func remove<L: AnyNativeListener>(_ listener: L) {
        mutex.lock()
        defer { mutex.unlock() }
        listeners[listener.stringId] = nil
    }
    
    func find<L: AnyNativeListener>(id: Int32) -> L? {
        mutex.lock()
        defer { mutex.unlock() }
        return listeners[L.stringId(id)] as? L
    }
}
#endif