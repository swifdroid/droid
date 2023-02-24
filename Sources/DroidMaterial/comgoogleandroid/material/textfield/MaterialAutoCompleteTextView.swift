//
//  MaterialAutoCompleteTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.TextFieldPackage {
    public class MaterialAutoCompleteTextViewClass: AndroidClassName {}
    
    public var MaterialAutoCompleteTextView: MaterialAutoCompleteTextViewClass { .init(superClass: self, "MaterialAutoCompleteTextView") }
}

class MaterialAutoCompleteTextView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.textfield.MaterialAutoCompleteTextView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
