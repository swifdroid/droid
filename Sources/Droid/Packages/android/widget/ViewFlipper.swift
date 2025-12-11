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

open class ViewFlipper: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
