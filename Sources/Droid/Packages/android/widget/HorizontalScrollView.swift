//
//  HorizontalScrollView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class HorizontalScrollViewClass: JClassName, @unchecked Sendable {}
    public var HorizontalScrollView: HorizontalScrollViewClass { .init(parent: self, name: "HorizontalScrollView") }
}

open class HorizontalScrollView: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
