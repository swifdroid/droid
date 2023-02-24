//
//  MaterialImageViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class ImageViewPackage: AndroidClassName {}
    
    public var imageview: ImageViewPackage { .init(superClass: self, "imageview") }
}
