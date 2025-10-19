//
//  NativeOnContextClickListener.swift
//  Droid
//
//  Created by Mihael Isaev on 21.08.2025.
//

#if os(Android)
import Android

extension AppKitPackage.ListenersPackage {
    public class OnContextClickListenerClass: JClassName, @unchecked Sendable {}
    public var OnContextClickListener: OnContextClickListenerClass { .init(parent: self, name: "NativeOnContextClickListener") }
}

final class NativeOnContextClickListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnContextClickListener" }

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@MainActor () -> Bool)
    typealias HandlerWithEvent = (@MainActor (NativeOnContextClickListenerEvent) -> Bool)

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
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView? = nil) -> Bool {
        if let view {
            return handlerWithEvent?(.init(view, isSameView, triggerView)) ?? handler?() ?? false
        } else {
            return handler?() ?? false
        }
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnContextClickListener_onContextClick")
public func nativeListenerOnContextClick(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) -> jboolean {
    guard
        let listener: NativeOnContextClickListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let result = MainActor.assumeIsolated {
        listener.handle(true, nil)
    }
    return result ? 1 : 0
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnContextClickListener_onContextClickExtended")
public func nativeListenerOnContextClickExtended(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject) -> jboolean {
    guard
        let listener: NativeOnContextClickListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let bool = sameView == 1 ? true : false
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    let result = MainActor.assumeIsolated {
        listener.handle(bool, triggerView)
    }
    return result ? 1 : 0
}
#endif

public final class NativeOnContextClickListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    init (_ view: View, _ isSameView: Bool, _ triggerView: NativeListenerTriggerView? = nil) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
    }
}