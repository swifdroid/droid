//
//  NativeOnReceiveContentCompatListener.swift
//  
//
//  Created by Mihael Isaev on 29.01.2022.
//

#if os(Android)
import Android

extension AppKitPackage.ListenersPackage {
    public class OnReceiveContentCompatListenerClass: JClassName, @unchecked Sendable {}
    public var OnReceiveContentCompatListener: OnReceiveContentCompatListenerClass { .init(parent: self, name: "NativeOnReceiveContentCompatListener") }
}

final class NativeOnReceiveContentCompatListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnReceiveContentCompatListener" }    

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@MainActor () -> ContentInfoCompat?)
    typealias HandlerWithEvent = (@MainActor (NativeOnReceiveContentCompatListenerEvent) -> ContentInfoCompat?)

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
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ payload: ContentInfoCompat?) -> ContentInfoCompat? {
        if let view {
            return handlerWithEvent?(.init(view, isSameView, triggerView, payload))
        }
        return handler?()
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnReceiveContentCompatListener_onReceiveContent")
public func nativeListenerOnReceiveContentCompat(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject, p: jobject) -> jobject? {
    guard
        let listener: NativeOnReceiveContentCompatListener = ListenerStore.shared.find(id: uniqueId)
    else { return nil }
    let bool = vId == -1 ? true : (sameView == 1 ? true : false)
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    var payload: ContentInfoCompat?
    if let object = p.box(JEnv(env))?.object() {
        payload = .init(object)
    }
    let result = MainActor.assumeIsolated {
        listener.handle(bool, triggerView, payload)
    }
    return result?.object.ref.ref
}
#endif

public final class NativeOnReceiveContentCompatListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    public let payload: ContentInfoCompat?
    init (_ view: View, _ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ payload: ContentInfoCompat?) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
        self.payload = payload
    }
}

public final class ContentInfoCompat: JObjectable, Sendable {
    /// The JNI class name
    class var className: JClassName { "androidx/core/view/ContentInfoCompat" }    

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    // TODO: implement methods and properties
}