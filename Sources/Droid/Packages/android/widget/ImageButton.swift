//
//  ImageButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ImageButtonClass: JClassName, @unchecked Sendable {}
    public var ImageButton: ImageButtonClass { .init(parent: self, name: "ImageButton") }
}

open class ImageButton: ImageView, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
