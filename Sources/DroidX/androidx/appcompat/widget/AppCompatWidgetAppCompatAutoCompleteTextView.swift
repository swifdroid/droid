//
//  AppCompatWidgetAppCompatAutoCompleteTextView.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatAutoCompleteTextViewClass: AndroidClassName {}
    
    public var AppCompatAutoCompleteTextView: AppCompatAutoCompleteTextViewClass { .init(superClass: self, "AppCompatAutoCompleteTextView") }
}

class AppCompatAutoCompleteTextView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatAutoCompleteTextView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
