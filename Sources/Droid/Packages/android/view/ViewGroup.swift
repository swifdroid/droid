//
//  ViewGroup.swift
//  Droid
//
//  Created by Mihael Isaev on 14.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.ViewPackage {
    public class ViewGroupClass: AndroidClassName {}
    
    public var ViewGroup: ViewGroupClass { .init(superClass: self, "ViewGroup") }
}

class ViewGroup: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.view.ViewGroup], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
