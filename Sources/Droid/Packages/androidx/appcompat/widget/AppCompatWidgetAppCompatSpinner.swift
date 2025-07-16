//
//  AppCompatWidgetAppCompatSpinner.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatSpinnerClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatSpinner: AppCompatSpinnerClass { .init(parent: self, name: "AppCompatSpinner") }
}

// class AppCompatSpinner: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatSpinner], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
