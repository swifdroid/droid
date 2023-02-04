//
//  PagerTitleStrip.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ViewPagerPackage.WidgetPackage {
    public class PagerTitleStripClass: AndroidClassName {}
    
    public var PagerTitleStrip: PagerTitleStripClass { .init(superClass: self, "PagerTitleStrip") }
}

class PagerTitleStrip: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.viewpager.widget.PagerTitleStrip], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
