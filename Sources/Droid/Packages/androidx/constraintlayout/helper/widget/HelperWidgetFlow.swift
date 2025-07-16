//
//  HelperWidgetFlow.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.ConstraintLayoutPackage.HelperPackage.WidgetPackage {
    public class FlowClass: JClassName, @unchecked Sendable {}
    
    public var Flow: FlowClass { .init(parent: self, name: "Flow") }
}

// class Flow: @unchecked Sendable, JObjectable {
//     init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.constraintlayout.helper.widget.Flow], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
