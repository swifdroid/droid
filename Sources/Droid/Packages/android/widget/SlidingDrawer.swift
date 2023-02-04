//
//  SlidingDrawer.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.WidgetPackage {
    public class SlidingDrawerClass: AndroidClassName {}
    
    public var SlidingDrawer: SlidingDrawerClass { .init(superClass: self, "SlidingDrawer") }
}

class SlidingDrawer: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.widget.SlidingDrawer], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
