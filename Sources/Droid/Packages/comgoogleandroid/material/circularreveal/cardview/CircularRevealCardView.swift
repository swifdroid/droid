//
//  CircularRevealCardView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage.CardViewPackage {
    public class CircularRevealCardViewClass: JClassName, @unchecked Sendable {}
    
    public var CircularRevealCardView: CircularRevealCardViewClass { .init(parent: self, name: "CircularRevealCardView") }
}

// class CircularRevealCardView: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.circularreveal.cardview.CircularRevealCardView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
