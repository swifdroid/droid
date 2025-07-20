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

import DroidFoundation
import FoundationEssentials

extension AndroidPackage.ViewPackage.ViewGroupClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}

#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class LayoutParams: Sendable, JObjectable {
    public enum LinearLayoutType: String {
        case viewGroup = "android/view/ViewGroup$LayoutParams"
        case windowManager = "android/view/WindowManager$LayoutParams"
        case linearLayout = "android/widget/LinearLayout$LayoutParams"
        case actionBar = "android/app/ActionBar$LayoutParams"
        case toolbar = "android/widget/Toolbar$LayoutParams"
        case tableRow = "android/widget/TableRow$LayoutParams"
        case gridLayout = "android/widget/GridLayout$LayoutParams"
        case radioGroup = "android/widget/RadioGroup$LayoutParams"
        case absListView = "android/widget/AbsListView$LayoutParams"
        case frameLayout = "android/widget/FrameLayout$LayoutParams"
        case tableLayout = "android/widget/TableLayout$LayoutParams"
        case actionMenuView = "android/widget/ActionMenuView$LayoutParams"
        case relativeLayout = "android/widget/RelativeLayout$LayoutParams"

        case appCompatActionBar = "androidx/appcompat/app/ActionBar$LayoutParams"
        case appCompatToolbar = "androidx/appcompat/widget/Toolbar$LayoutParams"
        case viewPager = "androidx/viewpager/widget/ViewPager$LayoutParams"
        case appCompatActionMenuView = "androidx/appcompat/widget/ActionMenuView$LayoutParams"
        case drawerLayout = "androidx/drawerLayout/widget/DrawerLayout$LayoutParams"
        case linearLayoutCompat = "androidx/appcompat/widget/LinearLayoutCompat$LayoutParams"
        case constraints = "androidx/constraintlayout/widget/Constraints$LayoutParams"
        case actionBarOverlayLayout = "androidx/appcompat/widget/ActionBarOverlayLayout$LayoutParams"
        case constraintLayout = "androidx/constraintlayout/widget/ConstraintLayout$LayoutParams"

        case gallery = "android/widget/Gallery$LayoutParams"
        case absoluteLayout = "android/widget/AbsoluteLayout$LayoutParams"

        static func fromClassName(_ className: JClassName) -> Self {
            .init(rawValue: className.path + "$LayoutParams") ?? .viewGroup
        }
    }

    // MARK: - Properties

    /// Object wrapper
    public let object: JObject
    
    public struct LayoutSize: ExpressibleByIntegerLiteral, JValuable, Equatable {
        let value: Int32

        #if os(Android)
        public var jValue: jvalue { value.jValue }
        #endif
        
        public init(integerLiteral value: Int) {
            self.value = Int32(value)
        }
        
        public static var matchParent: Self { -1 }
        public static var wrapContent: Self { -2 }

        public static func == (lhs: LayoutSize, rhs: LayoutSize) -> Bool {
            lhs.value == rhs.value
        }
    }
    
    convenience init? (_ type: LinearLayoutType) {
        guard let env = JEnv.current() else { return nil }
        self.init(env, type)
    }
    
    init? (_ env: JEnv, _ type: LinearLayoutType) {
        DroidApp.logger.critical("💡 1LayoutParams trying to load class: \(type.rawValue)")
        #if os(Android)
        guard
            let clazz = JClass.load(.init(stringLiteral: type.rawValue)),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .returning(.void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: nil)
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }
    
    convenience init? (_ type: LinearLayoutType, width: LayoutSize, height: LayoutSize, unit: DimensionUnit = .dp) {
        #if os(Android)
        guard let env = JEnv.current() else { return nil }
        self.init(env, type, width: width, height: height, unit: unit)
        #else
        return nil
        #endif
    }
    
    init? (_ env: JEnv, _ type: LinearLayoutType, width: LayoutSize, height: LayoutSize, unit: DimensionUnit = .dp) {
        #if os(Android)
        let correctWidth: LayoutSize
        if [.matchParent, .wrapContent].contains(width) {
            correctWidth = width
        } else {
            correctWidth = .init(integerLiteral: Int(unit.toPixels(width.value)))
        }
        let correctHeight: LayoutSize
        if [.matchParent, .wrapContent].contains(height) {
            correctHeight = height
        } else {
            correctHeight = .init(integerLiteral: Int(unit.toPixels(height.value)))
        }
        DroidApp.logger.critical("💡 2LayoutParams trying to load class: \(type.rawValue)")
        guard
            let clazz = JClass.load(.init(stringLiteral: type.rawValue)),
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
        guard
            let env = JEnv.current(),
            let fieldId = clazz.fieldId(name: "width", signature: .int)
        else { return }
        env.setIntField(object, fieldId, value)
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

    // MARK: - Margins

    public func setMargins(left: Int32, top: Int32, right: Int32, bottom: Int32) {
        #if os(Android)
        let logger = Logger(label: "setMargins")
        logger.info("💧 setMargins l: \(left) t: \(top) r: \(right) b: \(bottom)")
        guard
            let env = JEnv.current(),
            let methodId = clazz.methodId(env: env, name: "setMargins", signature: .init(.int, .int, .int, .int, returning: .void))
        else { logger.info("💧 setMargins exit early");return }
        env.callVoidMethod(object: object, methodId: methodId, args: [left, top, right, bottom])
        logger.info("💧 setMargins success")
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
