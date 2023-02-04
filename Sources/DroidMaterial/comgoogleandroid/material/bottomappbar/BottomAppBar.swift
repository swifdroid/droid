//
//  BottomAppBar.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.BottomAppBarPackage {
    public class BottomAppBarClass: AndroidClassName {}
    
    public var BottomAppBar: BottomAppBarClass { .init(superClass: self, "BottomAppBar") }
}

class BottomAppBar: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.bottomappbar.BottomAppBar])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
