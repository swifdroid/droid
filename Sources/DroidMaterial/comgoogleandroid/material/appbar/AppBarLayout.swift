//
//  AppBarLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage {
    public class AppBarLayoutClass: JClassName, @unchecked Sendable {}
    public var AppBarLayout: AppBarLayoutClass { .init(parent: self, name: "AppBarLayout") }
}
extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage.AppBarLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let materialAppBarLayout: Self = .init(.comGoogleAndroid.material.appbar.AppBarLayout.LayoutParams)
}

open class AppBarLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.material.appbar.AppBarLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .materialAppBarLayout }
    open override class var gradleDependencies: [String] { [
        #"implementation("com.google.android.material:material:1.12.0")"#
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
            .scrollFlags,
            .scrollEffect,
            .liftOnScroll,
            .minHeight,
            .maxHeight
        ]
    }

    open override func processLayoutParams(_ lp: LayoutParams, for subview: View) {
        super.processLayoutParams(lp, for: subview)
        let params = filteredLayoutParams()
        for param in params {
            switch param.key {
                case .scrollFlags:
                    if let value = param.value as? ScrollFlagsLayoutParam.Value {
                        // TODO: apply
                    }
                case .scrollEffect:
                    if let value = param.value as? ScrollEffectLayoutParam.Value {
                        // TODO: apply
                    }
                case .liftOnScroll:
                    if let value = param.value as? LiftOnScrollLayoutParam.Value {
                        // TODO: apply
                    }
                case .minHeight:
                    if let value = param.value as? MinHeightLayoutParam.Value {
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
    static let scrollFlags: LayoutParamKey = "scrollFlags"
    static let scrollEffect: LayoutParamKey = "scrollEffect"
    static let liftOnScroll: LayoutParamKey = "liftOnScroll"
    static let minHeight: LayoutParamKey = "minHeight"
    static let maxHeight: LayoutParamKey = "maxHeight"
}

struct ScrollFlagsLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .scrollFlags
    let value: Void = () // TODO: bitmask
}

struct ScrollEffectLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .scrollEffect
    let value: Void = () // TODO: AppBarLayout.ChildScrollEffect
}

struct LiftOnScrollLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .liftOnScroll
    let value: Bool
}

struct MinHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .minHeight
    let value: (LayoutParams.LayoutSize, DimensionUnit)
}

struct MaxHeightLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .maxHeight
    let value: (LayoutParams.LayoutSize, DimensionUnit)
}
