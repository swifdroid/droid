//
//  AppCompatWidgetAppCompatImageView.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatImageViewClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatImageView: AppCompatImageViewClass { .init(parent: self, name: "AppCompatImageView") }
}

// class AppCompatImageView: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatImageView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
