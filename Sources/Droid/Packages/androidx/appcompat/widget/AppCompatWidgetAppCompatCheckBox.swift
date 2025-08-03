//
//  AppCompatWidgetAppCompatCheckBox.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatCheckBoxClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatCheckBox: AppCompatCheckBoxClass { .init(parent: self, name: "AppCompatCheckBox") }
}

// class AppCompatCheckBox: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatCheckBox], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
