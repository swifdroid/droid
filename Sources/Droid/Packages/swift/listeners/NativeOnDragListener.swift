//
//  NativeOnDragListener.swift
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
    public class OnDragListenerClass: JClassName, @unchecked Sendable {}
    public var OnDragListener: OnDragListenerClass { .init(parent: self, name: "NativeOnDragListener") }
}

final class NativeOnDragListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnDragListener" }

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@UIThreadActor () -> Bool)
    typealias HandlerWithEvent = (@UIThreadActor (NativeOnDragListenerEvent) -> Bool)

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
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ dragEvent: DragEvent?) -> Bool {
        if let view {
            return handlerWithEvent?(.init(view, isSameView, triggerView, dragEvent)) ?? handler?() ?? false
        } else {
            return handler?() ?? false
        }
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnDragListener_onDrag")
public func nativeListenerOnDrag(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) -> jboolean {
    guard
        let listener: NativeOnDragListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let result = UIThreadActor.assumeIsolated {
        listener.handle(true, nil, nil)
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnDragListener_onDragView")
public func nativeListenerOnDragView(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject) -> jboolean {
    guard
        let listener: NativeOnDragListener = ListenerStore.shared.find(id: uniqueId)
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

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnDragListener_onDragEvent")
public func nativeListenerOnDragEvent(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, event: jobject) -> jboolean {
    guard
        let listener: NativeOnDragListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let box = event.box(JEnv(env))
    let result = UIThreadActor.assumeIsolated {
        if let object = box?.object() {
            return listener.handle(true, nil, .init(object))
        }
        return false
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnDragListener_onDragViewEvent")
public func nativeListenerOnDragViewEvent(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject, event: jobject) -> jboolean {
    guard
        let listener: NativeOnDragListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let bool = sameView == 1 ? true : false
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    let box = event.box(JEnv(env))
    let result = UIThreadActor.assumeIsolated {
        if let object = box?.object() {
            return listener.handle(bool, triggerView, .init(object))
        }
        return false
    }
    return result ? 1 : 0
}
#endif

public final class NativeOnDragListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    public let dragEvent: DragEvent?
    init (_ view: View, _ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ dragEvent: DragEvent?) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
        self.dragEvent = dragEvent
    }
}