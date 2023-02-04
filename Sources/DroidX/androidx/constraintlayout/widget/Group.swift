//
//  Group.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ConstraintLayoutPackage.WidgetPackage {
    public class GroupClass: AndroidClassName {}
    
    public var Group: GroupClass { .init(superClass: self, "Group") }
}

class Group: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.constraintlayout.widget.Group], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
