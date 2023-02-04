//
//  MotionLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ConstraintLayoutPackage.MotionPackage.WidgetPackage {
    public class MotionLayoutClass: AndroidClassName {}
    
    public var MotionLayout: MotionLayoutClass { .init(superClass: self, "MotionLayout") }
}

class MotionLayout: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.constraintlayout.motion.widget.MotionLayout], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
