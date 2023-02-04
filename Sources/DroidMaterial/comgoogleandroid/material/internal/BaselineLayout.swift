//
//  BaselineLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.InternalPackage {
    public class BaselineLayoutClass: AndroidClassName {}
    
    public var BaselineLayout: BaselineLayoutClass { .init(superClass: self, "BaselineLayout") }
}

class BaselineLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.internal.BaselineLayout])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
