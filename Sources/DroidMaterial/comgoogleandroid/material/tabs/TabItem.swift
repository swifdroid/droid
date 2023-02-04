//
//  TabItem.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.TabsPackage {
    public class TabItemClass: AndroidClassName {}
    
    public var TabItem: TabItemClass { .init(superClass: self, "TabItem") }
}

class TabItem: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.tabs.TabItem])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
