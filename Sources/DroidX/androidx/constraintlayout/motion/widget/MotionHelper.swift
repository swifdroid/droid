//
//  MotionHelper.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ConstraintLayoutPackage.MotionPackage.WidgetPackage {
    public class MotionHelperClass: AndroidClassName {}
    
    public var MotionHelper: MotionHelperClass { .init(superClass: self, "MotionHelper") }
}

class MotionHelper: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.constraintlayout.motion.widget.MotionHelper], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
