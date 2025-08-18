//
//  NativeOnClickListener.swift
//  
//
//  Created by Mihael Isaev on 29.01.2022.
//

#if os(Android)
import Android
#if canImport(AndroidLooper)
import AndroidLooper
#endif
#if canImport(Logging)
import Logging
#endif
import FoundationEssentials

extension AppKitPackage.ListenersPackage {
    public class OnClickListenerClass: JClassName, @unchecked Sendable {}
    public var OnClickListener: OnClickListenerClass { .init(parent: self, name: "NativeOnClickListener") }
}

protocol AnyNativeListener {
    var id: Int32 { get }
}

protocol AnyListenerStore: AnyObject {
    associatedtype Listener: AnyNativeListener
    
    var listeners: [Int32: Listener] { get set }
    var mutex: pthread_mutex_t { get set }

    func add(_ listener: Listener)
    func remove(id: Int32)
    func get(id: Int32) -> Listener?
    func find(id: Int32) -> Listener?
}

extension AnyListenerStore {
    func add(_ listener: Listener) {
        mutex.lock()
        defer { mutex.unlock() }
        listeners[listener.id] = listener
    }
    
    func remove(id: Int32) {
        mutex.lock()
        defer { mutex.unlock() }
        listeners[id] = nil
    }
    
    func get(id: Int32) -> Listener? {
        mutex.lock()
        defer { mutex.unlock() }
        return listeners[id]
    }
    
    func find(id: Int32) -> Listener? {
        mutex.lock()
        defer { mutex.unlock() }
        guard
            let listener = listeners[id]
        else { return nil }
        return listener
    }
}

private final class OnClickListenerStore: AnyListenerStore, @unchecked Sendable {
    typealias Listener = NativeOnClickListener

    static let shared = OnClickListenerStore()

    var listeners: [Int32: Listener] = [:]

    var mutex = pthread_mutex_t()

    init () {
        mutex.activate(recursive: true)
    }

    deinit {
        mutex.destroy()
    }
}

public final class NativeOnClickListener: AnyNativeListener, @unchecked Sendable {
    public final class Instance: JObjectable, Sendable {
        /// The JNI class name
        static var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnClickListener" }

        /// Object wrapper
        public let object: JObject

        public convenience init? (_ id: Int32, _ context: ActivityContext) {
            #if os(Android)
            guard let env = JEnv.current() else { return nil }
            self.init(env, id, context)
            #else
            return nil
            #endif
        }
        
        public init? (_ env: JEnv, _ id: Int32, _ context: ActivityContext) {
            #if os(Android)
            InnerLog.t("onclick 1")
            guard
                let classLoader = context.getClassLoader()
            else {
                InnerLog.t("onclick 1.1")
                return nil
            }
            InnerLog.t("onclick 2 classLoader ref: \(classLoader.ref.ref)")
            guard
                let clazz = classLoader.loadClass(Self.className)
            else {
                InnerLog.t("onclick 2.1")
                return nil
            }
            InnerLog.t("onclick 3: \(env.getVersionString()) clazz ref: \(clazz.ref)")
            guard
                let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.int, returning: .void))
            else {
                InnerLog.t("onclick 3.1")
                return nil
            }
            InnerLog.t("onclick 4")
            guard
                let global = env.newObject(clazz: clazz, constructor: methodId, args: [id])
            else {
                InnerLog.t("onclick 4.1")
                return nil
            }
            self.object = global
            #else
            return nil
            #endif
        }
    }
    
    /// Unique identifier
    let id: Int32

    /// Action handler
    let handler: (() async -> Void)

    /// JNI Instance
    var instance: Instance?

    public init (_ id: Int32, _ handler: @escaping () async -> Void) {
        self.id = id
        self.handler = handler
        OnClickListenerStore.shared.add(self)
    }
    
    // deinit {
    //     OnClickListenerStore.shared.remove(id: id)
    // }

    func attach(to view: View.ViewInstance) {
        instance = Instance(view.id, view.context)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnClickListener_onClick")
public func nativeOnClickListenerOnClick(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    guard
        let listener = OnClickListenerStore.shared.find(id: uniqueId)
    else { return }
    Task { @UIThreadActor in
        await listener.handler()
    }
}
#endif