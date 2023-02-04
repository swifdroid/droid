//
//  LayoutParams.swift
//  Droid
//
//  Created by Mihael Isaev on 14.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.ViewPackage.ViewGroupClass {
    public class LayoutParamsClass: AndroidClassName {}
    
    public var LayoutParams: LayoutParamsClass { .init(superClass: self, subclass: "LayoutParams") }
}

class LayoutParams: JClass {
    struct LayoutSize: ExpressibleByIntegerLiteral {
        let value: Int
        
        init(integerLiteral value: Int) {
            self.value = value
        }
        
        static var matchParent: Self { -1 }
        static var wrapContent: Self { -2 }
    }
    
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.view.ViewGroup.LayoutParams], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
    
    init (_ environment: JEnvironment, _ context: JObjectReference, width: LayoutSize, height: LayoutSize) {
        super.init(environment, context, classes: [.android.view.ViewGroup.LayoutParams], args: [.int(width.value), .int(height.value)])
    }
}
