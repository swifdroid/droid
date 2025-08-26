//
//  QuickContactBadge.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class QuickContactBadgeClass: JClassName, @unchecked Sendable {}
    public var QuickContactBadge: QuickContactBadgeClass { .init(parent: self, name: "QuickContactBadge") }
}

open class QuickContactBadge: View, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
