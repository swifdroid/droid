//
//  AppCompatWidgetSearchView.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class SearchViewClass: JClassName, @unchecked Sendable {}
    
    public var SearchView: SearchViewClass { .init(parent: self, name: "SearchView") }
}

// class SearchView: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.SearchView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
