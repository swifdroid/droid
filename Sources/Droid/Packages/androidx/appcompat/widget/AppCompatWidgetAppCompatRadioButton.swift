//
//  AppCompatWidgetAppCompatRadioButton.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatRadioButtonClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatRadioButton: AppCompatRadioButtonClass { .init(parent: self, name: "AppCompatRadioButton") }
}

// class AppCompatRadioButton: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatRadioButton], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
