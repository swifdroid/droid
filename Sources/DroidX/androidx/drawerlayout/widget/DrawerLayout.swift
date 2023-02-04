//
//  DrawerLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.DrawerLayoutPackage.WidgetPackage {
    public class DrawerLayoutClass: AndroidClassName {}
    
    public var DrawerLayout: DrawerLayoutClass { .init(superClass: self, "DrawerLayout") }
}

class DrawerLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.drawerlayout.widget.DrawerLayout], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
