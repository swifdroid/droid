//
//  LayoutParams.swift
//  Droid
//
//  Created by Mihael Isaev on 14.01.2022.
//

#if os(Android)
import Android
#endif
#if canImport(Logging)
import Logging
#endif
#if canImport(AndroidLooper)
import AndroidLooper
#endif

#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class LayoutParams: Sendable, JObjectable {
    public struct Class: Sendable, CustomStringConvertible, ExpressibleByStringLiteral {
        public let className: JClassName

        public init(stringLiteral value: String) {
            self.className = .init(stringLiteral: value)
        }

        public init(_ className: JClassName) {
            self.className = className
        }

        public var description: String { className.description }

        public static let windowManager: Self = "android/view/WindowManager$LayoutParams"
        public static let actionBar: Self = "android/app/ActionBar$LayoutParams"
        public static let toolbar: Self = "android/widget/Toolbar$LayoutParams"
        public static let radioGroup: Self = "android/widget/RadioGroup$LayoutParams"
        public static let absListView: Self = "android/widget/AbsListView$LayoutParams"
        
        public static let appCompatActionBar: Self = "androidx/appcompat/app/ActionBar$LayoutParams"
        public static let appCompatToolbar: Self = "androidx/appcompat/widget/Toolbar$LayoutParams"
        public static let viewPager: Self = "androidx/viewpager/widget/ViewPager$LayoutParams"
        public static let appCompatActionMenuView: Self = "androidx/appcompat/widget/ActionMenuView$LayoutParams"
        public static let constraints: Self = "androidx/constraintlayout/widget/Constraints$LayoutParams"
        public static let actionBarOverlayLayout: Self = "androidx/appcompat/widget/ActionBarOverlayLayout$LayoutParams"
    }

    // MARK: - Properties

    /// Object wrapper
    public let object: JObject
    
    public struct LayoutSize: JValuable, Equatable, Sendable {
        let value: Int32

        #if os(Android)
        public var jValue: jvalue { value.jValue }
        #endif
        
        public init(_ value: Int) {
            self.value = Int32(value)
        }
        
        public static var matchParent: Self { .init(-1) }
        public static var wrapContent: Self { .init(-2) }

        public static func == (lhs: LayoutSize, rhs: LayoutSize) -> Bool {
            lhs.value == rhs.value
        }
    }
    
    init (_ object: JObject) {
        self.object = object
    }

    convenience init? (_ context: ActivityContext, _ className: JClassName) {
        guard let env = JEnv.current() else { return nil }
        self.init(env, context, className)
    }
    
    init? (_ env: JEnv, _ context: ActivityContext, _ className: JClassName) {
        InnerLog.t("💡 1LayoutParams trying to load class: \(className)")
        #if os(Android)
        guard
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .returning(.void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: nil)
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }
    
    convenience init? (_ context: ActivityContext, _ className: JClassName, width: LayoutSize, height: LayoutSize, unit: DimensionUnit = .dp) {
        #if os(Android)
        guard let env = JEnv.current() else { return nil }
        self.init(env, context, className, width: width, height: height, unit: unit)
        #else
        return nil
        #endif
    }
    
    init? (_ env: JEnv, _ context: ActivityContext, _ className: JClassName, width: LayoutSize, height: LayoutSize, unit: DimensionUnit = .dp) {
        #if os(Android)
        let correctWidth: LayoutSize
        if [.matchParent, .wrapContent].contains(width) {
            correctWidth = width
        } else {
            correctWidth = .init(Int(unit.toPixels(width.value)))
        }
        let correctHeight: LayoutSize
        if [.matchParent, .wrapContent].contains(height) {
            correctHeight = height
        } else {
            correctHeight = .init(Int(unit.toPixels(height.value)))
        }
        InnerLog.t("💡 2LayoutParams trying to load class: \(className)")
        guard
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.int, .int, returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [correctWidth, correctHeight])
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }

    // MARK: - Standard

    public func setWidth(_ value: Int32) {
        #if os(Android)
        InnerLog.t("lp.setWidth \(value) case 1")
        guard
            let env = JEnv.current(),
            let fieldId = clazz.fieldId(name: "width", signature: .int)
        else { return }
        env.setIntField(object, fieldId, value)
        InnerLog.t("lp.setWidth \(value) case 2")
        #endif
    }

    public func getWidth() -> Int32? {
        #if os(Android)
        InnerLog.t("lp.getWidth case 1")
        guard
            let env = JEnv.current(),
            let fieldId = clazz.fieldId(name: "width", signature: .int)
        else { return nil }
        let value = env.getIntField(object, fieldId)
        InnerLog.t("lp.getWidth case 2 value: \(value)")
        return value
        #else
        return nil
        #endif
    }

    public func setHeight(_ value: Int32) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let fieldId = clazz.fieldId(name: "height", signature: .int)
        else { return }
        env.setIntField(object, fieldId, value)
        #endif
    }

    public func getHeight() -> Int32? {
        #if os(Android)
        InnerLog.t("lp.getHeight case 1")
        guard
            let env = JEnv.current(),
            let fieldId = clazz.fieldId(name: "height", signature: .int)
        else { return nil }
        let value = env.getIntField(object, fieldId)
        InnerLog.t("lp.getHeight case 2 value: \(value)")
        return value
        #else
        return nil
        #endif
    }

    // MARK: - Margins

    public func setMargins(left: Int32, top: Int32, right: Int32, bottom: Int32) {
        #if os(Android)
        InnerLog.t("💧 setMargins l: \(left) t: \(top) r: \(right) b: \(bottom)")
        guard
            let env = JEnv.current(),
            let methodId = clazz.methodId(env: env, name: "setMargins", signature: .init(.int, .int, .int, .int, returning: .void))
        else { InnerLog.t("💧 setMargins exit early");return }
        env.callVoidMethod(object: object, methodId: methodId, args: [left, top, right, bottom])
        InnerLog.t("💧 setMargins success")
        #endif
    }

    public func setMarginStart(_ value: Int32) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let methodId = clazz.methodId(env: env, name: "setMarginStart", signature: .init(.int, returning: .void))
        else { return }
        env.callVoidMethod(object: object, methodId: methodId, args: [value])
        #endif
    }

    public func setMarginEnd(_ value: Int32) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let methodId = clazz.methodId(env: env, name: "setMarginEnd", signature: .init(.int, returning: .void))
        else { return }
        env.callVoidMethod(object: object, methodId: methodId, args: [value])
        #endif
    }

    // MARK: FrameLayout

    public func setGravity(_ value: Int32) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let fieldId = clazz.fieldId(name: "gravity", signature: .int)
        else { return }
        env.setIntField(object, fieldId, value)
        #endif
    }

    // MARK: LinearLayout

    public func setWeight(_ value: Float) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let fieldId = clazz.fieldId(name: "weight", signature: .float)
        else { return }
        env.setFloatField(object, fieldId, value)
        #endif
    }

    // MARK: AbsoluteLayout

    public func setX(_ value: Int32) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let fieldId = clazz.fieldId(name: "x", signature: .int)
        else { return }
        env.setIntField(object, fieldId, value)
        #endif
    }

    public func setY(_ value: Int32) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let fieldId = clazz.fieldId(name: "y", signature: .int)
        else { return }
        env.setIntField(object, fieldId, value)
        #endif
    }

    // MARK: CoordinatorLayout

    public func setAnchorId(_ value: Int32) {
        #if os(Android)
        InnerLog.t("💧 setAnchorId v: \(value)")
        guard
            let env = JEnv.current(),
            let methodId = clazz.methodId(env: env, name: "setAnchorId", signature: .init(.int, returning: .void))
        else { InnerLog.t("💧 setMargins exit early");return }
        env.callVoidMethod(object: object, methodId: methodId, args: [value])
        InnerLog.t("💧 setAnchorId success")
        #endif
    }

    // MARK: RelativeLayout

    enum RelativeLayoutRule: Int32 {
        case leftOf = 0
        case rightOf
        case above
        case below
        case alignBaseline
        case alignLeft
        case alignTop
        case alignRight
        case alignBottom
        case alignParentLeft
        case alignParentTop
        case alignParentRight
        case alignParentBottom
        case centerInParent
        case centerHorizontal
        case centerVertical
        case startOf
        case endOf
        case alignStart
        case alignEnd
        case alignParentStart
        case alignParentEnd
    }

    public func addRule(_ verb: Int32, _ subject: Int32 = -1) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let methodId = clazz.methodId(env: env, name: "addRule", signature: .init(.int, .int, returning: .void))
        else { return }
        env.callVoidMethod(object: object, methodId: methodId, args: [verb, subject])
        #endif
    }

    public func removeRule(_ verb: Int32) {
        addRule(verb, 0)
    }
}
