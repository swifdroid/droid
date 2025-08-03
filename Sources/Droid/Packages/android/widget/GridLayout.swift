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

open class GridLayout: View, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.GridLayout }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
