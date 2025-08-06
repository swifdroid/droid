//
//  Drawable.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidPackage.GraphicsPackage.DrawablePackage {
    public class DrawableClass: JClassName, @unchecked Sendable {}
    public var Drawable: DrawableClass { .init(parent: self, name: "Drawable") }
}

open class Drawable: @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { .android.graphics.drawable.Drawable }
    
    let object: JObject

    @discardableResult
    public init(_ object: JObject) {
        self.object = object
    }

    // TODO: implement Drawable
}
