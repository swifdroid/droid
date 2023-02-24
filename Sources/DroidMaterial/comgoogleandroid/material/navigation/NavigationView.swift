//
//  NavigationView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.NavigationPackage {
    public class NavigationViewClass: AndroidClassName {}
    
    public var NavigationView: NavigationViewClass { .init(superClass: self, "NavigationView") }
}

class NavigationView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.navigation.NavigationView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
