//
//  AppCompatWidgetToolbar.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class ToolbarClass: JClassName, @unchecked Sendable {}
    
    public var Toolbar: ToolbarClass { .init(parent: self, name: "Toolbar") }
}

public final class Toolbar: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .androidx.appcompat.widget.Toolbar }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
