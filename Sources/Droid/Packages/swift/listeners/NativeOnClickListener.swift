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

final class NativeOnClickListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnClickListener" }    

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (() async -> Void)

    /// Action handler
    var handler: Handler?

    func setHandler(_ handler: @escaping Handler) -> Self {
        self.handler = handler
        return self
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnClickListener_onClick")
public func nativeListenerOnClick(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    guard
        let listener: NativeOnClickListener = ListenerStore.shared.find(id: uniqueId)
    else { return }
    Task { @UIThreadActor in
        await listener.handler?()
    }
}
#endif