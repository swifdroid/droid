//
//  ScrollView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ScrollViewClass: JClassName, @unchecked Sendable {}
    public var ScrollView: ScrollViewClass { .init(parent: self, name: "ScrollView") }
}

open class ScrollView: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
