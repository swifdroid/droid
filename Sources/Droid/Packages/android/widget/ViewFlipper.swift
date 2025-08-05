//
//  ViewFlipper.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ViewFlipperClass: JClassName, @unchecked Sendable {}
    public var ViewFlipper: ViewFlipperClass { .init(parent: self, name: "ViewFlipper") }
}

open class ViewFlipper: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
