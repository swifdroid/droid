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

open class ScrollView: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.ScrollView }
    public override class var layoutParamsClass: LayoutParams.Class { .frameLayout }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
