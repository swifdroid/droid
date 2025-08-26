//
//  ViewAnimator.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ViewAnimatorClass: JClassName, @unchecked Sendable {}
    public var ViewAnimator: ViewAnimatorClass { .init(parent: self, name: "ViewAnimator") }
}

open class ViewAnimator: View, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
