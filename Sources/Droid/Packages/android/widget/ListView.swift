//
//  ListView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ListViewClass: JClassName, @unchecked Sendable {}
    public var ListView: ListViewClass { .init(parent: self, name: "ListView") }
}

open class ListView: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
