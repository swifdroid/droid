//
//  FloatingActionButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.FloatingActionButtonPackage {
    public class FloatingActionButtonClass: JClassName, @unchecked Sendable {}
    
    public var FloatingActionButton: FloatingActionButtonClass { .init(parent: self, name: "FloatingActionButton") }
}

// class FloatingActionButton: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.floatingactionbutton.FloatingActionButton], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
