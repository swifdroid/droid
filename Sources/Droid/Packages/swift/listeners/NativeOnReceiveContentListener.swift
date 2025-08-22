//
//  NativeOnReceiveContentListener.swift
//  
//
//  Created by Mihael Isaev on 29.01.2022.
//

#if os(Android)
import Android
#if canImport(AndroidLooper)
import AndroidLooper
#endif

extension AppKitPackage.ListenersPackage {
    public class OnReceiveContentListenerClass: JClassName, @unchecked Sendable {}
    public var OnReceiveContentListener: OnReceiveContentListenerClass { .init(parent: self, name: "NativeOnReceiveContentListener") }
}

final class NativeOnReceiveContentListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnReceiveContentListener" }    

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@UIThreadActor () -> ContentInfo?)
    typealias HandlerWithEvent = (@UIThreadActor (NativeOnReceiveContentListenerEvent) -> ContentInfo?)

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
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ payload: ContentInfo?) -> ContentInfo? {
        if let view {
            return handlerWithEvent?(.init(view, isSameView, triggerView, payload))
        }
        return handler?()
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnReceiveContentListener_onReceiveContent")
public func nativeListenerOnReceiveContent(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject, p: jobject) -> jobject? {
    guard
        let listener: NativeOnReceiveContentListener = ListenerStore.shared.find(id: uniqueId)
    else { return nil }
    let bool = vId == -1 ? true : (sameView == 1 ? true : false)
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    var payload: ContentInfo?
    if let object = p.box(JEnv(env))?.object() {
        payload = .init(object)
    }
    #if canImport(AndroidLooper)
    let result = UIThreadActor.assumeIsolated {
        listener.handle(bool, triggerView, payload)
    }
    return result?.object.ref.ref
    #endif
}
#endif

public final class NativeOnReceiveContentListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    public let payload: ContentInfo?
    init (_ view: View, _ isSameView: Bool, _ triggerView: NativeListenerTriggerView?, _ payload: ContentInfo?) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
        self.payload = payload
    }
}

public final class ContentInfo: JObjectable, Sendable {
    /// The JNI class name
    class var className: JClassName { "android/view/ContentInfo" }    

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    // TODO: implement methods and properties
}