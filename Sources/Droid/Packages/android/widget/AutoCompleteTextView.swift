//
//  AutoCompleteTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.WidgetPackage {
    public class AutoCompleteTextViewClass: AndroidClassName {}
    
    public var AutoCompleteTextView: AutoCompleteTextViewClass { .init(superClass: self, "AutoCompleteTextView") }
}

class AutoCompleteTextView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.widget.AutoCompleteTextView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
