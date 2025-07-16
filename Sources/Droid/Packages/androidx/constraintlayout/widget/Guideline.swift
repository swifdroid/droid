//
//  Guideline.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.ConstraintLayoutPackage.WidgetPackage {
    public class GuidelineClass: JClassName, @unchecked Sendable {}
    
    public var Guideline: GuidelineClass { .init(parent: self, name: "Guideline") }
}

// class Guideline: @unchecked Sendable, JObjectable {
//     init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.constraintlayout.widget.Guideline], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
