//
//  TextSwitcher.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class TextSwitcherClass: JClassName, @unchecked Sendable {}
    public var TextSwitcher: TextSwitcherClass { .init(parent: self, name: "TextSwitcher") }
}

open class TextSwitcher: View, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
