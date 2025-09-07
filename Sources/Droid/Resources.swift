public final class Resources {}

extension Resources {
    public final class Theme: JObjectable, Sendable {
        public class var className: JClassName { .init(stringLiteral: "android/content/res/Resources$Theme") }

        /// Object wrapper
        public let object: JObject

        public convenience init? (_ className: JClassName) {
            #if os(Android)
            guard let env = JEnv.current() else { return nil }
            self.init(env, className)
            #else
            return nil
            #endif
        }
        
        public init? (_ env: JEnv, _ className: JClassName) {
            #if os(Android)
            guard
                let clazz = JClass.load(className),
                let global = clazz.newObject(env, args: AppContext.shared.object.signed(as: .android.content.Context))
            else { return nil }
            self.object = global
            #else
            return nil
            #endif
        }
        
        public init? (_ object: JObject) {
            #if os(Android)
            self.object = object
            #else
            return nil
            #endif
        }

        public func resolveAttribute(_ resourceId: Int32, _ typedValue: TypedValue, _ resolveReference: Bool) -> Bool {
            #if os(Android)
            InnerLog.t("Theme.resolveAttribute 1")
            guard let env = JEnv.current() else {
                InnerLog.t("Theme.resolveAttribute 1.1 exit")
                return false
            }
            guard let methodId = clazz.methodId(env: env, name: "resolveAttribute", signature: .init(.int, .object(TypedValue.className), .boolean, returning: .boolean)) else {
                InnerLog.t("Theme.resolveAttribute 1.2 exit")
                return false
            }
            return env.callBooleanMethod(object: object, methodId: methodId, args: [resourceId, typedValue.object, resolveReference])
            #else
            return false
            #endif
        }
    }
}