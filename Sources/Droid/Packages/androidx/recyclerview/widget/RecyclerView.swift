//
//  RecyclerView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.RecyclerViewPackage.WidgetPackage {
    public class RecyclerViewClass: JClassName, @unchecked Sendable {}
    
    public var RecyclerView: RecyclerViewClass { .init(parent: self, name: "RecyclerView") }
}

// class RecyclerView: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.recyclerview.widget.RecyclerView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
