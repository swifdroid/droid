//
//  CoordinatorLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.CoordinatorLayoutPackage.WidgetPackage {
    public class CoordinatorLayoutClass: AndroidClassName {}
    
    public var CoordinatorLayout: CoordinatorLayoutClass { .init(superClass: self, "CoordinatorLayout") }
}

class CoordinatorLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.coordinatorlayout.widget.CoordinatorLayout], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
