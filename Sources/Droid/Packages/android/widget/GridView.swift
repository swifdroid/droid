//
//  GridView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class GridViewClass: JClassName, @unchecked Sendable {}
    public var GridView: GridViewClass { .init(parent: self, name: "GridView") }
}

open class GridView: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
