//
//  CircularProgressIndicator.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.ProgressIndicatorPackage {
    public class CircularProgressIndicatorClass: JClassName, @unchecked Sendable {}
    
    public var CircularProgressIndicator: CircularProgressIndicatorClass { .init(parent: self, name: "CircularProgressIndicator") }
}

// class CircularProgressIndicator: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.progressindicator.CircularProgressIndicator], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
