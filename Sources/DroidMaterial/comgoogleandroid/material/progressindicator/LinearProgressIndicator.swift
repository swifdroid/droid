//
//  LinearProgressIndicator.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.ProgressIndicatorPackage {
    public class LinearProgressIndicatorClass: JClassName, @unchecked Sendable {}
    
    public var LinearProgressIndicator: LinearProgressIndicatorClass { .init(parent: self, name: "LinearProgressIndicator") }
}

// class LinearProgressIndicator: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.progressindicator.LinearProgressIndicator], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
