//
//  NativeListener.swift
//  Droid
//
//  Created by Mihael Isaev on 18.08.2025.
//

#if os(Android)
import Android

protocol AnyNativeListener: AnyObject {
    static var className: JClassName { get }
    var id: Int32 { get }
    var instance: ListenerInstance? { get set }
    var shouldInitWithViewId: Bool { get }
}

extension AnyNativeListener {
    var stringId: String { "\(Self.className.name)\(id)" }
    static func stringId(_ id: Int32) -> String {
        "\(className.name)\(id)"
    }
    
    func addIntoStore() {
        ListenerStore.shared.add(self)
    }

    @MainActor
    func instantiate(_ context: Contextable) -> ListenerInstance? {
        instance = .init(
            id,
            viewId: nil,
            context.context,
            Self.className
        )
        return instance
    }

    func attach(to view: View.ViewInstance) {
        instance = .init(
            id,
            viewId: shouldInitWithViewId ? view.id : nil,
            view.context,
            Self.className
        )
    }
}

class NativeListener: @unchecked Sendable {
    /// Unique identifier
    let id: Int32

    /// View identifier
    let viewId: Int32?

    /// JNI Instance
    var instance: ListenerInstance?

    public init (_ id: Int32, viewId: Int32?) {
        self.id = id
        self.viewId = nil
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

    public convenience init? (_ id: Int32, viewId: Int32? = nil, _ context: ActivityContext, _ className: JClassName) {
        guard let env = JEnv.current() else { return nil }
        self.init(env, id, viewId: viewId, context, className)
    }
    
    public init? (_ env: JEnv, _ id: Int32, viewId: Int32? = nil, _ context: ActivityContext, _ className: JClassName) {
        var args: [JSignatureItemable] = [id]
        if let viewId {
            args.append(viewId)
        }
        guard
            let clazz = JClass.load(className),
            let global = clazz.newObject(env, args: args)
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

public final class NativeListenerTriggerView: Sendable {
    public let id: Int32
    public let object: JObject

    init (id: Int32, object: JObject) {
        self.id = id
        self.object = object
    }
}