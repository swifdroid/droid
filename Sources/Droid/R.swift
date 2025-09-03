#if canImport(Android)
import Android
#else
#if canImport(Glibc)
import Glibc
#endif
#endif
import JNIKit
#if canImport(AndroidLooper)
import AndroidLooper
#endif

public typealias R = InnerR

#if canImport(AndroidLooper)
@UIThreadActor
#endif
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
        id = Resource(className, nil, "id")
        attr = Resource(className, nil, "attr")
        menu = Resource(className, nil, "menu")
        drawable = Resource(className, nil, "drawable")
        string = Resource(className, nil, "string")
        anim = Resource(className, nil, "anim")
        animator = Resource(className, nil, "animator")
        array = Resource(className, nil, "array")
        bool = Resource(className, nil, "bool")
        color = Resource(className, nil, "color")
        dimen = Resource(className, nil, "dimen")
        fraction = Resource(className, nil, "fraction")
        integer = Resource(className, nil, "integer")
        interpolator = Resource(className, nil, "interpolator")
        layout = Resource(className, nil, "layout")
        mipmap = Resource(className, nil, "mipmap")
        plurals = Resource(className, nil, "plurals")
        raw = Resource(className, nil, "raw")
        style = Resource(className, nil, "style")
        transition = Resource(className, nil, "transition")
        xml = Resource(className, nil, "xml")
    }

    public init (_ context: JClassLoadable) {
        id = Resource(nil, context, "id")
        attr = Resource(nil, context, "attr")
        menu = Resource(nil, context, "menu")
        drawable = Resource(nil, context, "drawable")
        string = Resource(nil, context, "string")
        anim = Resource(nil, context, "anim")
        animator = Resource(nil, context, "animator")
        array = Resource(nil, context, "array")
        bool = Resource(nil, context, "bool")
        color = Resource(nil, context, "color")
        dimen = Resource(nil, context, "dimen")
        fraction = Resource(nil, context, "fraction")
        integer = Resource(nil, context, "integer")
        interpolator = Resource(nil, context, "interpolator")
        layout = Resource(nil, context, "layout")
        mipmap = Resource(nil, context, "mipmap")
        plurals = Resource(nil, context, "plurals")
        raw = Resource(nil, context, "raw")
        style = Resource(nil, context, "style")
        transition = Resource(nil, context, "transition")
        xml = Resource(nil, context, "xml")
    }

    @dynamicMemberLookup
    public struct Resource: Sendable {
        let parentClass: JClassName?
        let context: JClassLoadable?
        let child: String

        init (
            _ parent: JClassName? = nil,
            _ context: JClassLoadable? = nil,
            _ child: String
        ) {
            self.parentClass = parent
            self.context = context
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