//
//  CollapsingToolbarLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage {
    public class CollapsingToolbarLayoutClass: AndroidClassName {}
    
    public var CollapsingToolbarLayout: CollapsingToolbarLayoutClass { .init(superClass: self, "CollapsingToolbarLayout") }
}

class CollapsingToolbarLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.appbar.CollapsingToolbarLayout], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
