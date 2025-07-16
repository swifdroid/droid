//
//  PagerTitleStrip.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import FoundationEssentials
import DroidFoundation

extension AndroidXPackage.ViewPagerPackage.WidgetPackage {
    public class PagerTitleStripClass: JClassName, @unchecked Sendable {}
    
    public var PagerTitleStrip: PagerTitleStripClass { .init(parent: self, name: "PagerTitleStrip") }
}

// class PagerTitleStrip: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.viewpager.widget.PagerTitleStrip], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
