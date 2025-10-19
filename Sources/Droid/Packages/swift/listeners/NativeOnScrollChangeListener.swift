//
//  NativeOnScrollChangeListener.swift
//  Droid
//
//  Created by Mihael Isaev on 18.08.2025.
//

#if os(Android)
import Android

extension AppKitPackage.ListenersPackage {
    public class OnScrollChangeListenerClass: JClassName, @unchecked Sendable {}
    public var OnScrollChangeListener: OnScrollChangeListenerClass { .init(parent: self, name: "NativeOnScrollChangeListener") }
}

final class NativeOnScrollChangeListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnScrollChangeListener" }

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@MainActor () -> Void)
    typealias HandlerWithEvent = (@MainActor (NativeOnScrollChangeListenerEvent) -> Void)

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
    func handle(
        _ isSameView: Bool,
        _ triggerView: NativeListenerTriggerView? = nil,
        _ scrollX: Int,
        _ scrollY: Int,
        _ oldScrollX: Int,
        _ oldScrollY: Int
    ) {
        if let view {
            handlerWithEvent?(.init(
                view,
                isSameView,
                triggerView,
                scrollX,
                scrollY,
                oldScrollX,
                oldScrollY
            )) ?? handler?()
        } else {
            handler?()
        }
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnScrollChangeListener_onScrollChange")
public func nativeListenerOnScrollChange(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, scrollX: jint, scrollY: jint, oldScrollX: jint, oldScrollY: jint) {
    guard
        let listener: NativeOnScrollChangeListener = ListenerStore.shared.find(id: uniqueId)
    else { return }
    Task { @MainActor in
        listener.handle(true, nil, Int(scrollX), Int(scrollY), Int(oldScrollX), Int(oldScrollY))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnScrollChangeListener_onScrollChangeExtended")
public func nativeListenerOnScrollChangeExtended(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject, scrollX: jint, scrollY: jint, oldScrollX: jint, oldScrollY: jint) {
    guard
        let listener: NativeOnScrollChangeListener = ListenerStore.shared.find(id: uniqueId)
    else { return }
    let bool = sameView == 1 ? true : false
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    Task { @MainActor in
        listener.handle(bool, triggerView, Int(scrollX), Int(scrollY), Int(oldScrollX), Int(oldScrollY))
    }
}
#endif

public final class NativeOnScrollChangeListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    public let scrollX: Int
    public let scrollY: Int
    public let oldScrollX: Int
    public let oldScrollY: Int
    init (
        _ view: View,
        _ isSameView: Bool,
        _ triggerView: NativeListenerTriggerView? = nil,
        _ scrollX: Int,
        _ scrollY: Int,
        _ oldScrollX: Int,
        _ oldScrollY: Int
    ) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
        self.scrollX = scrollX
        self.scrollY = scrollY
        self.oldScrollX = oldScrollX
        self.oldScrollY = oldScrollY
    }
}