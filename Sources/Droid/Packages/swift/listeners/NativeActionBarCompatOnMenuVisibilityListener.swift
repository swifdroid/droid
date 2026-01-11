//
//  NativeActionBarCompatOnMenuVisibilityListener.swift
//  
//
//  Created by Mihael Isaev on 05.01.2026.
//

#if os(Android)
import Android

final class NativeActionBarCompatOnMenuVisibilityListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeActionBarCompatOnMenuVisibilityListener" }
    var androidClassName: JClassName { "androidx/appcompat/app/ActionBar$OnMenuVisibilityListener" }

    var shouldInitWithViewId: Bool { false }

    typealias Handler = (@MainActor (_ isVisible: Bool) -> Void)

    /// Handlers
    var handler: Handler?

    func setHandler(_ handler: @escaping Handler) -> Self {
        self.handler = handler
        return self
    }

    @MainActor
    func handle(_ isVisible: Bool) {
        handler?(isVisible)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeActionBarCompatOnMenuVisibilityListener_onMenuVisibilityChanged")
public func nativeListenerActionBarCompatOnMenuVisibilityChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, isVisible: jboolean) {
    guard
        let listener: NativeActionBarCompatOnMenuVisibilityListener = ListenerStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 NativeActionBarCompatOnMenuVisibilityListener: Listener with id \(uniqueId) not found")
        return
    }
    MainActor.assumeIsolated {
        listener.handle(isVisible == 1)
    }
}
#endif