//
//  InlineContentView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage.InlinePackage {
    public class InlineContentViewClass: JClassName, @unchecked Sendable {}
    
    public var InlineContentView: InlineContentViewClass { .init(parent: self, name: "InlineContentView") }
}

// class InlineContentView: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.android.widget.inline.InlineContentView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
