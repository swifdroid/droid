//
//  Drawable.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

extension AndroidPackage.GraphicsPackage.DrawablePackage {
    public class DrawableClass: JClassName, @unchecked Sendable {}
    public var Drawable: DrawableClass { .init(parent: self, name: "Drawable") }
}

#if canImport(AndroidLooper)
@UIThreadActor
#endif
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
