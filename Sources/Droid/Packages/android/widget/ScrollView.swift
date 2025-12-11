//
//  ScrollView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ScrollViewClass: JClassName, @unchecked Sendable {}
    public var ScrollView: ScrollViewClass { .init(parent: self, name: "ScrollView") }
}

open class ScrollView: ViewGroup {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.ScrollView }
    public override class var layoutParamsClass: LayoutParams.Class { .frameLayout }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}
