//
//  TableRow.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class TableRowClass: JClassName, @unchecked Sendable {}
    public var TableRow: TableRowClass { .init(parent: self, name: "TableRow") }
}
extension AndroidPackage.WidgetPackage.TableRowClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let tableRow: Self = .init(.android.widget.TableLayout.LayoutParams)
}

open class TableRow: View {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.TableRow }
    open override class var layoutParamsClass: LayoutParams.Class { .tableRow }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            .column,
            .span
        ]
    }
}

extension LayoutParamKey {
    static let span: Self = "span"
    static let column: Self = "column"
}

struct SpanLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .span
    let value: Int
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: Int32(value))
    }
}

struct ColumnLayoutParam: LayoutParamToApply {
    let key: LayoutParamKey = .column
    let value: Int
    func apply(_ env: JEnv?, _ context: View.ViewInstance, _ lp: LayoutParams) {
        lp.setField(env, name: key.rawValue, arg: Int32(value))
    }
}
