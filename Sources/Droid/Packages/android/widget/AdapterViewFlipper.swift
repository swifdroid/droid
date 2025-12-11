//
//  AdapterViewFlipper.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class AdapterViewFlipperClass: JClassName, @unchecked Sendable {}
    public var AdapterViewFlipper: AdapterViewFlipperClass { .init(parent: self, name: "AdapterViewFlipper") }
}

open class AdapterViewFlipper: View {//: AdapterViewAnimator {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.AdapterViewFlipper }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}
