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

open class AdapterViewAnimator: View {//AdapterView<Adapter> {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.AdapterViewAnimator }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}