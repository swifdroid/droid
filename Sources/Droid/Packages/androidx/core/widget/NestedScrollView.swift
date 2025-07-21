//
//  NestedScrollView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.CorePackage.WidgetPackage {
    public class NestedScrollViewClass: JClassName, @unchecked Sendable {}
    
    public var NestedScrollView: NestedScrollViewClass { .init(parent: self, name: "NestedScrollView") }
}

// class NestedScrollView: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.core.widget.NestedScrollView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
