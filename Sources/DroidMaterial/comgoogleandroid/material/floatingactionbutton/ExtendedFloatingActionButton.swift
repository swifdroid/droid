//
//  ExtendedFloatingActionButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.FloatingActionButtonPackage {
    public class ExtendedFloatingActionButtonClass: JClassName, @unchecked Sendable {}
    
    public var ExtendedFloatingActionButton: ExtendedFloatingActionButtonClass { .init(parent: self, name: "ExtendedFloatingActionButton") }
}

// class ExtendedFloatingActionButton: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.floatingactionbutton.ExtendedFloatingActionButton], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
