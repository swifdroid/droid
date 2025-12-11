//
//  ImageSwitcher.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ImageSwitcherClass: JClassName, @unchecked Sendable {}
    public var ImageSwitcher: ImageSwitcherClass { .init(parent: self, name: "ImageSwitcher") }
}

open class ImageSwitcher: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
