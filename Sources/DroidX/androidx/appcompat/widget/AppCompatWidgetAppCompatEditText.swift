//
//  AppCompatWidgetAppCompatEditText.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatEditTextClass: AndroidClassName {}
    
    public var AppCompatEditText: AppCompatEditTextClass { .init(superClass: self, "AppCompatEditText") }
}

class AppCompatEditText: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatEditText], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
