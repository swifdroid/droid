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

extension SwiftPackage.ViewPackage {
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
        DroidApp.logger.info("OnClickListenerStore.find 1")
        guard let object = obj.object() else { return nil }
        DroidApp.logger.info("OnClickListenerStore.find 2")
        guard let listener = listeners.values.first(where: {
            if let instance = $0.instance {
                return env.isSameObject(instance.object, object)
            }
            return false
        }) else {
            DroidApp.logger.info("OnClickListenerStore.find NOT FOUND")
            return nil
        }
        DroidApp.logger.info("OnClickListenerStore.find FOUND")
        return listener
    }
    #endif
}

public final class NativeOnClickListener: @unchecked Sendable {
    public final class Instance: JObjectable, Sendable {
        /// The JNI class name
        static var className: JClassName { "com/somebody/app/NativeOnClickListener" }//.swift.view.OnClickListener }

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
            let logger = Logger(label: "nativeonclick")
            logger.info("onclick 1")
            guard
                let classLoader = context.getClassLoader()
            else {
                logger.info("onclick 1.1")
                return nil
            }
            logger.info("onclick 2 classLoader ref: \(classLoader.ref.ref)")
            guard
                let clazz = classLoader.loadClass(Self.className)
            else {
                logger.info("onclick 2.1")
                return nil
            }
            logger.info("onclick 3: \(env.getVersionString()) clazz ref: \(clazz.ref)")
            guard
                let methodId = clazz.methodId(env: env, name: "<init>", signature: .returning(.void))
            else {
                logger.info("onclick 3.1")
                return nil
            }
            logger.info("onclick 4")
            guard
                let global = env.newObject(clazz: clazz, constructor: methodId)
            else {
                logger.info("onclick 4.1")
                return nil
            }
            self.object = global
            #else
            return nil
            #endif
        }
    }

    deinit {
        Logger(label: "NativeOnClickListener").critical("🧹🧹 deinit Instance")
    }
    
    fileprivate static let listenerStore = OnClickListenerStore()

    /// Unique identifier
    let id = UUID()

    /// Action handler
    let handler: (() async -> Void)

    /// JNI Instance
    var instance: Instance?

    public init (_ handler: @escaping () async -> Void) {
        self.handler = handler
        Task {
            await NativeOnClickListener.listenerStore.add(self)
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
// @_cdecl("Java_stream_swift_android_view_NativeOnClickListener_onClick")
@_cdecl("Java_com_somebody_app_NativeOnClickListener_onClick")
public func on_click_listener_onClick(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, view: jobject) {
    DroidApp.logger.info("on_click_listener_onClick 1")
    let env = JEnv(env)
    guard let callerObjectBox = JObjectBox(callerClassObject, env: env) else {
        return
    }
    DroidApp.logger.info("on_click_listener_onClick 2")
    Task {
        DroidApp.logger.info("on_click_listener_onClick 3")
        guard
            let env = JEnv.current(),
            let listener = await NativeOnClickListener.listenerStore.find(obj: callerObjectBox, env: env)
        else { return }
        DroidApp.logger.info("on_click_listener_onClick 4")
        await listener.handler()
    }
}
#endif