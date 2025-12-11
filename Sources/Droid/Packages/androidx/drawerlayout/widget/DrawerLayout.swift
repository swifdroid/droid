//
//  DrawerLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.DrawerLayoutPackage.WidgetPackage {
    public class DrawerLayoutClass: JClassName, @unchecked Sendable {}   
    public var DrawerLayout: DrawerLayoutClass { .init(parent: self, name: "DrawerLayout") }
}
extension AndroidXPackage.DrawerLayoutPackage.WidgetPackage.DrawerLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let drawerLayout: Self = .init(.androidx.drawerlayout.widget.DrawerLayout.LayoutParams)
}

open class DrawerLayout: ViewGroup {
    /// The JNI class name
    public override class var className: JClassName { .androidx.drawerlayout.widget.DrawerLayout }
    public override class var layoutParamsClass: LayoutParams.Class { .drawerLayout }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }

    open override func applicableLayoutParams() -> [LayoutParamKey] {
        super.applicableLayoutParams() + [
            
        ]
    }
}
