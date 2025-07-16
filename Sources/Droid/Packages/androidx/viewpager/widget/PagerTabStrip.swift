//
//  PagerTabStrip.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.ViewPagerPackage.WidgetPackage {
    public class PagerTabStripClass: JClassName, @unchecked Sendable {}
    
    public var PagerTabStrip: PagerTabStripClass { .init(parent: self, name: "PagerTabStrip") }
}

// class PagerTabStrip: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.viewpager.widget.PagerTabStrip], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
