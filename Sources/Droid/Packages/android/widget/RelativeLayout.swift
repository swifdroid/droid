//
//  RelativeLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class RelativeLayoutClass: JClassName, @unchecked Sendable {}
    public var RelativeLayout: RelativeLayoutClass { .init(parent: self, name: "RelativeLayout") }
}

open class RelativeLayout: View, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .android.widget.RelativeLayout }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
