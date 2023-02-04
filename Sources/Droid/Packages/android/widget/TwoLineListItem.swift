//
//  TwoLineListItem.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.WidgetPackage {
    public class TwoLineListItemClass: AndroidClassName {}
    
    public var TwoLineListItem: TwoLineListItemClass { .init(superClass: self, "TwoLineListItem") }
}

class TwoLineListItem: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.widget.TwoLineListItem], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
