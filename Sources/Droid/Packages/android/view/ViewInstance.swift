#if os(Android)
import Android
#endif
#if canImport(Logging)
import Logging
#endif

extension View {
    @MainActor
    public final class ViewInstance: JObjectable, Contextable, StatesHolder, @unchecked Sendable {
        /// Unique identifier
        public let id: Int32

        /// Context
        let contextLink: () -> ActivityContext?
        public var context: ActivityContext? {
            let c = contextLink()
            if c == nil {
                InnerLog.c("🟥🟥 View.ViewInstance.context is nil for view(id: \(id))")
            }
            return c
        }

        /// View
        public private(set) weak var view: View?

        /// Object wrapper
        public let object: JObject

        /// States holder
        public let statesValues: StatesHolderValuesBox = StatesHolderValuesBox()

        /// Layout Params Class name
        var lpClassName: JClassName?

        public convenience init? (_ className: JClassName, _ view: View, _ contextLink: @escaping () -> ActivityContext?, _ id: Int32) {
            #if os(Android)
            guard let env = JEnv.current() else { return nil }
            self.init(env, className, view, contextLink, id)
            #else
            return nil
            #endif
        }
        
        public init? (_ env: JEnv, _ className: JClassName, _ view: View, _ contextLink: @escaping () -> ActivityContext?, _ id: Int32) {
            #if os(Android)
            guard let context = contextLink() else {
                InnerLog.c("🟥🟥 View.ViewInstance.init 2 failed: context is nil for view(id: \(id)) class: \(className.path)")
                return nil
            }
            guard
                let clazz = JClass.load(className),
                let global = clazz.newObject(env, args: context.object.signed(as: .android.content.Context))
            else { return nil }
            self.id = id
            self.object = global
            self.view = view
            self.contextLink = contextLink
            InnerLog.t("🟩🟩 View.ViewInstance.init(id: \(id)) 1: \(self.className.fullName) ref: \(object.ref.ref))")
            // Assign Swift-generated id
            global.callVoidMethod(env, name: "setId", args: id)
            #else
            return nil
            #endif
        }
        
        public init? (_ object: JObject, _ view: View, _ contextLink: @escaping () -> ActivityContext?, _ id: Int32, setId: Bool) {
            #if os(Android)
            if contextLink() == nil {
                InnerLog.c("🟥🟥 View.ViewInstance.init 3 failed: context is nil for view(id: \(view.id))")
                return nil
            }
            self.id = id
            self.object = object
            self.view = view
            self.contextLink = contextLink
            InnerLog.t("🟩🟩 View.ViewInstance.init(id: \(id)) 2: \(self.className.fullName) ref: \(object.ref.ref))")
            if setId {
                // Assign Swift-generated id
                object.callVoidMethod(name: "setId", args: id)
            }
            #else
            return nil
            #endif
        }

        deinit {
            InnerLog.t("🟥🟥🟥 View.ViewInstance DEINIT(id: \(id)): \(self.className.fullName)")
            releaseStates()
        }

        public func setLayoutParams(width: LayoutParams.LayoutSize, height: LayoutParams.LayoutSize, unit: DimensionUnit) {
            #if os(Android)
            if let lp = view?.layoutParamsForSubviews(width: width, height: height, unit: unit) {
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
            // InnerLog.t("⚡️view(id: \(id)) viewInstance requestLayout 1")
            env.callVoidMethod(object: object, methodId: methodId)
            // InnerLog.t("⚡️view(id: \(id)) viewInstance requestLayout 2")
            #endif
        }
        
        public func layoutParams(_ lpClassName: JClassName? = nil) -> LayoutParams? {
            #if os(Android)
            // InnerLog.t("view(id: \(id)) viewInstance getLayoutParams 1")
            guard let env = JEnv.current() else {
                // InnerLog.t("view(id: \(id)) viewInstance getLayoutParams 1.1 exit")
                return nil
            }
            guard let methodId = clazz.methodId(env: env, name: "getLayoutParams", signature: .returning(.object(.android.view.ViewGroup.LayoutParams))) else {
                // InnerLog.t("view(id: \(id)) viewInstance getLayoutParams 1.2 exit clazz: \(clazz.name.path)")
                return nil
            }
                // InnerLog.t("view(id: \(id)) viewInstance getLayoutParams 1.3 exit clazz: \(clazz.name.path)")
            guard let lpClazz = JClass.load(lpClassName ?? self.lpClassName ?? .init(stringLiteral: "\(className.path)$LayoutParams")) else {
                return nil
            }
            guard let globalObject = env.callObjectMethod(object: object, methodId: methodId, returningClass: lpClazz) else {
                // InnerLog.t("view(id: \(id)) viewInstance getLayoutParams 1.4 exit")
                return nil
            }
            // InnerLog.t("view(id: \(id)) viewInstance getLayoutParams 2")
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
            // InnerLog.t("view(id: \(id)) viewInstance setLayoutParams 1")
            env.callVoidMethod(object: object, methodId: methodId, args: [params.object])
            // InnerLog.t("view(id: \(id)) viewInstance setLayoutParams 2")
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
            InnerLog.t("💚 view(id: \(id)) viewInstance addView class: \(className.name)")
            InnerLog.t("💚 view(id: \(id)) self viewInstance: \(self)")
            InnerLog.t("💚 view(id: \(id)) target viewInstance: \(viewInstance)")
            var args: [JSignatureItemable] = [viewInstance.object.signed(as: .android.view.View)]
            if let index {
                args.append(Int32(index))
            }
            if let layoutParams {
                args.append(layoutParams.object.signed(as: .android.view.ViewGroup.LayoutParams))
            }
            InnerLog.t("💚 view(id: \(id)) viewInstance addView 1")
            object.callVoidMethod(name: "addView", args: args)
            InnerLog.t("💚 view(id: \(id)) viewInstance addView 2")
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
        //         let object = env.callObjectMethod(object: self.object, methodId: methodId, args: []),
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
            env.callVoidMethod(object: object, methodId: methodId, args: args.map { $0.signatureItemWithValue.value })
            #endif
        }

        public func callVoidMethod(_ env: JEnv?, name: String, args: JSignatureItemable...) {
            #if os(Android)
            guard
                let env = env ?? JEnv.current(),
                let methodId = clazz.methodId(env: env, name: name, signature: .init(args.map { $0.signatureItemWithValue.signatureItem }, returning: .void))
            else { return }
            env.callVoidMethod(object: object, methodId: methodId, args: args.map { $0.signatureItemWithValue.value })
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