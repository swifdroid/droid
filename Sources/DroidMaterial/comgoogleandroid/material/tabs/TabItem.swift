//
//  TabItem.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.TabsPackage {
    public class TabItemClass: JClassName, @unchecked Sendable {}
    
    public var TabItem: TabItemClass { .init(parent: self, name: "TabItem") }
}

// class TabItem: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.tabs.TabItem], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
