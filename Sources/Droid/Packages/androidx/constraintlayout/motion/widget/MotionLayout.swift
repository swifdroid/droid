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

class MotionLayout: ConstraintLayout {
    /// The JNI class name
    public override class var className: JClassName { .androidx.constraintlayout.motion.widget.MotionLayout }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}
