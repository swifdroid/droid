#if canImport(AndroidLooper)
import AndroidLooper
#endif

public protocol LayoutParamToApply {
    var key: LayoutParamKey { get }
    #if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams)
    #if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    func applyOrAppend<T: View>(_ view: T) -> T
}

extension LayoutParamToApply {
    #if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    @discardableResult
    public func applyOrAppend<T: View>(_ view: T) -> T {
        if let instance = view.instance, let lp = instance.getLayoutParams() {
            apply(nil, instance, lp)
            instance.setLayoutParams(lp)
        } else {
            view._layoutParamsToApply.append(self)
        }
        return view
    }
}

// MARK: - Key Definition
public struct LayoutParamKey: ExpressibleByStringLiteral, Hashable, RawRepresentable, Sendable {
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        rawValue = value
    }
    
    // Built-in keys
    static let width: Self = "width"
    static let height: Self = "height"
    static let setMargins: Self = "setMargins"
    static let startMargin: Self = "startMargin"
    static let endMargin: Self = "endMargin"
}

struct WidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .width
    let value: (LayoutParams.LayoutSize, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(nil, name: key.rawValue, arg: value.0.value < 0 ? value.0.value : value.1.toPixels(value.0.value))
    }
}

struct HeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .height
    let value: (LayoutParams.LayoutSize, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(nil, name: key.rawValue, arg: value.0.value < 0 ? value.0.value : value.1.toPixels(value.0.value))
    }
}

struct SetMarginsLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .setMargins
    let value: (Int, Int, Int, Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.callVoidMethod(nil, name: key.rawValue, args: value.4.toPixels(Int32(value.0)), value.4.toPixels(Int32(value.1)), value.4.toPixels(Int32(value.2)), value.4.toPixels(Int32(value.3)))
    }
}

struct StartMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .startMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(nil, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
    }
}

struct EndMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .endMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(nil, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
    }
}