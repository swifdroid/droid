//
//  NativeOnClickListener.swift
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
    public class OnClickListenerClass: JClassName, @unchecked Sendable {}
    public var OnClickListener: OnClickListenerClass { .init(parent: self, name: "NativeOnClickListener") }
}

public final class NativeOnClickListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    init (_ view: View, _ isSameView: Bool, _ triggerView: NativeListenerTriggerView? = nil) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
    }
}

final class NativeOnClickListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnClickListener" }    

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@UIThreadActor () -> Void)
    typealias HandlerWithEvent = (@UIThreadActor (NativeOnClickListenerEvent) -> Void)

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
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView? = nil) {
        handler?()
        if let view {
            handlerWithEvent?(.init(view, isSameView, triggerView))
        }
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnClickListener_onClick")
public func nativeListenerOnClick(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject) {
    guard
        let listener: NativeOnClickListener = ListenerStore.shared.find(id: uniqueId)
    else { return }
    let bool = vId == -1 ? true : (sameView == 1 ? true : false)
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    #if canImport(AndroidLooper)
    Task { @UIThreadActor in
        listener.handle(bool, triggerView)
    }
    #endif
}
#else
public final class NativeOnClickListenerEvent {
    public let view: View! = nil
    public let isSameView: Bool = false
    public let triggerView: NativeListenerTriggerView? = nil
    init() {}
}
#endif