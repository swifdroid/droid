//
//  Space.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class SpaceClass: JClassName, @unchecked Sendable {}
    public var Space: SpaceClass { .init(parent: self, name: "Space") }
}

open class Space: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.Space }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
        weight(1)
    }

    @discardableResult
    init(weight: Float) {
        super.init()
        self.weight(weight)
    }
}
