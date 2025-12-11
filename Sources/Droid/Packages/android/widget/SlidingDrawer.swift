//
//  SlidingDrawer.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class SlidingDrawerClass: JClassName, @unchecked Sendable {}
    public var SlidingDrawer: SlidingDrawerClass { .init(parent: self, name: "SlidingDrawer") }
}

open class SlidingDrawer: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
