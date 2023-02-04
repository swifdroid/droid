//
//  FloatingActionButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.FloatingActionButtonPackage {
    public class FloatingActionButtonClass: AndroidClassName {}
    
    public var FloatingActionButton: FloatingActionButtonClass { .init(superClass: self, "FloatingActionButton") }
}

class FloatingActionButton: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.floatingactionbutton.FloatingActionButton])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
