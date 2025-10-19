//
//  TextWatcher.swift
//  Droid
//
//  Created by Mihael Isaev on 27.01.2022.
//

#if os(Android)
import Android

extension AppKitPackage {
    public class TextWatcherClass: JClassName, @unchecked Sendable {}
    public var TextWatcher: TextWatcherClass { .init(parent: self, name: "NativeTextWatcher") }
}

final class NativeTextWatcher: NativeListener, AnyNativeListener, @unchecked Sendable {
    /// The JNI class name
    class var className: JClassName { "stream/swift/droid/appkit/watchers/NativeTextWatcher" }
    static let originalClassName: JClassName = "android/text/TextWatcher"

    var shouldInitWithViewId: Bool { false }

    typealias HandlerBeforeTextChangedEvent = (@MainActor (NativeTextWatcherBeforeTextChangedEvent) -> Void)
    typealias HandlerOnTextChangedEvent = (@MainActor (NativeTextWatcherOnTextChangedEvent) -> Void)
    typealias HandlerAfterTextChangedEvent = (@MainActor (NativeTextWatcherAfterTextChangedEvent) -> Void)

    /// View
    var view: View?

    /// Handlers
    var handlerBeforeTextChangedEvent: HandlerBeforeTextChangedEvent?
    var handlerOnTextChangedEvent: HandlerOnTextChangedEvent?
    var handlerAfterTextChangedEvent: HandlerAfterTextChangedEvent?

    func setHandler(
        _ view: View?,
        _ handlerBefore: HandlerBeforeTextChangedEvent?,
        _ handlerOn: @escaping HandlerOnTextChangedEvent,
        _ handlerAfter: HandlerAfterTextChangedEvent?
    ) -> Self {
        self.view = view
        self.handlerBeforeTextChangedEvent = handlerBefore
        self.handlerOnTextChangedEvent = handlerOn
        self.handlerAfterTextChangedEvent = handlerAfter
        return self
    }

    @MainActor
    func handleBeforeTextChanged(_ p0: String?, _ p1: Int, _ p2: Int, _ p3: Int) {
        guard let view else { return }
        handlerBeforeTextChangedEvent?(.init(view, p0, p1, p2, p3))
    }

    @MainActor
    func handleOnTextChanged(_ p0: String?, _ p1: Int, _ p2: Int, _ p3: Int) {
        guard let view else { return }
        handlerOnTextChangedEvent?(.init(view, p0, p1, p2, p3))
    }

    @MainActor
    func handleAfterTextChanged(_ p0: String?) {
        guard let view else { return }
        handlerAfterTextChangedEvent?(.init(view, p0))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_watchers_NativeTextWatcher_beforeTextChanged")
public func nativeTextWatcherBeforeTextChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, p1: jint, p2: jint, p3: jint) {
    guard
        let watcher: NativeTextWatcher = ListenerStore.shared.find(id: uniqueId)
    else { return }
    Task { @MainActor in
        watcher.handleBeforeTextChanged(nil, Int(p1), Int(p2), Int(p3))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_watchers_NativeTextWatcher_beforeTextChangedExtended")
public func nativeTextWatcherBeforeTextChangedExtended(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, p0: jobject, p1: jint, p2: jint, p3: jint) {
    guard
        let watcher: NativeTextWatcher = ListenerStore.shared.find(id: uniqueId)
    else { return }
    let p0 = JString(from: p0)?.string()
    Task { @MainActor in
        watcher.handleBeforeTextChanged(p0, Int(p1), Int(p2), Int(p3))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_watchers_NativeTextWatcher_onTextChanged")
public func nativeTextWatcherOnTextChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, p1: jint, p2: jint, p3: jint) {
    guard
        let watcher: NativeTextWatcher = ListenerStore.shared.find(id: uniqueId)
    else { return }
    Task { @MainActor in
        watcher.handleOnTextChanged(nil, Int(p1), Int(p2), Int(p3))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_watchers_NativeTextWatcher_onTextChangedExtended")
public func nativeTextWatcherOnTextChangedExtended(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, p0: jobject, p1: jint, p2: jint, p3: jint) {
    guard
        let watcher: NativeTextWatcher = ListenerStore.shared.find(id: uniqueId)
    else { return }
    let p0 = JString(from: p0)?.string()
    Task { @MainActor in
        watcher.handleOnTextChanged(p0, Int(p1), Int(p2), Int(p3))
    }
}

@_cdecl("Java_stream_swift_droid_appkit_watchers_NativeTextWatcher_afterTextChanged")
public func nativeTextWatcherAfterTextChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint) {
    guard
        let watcher: NativeTextWatcher = ListenerStore.shared.find(id: uniqueId)
    else { return }
    Task { @MainActor in
        watcher.handleAfterTextChanged(nil)
    }
}

@_cdecl("Java_stream_swift_droid_appkit_watchers_NativeTextWatcher_afterTextChangedExtended")
public func nativeTextWatcherAfterTextChangedExtended(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, uniqueId: jint, p0: jobject, p1: jint, p2: jint, p3: jint) {
    guard
        let watcher: NativeTextWatcher = ListenerStore.shared.find(id: uniqueId)
    else { return }
    let p0 = JString(from: p0)?.string()
    Task { @MainActor in
        watcher.handleAfterTextChanged(p0)
    }
}
#endif

public final class NativeTextWatcherBeforeTextChangedEvent {
    public let view: View
    public let p0: String?
    public let p1, p2, p3: Int
    init (_ view: View, _ p0: String?, _ p1: Int, _ p2: Int, _ p3: Int) {
        self.view = view
        self.p0 = p0
        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
    }
}

public final class NativeTextWatcherOnTextChangedEvent {
    public let view: View
    public let p0: String?
    public let p1, p2, p3: Int
    init (_ view: View, _ p0: String?, _ p1: Int, _ p2: Int, _ p3: Int) {
        self.view = view
        self.p0 = p0
        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
    }
}

public final class NativeTextWatcherAfterTextChangedEvent {
    public let view: View
    public let p0: String? // Editable?
    init (_ view: View, _ p0: String?) {
        self.view = view
        self.p0 = p0
    }
}

// public protocol CharSequence {}
// public protocol GetChars {}
// public protocol Spannable {}
// public protocol Appendable {}
// public protocol Editable: CharSequence, GetChars, Spannable, Appendable, Sendable {}