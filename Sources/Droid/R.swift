#if canImport(Android)
import Android
#else
#if canImport(Glibc)
import Glibc
#endif
#endif
import JNIKit

public typealias R = InnerR

@MainActor
public struct InnerR: Sendable {
    public let id: Resource
    public let attr: Resource
    public let menu: Resource
    public let drawable: Resource
    public let string: Resource
    public let anim: Resource
    public let animator: Resource
    public let array: Resource
    public let bool: Resource
    public let color: Resource
    public let dimen: Resource
    public let fraction: Resource
    public let integer: Resource
    public let interpolator: Resource
    public let layout: Resource
    public let mipmap: Resource
    public let plurals: Resource
    public let raw: Resource
    public let style: Resource
    public let transition: Resource
    public let xml: Resource
    
    public init (_ className: JClassName? = nil) {
        id = Resource(className, "id")
        attr = Resource(className, "attr")
        menu = Resource(className, "menu")
        drawable = Resource(className, "drawable")
        string = Resource(className, "string")
        anim = Resource(className, "anim")
        animator = Resource(className, "animator")
        array = Resource(className, "array")
        bool = Resource(className, "bool")
        color = Resource(className, "color")
        dimen = Resource(className, "dimen")
        fraction = Resource(className, "fraction")
        integer = Resource(className, "integer")
        interpolator = Resource(className, "interpolator")
        layout = Resource(className, "layout")
        mipmap = Resource(className, "mipmap")
        plurals = Resource(className, "plurals")
        raw = Resource(className, "raw")
        style = Resource(className, "style")
        transition = Resource(className, "transition")
        xml = Resource(className, "xml")
    }

    @dynamicMemberLookup
    public struct Resource: Sendable {
        let parentClass: JClassName?
        let child: String

        init (
            _ parent: JClassName? = nil,
            _ child: String
        ) {
            self.parentClass = parent
            self.child = child
        }

        public subscript(dynamicMember fieldName: String) -> Int32 {
            get {
                resolveAttrResId(fieldName)
            }
        }

        /// Gets the runtime value of `R.attr.attrName`
        func resolveAttrResId(_ attrName: String) -> Int32 {
            #if os(Android)
            let classKey: String
            if let parentClass {
                classKey = "\(parentClass.path)/R$\(child)"
            } else {
                classKey = "R$\(child)"
            }
            let cacheKey = "\(classKey)_\(attrName)"
            if let value = RCache.shared.get(cacheKey) {
                return value
            }
            guard let env = JEnv.current() else { return 0 }
            let className = JClassName(stringLiteral: classKey)
            guard let clazz = JClass.load(className) else { return 0 }
            guard let fieldId = clazz.staticFieldId(name: attrName, signature: .int) else { return 0 }
            let value = env.getStaticIntField(clazz, fieldId)
            RCache.shared.set(cacheKey, value)
            return value
            #else
            return 0
            #endif
        }
    }
}

class RCache {
    nonisolated(unsafe) static let shared = RCache()

    init () {
        mutex.activate(recursive: true)
    }

    deinit {
        mutex.destroy()
    }

    /// Mutex used to protect access to the logger's log level.
    private var mutex = pthread_mutex_t()

    private var values: [String: Int32] = [:]

    func set(_ key: String, _ value: Int32) {
        mutex.lock()
        defer { mutex.unlock() }
        values[key] = value
    }

    func get(_ key: String) -> Int32? {
        mutex.lock()
        defer { mutex.unlock() }
        return values[key]
    }
}