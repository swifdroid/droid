//
//  TextInputEditText.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.TextFieldPackage {
    public class TextInputEditTextClass: AndroidClassName {}
    
    public var TextInputEditText: TextInputEditTextClass { .init(superClass: self, "TextInputEditText") }
}

class TextInputEditText: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.textfield.TextInputEditText])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
