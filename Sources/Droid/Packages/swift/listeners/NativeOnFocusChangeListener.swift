//
//  NativeOnFocusChangeListener.swift
//  Droid
//
//  Created by Mihael Isaev on 18.08.2025.
//

#if os(Android)
import Android

extension AppKitPackage.ListenersPackage {
    public class OnFocusChangeListenerClass: JClassName, @unchecked Sendable {}
    public var OnFocusChangeListener: OnFocusChangeListenerClass { .init(parent: self, name: "NativeOnFocusChangeListener") }
}

final class NativeOnFocusChangeListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnFocusChangeListener" }

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@MainActor () -> Void)
    typealias HandlerWithEvent = (@MainActor (NativeOnFocusChangeListenerEvent) -> Void)

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
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ hasFocus: Bool) {
        if let view {
            handlerWithEvent?(.init(view, isSameView, triggerView, hasFocus)) ?? handler?()
        } else {
            handler?()
        }
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnFocusChangeListener_onFocusChange")
public func nativeListenerOnFocusChange(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, hasFocus: jboolean) {
    guard
        let listener: NativeOnFocusChangeListener = ListenerStore.shared.find(id: uniqueId)
    else { return }
    Task { @MainActor in
        listener.handle(true, nil, hasFocus == 1)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnFocusChangeListener_onFocusChangeExtended")
public func nativeListenerOnFocusChangeExtended(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject, hasFocus: jboolean) {
    guard
        let listener: NativeOnFocusChangeListener = ListenerStore.shared.find(id: uniqueId)
    else { return }
    let bool = sameView == 1 ? true : false
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    Task { @MainActor in
        listener.handle(bool, triggerView, hasFocus == 1)
    }
}
#endif

public final class NativeOnFocusChangeListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    public let hasFocus: Bool
    init (_ view: View, _ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ hasFocus: Bool) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
        self.hasFocus = hasFocus
    }
}