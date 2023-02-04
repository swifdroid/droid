//
//  MaterialCardView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.CardPackage {
    public class MaterialCardViewClass: AndroidClassName {}
    
    public var MaterialCardView: MaterialCardViewClass { .init(superClass: self, "MaterialCardView") }
}

class MaterialCardView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.card.MaterialCardView])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
