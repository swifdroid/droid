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
        if let instance = view.instance, let lp = instance.layoutParams() {
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
    static let leftMargin: Self = "leftMargin"
    static let rightMargin: Self = "rightMargin"
    static let topMargin: Self = "topMargin"
    static let bottomMargin: Self = "bottomMargin"
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

struct LeftMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .leftMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(nil, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
    }
}

struct RightMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .rightMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(nil, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
    }
}

struct TopMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .topMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(nil, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
    }
}

struct BottomMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .bottomMargin
    let value: (Int, DimensionUnit)
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(nil, name: key.rawValue, arg: value.1.toPixels(Int32(value.0)))
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