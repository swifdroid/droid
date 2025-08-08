//
//  FlexboxLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension ComGoogleAndroidPackage {
    public class FlexboxLayoutClass: JClassName, @unchecked Sendable {}
    public var FlexboxLayout: FlexboxLayoutClass { .init(parent: self, name: "FlexboxLayout") }
}
extension ComGoogleAndroidPackage.FlexboxLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let flexboxLayout: Self = .init(.comGoogleAndroid.FlexboxLayout.LayoutParams)
}

open class FlexboxLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.FlexboxLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .flexboxLayout }
    open override class var gradleDependencies: [String] { [
        #"implementation("com.google.android.flexbox:flexbox:3.0.0")"#
    ] }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            .order,
            .flexGrow,
            .flexShrink,
            .flexBasisPercent,
            .alignSelf,
            .wrapBefore,
            .minWidth,
            .minHeight,
            .maxWidth,
            .maxHeight
        ]
    }

    open override func processLayoutParams(_ lp: LayoutParams, for subview: View) {
        super.processLayoutParams(lp, for: subview)
        let params = filteredLayoutParams()
        for param in params {
            switch param.key {
                case .order:
                    if let value = param.value as? OrderLayoutParam.Value {
                        // TODO: apply
                    }
                case .flexGrow:
                    if let value = param.value as? FlexGrowLayoutParam.Value {
                        // TODO: apply
                    }
                case .flexShrink:
                    if let value = param.value as? FlexShrinkLayoutParam.Value {
                        // TODO: apply
                    }
                case .flexBasisPercent:
                    if let value = param.value as? FlexBasisPercentLayoutParam.Value {
                        // TODO: apply
                    }
                case .alignSelf:
                    if let value = param.value as? AlignSelfLayoutParam.Value {
                        // TODO: apply
                    }
                case .wrapBefore:
                    if let value = param.value as? WrapBeforeLayoutParam.Value {
                        // TODO: apply
                    }
                case .minWidth:
                    if let value = param.value as? MinWidthLayoutParam.Value {
                        // TODO: apply
                    }
                case .minHeight:
                    if let value = param.value as? MinHeightLayoutParam.Value {
                        // TODO: apply
                    }
                case .maxWidth:
                    if let value = param.value as? MaxWidthLayoutParam.Value {
                        // TODO: apply
                    }
                case .maxHeight:
                    if let value = param.value as? MaxHeightLayoutParam.Value {
                        // TODO: apply
                    }
                default: continue
            }
        }
    }
}

extension LayoutParamKey {
    // static let order: LayoutParamKey = "order"
    static let flexGrow: LayoutParamKey = "flexGrow"
    static let flexShrink: LayoutParamKey = "flexShrink"
    static let flexBasisPercent: LayoutParamKey = "flexBasisPercent"
    static let alignSelf: LayoutParamKey = "alignSelf"
    static let wrapBefore: LayoutParamKey = "wrapBefore"
    // static let minWidth: LayoutParamKey = "minWidth"
    // static let minHeight: LayoutParamKey = "minHeight"
    // static let maxWidth: LayoutParamKey = "maxWidth"
    // static let maxHeight: LayoutParamKey = "maxHeigh"
}

// struct OrderLayoutParam: LayoutParamToApply {
//     let key: LayoutParamKey = .order
//     let value: Int
// }

struct FlexGrowLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .flexGrow
    let value: Float
}

struct FlexShrinkLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .flexShrink
    let value: Float
}

struct FlexBasisPercentLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .flexBasisPercent
    let value: Float
}

struct AlignSelfLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .alignSelf
    let value: Int32
}

struct WrapBeforeLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .wrapBefore
    let value: Bool
}

// struct MinWidthLayoutParam: LayoutParamToApply {
//     let key: LayoutParamKey = .minWidth
//     let value: (Int, DimensionUnit)
// }

// struct MinHeightLayoutParam: LayoutParamToApply {
//     let key: LayoutParamKey = .minHeight
//     let value: (Int, DimensionUnit)
// }

// struct MaxWidthLayoutParam: LayoutParamToApply {
//     let key: LayoutParamKey = .maxWidth
//     let value: (Int, DimensionUnit)
// }

// struct MaxHeightLayoutParam: LayoutParamToApply {
//     let key: LayoutParamKey = .maxHeight
//     let value: (Int, DimensionUnit)
// }
