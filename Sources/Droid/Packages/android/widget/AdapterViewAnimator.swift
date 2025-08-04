//
//  AdapterViewAnimator.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

extension AndroidPackage.WidgetPackage {
    public class AdapterViewAnimatorClass: JClassName, @unchecked Sendable {}
    public var AdapterViewAnimator: AdapterViewAnimatorClass { .init(parent: self, name: "AdapterViewAnimator") }
}

open class AdapterViewAnimator: View, @unchecked Sendable {//AdapterView<Adapter> {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.AdapterViewAnimator }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}