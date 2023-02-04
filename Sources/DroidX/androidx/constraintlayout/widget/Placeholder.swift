//
//  Placeholder.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ConstraintLayoutPackage.WidgetPackage {
    public class PlaceholderClass: AndroidClassName {}
    
    public var Placeholder: PlaceholderClass { .init(superClass: self, "Placeholder") }
}

class Placeholder: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.constraintlayout.widget.Placeholder], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
