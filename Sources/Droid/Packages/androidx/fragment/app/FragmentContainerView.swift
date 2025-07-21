//
//  FragmentContainerView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.FragmentPackage.AppPackage {
    public class FragmentContainerViewClass: JClassName, @unchecked Sendable {}
    
    public var FragmentContainerView: FragmentContainerViewClass { .init(parent: self, name: "FragmentContainerView") }
}

// class FragmentContainerView: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.fragment.app.FragmentContainerView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
