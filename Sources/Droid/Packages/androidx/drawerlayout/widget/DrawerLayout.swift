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

// class DrawerLayout: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.drawerlayout.widget.DrawerLayout], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
