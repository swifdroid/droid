//
//  CollapsingToolbarLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage {
    public class CollapsingToolbarLayoutClass: JClassName, @unchecked Sendable {}
    
    public var CollapsingToolbarLayout: CollapsingToolbarLayoutClass { .init(parent: self, name: "CollapsingToolbarLayout") }
}

// class CollapsingToolbarLayout: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.appbar.CollapsingToolbarLayout], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
