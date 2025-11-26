//
//  NativeOnApplyWindowInsetsCompatListener.swift
//  
//
//  Created by Mihael Isaev on 21.08.2025.
//

#if os(Android)
import Android

extension AppKitPackage.ListenersPackage {
    public class OnApplyWindowInsetsCompatListenerClass: JClassName, @unchecked Sendable {}
    public var OnApplyWindowInsetsCompatListener: OnApplyWindowInsetsCompatListenerClass { .init(parent: self, name: "NativeOnApplyWindowInsetsCompatListener") }
}

final class NativeOnApplyWindowInsetsCompatListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnApplyWindowInsetsCompatListener" }    

    var shouldInitWithViewId: Bool { true }

    typealias HandlerWithEvent = (@MainActor (NativeOnApplyWindowInsetsCompatListenerEvent) -> WindowInsetsCompat)

    /// View
    var view: View?

    /// Handlers
    var handlerWithEvent: HandlerWithEvent?

    func setHandler(_ view: View?, _ handler: @escaping HandlerWithEvent) -> Self {
        self.view = view
        self.handlerWithEvent = handler
        return self
    }

    @MainActor
    func handle(_ isSameView: Bool, _ triggerView: NativeListenerTriggerView? = nil, _ insets: WindowInsetsCompat) -> WindowInsetsCompat {
        guard
            let view,
            let handlerWithEvent
        else { return insets }
        return handlerWithEvent(.init(view, isSameView, triggerView, insets))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnApplyWindowInsetsCompatListener_onApplyWindowInsets")
public func nativeListenerOnApplyWindowInsetsCompat(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, sameView: jboolean, vId: jint, v: jobject, insets: jobject) -> jobject {
    guard
        let listener: NativeOnApplyWindowInsetsCompatListener = ListenerStore.shared.find(id: uniqueId)
    else { return insets }
    let bool = vId == -1 ? true : (sameView == 1 ? true : false)
    var triggerView: NativeListenerTriggerView?
    let env = JEnv(env)
    if let object = v.box(env)?.object() {
        triggerView = .init(id: vId, object: object)
    }
    let insetsObject = insets.box(env)?.object()
    guard let insetsObject else { return insets }
    let result = MainActor.assumeIsolated {
        return listener.handle(bool, triggerView, .init(insetsObject)).object
    }
    guard let local = env.newLocalRefPure(result.ref.ref) else { return insets }
    return local
}
#endif

public final class NativeOnApplyWindowInsetsCompatListenerEvent {
    public let view: View
    public let isSameView: Bool
    public let triggerView: NativeListenerTriggerView?
    public let insets: WindowInsetsCompat
    
    init (_ view: View, _ isSameView: Bool, _ triggerView: NativeListenerTriggerView? = nil, _ insets: WindowInsetsCompat) {
        self.view = view
        self.isSameView = isSameView
        self.triggerView = triggerView
        self.insets = insets
    }
}