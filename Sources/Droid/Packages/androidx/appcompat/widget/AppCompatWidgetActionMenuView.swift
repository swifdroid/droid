//
//  AppCompatWidgetActionMenuView.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class ActionMenuViewClass: JClassName, @unchecked Sendable {}
    
    public var ActionMenuView: ActionMenuViewClass { .init(parent: self, name: "ActionMenuView") }
}

// class ActionMenuView: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.ActionMenuView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
