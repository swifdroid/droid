//
//  NavigationRailView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.NavigationRailPackage {
    public class NavigationRailViewClass: JClassName, @unchecked Sendable {}
    
    public var NavigationRailView: NavigationRailViewClass { .init(parent: self, name: "NavigationRailView") }
}

// class NavigationRailView: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.comGoogleAndroid.material.navigationrail.NavigationRailView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
