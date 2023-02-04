//
//  HelperWidgetLayer.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ConstraintLayoutPackage.HelperPackage.WidgetPackage {
    public class LayerClass: AndroidClassName {}
    
    public var Layer: LayerClass { .init(superClass: self, "Layer") }
}

class Layer: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.constraintlayout.helper.widget.Layer], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
