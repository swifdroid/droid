//
//  MaterialTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.TextViewPackage {
    public class MaterialTextViewClass: AndroidClassName {}
    
    public var MaterialTextView: MaterialTextViewClass { .init(superClass: self, "MaterialTextView") }
}

class MaterialTextView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.textview.MaterialTextView])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
