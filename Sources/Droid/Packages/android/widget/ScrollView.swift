//
//  ScrollView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.WidgetPackage {
    public class ScrollViewClass: AndroidClassName {}
    
    public var ScrollView: ScrollViewClass { .init(superClass: self, "ScrollView") }
}

class ScrollView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.widget.ScrollView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
