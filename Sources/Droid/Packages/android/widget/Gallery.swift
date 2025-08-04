//
//  Gallery.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class GalleryClass: JClassName, @unchecked Sendable {}    
    public var Gallery: GalleryClass { .init(parent: self, name: "Gallery") }
}
extension AndroidPackage.WidgetPackage.GalleryClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let gallery: Self = .init(.android.widget.Gallery.LayoutParams)
}

open class Gallery: View, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.Gallery }
    open override class var layoutParamsClass: LayoutParams.Class { .gallery }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
