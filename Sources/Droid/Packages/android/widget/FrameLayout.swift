//
//  FrameLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 24.06.2025.
//

import DroidFoundation
import FoundationEssentials

extension AndroidPackage.WidgetPackage {
    public class FrameLayoutClass: JClassName, @unchecked Sendable {}
    
    public var FrameLayout: FrameLayoutClass { .init(parent: self, name: "FrameLayout") }
}

public final class FrameLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { .android.widget.FrameLayout }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
