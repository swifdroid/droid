//
//  AppCompatWidgetAppCompatMultiAutoCompleteTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatMultiAutoCompleteTextViewClass: AndroidClassName {}
    
    public var AppCompatMultiAutoCompleteTextView: AppCompatMultiAutoCompleteTextViewClass { .init(superClass: self, "AppCompatMultiAutoCompleteTextView") }
}

class AppCompatMultiAutoCompleteTextView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatMultiAutoCompleteTextView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
