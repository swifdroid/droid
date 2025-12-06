//
//  MaterialAutoCompleteTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.TextFieldPackage {
    public class MaterialAutoCompleteTextViewClass: JClassName, @unchecked Sendable {}
    
    public var MaterialAutoCompleteTextView: MaterialAutoCompleteTextViewClass { .init(parent: self, name: "MaterialAutoCompleteTextView") }
}

// class MaterialAutoCompleteTextView: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.textfield.MaterialAutoCompleteTextView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
