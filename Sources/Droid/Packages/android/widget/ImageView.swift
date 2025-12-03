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
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}

extension ImageView {
    public enum ScaleType: Int, Sendable {
        case matrix = 0
        case fitXY = 1
        case fitStart = 2
        case fitCenter = 3
        case fitEnd = 4
        case center = 5
        case centerCrop = 6
        case centerInside = 7

        public static func from(_ ordinal: Int) -> ScaleType? {
            return ScaleType(rawValue: ordinal)
        }
    }
}
