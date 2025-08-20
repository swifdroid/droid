//
//  NativeOnLongClickListener.swift
//  Droid
//
//  Created by Mihael Isaev on 18.08.2025.
//

#if os(Android)
import Android
#if canImport(AndroidLooper)
import AndroidLooper
#endif

extension AppKitPackage.ListenersPackage {
    public class OnLongClickListenerClass: JClassName, @unchecked Sendable {}
    public var OnLongClickListener: OnLongClickListenerClass { .init(parent: self, name: "NativeOnLongClickListener") }
}

final class NativeOnLongClickListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnLongClickListener" }

    var shouldInitWithViewId: Bool { true }

    /// Action handler
    var handler: (() -> Bool)?

    func setHandler(_ handler: @escaping () -> Bool) -> Self {
        self.handler = handler
        return self
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnLongClickListener_onLongClick")
public func nativeListenerOnLongClick(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) -> jboolean {
    guard
        let listener: NativeOnLongClickListener = ListenerStore.shared.find(id: uniqueId)
    else { return 0 }
    let result = UIThreadActor.assumeIsolated {
        listener.handler?() ?? false
    }
    return result ? 1 : 0
}
#endif