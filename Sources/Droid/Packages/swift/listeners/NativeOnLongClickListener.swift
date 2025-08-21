//
//  NativeOnLongClickListener.swift
//  Droid
//
//  Created by Mihael Isaev on 18.08.2025.
//

#if os(Android)
import Android
#if canImport(AndroidLooper)
import AndroidLooper
#endif

extension AppKitPackage.ListenersPackage {
    public class OnLongClickListenerClass: JClassName, @unchecked Sendable {}
    public var OnLongClickListener: OnLongClickListenerClass { .init(parent: self, name: "NativeOnLongClickListener") }
}

public final class NativeOnLongClickListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    init (_ view: View, _ isSameView: Bool, _ triggerView: NativeListenerTriggerView? = nil) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
    }
}

final class NativeOnLongClickListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnLongClickListener" }

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@UIThreadActor () -> Bool)
    typealias HandlerWithEvent = (@UIThreadActor (NativeOnLongClickListenerEvent) -> Bool)

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
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView? = nil) -> Bool {
        if let view {
            return handlerWithEvent?(.init(view, isSameView, triggerView)) ?? handler?() ?? false
        } else {
            return handler?() ?? false
        }
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnLongClickListener_onLongClick")
public func nativeListenerOnLongClick(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) -> jboolean {
    guard
        let listener: NativeOnLongClickListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let result = UIThreadActor.assumeIsolated {
        listener.handle(true, nil)
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnLongClickListener_onLongClickExtended")
public func nativeListenerOnLongClickExtended(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject) -> jboolean {
    guard
        let listener: NativeOnLongClickListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let bool = sameView == 1 ? true : false
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    let result = UIThreadActor.assumeIsolated {
        listener.handle(bool, triggerView)
    }
    return result ? 1 : 0
}
#else
public final class NativeOnLongClickListenerEvent {
    public let view: View! = nil
    public let isSameView: Bool = false
    public let triggerView: NativeListenerTriggerView? = nil
    init() {}
}
#endif