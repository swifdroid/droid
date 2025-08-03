//
//  AppCompatWidgetSwitchCompat.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class SwitchCompatClass: JClassName, @unchecked Sendable {}
    
    public var SwitchCompat: SwitchCompatClass { .init(parent: self, name: "SwitchCompat") }
}

// class SwitchCompat: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.SwitchCompat], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
