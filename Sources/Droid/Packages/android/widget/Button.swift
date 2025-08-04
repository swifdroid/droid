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

open class Button: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
    
    public func setText(_ text: String) {
        // text.withCString { cstr in
        //     let jsss = environment.pointer.pointee?.pointee.NewStringUTF(environment.pointer, cstr)
        //     callVoidWithMethod("setText", .object(.java.lang.CharSequence) / JStringWrapper.init(v: jsss!))
        // }
    }
}
