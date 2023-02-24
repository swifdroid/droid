//
//  View.swift
//  Droid
//
//  Created by Mihael Isaev on 14.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI
import JNIKit

extension AndroidPackage.ViewPackage {
    public class ViewClass: AndroidClassName {}
    
    public var View: ViewClass { .init(superClass: self, "View") }
}

extension AndroidPackage.ViewPackage {
    public class OnClickListenerClass: AndroidClassName {}
    
    public var ViewOnClickListener: OnClickListenerClass { .init(superClass: self, "View$OnClickListener") }
}

open class View: JClass {
    public init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.view.View], args: [.object(.android.content.Context) / context])
    }
    
    public override init (_ environment: JEnvironment, _ context: JObjectReference, classes: [AndroidClassName], args: [JArgument]) {
        print(.debug, "🪚", "View init step 1")
        super.init(environment, context, classes: classes, args: args)
    }
    
    required public init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
    
    public func setPadding(left: Int, top: Int, right: Int, bottom: Int) {
        callVoidWithMethod("setPadding", .int(left), .int(top), .int(right), .int(bottom))
    }
    
    public func setLayoutParams(_ class: JClass) {
        callVoidWithMethod("setLayoutParams", .object(`class`.reference.classes) / `class`)
    }
    
    public func addView(_ class: JClass) {
        callVoidWithMethod("addView", [.object(.android.view.View)], [.object(`class`.reference.classes) / `class`])
    }
    
    public func setBackground(_ class: JClass) {
        callVoidWithMethod("setBackground", [.object(.android.graphics.drawable.Drawable)], [.object(`class`.reference.classes) / `class`])
    }
    
    public func setOnClickListener(_ listener: JClass) {
        callVoidWithMethod("setOnClickListener", .object(.android.view.ViewOnClickListener) / listener)
    }
}
