//
//  NativeOnHoverListener.swift
//  Droid
//
//  Created by Mihael Isaev on 21.08.2025.
//

#if os(Android)
import Android

extension AppKitPackage.ListenersPackage {
    public class OnHoverListenerClass: JClassName, @unchecked Sendable {}
    public var OnHoverListener: OnHoverListenerClass { .init(parent: self, name: "NativeOnHoverListener") }
}

final class NativeOnHoverListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnHoverListener" }

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@MainActor () -> Bool)
    typealias HandlerWithEvent = (@MainActor (NativeOnHoverListenerEvent) -> Bool)

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

    @MainActor
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ motionEvent: MotionEvent?) -> Bool {
        if let view {
            return handlerWithEvent?(.init(view, isSameView, triggerView, motionEvent)) ?? handler?() ?? false
        } else {
            return handler?() ?? false
        }
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnHoverListener_onHover")
public func nativeListenerOnHover(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) -> jboolean {
    guard
        let listener: NativeOnHoverListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let result = MainActor.assumeIsolated {
        listener.handle(true, nil, nil)
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnHoverListener_onHoverView")
public func nativeListenerOnHoverView(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject) -> jboolean {
    guard
        let listener: NativeOnHoverListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let bool = sameView == 1 ? true : false
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    let result = MainActor.assumeIsolated {
        listener.handle(bool, triggerView, nil)
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnHoverListener_onHoverEvent")
public func nativeListenerOnHoverEvent(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, event: jobject) -> jboolean {
    guard
        let listener: NativeOnHoverListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let box = event.box(JEnv(env))
    let result = MainActor.assumeIsolated {
        if let object = box?.object() {
            return listener.handle(true, nil, .init(object))
        }
        return false
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnHoverListener_onHoverViewEvent")
public func nativeListenerOnHoverViewEvent(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject, event: jobject) -> jboolean {
    guard
        let listener: NativeOnHoverListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let bool = sameView == 1 ? true : false
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    let box = event.box(JEnv(env))
    let result = MainActor.assumeIsolated {
        if let object = box?.object() {
            return listener.handle(bool, triggerView, .init(object))
        }
        return false
    }
    return result ? 1 : 0
}
#endif

public final class NativeOnHoverListenerEvent {
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