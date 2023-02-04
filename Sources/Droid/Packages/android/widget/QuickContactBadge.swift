//
//  QuickContactBadge.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.WidgetPackage {
    public class QuickContactBadgeClass: AndroidClassName {}
    
    public var QuickContactBadge: QuickContactBadgeClass { .init(superClass: self, "QuickContactBadge") }
}

class QuickContactBadge: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.widget.QuickContactBadge], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
