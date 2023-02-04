//
//  MaterialAutoCompleteTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.TextFieldPackage {
    public class MaterialAutoCompleteTextViewClass: AndroidClassName {}
    
    public var MaterialAutoCompleteTextView: MaterialAutoCompleteTextViewClass { .init(superClass: self, "MaterialAutoCompleteTextView") }
}

class MaterialAutoCompleteTextView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.textfield.MaterialAutoCompleteTextView])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
