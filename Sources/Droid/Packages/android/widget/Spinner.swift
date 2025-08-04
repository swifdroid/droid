//
//  Spinner.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class SpinnerClass: JClassName, @unchecked Sendable {}
    public var Spinner: SpinnerClass { .init(parent: self, name: "Spinner") }
}

open class Spinner: View, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .android.widget.Spinner }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
