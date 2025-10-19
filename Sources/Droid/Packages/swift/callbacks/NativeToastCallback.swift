//
//  NativeToastCallback.swift
//  
//
//  Created by Mihael Isaev on 29.01.2022.
//

#if os(Android)
import Android

extension AppKitPackage.CallbacksPackage {
    public class ToastCallbackClass: JClassName, @unchecked Sendable {}
    public var ToastCallback: ToastCallbackClass { .init(parent: self, name: "NativeToastCallback") }
}

final class NativeToastCallback: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { .appKit.callbacks.ToastCallback }    

    var shouldInitWithViewId: Bool { false }

    typealias Handler = (() async -> Void)

    /// Handlers
    var shownHandler: Handler?
    var hiddenHandler: Handler?

    func setHandlers(onShown: @escaping Handler, onHidden: @escaping Handler) -> Self {
        self.shownHandler = onShown
        self.hiddenHandler = onHidden
        return self
    }
}

@_cdecl("Java_stream_swift_droid_appkit_callbacks_NativeToastCallback_onToastShown")
public func nativeToastCallbackOnToastShown(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    guard
        let listener: NativeToastCallback = ListenerStore.shared.find(id: uniqueId)
    else { return }
    #if os(Android)
    Task { @MainActor in
        await listener.shownHandler?()
    }
    #endif
}

@_cdecl("Java_stream_swift_droid_appkit_callbacks_NativeToastCallback_onToastHidden")
public func nativeToastCallbackOnToastHidden(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    guard
        let listener: NativeToastCallback = ListenerStore.shared.find(id: uniqueId)
    else { return }
    #if os(Android)
    Task { @MainActor in
        await listener.hiddenHandler?()
    }
    #endif
}
#endif