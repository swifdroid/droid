//
//  AppCompatWidgetAppCompatToggleButton.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatToggleButtonClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatToggleButton: AppCompatToggleButtonClass { .init(parent: self, name: "AppCompatToggleButton") }
}

// class AppCompatToggleButton: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatToggleButton], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
