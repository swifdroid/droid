#if os(Android)
import Android
#endif
#if canImport(Logging)
import Logging
#endif
#if canImport(AndroidLooper)
import AndroidLooper
#endif

extension View {
    #if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    public final class ViewInstance: JObjectable, Sendable {
        /// Unique identifier
        public let id: Int32

        /// Context
        public let context: ActivityContext

        /// View
        public let view: View

        /// Object wrapper
        public let object: JObject

        public convenience init? (_ className: JClassName, _ view: View, _ context: ActivityContext, _ id: Int32) {
            #if os(Android)
            guard let env = JEnv.current() else { return nil }
            self.init(env, className, view, context, id)
            #else
            return nil
            #endif
        }
        
        public init? (_ env: JEnv, _ className: JClassName, _ view: View, _ context: ActivityContext, _ id: Int32) {
            #if os(Android)
            guard
                let classLoader = context.getClassLoader(),
                let viewClazz = classLoader.loadClass(.android.view.View),
                let clazz = classLoader.loadClass(className),
                let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(.android.content.Context), returning: .void)),
                let global = env.newObject(clazz: clazz, constructor: methodId, args: [context.object])
            else { return nil }
            self.id = id
            self.object = global
            self.view = view
            self.context = context
            #else
            return nil
            #endif
        }
        
        public init? (_ object: JObject, _ view: View, _ context: ActivityContext, _ id: Int32) {
            guard
                let env = JEnv.current(),
                let classLoader = context.getClassLoader(),
                let viewClazz = classLoader.loadClass(.android.view.View),
            else { return nil }
            #if os(Android)
            self.id = id
            self.object = object
            self.view = view
            self.context = context
            #else
            return nil
            #endif
        }

        public func setPadding(left: Int, top: Int, right: Int, bottom: Int) {
            #if os(Android)
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "setPadding", signature: .init(.int, .int, .int, .int, returning: .void))
            else { return }
            env.callVoidMethod(object: object, methodId: methodId, args: [left, top, right, bottom])
            #endif
        }

        public func setLayoutParams(width: LayoutParams.LayoutSize, height: LayoutParams.LayoutSize, unit: DimensionUnit) {
            #if os(Android)
            if let lp = view.layoutParamsForSubviews(width: width, height: height, unit: unit) {
                setLayoutParams(lp)
            }
            #endif
        }

        public func requestLayout() {
            #if os(Android)
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "requestLayout", signature: .returning(.void))
            else { return }
            InnerLog.d("⚡️view(id: \(id)) viewInstance requestLayout 1")
            env.callVoidMethod(object: object, methodId: methodId)
            InnerLog.d("⚡️view(id: \(id)) viewInstance requestLayout 2")
            #endif
        }
        
        public func getLayoutParams() -> LayoutParams? {
            #if os(Android)
            InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 1")
            guard let env = JEnv.current() else {
                InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 1.1 exit")
                return nil
            }
            guard let methodId = clazz.methodId(env: env, name: "getLayoutParams", signature: .returning(.object(.android.view.ViewGroup.LayoutParams))) else {
                InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 1.2 exit clazz: \(clazz.name.path)")
                return nil
            }
            guard let lpClazz = context.getClassLoader()?.loadClass(.init(stringLiteral: "\(className.path)$LayoutParams")) else {
                InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 1.3 exit clazz: \(clazz.name.path)")
                return nil
            }
            guard let globalObject = env.callObjectMethod(object: object, methodId: methodId, clazz: lpClazz) else {
                InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 1.4 exit")
                return nil
            }
            InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 2")
            return LayoutParams(globalObject)
            #else
            return nil
            #endif
        }
        
        public func setLayoutParams(_ params: LayoutParams) {
            #if os(Android)
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "setLayoutParams", signature: .init(.object(.android.view.ViewGroup.LayoutParams), returning: .void))
            else { return }
            InnerLog.d("view(id: \(id)) viewInstance setLayoutParams 1")
            env.callVoidMethod(object: object, methodId: methodId, args: [params.object])
            InnerLog.d("view(id: \(id)) viewInstance setLayoutParams 2")
            #endif
        }

        public func addView(_ viewInstance: ViewInstance) {
            InnerLog.d("💚 view(id: \(id)) viewInstance addView class: \(className.name)")
            InnerLog.d("💚 view(id: \(id)) self viewInstance: \(self)")
            InnerLog.d("💚 view(id: \(id)) target viewInstance: \(viewInstance)")
            #if os(Android)
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "addView", signature: .init(.object(.android.view.View), returning: .void))
            else { return }
            InnerLog.d("💚 view(id: \(id)) viewInstance addView 1")
            env.callVoidMethod(object: object, methodId: methodId, args: [viewInstance.object])
            InnerLog.d("💚 view(id: \(id)) viewInstance addView 2")
            #endif
        }

        public func removeView(_ viewInstance: ViewInstance) {
            #if os(Android)
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "removeView", signature: .init(.object(.android.view.View), returning: .void))
            else { return }
            env.callVoidMethod(object: object, methodId: methodId, args: [viewInstance.object])
            #endif
        }

        // public func getParent() -> ViewParent? {
        //     #if os(Android)
        //     guard
        //         let env = JEnv.current(),
        //         let methodId = clazz.methodId(env: env, name: "getParent", signature: .returning(.object(.android.view.ViewParent))),
        //         let object = env.callObjectMethod(object: .init(ref, clazz), methodId: methodId, args: []),
        //         let parent = ViewParent(object, context)
        //     else { return nil }
        //     return parent
        //     #else
        //     return nil
        //     #endif
        // }

        public func setBackgroundColor(_ color: GraphicsColor) {
            #if os(Android)
            InnerLog.d("setBackgroundColor color: \(color.value)")
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "setBackgroundColor", signature: .init(.int, returning: .void))
            else { return }
            env.callVoidMethod(object: .init(ref, clazz), methodId: methodId, args: [color])
            #endif
        }

        public func setOrientation(_ orientation: LinearLayout.Orientation) {
            #if os(Android)
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "setOrientation", signature: .init(.int, returning: .void))
            else { return }
            env.callVoidMethod(object: object, methodId: methodId, args: [orientation.rawValue])
            #endif
        }

        public func setBackground(_ class: JClass) {
            #if os(Android)
            // guard
            //     let env = JEnv.current(),
            //     let methodId = clazz.methodId(env: env, name: "setBackground", signature: .init(.object(.android.graphics.drawable.Drawable), returning: .void))
            // else { return }
            // env.callVoidMethod(object: object, methodId: methodId, args: [`class`])
            #endif
        }

        public func setOnClickListener(_ listener: NativeOnClickListener) {
            #if os(Android)
            guard
                let instance = listener.instance,
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "setOnClickListener", signature: .init(.object(.android.view.ViewOnClickListener), returning: .void))
            else { return }
            env.callVoidMethod(object: object, methodId: methodId, args: [instance.object])
            #endif
        }
    }
}

extension View.ViewInstance: Equatable, Hashable {
    public nonisolated static func == (lhs: View.ViewInstance, rhs: View.ViewInstance) -> Bool {
        lhs.id == rhs.id
    }

    public nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}