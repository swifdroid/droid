//
//  AppCompatWidgetAppCompatRatingBar.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatRatingBarClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatRatingBar: AppCompatRatingBarClass { .init(parent: self, name: "AppCompatRatingBar") }
}

// class AppCompatRatingBar: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatRatingBar], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
