//
//  NativeOnApplyWindowInsetsListener.swift
//  
//
//  Created by Mihael Isaev on 21.08.2025.
//

#if os(Android)
import Android

extension AppKitPackage.ListenersPackage {
    public class OnApplyWindowInsetsListenerClass: JClassName, @unchecked Sendable {}
    public var OnApplyWindowInsetsListener: OnApplyWindowInsetsListenerClass { .init(parent: self, name: "NativeOnApplyWindowInsetsListener") }
}

final class NativeOnApplyWindowInsetsListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnApplyWindowInsetsListener" }    

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@MainActor () -> Void)
    typealias HandlerWithEvent = (@MainActor (NativeOnApplyWindowInsetsListenerEvent) -> Void)

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
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView? = nil) {
        handler?()
        if let view {
            handlerWithEvent?(.init(view, isSameView, triggerView))
        }
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnApplyWindowInsetsListener_onApplyWindowInsets")
public func nativeListenerOnApplyWindowInsets(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject) {
    guard
        let listener: NativeOnApplyWindowInsetsListener = ListenerStore.shared.find(id: uniqueId)
    else { return }
    let bool = vId == -1 ? true : (sameView == 1 ? true : false)
    var triggerView: NativeListenerTriggerView?
    if let object = v.box(JEnv(env))?.object() {
        triggerView = .init(id: vId, object: object)
    }
    Task { @MainActor in
        listener.handle(bool, triggerView)
    }
}
#endif

public final class NativeOnApplyWindowInsetsListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    init (_ view: View, _ isSameView: Bool, _ triggerView: NativeListenerTriggerView? = nil) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
    }
}