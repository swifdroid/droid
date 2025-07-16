//
//  MaterialToolbar.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage {
    public class MaterialToolbarClass: JClassName, @unchecked Sendable {}
    
    public var MaterialToolbar: MaterialToolbarClass { .init(parent: self, name: "MaterialToolbar") }
}

// class MaterialToolbar: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.appbar.MaterialToolbar], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
