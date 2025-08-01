//
//  AbsoluteLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class AbsoluteLayoutClass: JClassName, @unchecked Sendable {}
    public var AbsoluteLayout: AbsoluteLayoutClass { .init(parent: self, name: "AbsoluteLayout") }
}

public class AbsoluteLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { .android.widget.AbsoluteLayout }
}
