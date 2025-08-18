//
//  Button.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ButtonClass: JClassName, @unchecked Sendable {}
    public var Button: ButtonClass { .init(parent: self, name: "Button") }
}

open class Button: TextView, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.Button }
}