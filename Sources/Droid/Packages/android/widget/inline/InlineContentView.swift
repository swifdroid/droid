//
//  InlineContentView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.WidgetPackage.InlinePackage {
    public class InlineContentViewClass: AndroidClassName {}
    
    public var InlineContentView: InlineContentViewClass { .init(superClass: self, "InlineContentView") }
}

class InlineContentView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.widget.inline.InlineContentView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
