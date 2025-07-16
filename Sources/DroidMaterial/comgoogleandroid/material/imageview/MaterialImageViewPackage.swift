//
//  MaterialImageViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class ImageViewPackage: JClassName, @unchecked Sendable {}
    
    public var imageview: ImageViewPackage { .init(parent: self, name: "imageview") }
}
