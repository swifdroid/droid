//
//  TabLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.TabsPackage {
    public class TabLayoutClass: AndroidClassName {}
    
    public var TabLayout: TabLayoutClass { .init(superClass: self, "TabLayout") }
}

class TabLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.tabs.TabLayout])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
