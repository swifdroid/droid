//
//  AppBarLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.AppBarPackage {
    public class AppBarLayoutClass: AndroidClassName {}
    
    public var AppBarLayout: AppBarLayoutClass { .init(superClass: self, "AppBarLayout") }
}

class AppBarLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.appbar.AppBarLayout])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
