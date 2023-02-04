//
//  MaterialToolbar.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.AppBarPackage {
    public class MaterialToolbarClass: AndroidClassName {}
    
    public var MaterialToolbar: MaterialToolbarClass { .init(superClass: self, "MaterialToolbar") }
}

class MaterialToolbar: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.appbar.MaterialToolbar])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
