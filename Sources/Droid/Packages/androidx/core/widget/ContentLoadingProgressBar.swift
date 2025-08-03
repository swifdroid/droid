//
//  ContentLoadingProgressBar.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.CorePackage.WidgetPackage {
    public class ContentLoadingProgressBarClass: JClassName, @unchecked Sendable {}
    
    public var ContentLoadingProgressBar: ContentLoadingProgressBarClass { .init(parent: self, name: "ContentLoadingProgressBar") }
}

// class ContentLoadingProgressBar: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.core.widget.ContentLoadingProgressBar], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
