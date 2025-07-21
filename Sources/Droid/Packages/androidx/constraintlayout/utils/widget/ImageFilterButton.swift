//
//  ImageFilterButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ConstraintLayoutPackage.UtilsPackage.WidgetPackage {
    public class ImageFilterButtonClass: JClassName, @unchecked Sendable {}
    
    public var ImageFilterButton: ImageFilterButtonClass { .init(parent: self, name: "ImageFilterButton") }
}

// class ImageFilterButton: @unchecked Sendable, JObjectable {
//     init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.constraintlayout.utils.widget.ImageFilterButton], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
