//
//  MaterialCardView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.CardPackage {
    public class MaterialCardViewClass: JClassName, @unchecked Sendable {}
    
    public var MaterialCardView: MaterialCardViewClass { .init(parent: self, name: "MaterialCardView") }
}

// class MaterialCardView: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.card.MaterialCardView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
