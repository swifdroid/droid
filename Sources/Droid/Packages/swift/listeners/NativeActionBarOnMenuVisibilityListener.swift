//
//  NativeActionBarOnMenuVisibilityListener.swift
//  
//
//  Created by Mihael Isaev on 05.01.2026.
//

#if os(Android)
import Android

final class NativeActionBarOnMenuVisibilityListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeActionBarOnMenuVisibilityListener" }
    var androidClassName: JClassName { "android/app/ActionBar$OnMenuVisibilityListener" }

    var shouldInitWithViewId: Bool { false }

    typealias Handler = (@MainActor (_ isVisible: Bool) -> Void)

    /// View
    var view: View?

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

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeActionBarOnMenuVisibilityListener_onMenuVisibilityChanged")
public func nativeListenerActionBarOnMenuVisibilityChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, isVisible: jboolean) {
    guard
        let listener: NativeActionBarOnMenuVisibilityListener = ListenerStore.shared.find(id: uniqueId)
    else {
        InnerLog.c("🟥 NativeActionBarOnMenuVisibilityListener: Listener with id \(uniqueId) not found")
        return
    }
    MainActor.assumeIsolated {
        listener.handle(isVisible == 1)
    }
}
#endif