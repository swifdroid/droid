//
//  AppCompatWidgetAppCompatMultiAutoCompleteTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatMultiAutoCompleteTextViewClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatMultiAutoCompleteTextView: AppCompatMultiAutoCompleteTextViewClass { .init(parent: self, name: "AppCompatMultiAutoCompleteTextView") }
}

// class AppCompatMultiAutoCompleteTextView: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatMultiAutoCompleteTextView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
