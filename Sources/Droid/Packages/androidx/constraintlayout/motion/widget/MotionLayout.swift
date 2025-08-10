//
//  MotionLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ConstraintLayoutPackage.MotionPackage.WidgetPackage {
    public class MotionLayoutClass: JClassName, @unchecked Sendable {}
    public var MotionLayout: MotionLayoutClass { .init(parent: self, name: "MotionLayout") }
}

class MotionLayout: ConstraintLayout, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .androidx.constraintlayout.motion.widget.MotionLayout }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
