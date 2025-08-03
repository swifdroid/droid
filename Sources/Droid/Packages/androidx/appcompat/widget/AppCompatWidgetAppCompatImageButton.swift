//
//  AppCompatWidgetAppCompatImageButton.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatImageButtonClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatImageButton: AppCompatImageButtonClass { .init(parent: self, name: "AppCompatImageButton") }
}

// class AppCompatImageButton: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatImageButton], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
