//
//  NativeOnCapturedPointerListener.swift
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
    public class OnCapturedPointerListenerClass: JClassName, @unchecked Sendable {}
    public var OnCapturedPointerListener: OnCapturedPointerListenerClass { .init(parent: self, name: "NativeOnCapturedPointerListener") }
}

final class NativeOnCapturedPointerListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnCapturedPointerListener" }

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@UIThreadActor () -> Bool)
    typealias HandlerWithEvent = (@UIThreadActor (NativeOnCapturedPointerListenerEvent) -> Bool)

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
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ motionEvent: MotionEvent?) -> Bool {
        if let view {
            return handlerWithEvent?(.init(view, isSameView, triggerView, motionEvent)) ?? handler?() ?? false
        } else {
            return handler?() ?? false
        }
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnCapturedPointerListener_onCapturedPointer")
public func nativeListenerOnCapturedPointer(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) -> jboolean {
    guard
        let listener: NativeOnCapturedPointerListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let result = UIThreadActor.assumeIsolated {
        listener.handle(true, nil, nil)
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnCapturedPointerListener_onCapturedPointerView")
public func nativeListenerOnCapturedPointerView(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject) -> jboolean {
    guard
        let listener: NativeOnCapturedPointerListener = ListenerStore.shared.find(id: uniqueId)
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

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnCapturedPointerListener_onCapturedPointerEvent")
public func nativeListenerOnCapturedPointerEvent(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, event: jobject) -> jboolean {
    guard
        let listener: NativeOnCapturedPointerListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    var motionEvent: MotionEvent?
    if let object = event.box(JEnv(env))?.object() {
        motionEvent = .init(object)
    }
    let result = UIThreadActor.assumeIsolated {
        listener.handle(true, nil, motionEvent)
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnCapturedPointerListener_onCapturedPointerViewEvent")
public func nativeListenerOnCapturedPointerViewEvent(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject, event: jobject) -> jboolean {
    guard
        let listener: NativeOnCapturedPointerListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let bool = sameView == 1 ? true : false
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    var motionEvent: MotionEvent?
    if let object = event.box(JEnv(env))?.object() {
        motionEvent = .init(object)
    }
    let result = UIThreadActor.assumeIsolated {
        listener.handle(bool, triggerView, motionEvent)
    }
    return result ? 1 : 0
}
#endif

public final class NativeOnCapturedPointerListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    public let motionEvent: MotionEvent?
    init (_ view: View, _ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ motionEvent: MotionEvent?) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
        self.motionEvent = motionEvent
    }
}