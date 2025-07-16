//
//  CoordinatorLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.CoordinatorLayoutPackage.WidgetPackage {
    public class CoordinatorLayoutClass: JClassName, @unchecked Sendable {}
    
    public var CoordinatorLayout: CoordinatorLayoutClass { .init(parent: self, name: "CoordinatorLayout") }
}

// class CoordinatorLayout: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.coordinatorlayout.widget.CoordinatorLayout], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
