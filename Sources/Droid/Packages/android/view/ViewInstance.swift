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
    public final class ViewInstance: JObjectable, @unchecked Sendable {
        /// Unique identifier
        public let id: Int32

        /// Context
        public let context: ActivityContext

        /// View
        public let view: View

        /// Object wrapper
        public let object: JObject

        /// Layout Params Class name
        var lpClassName: JClassName?

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
                let clazz = JClass.load(className),
                let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(.android.content.Context), returning: .void)),
                let global = env.newObject(clazz: clazz, constructor: methodId, args: [context.object])
            else { return nil }
            self.id = id
            self.object = global
            self.view = view
            self.context = context
            // Assign Swift-generated id
            global.callVoidMethod(env, name: "setId", args: id)
            #else
            return nil
            #endif
        }
        
        public init? (_ object: JObject, _ view: View, _ context: ActivityContext, _ id: Int32, setId: Bool) {
            #if os(Android)
            self.id = id
            self.object = object
            self.view = view
            self.context = context
            if setId {
                // Assign Swift-generated id
                object.callVoidMethod(name: "setId", args: id)
            }
            #else
            return nil
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
            // InnerLog.d("⚡️view(id: \(id)) viewInstance requestLayout 1")
            env.callVoidMethod(object: object, methodId: methodId)
            // InnerLog.d("⚡️view(id: \(id)) viewInstance requestLayout 2")
            #endif
        }
        
        public func layoutParams(_ lpClassName: JClassName? = nil) -> LayoutParams? {
            #if os(Android)
            // InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 1")
            guard let env = JEnv.current() else {
                // InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 1.1 exit")
                return nil
            }
            guard let methodId = clazz.methodId(env: env, name: "getLayoutParams", signature: .returning(.object(.android.view.ViewGroup.LayoutParams))) else {
                // InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 1.2 exit clazz: \(clazz.name.path)")
                return nil
            }
                // InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 1.3 exit clazz: \(clazz.name.path)")
            guard let lpClazz = JClass.load(lpClassName ?? self.lpClassName ?? .init(stringLiteral: "\(className.path)$LayoutParams")) else {
                return nil
            }
            guard let globalObject = env.callObjectMethod(object: object, methodId: methodId, clazz: lpClazz) else {
                // InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 1.4 exit")
                return nil
            }
            // InnerLog.d("view(id: \(id)) viewInstance getLayoutParams 2")
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
            // InnerLog.d("view(id: \(id)) viewInstance setLayoutParams 1")
            env.callVoidMethod(object: object, methodId: methodId, args: [params.object])
            // InnerLog.d("view(id: \(id)) viewInstance setLayoutParams 2")
            #endif
        }

        /// Adds a child view.
        ///
        /// If no layout parameters are already set on the child, the default parameters for this `ViewGroup` are set on the child.
        ///
        /// - Parameters:
        ///     - viewInstance: `ViewInstance` of the child view to add
        ///     - index: the position at which to add the child
        ///     - layoutParams: the layout parameters to set on the child
        public func addView(_ viewInstance: ViewInstance, index: Int? = nil, layoutParams: LayoutParams? = nil) {
            // InnerLog.d("💚 view(id: \(id)) viewInstance addView class: \(className.name)")
            // InnerLog.d("💚 view(id: \(id)) self viewInstance: \(self)")
            // InnerLog.d("💚 view(id: \(id)) target viewInstance: \(viewInstance)")
            var args: [JSignatureItemable] = [viewInstance.object.signed(as: .android.view.View)]
            if let index {
                args.append(Int32(index))
            }
            if let layoutParams {
                args.append(layoutParams.object.signed(as: .android.view.ViewGroup.LayoutParams))
            }
            object.callVoidMethod(name: "addView", args: args)
            // InnerLog.d("💚 view(id: \(id)) viewInstance addView 2")
        }

        /// Removes a child view.
        ///
        /// - Parameters:
        ///     - viewInstance: `ViewInstance` of the child view to remove
        public func removeView(_ viewInstance: ViewInstance) {
            object.callVoidMethod(name: "removeView", args: viewInstance.object.signed(as: .android.view.View))
        }

        // public func parent() -> ViewParent? {
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

        public func setBackground(_ class: JClass) {
            #if os(Android)
            // guard
            //     let env = JEnv.current(),
            //     let methodId = clazz.methodId(env: env, name: "setBackground", signature: .init(.object(.android.graphics.drawable.Drawable), returning: .void))
            // else { return }
            // env.callVoidMethod(object: object, methodId: methodId, args: [`class`])
            #endif
        }

        public func callVoidMethod(_ env: JEnv?, name: String, signatureItems: JSignatureItem..., args: JSignatureItemable...) {
            #if os(Android)
            guard
                let env = env ?? JEnv.current(),
                let methodId = clazz.methodId(env: env, name: name, signature: .init(signatureItems, returning: .void))
            else { return }
            env.callVoidMethod(object: .init(ref, clazz), methodId: methodId, args: args.map { $0.signatureItemWithValue.value })
            #endif
        }

        public func callVoidMethod(_ env: JEnv?, name: String, args: JSignatureItemable...) {
            #if os(Android)
            guard
                let env = env ?? JEnv.current(),
                let methodId = clazz.methodId(env: env, name: name, signature: .init(args.map { $0.signatureItemWithValue.signatureItem }, returning: .void))
            else { return }
            env.callVoidMethod(object: .init(ref, clazz), methodId: methodId, args: args.map { $0.signatureItemWithValue.value })
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