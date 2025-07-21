//
//  StackView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class StackViewClass: JClassName, @unchecked Sendable {}
    
    public var StackView: StackViewClass { .init(parent: self, name: "StackView") }
}

public class StackView: View, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { .android.widget.StackView }
}
