//
//  AppCompatWidgetAppCompatTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatTextViewClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatTextView: AppCompatTextViewClass { .init(parent: self, name: "AppCompatTextView") }
}

// class AppCompatTextView: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatTextView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
