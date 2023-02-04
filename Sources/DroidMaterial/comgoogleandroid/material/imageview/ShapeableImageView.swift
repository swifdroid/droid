//
//  ShapeableImageView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.ImageViewPackage {
    public class ShapeableImageViewClass: AndroidClassName {}
    
    public var ShapeableImageView: ShapeableImageViewClass { .init(superClass: self, "ShapeableImageView") }
}

class ShapeableImageView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.imageview.ShapeableImageView])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
