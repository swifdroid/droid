//
//  Placeholder.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.ConstraintLayoutPackage.WidgetPackage {
    public class PlaceholderClass: JClassName, @unchecked Sendable {}
    
    public var Placeholder: PlaceholderClass { .init(parent: self, name: "Placeholder") }
}

// class Placeholder: @unchecked Sendable, JObjectable {
//     init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.constraintlayout.widget.Placeholder], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
