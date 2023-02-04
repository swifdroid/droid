//
//  HelperWidgetFlow.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ConstraintLayoutPackage.HelperPackage.WidgetPackage {
    public class FlowClass: AndroidClassName {}
    
    public var Flow: FlowClass { .init(superClass: self, "Flow") }
}

class Flow: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.constraintlayout.helper.widget.Flow], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
