//
//  ConstraintLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.ConstraintLayoutPackage.WidgetPackage {
    public class ConstraintLayoutClass: JClassName, @unchecked Sendable {}
    
    public var ConstraintLayout: ConstraintLayoutClass { .init(parent: self, name: "ConstraintLayout") }
}

public final class ConstraintLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { .androidx.constraintlayout.widget.ConstraintLayout }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: () -> BodyBuilderItemable) {
        super.init(content: content)
    }
}