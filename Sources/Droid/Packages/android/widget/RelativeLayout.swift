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

public class RelativeLayout: View, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { .android.widget.RelativeLayout }
}
