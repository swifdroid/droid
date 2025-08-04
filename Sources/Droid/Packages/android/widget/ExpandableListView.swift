//
//  ExpandableListView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ExpandableListViewClass: JClassName, @unchecked Sendable {}
    public var ExpandableListView: ExpandableListViewClass { .init(parent: self, name: "ExpandableListView") }
}

open class ExpandableListView: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
