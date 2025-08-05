//
//  ViewSwitcher.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ViewSwitcherClass: JClassName, @unchecked Sendable {}
    public var ViewSwitcher: ViewSwitcherClass { .init(parent: self, name: "ViewSwitcher") }
}

open class ViewSwitcher: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
