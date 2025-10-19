//
//  ColorStateList.swift
//  Droid
//
//  Created by Mihael Isaev on 19.09.2025.
//

public enum ColorState: Sendable {
    case pressed
    case focused
    case selected
    case enabled
    case checked
    case activated
    case hovered
    case windowFocused

    #if os(Android)
    @MainActor
    #endif
    public var resourceId: Int32 {
        switch self {
        case .pressed: return android.R.attr.state_pressed
        case .focused: return android.R.attr.state_focused
        case .selected: return android.R.attr.state_selected
        case .enabled: return android.R.attr.state_enabled
        case .checked: return android.R.attr.state_checked
        case .activated: return android.R.attr.state_activated
        case .hovered: return android.R.attr.state_hovered
        case .windowFocused: return android.R.attr.state_window_focused
        }
    }
}

public struct ColorStateListItem: Sendable {
    public let states: [ColorState]
    public let color: GraphicsColor

    public init (_ color: GraphicsColor, for states: [ColorState]) {
        self.states = states
        self.color = color
    }

    public init (_ color: GraphicsColor, for states: ColorState...) {
        self.states = states
        self.color = color
    }

    public static func pressed(_ color: GraphicsColor) -> Self {
        .init(color, for: .pressed)
    }
    public static func focused(_ color: GraphicsColor) -> Self {
        .init(color, for: .focused)
    }
    public static func selected(_ color: GraphicsColor) -> Self {
        .init(color, for: .selected)
    }
    public static func enabled(_ color: GraphicsColor) -> Self {
        .init(color, for: .enabled)
    }
    public static func checked(_ color: GraphicsColor) -> Self {
        .init(color, for: .checked)
    }
    public static func activated(_ color: GraphicsColor) -> Self {
        .init(color, for: .activated)
    }
    public static func hovered(_ color: GraphicsColor) -> Self {
        .init(color, for: .hovered)
    }
    public static func windowFocused(_ color: GraphicsColor) -> Self {
        .init(color, for: .windowFocused)
    }
}

#if os(Android)
@MainActor
#endif
public final class ColorStateList: JObjectable, @unchecked Sendable {
    /// The JNI class name
    public static let className: JClassName = "android/content/res/ColorStateList"
    
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    public init! (_ items: [ColorStateListItem]) {
        InnerLog.d("ColorStateList init 1")
        var statesArray: [[Int32]] = []
        var colorsArray: [Int32] = []
        for item in items {
            var stateSet: [Int32] = []
            for state in item.states {
                stateSet.append(state.resourceId)
            }
            statesArray.append(stateSet)
            colorsArray.append(item.color.value)
        }
        InnerLog.d("ColorStateList init 2")
        #if os(Android)
        guard
            let env = JEnv.current()
        else {
            InnerLog.d("ColorStateList init 2.1 exit")
            return nil
        }
        InnerLog.d("ColorStateList init 3")
        guard
            let clazz = JClass.load(Self.className)
        else {
            InnerLog.d("ColorStateList init 3.1 exit")
            return nil
        }
        InnerLog.d("ColorStateList init 4")
        guard
            let global = clazz.newObject(env, args: statesArray, colorsArray)
        else {
            InnerLog.d("ColorStateList init 4.1 exit")
            return nil }
        InnerLog.d("ColorStateList init 5")
        self.object = global
        #else
        return nil
        #endif
    }

    public convenience init! (_ items: ColorStateListItem...) {
        self.init(items)
    }

    /// Describe the kinds of special objects contained in this Parcelable instance's marshaled representation.
    /// 
    /// For example, if the object will include a file descriptor in the output of writeToParcel(android.os.Parcel, int),
    /// the return value of this method must include the `CONTENTS_FILE_DESCRIPTOR` bit.
    /// - Returns: a bitmask indicating the set of special object types marshaled by this Parcelable object instance.
    /// Value is either 0 or 1 (`CONTENTS_FILE_DESCRIPTOR`).
    public func describeContents() -> Int32 {
        object.callIntMethod(name: "describeContents") ?? 0
    }

    /// Returns a mask of the configuration parameters for which this color state list may change, requiring that it be re-created.
    public func getChangingConfigurations() -> Int32 {
        object.callIntMethod(name: "getChangingConfigurations") ?? 0
    }

    public func getColorForState(_ stateSet: [ColorState], defaultColor: GraphicsColor) -> GraphicsColor {
        var stateSetIds: [Int32] = []
        for state in stateSet {
            stateSetIds.append(state.resourceId)
        }
        let colorValue = object.callIntMethod(name: "getColorForState", args: stateSetIds, defaultColor.value) ?? defaultColor.value
        return GraphicsColor(integerLiteral: colorValue)
    }
}