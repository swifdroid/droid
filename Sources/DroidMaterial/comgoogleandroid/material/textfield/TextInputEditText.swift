//
//  TextInputEditText.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.TextFieldPackage {
    public class TextInputEditTextClass: JClassName, @unchecked Sendable {}
    
    public var TextInputEditText: TextInputEditTextClass { .init(parent: self, name: "TextInputEditText") }
}

// class TextInputEditText: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.textfield.TextInputEditText], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
