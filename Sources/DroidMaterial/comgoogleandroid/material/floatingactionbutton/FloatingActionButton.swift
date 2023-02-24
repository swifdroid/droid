//
//  FloatingActionButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.FloatingActionButtonPackage {
    public class FloatingActionButtonClass: AndroidClassName {}
    
    public var FloatingActionButton: FloatingActionButtonClass { .init(superClass: self, "FloatingActionButton") }
}

class FloatingActionButton: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.floatingactionbutton.FloatingActionButton], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
