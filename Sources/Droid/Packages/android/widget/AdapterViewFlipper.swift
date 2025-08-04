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

open class AdapterViewFlipper: View, @unchecked Sendable {//: AdapterViewAnimator {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.AdapterViewFlipper }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
