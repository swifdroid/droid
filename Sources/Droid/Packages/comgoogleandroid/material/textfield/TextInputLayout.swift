//
//  TextInputLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.TextFieldPackage {
    public class TextInputLayoutClass: JClassName, @unchecked Sendable {}
    
    public var TextInputLayout: TextInputLayoutClass { .init(parent: self, name: "TextInputLayout") }
}

// class TextInputLayout: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.textfield.TextInputLayout], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
