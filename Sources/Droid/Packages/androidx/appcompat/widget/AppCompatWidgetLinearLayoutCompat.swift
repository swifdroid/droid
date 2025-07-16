//
//  AppCompatWidgetLinearLayoutCompat.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class LinearLayoutCompatClass: JClassName, @unchecked Sendable {}
    
    public var LinearLayoutCompat: LinearLayoutCompatClass { .init(parent: self, name: "LinearLayoutCompat") }
}

// class LinearLayoutCompat: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.LinearLayoutCompat], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
