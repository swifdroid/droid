//
//  AppCompatWidgetAppCompatButton.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatButtonClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatButton: AppCompatButtonClass { .init(parent: self, name: "AppCompatButton") }
}

// class AppCompatButton: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatButton], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
