//
//  TableLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class TableLayoutClass: JClassName, @unchecked Sendable {}
    public var TableLayout: TableLayoutClass { .init(parent: self, name: "TableLayout") }
}
extension AndroidPackage.WidgetPackage.TableLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let tableLayout: Self = .init(.android.widget.TableLayout.LayoutParams)
}

open class TableLayout: View, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.TableLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .tableLayout }

    @discardableResult
    public override init() {
        super.init()
    }
}
