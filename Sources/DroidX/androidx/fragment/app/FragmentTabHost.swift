//
//  FragmentTabHost.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.FragmentPackage.AppPackage {
    public class FragmentTabHostClass: AndroidClassName {}
    
    public var FragmentTabHost: FragmentTabHostClass { .init(superClass: self, "FragmentTabHost") }
}

class FragmentTabHost: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.fragment.app.FragmentTabHost], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
