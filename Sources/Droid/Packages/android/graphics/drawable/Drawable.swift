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

/// A Drawable is a general abstraction for "something that can be drawn."
/// 
/// Most often you will deal with Drawable as the type of resource retrieved for drawing things to the screen;
/// the Drawable class provides a generic API for dealing with an underlying visual resource that may take a variety of forms.
/// 
/// Unlike a View, a Drawable does not have any facility to receive events or otherwise interact with the user.
@MainActor
open class Drawable: JObjectable, @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { .android.graphics.drawable.Drawable }
    
    public let object: JObject

    @discardableResult
    public init(_ object: JObject) {
        self.object = object
    }

    // TODO: implement Drawable
}
