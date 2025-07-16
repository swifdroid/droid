//
//  Barrier.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.ConstraintLayoutPackage.WidgetPackage {
    public class BarrierClass: JClassName, @unchecked Sendable {}
    
    public var Barrier: BarrierClass { .init(parent: self, name: "Barrier") }
}

// class Barrier: @unchecked Sendable, JObjectable {
//     init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.constraintlayout.widget.Barrier], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
