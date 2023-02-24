//
//  ExtendedFloatingActionButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.FloatingActionButtonPackage {
    public class ExtendedFloatingActionButtonClass: AndroidClassName {}
    
    public var ExtendedFloatingActionButton: ExtendedFloatingActionButtonClass { .init(superClass: self, "ExtendedFloatingActionButton") }
}

class ExtendedFloatingActionButton: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.floatingactionbutton.ExtendedFloatingActionButton], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
