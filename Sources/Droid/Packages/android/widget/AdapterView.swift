//
//  AdapterView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class AdapterViewClass: JClassName, @unchecked Sendable {}
    public var AdapterView: AdapterViewClass { .init(parent: self, name: "AdapterView") }
}

open class AdapterView<T: Adapter>: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.AdapterView }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}