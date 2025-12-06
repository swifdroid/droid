//
//  ShapeableImageView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.ImageViewPackage {
    public class ShapeableImageViewClass: JClassName, @unchecked Sendable {}
    
    public var ShapeableImageView: ShapeableImageViewClass { .init(parent: self, name: "ShapeableImageView") }
}

// class ShapeableImageView: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.imageview.ShapeableImageView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
