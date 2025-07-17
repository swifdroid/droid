#if os(Android)
import Android
#endif
#if canImport(Logging)
import Logging
#endif

extension View {
    public final class ViewInstance: JObjectable, Sendable {
        /// Unique identifier
        public let id: Int32

        /// Context
        public let context: ActivityContext

        /// Object wrapper
        public let object: JObject

        public convenience init? (_ className: JClassName, _ context: ActivityContext, _ id: Int32) {
            #if os(Android)
            guard let env = JEnv.current() else { return nil }
            self.init(env, className, context, id)
            #else
            return nil
            #endif
        }
        
        public init? (_ env: JEnv, _ className: JClassName, _ context: ActivityContext, _ id: Int32) {
            #if os(Android)
            guard
                let clazz = JClass.load(className),
                let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(.android.content.Context), returning: .void)),
                let global = env.newObject(clazz: clazz, constructor: methodId, args: [context.object])
            else { return nil }
            self.id = IPC_DIPC
            self.object = global
            self.context = context
            #else
            return nil
            #endif
        }
        
        public init? (_ object: JObject, _ context: ActivityContext, _ id: Int32) {
            #if os(Android)
            self.id = id
            self.object = object
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
            let type: LayoutParams.LinearLayoutType = .fromClassName(clazz.name)
            if let lp = LayoutParams(type, width: width, height: height, unit: unit) {
                setLayoutParams(lp)
            }
        }

        public func requestLayout() {
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "requestLayout", signature: .returning(.void))
            else { return }
            DroidApp.logger.debug("⚡️view(id: \(id)) viewInstance requestLayout 1")
            env.callVoidMethod(object: object, methodId: methodId)
            DroidApp.logger.debug("⚡️view(id: \(id)) viewInstance requestLayout 2")
        }
        
        public func setLayoutParams(_ params: LayoutParams) {
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "setLayoutParams", signature: .init(.object(.android.view.ViewGroup.LayoutParams), returning: .void))
            else { return }
            DroidApp.logger.debug("view(id: \(id)) viewInstance setLayoutParams 1")
            env.callVoidMethod(object: object, methodId: methodId, args: [params.object])
            DroidApp.logger.debug("view(id: \(id)) viewInstance setLayoutParams 2")
        }

        public func addView(_ viewInstance: ViewInstance) {
            DroidApp.logger.debug("💚 view(id: \(id)) viewInstance addView class: \(className.name)")
            DroidApp.logger.debug("💚 view(id: \(id)) self viewInstance: \(self)")
            DroidApp.logger.debug("💚 view(id: \(id)) target viewInstance: \(viewInstance)")
            #if os(Android)
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "addView", signature: .init(.object(.android.view.View), returning: .void))
            else { return }
            DroidApp.logger.debug("💚 view(id: \(id)) viewInstance addView 1")
            env.callVoidMethod(object: object, methodId: methodId, args: [viewInstance.object])
            DroidApp.logger.debug("💚 view(id: \(id)) viewInstance addView 2")
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
            Logger(label: "setBackgroundColor").info("color: \(color.value)")
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "setBackgroundColor", signature: .init(.int, returning: .void))
            else { return }
            env.callVoidMethod(object: .init(ref, clazz), methodId: methodId, args: [color])
            #endif
        }

        public func setOrientation(_ orientation: LinearLayout.Orientation) {
            guard
                let env = JEnv.current(),
                let methodId = clazz.methodId(env: env, name: "setOrientation", signature: .init(.int, returning: .void))
            else { return }
            env.callVoidMethod(object: object, methodId: methodId, args: [orientation.rawValue])
        }

        public func setBackground(_ class: JClass) {
            // guard
            //     let env = JEnv.current(),
            //     let methodId = clazz.methodId(env: env, name: "setBackground", signature: .init(.object(.android.graphics.drawable.Drawable), returning: .void))
            // else { return }
            // env.callVoidMethod(object: object, methodId: methodId, args: [`class`])
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
    public static func == (lhs: View.ViewInstance, rhs: View.ViewInstance) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}