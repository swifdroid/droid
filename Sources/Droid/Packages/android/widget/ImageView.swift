//
//  ImageView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ImageViewClass: JClassName, @unchecked Sendable {}
    public var ImageView: ImageViewClass { .init(parent: self, name: "ImageView") }
}

open class ImageView: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
