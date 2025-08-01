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

public class Space: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { .android.widget.Space }

    @discardableResult
    public override init() {
        super.init()
        weight(1)
    }

    init(weight: Float) {
        super.init()
        self.weight(weight)
    }
}
