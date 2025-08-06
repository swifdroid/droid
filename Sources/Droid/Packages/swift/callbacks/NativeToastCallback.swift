//
//  NativeToastCallback.swift
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

extension AppKitPackage.CallbacksPackage {
    public class ToastCallbackClass: JClassName, @unchecked Sendable {}
    public var ToastCallback: ToastCallbackClass { .init(parent: self, name: "NativeToastCallback") }
}

private actor ToastCallbackStore {
    private var listeners: [UUID: NativeToastCallback] = [:]
    
    func add(_ listener: NativeToastCallback) {
        listeners[listener.id] = listener
    }
    
    func remove(id: UUID) {
        listeners[id] = nil
    }
    
    func get(id: UUID) -> NativeToastCallback? {
        listeners[id]
    }
    
    #if canImport(Android)
    func find(obj: JObjectBox, env: JEnv) -> NativeToastCallback? {
        InnerLog.t("ToastCallbacksStore.find 1")
        guard let object = obj.object() else { return nil }
        InnerLog.t("ToastCallbacksStore.find 2")
        guard let listener = listeners.values.first(where: {
            env.isSameObject($0.object, object)
        }) else {
            InnerLog.t("ToastCallbacksStore.find NOT FOUND")
            return nil
        }
        InnerLog.t("ToastCallbacksStore.find FOUND")
        return listener
    }
    #endif
}

public final class NativeToastCallback: JObjectable, @unchecked Sendable {
    /// The JNI class name
    static var className: JClassName { .appKit.callbacks.ToastCallback }
    
    fileprivate static let store = ToastCallbackStore()

    /// Unique identifier
    let id = UUID()

    /// Handlers
    let shownHandler: (() async -> Void)
    let hiddenHandler: (() async -> Void)

    /// Context
    let context: ActivityContext

    /// JNI Object
    public let object: JObject

    @discardableResult
    public init? (
        context: ActivityContext,
        onShown: @escaping () async -> Void,
        onHidden: @escaping () async -> Void
    ) {
        #if os(Android)
        InnerLog.t("NativeToastCallback init 1")
        guard
            let env = JEnv.current()
        else {
            InnerLog.t("NativeToastCallback init 1.1")
            return nil
        }
        InnerLog.t("NativeToastCallback init 2")
        guard
            let classLoader = context.getClassLoader()
        else {
            InnerLog.t("NativeToastCallback init 2.1")
            return nil
        }
        InnerLog.t("NativeToastCallback init 3 classLoader ref: \(classLoader.ref.ref)")
        guard
            let clazz = classLoader.loadClass(Self.className)
        else {
            InnerLog.t("NativeToastCallback init 3.1")
            return nil
        }
        InnerLog.t("NativeToastCallback init 4: \(env.getVersionString()) clazz ref: \(clazz.ref)")
        guard
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .returning(.void))
        else {
            InnerLog.t("NativeToastCallback init 4.1")
            return nil
        }
        InnerLog.t("NativeToastCallback init 5")
        guard
            let global = env.newObject(clazz: clazz, constructor: methodId)
        else {
            InnerLog.t("NativeToastCallback init 5.1")
            return nil
        }
        self.object = global
        #else
        return nil
        #endif
        self.context = context
        self.shownHandler = onShown
        self.hiddenHandler = onHidden
        Task {
            await NativeToastCallback.store.add(self)
        }
    }
    
    // deinit {
    //     let id = self.id
    //     Task {
    //         await NativeToastCallback.store.remove(id: id)
    //     }
    // }
}

#if canImport(Android)
@_cdecl("Java_stream_swift_droid_appkit_callbacks_NativeToastCallback_onToastShown")
public func nativeToastCallbackOnToastShown(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, view: jobject) {
    InnerLog.t("nativeToastCallbackOnToastShown 1")
    let env = JEnv(env)
    guard let callerObjectBox = JObjectBox(callerClassObject, env: env) else {
        return
    }
    InnerLog.t("nativeToastCallbackOnToastShown 2")
    Task {
        InnerLog.t("nativeToastCallbackOnToastShown 3")
        guard
            let env = JEnv.current(),
            let listener = await NativeToastCallback.store.find(obj: callerObjectBox, env: env)
        else { return }
        InnerLog.t("nativeToastCallbackOnToastShown 4")
        await listener.shownHandler()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_callbacks_NativeToastCallback_onToastHidden")
public func nativeToastCallbackOnToastHidden(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, view: jobject) {
    InnerLog.t("nativeToastCallbackOnToastHidden 1")
    let env = JEnv(env)
    guard let callerObjectBox = JObjectBox(callerClassObject, env: env) else {
        return
    }
    InnerLog.t("nativeToastCallbackOnToastHidden 2")
    Task {
        InnerLog.t("nativeToastCallbackOnToastHidden 3")
        guard
            let env = JEnv.current(),
            let listener = await NativeToastCallback.store.find(obj: callerObjectBox, env: env)
        else { return }
        InnerLog.t("nativeToastCallbackOnToastHidden 4")
        await listener.hiddenHandler()
    }
}
#endif