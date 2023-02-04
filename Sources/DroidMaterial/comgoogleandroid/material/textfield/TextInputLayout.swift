//
//  TextInputLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.TextFieldPackage {
    public class TextInputLayoutClass: AndroidClassName {}
    
    public var TextInputLayout: TextInputLayoutClass { .init(superClass: self, "TextInputLayout") }
}

class TextInputLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.textfield.TextInputLayout])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
