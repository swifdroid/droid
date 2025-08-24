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

    /// Calls void method
    /// `args` if it is simple value like Bool, Int, Float, etc. the pass it as-is
    /// if it is object e.g. `View` then pass it as `args: myView.signed(as: .android.view.View)`
    public func callVoidMethod(_ env: JEnv?, name: String, args: JSignatureItemable...) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let methodId = clazz.methodId(env: env, name: name, signature: .init(args.map { $0.signatureItemWithValue.signatureItem }, returning: .void))
        else { return }
        env.callVoidMethod(object: .init(ref, clazz), methodId: methodId, args: args.map { $0.signatureItemWithValue.value })
        #endif
    }

    /// Sets value to the field
    /// `arg` if it is simple value like Bool, Int, Float, etc. the pass it as-is
    /// if it is object e.g. `View` then pass it as `arg: myView.signed(as: .android.view.View)`
    public func setField(_ env: JEnv?, name: String, arg: JSignatureItemable) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let fieldId = clazz.fieldId(name: name, signature: arg.signatureItemWithValue.signatureItem)
        else {
            InnerLog.t("⚠️ LayoutParams field \(name) NOT FOUND in \(clazz.name.path)")
            return
        }
        switch arg.signatureItemWithValue {
            case .boolean(let value):
                env.setBooleanField(object, fieldId, value ? 1 : 0)
            case .byte(let value):
                env.setByteField(object, fieldId, value)
            case .char(let value):
                env.setCharField(object, fieldId, value)
            case .short(let value):
                env.setShortField(object, fieldId, value)
            case .int(let value):
                env.setIntField(object, fieldId, value)
            case .long(let value):
                env.setLongField(object, fieldId, value)
            case .float(let value):
                env.setFloatField(object, fieldId, value)
            case .double(let value):
                env.setDoubleField(object, fieldId, value)
            case .object(let value, _):
                env.setObjectField(object, fieldId, value)
        }
        #endif
    }

    // MARK: - Standard

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
        setField(nil, name: "height", arg: value)
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

    // MARK: CoordinatorLayout

    func setAnchorId(_ value: Int32) {
        callVoidMethod(nil, name: "setAnchorId", args: value)
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
        callVoidMethod(nil, name: "addRule", args: verb, subject)
    }

    public func removeRule(_ verb: Int32) {
        addRule(verb, 0)
    }
}
