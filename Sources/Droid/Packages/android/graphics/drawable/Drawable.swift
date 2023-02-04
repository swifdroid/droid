//
//  Drawable.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.GraphicsPackage.DrawablePackage {
    public class DrawableClass: AndroidClassName {}
    
    public var Drawable: DrawableClass { .init(superClass: self, "Drawable") }
}

class Drawable: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.graphics.drawable.Drawable], args: [])
    }
    
    override init (_ environment: JEnvironment, _ context: JObjectReference, classes: [AndroidClassName], args: [JArgument]) {
        super.init(environment, context, classes: classes, args: args)
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
