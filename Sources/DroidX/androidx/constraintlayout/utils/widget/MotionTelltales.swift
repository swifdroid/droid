//
//  MotionTelltales.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ConstraintLayoutPackage.UtilsPackage.WidgetPackage {
    public class MotionTelltalesClass: AndroidClassName {}
    
    public var MotionTelltales: MotionTelltalesClass { .init(superClass: self, "MotionTelltales") }
}

class MotionTelltales: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.constraintlayout.utils.widget.MotionTelltales], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
