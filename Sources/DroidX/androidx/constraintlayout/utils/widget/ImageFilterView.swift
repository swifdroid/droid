//
//  ImageFilterView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.ConstraintLayoutPackage.UtilsPackage.WidgetPackage {
    public class ImageFilterViewClass: AndroidClassName {}
    
    public var ImageFilterView: ImageFilterViewClass { .init(superClass: self, "ImageFilterView") }
}

class ImageFilterView: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.constraintlayout.utils.widget.ImageFilterView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
