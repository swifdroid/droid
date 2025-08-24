//
//  CoordinatorLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

extension AndroidXPackage.CoordinatorLayoutPackage.WidgetPackage {
    public class CoordinatorLayoutClass: JClassName, @unchecked Sendable {}
    public var CoordinatorLayout: CoordinatorLayoutClass { .init(parent: self, name: "CoordinatorLayout") }
}
extension AndroidXPackage.CoordinatorLayoutPackage.WidgetPackage.CoordinatorLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public class BehaviorClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
    public var Behavior: BehaviorClass { .init(parent: self, name: "Behavior", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let coordinatorLayout: Self = .init(.androidx.coordinatorlayout.widget.CoordinatorLayout.LayoutParams)
}

open class CoordinatorLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .androidx.coordinatorlayout.widget.CoordinatorLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .coordinatorLayout }
    open class var behaviorClassName: JClassName { .androidx.coordinatorlayout.widget.CoordinatorLayout.Behavior }
    open override class var gradleDependencies: [String] { [
        #"implementation("androidx.coordinatorlayout:coordinatorlayout:1.3.0")"#
    ] }

    open override func layoutParamsForSubviews() -> LayoutParams? {
        let lp = super.layoutParamsForSubviews()
        lp?.setAnchorId(-1) // prevents "Unable to resolve anchor ID #0x0", applicable only if LayoutParams was initialized without arguments
        return lp
    }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            .setBehavior,
            .anchorId,
            .anchorGravity,
            .dodgeInsetEdges,
            .gravity,
            .insetEdge,
            .keyline
        ]
    }
}

extension LayoutParamKey {
    static let setBehavior: Self = "setBehavior"
    static let anchorId: Self = "anchorId"
    static let anchorGravity: Self = "anchorGravity"
    static let dodgeInsetEdges: Self = "dodgeInsetEdges"
    static let insetEdge: Self = "insetEdge"
    static let keyline: Self = "keyline"
}

// MARK: Behavior

#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class Behavior: @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { .androidx.coordinatorlayout.widget.CoordinatorLayout.Behavior }

    #if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    public final class BehaviorInstance: JObjectable, @unchecked Sendable {
        /// Context
        public let context: ActivityContext
        
        /// Object
        public let object: JObject

        public init? (_ env: JEnv, _ className: JClassName, _ context: ActivityContext) {
            #if os(Android)
            guard
                let classLoader = context.getClassLoader(),
                let clazz = classLoader.loadClass(className),
                let methodId = clazz.methodId(env: env, name: "<init>", signature: .returning(.void)),
                let global = env.newObject(clazz: clazz, constructor: methodId, args: [])
            else { return nil }
            self.object = global
            self.context = context
            #else
            return nil
            #endif
        }
    }
    var instance: BehaviorInstance?
    var _paramsToApply: [ParamToApply] = []
    
    public init() {}

    func instantiate(_ env: JEnv?, _ context: ActivityContext) -> BehaviorInstance? {
        guard
            let env = env ?? JEnv.current(),
            let instance = BehaviorInstance(env, Self.className, context)
        else { return nil }
        _paramsToApply.forEach { $0.apply(env, instance) }
        return instance
    }

    public struct ParamKey: ExpressibleByStringLiteral, Hashable, RawRepresentable, Sendable {
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }
    }

    public protocol ParamToApply {
        var key: ParamKey { get }
        #if canImport(AndroidLooper)
        @UIThreadActor
        #endif
        func apply(_ env: JEnv?, _ behavior: Behavior.BehaviorInstance)
        #if canImport(AndroidLooper)
        @UIThreadActor
        #endif
        func applyOrAppend<T: Behavior>(_ behavior: T) -> T
    }
}

extension Behavior.ParamToApply {
    #if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    @discardableResult
    public func applyOrAppend<T: Behavior>(_ behavior: T) -> T {
        if let instance = behavior.instance {
            apply(nil, instance)
        } else {
            behavior._paramsToApply.append(self)
        }
        return behavior
    }
}

struct BehaviorLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setBehavior
    let value: Behavior
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        guard
            let behavior = value.instantiate(env, context.context)
        else { return }
        lp.callVoidMethod(env, name: key.rawValue, args: behavior.signed(as: CoordinatorLayout.behaviorClassName))
    }
}

// MARK: AnchorId

struct AnchorIdLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .anchorId
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}

// MARK: AnchorGravity

struct AnchorGravityLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .anchorGravity
    let value: Gravity
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: Int32(value.rawValue))
    }
}

// MARK: DodgeInsetEdges

struct DodgeInsetEdgesLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .dodgeInsetEdges
    let value: Gravity
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: Int32(value.rawValue))
    }
}

// MARK: InsetEdge

struct InsetEdgeLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .insetEdge
    let value: Gravity
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: Int32(value.rawValue))
    }
}

// MARK: Keyline

struct KeylineLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .keyline
    let value: Int32
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: value)
    }
}
