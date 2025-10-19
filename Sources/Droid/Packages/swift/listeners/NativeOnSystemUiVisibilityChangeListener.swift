//
//  NativeOnSystemUiVisibilityChangeListener.swift
//  
//
//  Created by Mihael Isaev on 22.08.2025.
//

#if os(Android)
import Android

extension AppKitPackage.ListenersPackage {
    public class OnSystemUiVisibilityChangeListenerClass: JClassName, @unchecked Sendable {}
    public var OnSystemUiVisibilityChangeListener: OnSystemUiVisibilityChangeListenerClass { .init(parent: self, name: "NativeOnSystemUiVisibilityChangeListener") }
}

final class NativeOnSystemUiVisibilityChangeListener: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/listeners/NativeOnSystemUiVisibilityChangeListener" }    

    var shouldInitWithViewId: Bool { true }

    typealias Handler = (@MainActor (_ visibility: Int) -> Void)

    /// View
    var view: View?

    /// Handlers
    var handler: Handler?

    func setHandler(_ view: View?, _ handler: @escaping Handler) -> Self {
        self.view = view
        self.handler = handler
        return self
    }

    @MainActor
    func handle(_ visibility: Int) {
        handler?(visibility)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_listeners_NativeOnSystemUiVisibilityChangeListener_onSystemUiVisibilityChange")
public func nativeListenerOnSystemUiVisibilityChange(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, visibility: jint) {
    guard
        let listener: NativeOnSystemUiVisibilityChangeListener = ListenerStore.shared.find(id: uniqueId)
    else { return }
    let visibility = Int(visibility)
    Task { @MainActor in
        listener.handle(visibility)
    }
}
#endif