//
//  NativeOnKeyListener.swift
//  Droid
//
//  Created by Mihael Isaev on 21.08.2025.
//

#if os(Android)
import Android
#if canImport(AndroidLooper)
import AndroidLooper
#endif

extension AppKitPackage.ListenersPackage {
    public class OnKeyListenerClass: JClassName, @unchecked Sendable {}
    public var OnKeyListener: OnKeyListenerClass { .init(parent: self, name: "NativeOnKeyListener") }
}

final class NativeOnKeyListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnKeyListener" }

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@UIThreadActor () -> Bool)
    typealias HandlerWithEvent = (@UIThreadActor (NativeOnKeyListenerEvent) -> Bool)

    /// View
    var view: View?

    /// Handlers
    var handler: Handler?
    var handlerWithEvent: HandlerWithEvent?

    func setHandler(_ view: View?, _ handler: @escaping Handler) -> Self {
        self.view = view
        self.handler = handler
        return self
    }

    func setHandler(_ view: View?, _ handler: @escaping HandlerWithEvent) -> Self {
        self.view = view
        self.handlerWithEvent = handler
        return self
    }

    #if canImport(AndroidLooper)
    @UIThreadActor
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ keyEvent: KeyEvent?) -> Bool {
        if let view {
            return handlerWithEvent?(.init(view, isSameView, triggerView, keyEvent)) ?? handler?() ?? false
        } else {
            return handler?() ?? false
        }
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnKeyListener_onKey")
public func nativeListenerOnKey(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) -> jboolean {
    guard
        let listener: NativeOnKeyListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let result = UIThreadActor.assumeIsolated {
        listener.handle(true, nil, nil)
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnKeyListener_onKeyView")
public func nativeListenerOnKeyView(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject) -> jboolean {
    guard
        let listener: NativeOnKeyListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let bool = sameView == 1 ? true : false
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    let result = UIThreadActor.assumeIsolated {
        listener.handle(bool, triggerView, nil)
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnKeyListener_onKeyEvent")
public func nativeListenerOnKeyEvent(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, event: jobject) -> jboolean {
    guard
        let listener: NativeOnKeyListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    var keyEvent: KeyEvent?
    if let object = event.box(JEnv(env))?.object() {
        keyEvent = .init(object)
    }
    let result = UIThreadActor.assumeIsolated {
        listener.handle(true, nil, keyEvent)
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnKeyListener_onKeyViewEvent")
public func nativeListenerOnKeyViewEvent(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject, event: jobject) -> jboolean {
    guard
        let listener: NativeOnKeyListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let bool = sameView == 1 ? true : false
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    var keyEvent: KeyEvent?
    if let object = event.box(JEnv(env))?.object() {
        keyEvent = .init(object)
    }
    let result = UIThreadActor.assumeIsolated {
        listener.handle(bool, triggerView, keyEvent)
    }
    return result ? 1 : 0
}
#endif

public final class NativeOnKeyListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    public let keyEvent: KeyEvent?
    init (_ view: View, _ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ keyEvent: KeyEvent?) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
        self.keyEvent = keyEvent
    }
}