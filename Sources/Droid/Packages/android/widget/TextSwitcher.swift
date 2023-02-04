//
//  TextSwitcher.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.WidgetPackage {
    public class TextSwitcherClass: AndroidClassName {}
    
    public var TextSwitcher: TextSwitcherClass { .init(superClass: self, "TextSwitcher") }
}

class TextSwitcher: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.widget.TextSwitcher], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
