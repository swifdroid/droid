//
//  LinearLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class LinearLayoutClass: JClassName, @unchecked Sendable {}
    
    public var LinearLayout: LinearLayoutClass { .init(parent: self, name: "LinearLayout") }
}

public class LinearLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { .android.widget.LinearLayout }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }

    public enum Orientation: Int, Sendable {
        case horizontal, vertical
    }
    
    // func setDividerPadding(_ padding: Int) {
    //     guard
    //         let env = JEnv.current(),
    //         let methodId = clazz.methodId(env: env, name: "setDividerPadding", signature: .init(.int, returning: .void))
    //     else { return }
    //     return env.callVoidMethod(object: .init(ref, clazz), methodId: methodId, args: [padding])
    // }
    
    @discardableResult
    public func orientation(_ orientation: Orientation) -> Self {
        if let instance {
            instance.setOrientation(orientation)
        } else {
            _propertiesToApply.append(.orientation(orientation))
        }
        return self
    }
    
    // public func setGravity(_ gravity: Gravity) {
    //     guard
    //         let env = JEnv.current(),
    //         let methodId = clazz.methodId(env: env, name: "setGravity", signature: .init(.int, returning: .void))
    //     else { return }
    //     return env.callVoidMethod(object: .init(ref, clazz), methodId: methodId, args: [gravity.rawValue])
    // }
    
    // public func setHorizontalGravity(_ gravity: Gravity) {
    //     guard
    //         let env = JEnv.current(),
    //         let methodId = clazz.methodId(env: env, name: "setHorizontalGravity", signature: .init(.int, returning: .void))
    //     else { return }
    //     return env.callVoidMethod(object: .init(ref, clazz), methodId: methodId, args: [gravity.rawValue])
    // }
    
    // public func setVerticalGravity(_ gravity: Gravity) {
    //     guard
    //         let env = JEnv.current(),
    //         let methodId = clazz.methodId(env: env, name: "setVerticalGravity", signature: .init(.int, returning: .void))
    //     else { return }
    //     return env.callVoidMethod(object: .init(ref, clazz), methodId: methodId, args: [gravity.rawValue])
    // }
}

public struct Gravity: OptionSet, Sendable {
    public let rawValue: Int

    public init (rawValue: Int) {
        self.rawValue = rawValue
    }

    // MARK: - Axis Constants
    public static let noGravity = Gravity([])

    public static let axisSpecified = Gravity(rawValue: 0x0001)
    public static let axisPullBefore = Gravity(rawValue: 0x0002)
    public static let axisPullAfter = Gravity(rawValue: 0x0004)
    public static let axisClip = Gravity(rawValue: 0x0008)

    public static let axisXShift = 0
    public static let axisYShift = 4

    // MARK: - Absolute Gravity
    public static let top = Gravity(rawValue: (axisPullBefore.rawValue | axisSpecified.rawValue) << axisYShift)
    public static let bottom = Gravity(rawValue: (axisPullAfter.rawValue  | axisSpecified.rawValue) << axisYShift)
    public static let left = Gravity(rawValue: (axisPullBefore.rawValue | axisSpecified.rawValue) << axisXShift)
    public static let right = Gravity(rawValue: (axisPullAfter.rawValue  | axisSpecified.rawValue) << axisXShift)

    public static let centerVertical = Gravity(rawValue: axisSpecified.rawValue << axisYShift)
    public static let fillVertical = Gravity(rawValue: top.rawValue | bottom.rawValue)

    public static let centerHorizontal = Gravity(rawValue: axisSpecified.rawValue << axisXShift)
    public static let fillHorizontal = Gravity(rawValue: left.rawValue | right.rawValue)

    public static let center = Gravity(arrayLiteral: [centerVertical, centerHorizontal])
    public static let fill = Gravity(rawValue: fillVertical.rawValue | fillHorizontal.rawValue)

    public static let clipVertical = Gravity(rawValue: axisClip.rawValue << axisYShift)
    public static let clipHorizontal = Gravity(rawValue: axisClip.rawValue << axisXShift)

    // MARK: - Relative Layout Direction
    public static let relativeLayoutDirection = Gravity(rawValue: 0x00800000)

    public static let start = Gravity(arrayLiteral: [relativeLayoutDirection, left])
    public static let end = Gravity(arrayLiteral: [relativeLayoutDirection, right])

    // MARK: - Masks
    public static let horizontalGravityMask = Gravity(rawValue: (axisSpecified.rawValue | axisPullBefore.rawValue | axisPullAfter.rawValue) << axisXShift)
    public static let verticalGravityMask = Gravity(rawValue: (axisSpecified.rawValue | axisPullBefore.rawValue | axisPullAfter.rawValue) << axisYShift)
    public static let relativeHorizontalGravityMask = Gravity(arrayLiteral: [start, end])

    // MARK: - Display Clip
    public static let displayClipVertical = Gravity(rawValue: 0x10000000)
    public static let displayClipHorizontal = Gravity(rawValue: 0x01000000)
}