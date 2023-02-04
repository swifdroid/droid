//
//  ExpandableListView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.WidgetPackage {
    public class ExpandableListViewClass: AndroidClassName {}
    
    public var ExpandableListView: ExpandableListViewClass { .init(superClass: self, "ExpandableListView") }
}

class ExpandableListView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.widget.ExpandableListView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
