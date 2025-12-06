//
//  MaterialTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.TextViewPackage {
    public class MaterialTextViewClass: JClassName, @unchecked Sendable {}
    
    public var MaterialTextView: MaterialTextViewClass { .init(parent: self, name: "MaterialTextView") }
}

// class MaterialTextView: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.textview.MaterialTextView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
