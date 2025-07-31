public final class Resources {}

extension Resources {
    public final class Theme: JObjectable, Sendable {
        public class var className: JClassName { .init(stringLiteral: "android/content/res/Resources$Theme") }

        /// Context
        public let context: ActivityContext
        
        /// Object wrapper
        public let object: JObject

        public convenience init? (_ className: JClassName, _ context: ActivityContext) {
            #if os(Android)
            guard let env = JEnv.current() else { return nil }
            self.init(env, className, context)
            #else
            return nil
            #endif
        }
        
        public init? (_ env: JEnv, _ className: JClassName, _ context: ActivityContext) {
            #if os(Android)
            let classLoader = context.getClassLoader()
            guard
                let clazz = JClass.load(className, classLoader),
                let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(.android.content.Context), returning: .void)),
                let global = env.newObject(clazz: clazz, constructor: methodId, args: [context.object])
            else { return nil }
            self.object = global
            self.context = context
            #else
            return nil
            #endif
        }
        
        public init? (_ object: JObject, _ context: ActivityContext) {
            #if os(Android)
            self.object = object
            self.context = context
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