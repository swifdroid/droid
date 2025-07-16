//
//  AppBarLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage {
    public class AppBarLayoutClass: JClassName, @unchecked Sendable {}
    
    public var AppBarLayout: AppBarLayoutClass { .init(parent: self, name: "AppBarLayout") }
}

// class AppBarLayout: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.appbar.AppBarLayout], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
