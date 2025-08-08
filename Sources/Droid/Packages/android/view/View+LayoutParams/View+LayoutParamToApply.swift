public protocol LayoutParamToApply {
    associatedtype Value
    var key: LayoutParamKey { get }
    var value: Value { get }
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
    static let width: LayoutParamKey = "width"
    static let height: LayoutParamKey = "height"
    static let leftMargin: LayoutParamKey = "leftMargin"
    static let topMargin: LayoutParamKey = "topMargin"
    static let rightMargin: LayoutParamKey = "rightMargin"
    static let bottomMargin: LayoutParamKey = "bottomMargin"
    static let startMargin: LayoutParamKey = "startMargin"
    static let endMargin: LayoutParamKey = "endMargin"
}

struct WidthLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .width
    let value: (LayoutParams.LayoutSize, DimensionUnit)
}

struct HeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .height
    let value: (LayoutParams.LayoutSize, DimensionUnit)
}

struct LeftMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .leftMargin
    let value: (Int, DimensionUnit)
}

struct TopMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .topMargin
    let value: (Int, DimensionUnit)
}

struct RightMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .rightMargin
    let value: (Int, DimensionUnit)
}

struct BottomMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .bottomMargin
    let value: (Int, DimensionUnit)
}

struct StartMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .startMargin
    let value: (Int, DimensionUnit)
}

struct EndMarginLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .endMargin
    let value: (Int, DimensionUnit)
}