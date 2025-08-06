//
//  NativeOnClickListener.swift
//  
//
//  Created by Mihael Isaev on 29.01.2022.
//

#if canImport(Android)
import Android
#endif
#if canImport(Logging)
import Logging
#endif
import FoundationEssentials

extension AppKitPackage.ListenersPackage {
    public class OnClickListenerClass: JClassName, @unchecked Sendable {}
    public var OnClickListener: OnClickListenerClass { .init(parent: self, name: "NativeOnClickListener") }
}

private actor OnClickListenerStore {
    private var listeners: [UUID: NativeOnClickListener] = [:]
    
    func add(_ listener: NativeOnClickListener) {
        listeners[listener.id] = listener
    }
    
    func remove(id: UUID) {
        listeners[id] = nil
    }
    
    func get(id: UUID) -> NativeOnClickListener? {
        listeners[id]
    }
    
    #if canImport(Android)
    func find(obj: JObjectBox, env: JEnv) -> NativeOnClickListener? {
        InnerLog.i("OnClickListenerStore.find 1")
        guard let object = obj.object() else { return nil }
        InnerLog.i("OnClickListenerStore.find 2")
        guard let listener = listeners.values.first(where: {
            if let instance = $0.instance {
                return env.isSameObject(instance.object, object)
            }
            return false
        }) else {
            InnerLog.i("OnClickListenerStore.find NOT FOUND")
            return nil
        }
        InnerLog.i("OnClickListenerStore.find FOUND")
        return listener
    }
    #endif
}

public final class NativeOnClickListener: @unchecked Sendable {
    public final class Instance: JObjectable, Sendable {
        /// The JNI class name
        static var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnClickListener" }

        /// Object wrapper
        public let object: JObject

        public convenience init? (_ context: ActivityContext) {
            #if os(Android)
            guard let env = JEnv.current() else { return nil }
            self.init(env, context)
            #else
            return nil
            #endif
        }
        
        public init? (_ env: JEnv, _ context: ActivityContext) {
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
                let methodId = clazz.methodId(env: env, name: "<init>", signature: .returning(.void))
            else {
                InnerLog.t("onclick 3.1")
                return nil
            }
            InnerLog.t("onclick 4")
            guard
                let global = env.newObject(clazz: clazz, constructor: methodId)
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
    
    fileprivate static let store = OnClickListenerStore()

    /// Unique identifier
    let id = UUID()

    /// Action handler
    let handler: (() async -> Void)

    /// JNI Instance
    var instance: Instance?

    public init (_ handler: @escaping () async -> Void) {
        self.handler = handler
        Task {
            await NativeOnClickListener.store.add(self)
        }
    }
    
    // deinit {
    //     let id = self.id
    //     Task {
    //         await NativeOnClickListener.listenerStore.remove(id: id)
    //     }
    // }

    func attach(to view: View.ViewInstance) {
        instance = Instance(view.context)
    }
}

#if canImport(Android)
@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnClickListener_onClick")
public func nativeOnClickListenerOnClick(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, view: jobject) {
    InnerLog.t("nativeOnClickListenerOnClick 1")
    let env = JEnv(env)
    guard let callerObjectBox = JObjectBox(callerClassObject, env: env) else {
        return
    }
    InnerLog.t("nativeOnClickListenerOnClick 2")
    Task {
        InnerLog.t("nativeOnClickListenerOnClick 3")
        guard
            let env = JEnv.current(),
            let listener = await NativeOnClickListener.store.find(obj: callerObjectBox, env: env)
        else { return }
        InnerLog.t("nativeOnClickListenerOnClick 4")
        await listener.handler()
    }
}
#endif