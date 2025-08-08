public protocol ViewPropertyToApply {
    associatedtype Value
    var key: ViewPropertyKey { get }
    var value: Value { get }
}

// MARK: - Key Definition
public struct ViewPropertyKey: ExpressibleByStringLiteral, Hashable, RawRepresentable, Sendable {
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        rawValue = value
    }
    
    // Built-in keys
    static let backgroundColor: ViewPropertyKey = "backgroundColor"
    static let orientation: ViewPropertyKey = "orientation"
    static let onClick: ViewPropertyKey = "onClick"
    static let fitsSystemWindows: ViewPropertyKey = "fitsSystemWindows"
}

struct BackgroundColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .backgroundColor
    let value: GraphicsColor
}

struct OrientationViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .orientation
    let value: LinearLayout.Orientation
}

struct OnClickViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .onClick
    let value: NativeOnClickListener
}

struct FitsSystemWindowsViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .fitsSystemWindows
    let value: Bool
}