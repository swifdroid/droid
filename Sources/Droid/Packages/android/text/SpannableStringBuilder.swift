//
//  SpannableStringBuilder.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.TextPackage {
    public class SpannableStringBuilderClass: AndroidClassName {}
    
    public var SpannableStringBuilder: SpannableStringBuilderClass { .init(superClass: self, "SpannableStringBuilder") }
}

class SpannableStringBuilder: JClass, CharSequence {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.text.SpannableStringBuilder], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
