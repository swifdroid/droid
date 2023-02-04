//
//  ConstraintLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ConstraintLayoutPackage.WidgetPackage {
    public class ConstraintLayoutClass: AndroidClassName {}
    
    public var ConstraintLayout: ConstraintLayoutClass { .init(superClass: self, "ConstraintLayout") }
}

class ConstraintLayout: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.constraintlayout.widget.ConstraintLayout], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
