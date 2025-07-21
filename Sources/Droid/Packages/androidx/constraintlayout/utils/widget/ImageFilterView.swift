//
//  ImageFilterView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ConstraintLayoutPackage.UtilsPackage.WidgetPackage {
    public class ImageFilterViewClass: JClassName, @unchecked Sendable {}
    
    public var ImageFilterView: ImageFilterViewClass { .init(parent: self, name: "ImageFilterView") }
}

// class ImageFilterView: @unchecked Sendable, JObjectable {
//     init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.constraintlayout.utils.widget.ImageFilterView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
