//
//  NativeObject.swift
//  Droid
//
//  Created by Mihael Isaev on 29.08.2025.
//

#if os(Android)
import Android
#endif

protocol AnyNativeObject: AnyObject {
    static var nativeObjectClassName: JClassName { get }
    var id: Int32 { get }
}

extension AnyNativeObject {
    var stringId: String { "\(Self.nativeObjectClassName.name)\(id)" }
    static func stringId(_ id: Int32) -> String {
        "\(nativeObjectClassName.name)\(id)"
    }
    
    func addIntoStore() {
        ObjectStore.shared.add(self)
    }
}

@MainActor
open class NativeUIObject: JObjectable {

    /// Unique identifier
    let id: Int32

    public let object: JObject

    public required init (_ object: JObject) {
        self.id = DroidApp.shared.getNextViewId()
        self.object = object
    }

    public convenience init? (_ className: JClassName) {
        guard let env = JEnv.current() else { return nil }
        self.init(env, className)
    }

    public init? (_ env: JEnv, _ className: JClassName, _ initializer: Initializer = .normal) {
        self.id = DroidApp.shared.getNextViewId()
        #if os(Android)
        guard
            let clazz = JClass.load(className),
            let global = initializer == .normal
                ? clazz.newObject(env, args: id)
                : clazz.staticObjectMethod(env, name: "newInstance", args: id, returningClass: clazz)
        else {
            InnerLog.w("⚠️ Unable to initialize NativeObject(\(initializer.rawValue)) for className: \(className.path)")
            return nil
        }
        self.object = global
        if let s = self as? AnyNativeObject {
            s.addIntoStore()
        } else {
            InnerLog.w("⚠️ Unable to store \(className.path) because it does not conform to AnyNativeObject")
        }
        #else
        return nil
        #endif
    }

    public enum Initializer: String {
        case normal = "normal"
        case `static` = "static"
    }
}

open class NativeObject: JObjectable, @unchecked Sendable {
    /// Unique identifier
    let id: Int32

    public let object: JObject

    public init (_ object: JObject) {
        self.id = DroidApp.shared.getNextViewId()
        self.object = object
    }

    public convenience init? (_ className: JClassName) {
        guard let env = JEnv.current() else { return nil }
        self.init(env, className)
    }

    public enum Initializer: String {
        case normal = "normal"
        case `static` = "static"
    }

    public init? (_ env: JEnv, _ className: JClassName, _ initializer: Initializer = .normal) {
        self.id = DroidApp.shared.getNextViewId()
        #if os(Android)
        guard
            let clazz = JClass.load(className),
            let global = initializer == .normal
                ? clazz.newObject(env, args: id)
                : clazz.staticObjectMethod(env, name: "newInstance", args: id, returningClass: clazz)
        else {
            InnerLog.w("⚠️ Unable to initialize NativeObject(\(initializer.rawValue)) for className: \(className.path)")
            return nil
        }
        self.object = global
        if let s = self as? AnyNativeObject {
            s.addIntoStore()
        } else {
            InnerLog.w("⚠️ Unable to store \(className.path) because it does not conform to AnyNativeObject")
        }
        #else
        return nil
        #endif
    }
    
    // deinit {
    //     ObjectStore.shared.remove(id: id)
    // }
}

// MARK: - Store

final class ObjectStore: @unchecked Sendable {
    static let shared = ObjectStore()

    var objects: [String: AnyNativeObject] = [:]
    #if os(Android)
    var mutex = pthread_mutex_t()
    #endif

    init () {
        #if os(Android)
        mutex.activate(recursive: true)
        #endif
    }

    deinit {
        #if os(Android)
        mutex.destroy()
        #endif
    }

    func add(_ object: AnyNativeObject) {
        #if os(Android)
        mutex.lock()
        defer { mutex.unlock() }
        // InnerLog.t("🟥 ObjectStore add \(object.stringId)")
        objects[object.stringId] = object
        #endif
    }

    func remove(_ object: AnyNativeObject) {
        #if os(Android)
        mutex.lock()
        defer { mutex.unlock() }
        // InnerLog.t("🟥 ObjectStore remove \(object.stringId)")
        objects[object.stringId] = nil
        #endif
    }

    func find<O: AnyNativeObject>(id: Int32) -> O? {
        #if os(Android)
        mutex.lock()
        defer { mutex.unlock() }
        // InnerLog.t("🟥 ObjectStore find \(O.stringId(id))")
        return objects[O.stringId(id)] as? O
        #else
        return nil
        #endif
    }
}