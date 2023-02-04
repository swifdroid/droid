//
//  TextureView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.ViewPackage {
    public class TextureViewClass: AndroidClassName {}
    
    public var TextureView: TextureViewClass { .init(superClass: self, "TextureView") }
}

class TextureView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.view.TextureView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
