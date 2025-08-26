//
//  GridLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

extension AndroidPackage.WidgetPackage {
    public class GridLayoutClass: JClassName, @unchecked Sendable {}
    public var GridLayout: GridLayoutClass { .init(parent: self, name: "GridLayout") }
}
extension AndroidPackage.WidgetPackage.GridLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public class SpecClass: JClassName, @unchecked Sendable {}
    public class AlignmentClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
    public var Spec: SpecClass { .init(parent: self, name: "Spec", isInnerClass: true) }
    public var Alignment: AlignmentClass { .init(parent: self, name: "Alignment", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let gridLayout: Self = .init(.android.widget.GridLayout.LayoutParams)
}

open class GridLayout: View, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.GridLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .gridLayout }
    public class var specClassName: JClassName { .android.widget.GridLayout.Spec }
    public class var alignmentClassName: JClassName { .android.widget.GridLayout.Alignment }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            .columnSpec,
            .rowSpec
        ]
    }
}

extension GridLayout {
    public class _Alignment: JObjectable, @unchecked Sendable {
        /// The JNI class name
        public class var className: JClassName { .android.widget.GridLayout.Alignment }

        public var object: JObject

        init(object: JObject) {
            self.object = object
        }

        // public static var leading: Alignment {
        //     JEnv.current()?.getStaticObjectField(JClass., JFieldId)
        // }
    }

    public enum Alignment: String {
        case leading = "LEADING"
        case trailing = "TRAILING"
        case top = "TOP"
        case bottom = "BOTTOM"
        case start = "START"
        case end = "END"
        case left = "LEFT"
        case right = "RIGHT"
        case center = "CENTER"
        case baseline = "BASELINE"
        case fill = "FILL"
    }

    enum SpecType {
        case one(Int32)
        case two(Int32, Int32)
        case three(Int32, Float)
        case four(Int32, Alignment)
        case five(Int32, Int32, Float)
        case six(Int32, Int32, Alignment)
        case seven(Int32, Alignment, Float)
        case eight(Int32, Int32, Alignment, Float)
    }
}

extension LayoutParamKey {
    static let columnSpec: Self = "columnSpec"
    static let rowSpec: Self = "rowSpec"
}

// MARK: - Cell Position & Span

// MARK: ColumnSpec

fileprivate extension LayoutParamToApply {
    #if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    func apply(_ env: JEnv?, _ instance: View.ViewInstance, _ lp: LayoutParams, _ key: LayoutParamKey, _ value: GridLayout.SpecType) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let classLoader = instance.context.getClassLoader(),
            let clazz = classLoader.loadClass(GridLayout.className)
        else { return }
        func getAlignment(_ type: GridLayout.Alignment) -> JObject? {
            guard
                let fieldId = clazz.staticFieldId(name: type.rawValue, signature: .object(GridLayout.alignmentClassName))
            else { return nil }
            return env.getStaticObjectField(clazz, fieldId)
        }
        switch value {
        case .one(let start):
            guard
                let methodId = clazz.staticMethodId(name: "spec", signature: .init(.int, returning: .object(GridLayout.specClassName))),
                let spec = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [start])
            else { return }
            lp.setField(env, name: key.rawValue, arg: spec.signed(as: GridLayout.specClassName))
        case .two(let start, let size):
            guard
                let methodId = clazz.staticMethodId(name: "spec", signature: .init(.int, .int, returning: .object(GridLayout.specClassName))),
                let spec = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [start, size])
            else { return }
            lp.setField(env, name: key.rawValue, arg: spec.signed(as: GridLayout.specClassName))
        case .three(let start, let weight):
            guard
                let methodId = clazz.staticMethodId(name: "spec", signature: .init(.int, .float, returning: .object(GridLayout.specClassName))),
                let spec = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [start, weight])
            else { return }
            lp.setField(env, name: key.rawValue, arg: spec.signed(as: GridLayout.specClassName))
        case .four(let start, let alignmentType):
            guard
                let methodId = clazz.staticMethodId(name: "spec", signature: .init(.int, .object(GridLayout.alignmentClassName), returning: .object(GridLayout.specClassName))),
                let alignment = getAlignment(alignmentType),
                let spec = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [start, alignment.signed(as: GridLayout.alignmentClassName).value])
            else { return }
            lp.setField(env, name: key.rawValue, arg: spec.signed(as: GridLayout.specClassName))
        case .five(let start, let size, let weight):
            guard
                let methodId = clazz.staticMethodId(name: "spec", signature: .init(.int, .int, .float, returning: .object(GridLayout.specClassName))),
                let spec = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [start, size, weight])
            else { return }
            lp.setField(env, name: key.rawValue, arg: spec.signed(as: GridLayout.specClassName))
        case .six(let start, let size, let alignmentType):
            guard
                let methodId = clazz.staticMethodId(name: "spec", signature: .init(.int, .int, .object(GridLayout.alignmentClassName), returning: .object(GridLayout.specClassName))),
                let alignment = getAlignment(alignmentType),
                let spec = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [start, size, alignment.signed(as: GridLayout.alignmentClassName).value])
            else { return }
            lp.setField(env, name: key.rawValue, arg: spec.signed(as: GridLayout.specClassName))
        case .seven(let start, let alignmentType, let weight):
            guard
                let methodId = clazz.staticMethodId(name: "spec", signature: .init(.int, .object(GridLayout.alignmentClassName), .float, returning: .object(GridLayout.specClassName))),
                let alignment = getAlignment(alignmentType),
                let spec = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [start, alignment.signed(as: GridLayout.alignmentClassName).value, weight])
            else { return }
            lp.setField(env, name: key.rawValue, arg: spec.signed(as: GridLayout.specClassName))
        case .eight(let start, let size, let alignmentType, let weight):
            guard
                let methodId = clazz.staticMethodId(name: "spec", signature: .init(.int, .int, .object(GridLayout.alignmentClassName), .float, returning: .object(GridLayout.specClassName))),
                let alignment = getAlignment(alignmentType),
                let spec = env.callStaticObjectMethod(clazz: clazz, methodId: methodId, args: [start, size, alignment.signed(as: GridLayout.alignmentClassName).value, weight])
            else { return }
            lp.setField(env, name: key.rawValue, arg: spec.signed(as: GridLayout.specClassName))
        }
        #endif
    }
}

struct ColumnSpecLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .columnSpec
    let value: GridLayout.SpecType
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        apply(env, context, lp, key, value)
    }
}

// MARK: RowSpec

struct RowSpecLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .rowSpec
    let value: GridLayout.SpecType
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        apply(env, context, lp, key, value)
    }
}
