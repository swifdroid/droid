//
//  ViewPager.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ViewPagerPackage.WidgetPackage {
    public class ViewPagerClass: AndroidClassName {}
    
    public var ViewPager: ViewPagerClass { .init(superClass: self, "ViewPager") }
}

class ViewPager: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.viewpager.widget.ViewPager], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
