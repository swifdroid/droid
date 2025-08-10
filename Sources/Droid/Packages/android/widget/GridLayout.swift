//
//  GridLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class GridLayoutClass: JClassName, @unchecked Sendable {}
    public var GridLayout: GridLayoutClass { .init(parent: self, name: "GridLayout") }
}
extension AndroidPackage.WidgetPackage.GridLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let gridLayout: Self = .init(.android.widget.GridLayout.LayoutParams)
}

open class GridLayout: View, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.GridLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .gridLayout }

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
            .columnSpec,
            .rowSpec
        ]
    }

    open override func processLayoutParams(_ lp: LayoutParams, for subview: View) {
        super.processLayoutParams(lp, for: subview)
        let params = filteredLayoutParams()
        for param in params {
            switch param.key {
                case .columnSpec:
                    if let value = param.value as? ColumnSpecLayoutParam.Value {
                        // TODO: apply
                    }
                case .rowSpec:
                    if let value = param.value as? RowSpecLayoutParam.Value {
                        // TODO: apply
                    }
                case .column:
                    if let value = param.value as? ColumnLayoutParam.Value {
                        // TODO: apply
                    }
                case .row:
                    if let value = param.value as? RowLayoutParam.Value {
                        // TODO: apply
                    }
                case .columnSpan:
                    if let value = param.value as? ColumnSpanLayoutParam.Value {
                        // TODO: apply
                    }
                case .rowSpan:
                    if let value = param.value as? RowSpanLayoutParam.Value {
                        // TODO: apply
                    }
                default: continue
            }
        }
    }
}

extension LayoutParamKey {
    static let columnSpec: Self = "columnSpec"
    static let rowSpec: Self = "rowSpec"
}

// MARK: - Cell Position & Span

struct ColumnSpecLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .columnSpec
    let value: Void = () // TODO: Spec
}

struct RowSpecLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .rowSpec
    let value: Void = ()
}

// MARK: - Shortcut Fields (Alternative to Spec)

struct ColumnLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .column
    let value: Int
}

struct RowLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .row
    let value: Int
}

struct ColumnSpanLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .columnSpan
    let value: Int
}

struct RowSpanLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .rowSpan
    let value: Int
}
