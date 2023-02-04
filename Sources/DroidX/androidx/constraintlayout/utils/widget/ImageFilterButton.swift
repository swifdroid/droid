//
//  ImageFilterButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ConstraintLayoutPackage.UtilsPackage.WidgetPackage {
    public class ImageFilterButtonClass: AndroidClassName {}
    
    public var ImageFilterButton: ImageFilterButtonClass { .init(superClass: self, "ImageFilterButton") }
}

class ImageFilterButton: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.constraintlayout.utils.widget.ImageFilterButton], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
