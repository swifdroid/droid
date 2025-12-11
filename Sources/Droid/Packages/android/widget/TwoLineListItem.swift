//
//  TwoLineListItem.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class TwoLineListItemClass: JClassName, @unchecked Sendable {}
    public var TwoLineListItem: TwoLineListItemClass { .init(parent: self, name: "TwoLineListItem") }
}

open class TwoLineListItem: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
