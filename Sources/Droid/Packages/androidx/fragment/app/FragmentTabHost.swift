//
//  FragmentTabHost.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.FragmentPackage.AppPackage {
    public class FragmentTabHostClass: JClassName, @unchecked Sendable {}
    
    public var FragmentTabHost: FragmentTabHostClass { .init(parent: self, name: "FragmentTabHost") }
}

// class FragmentTabHost: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.fragment.app.FragmentTabHost], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
