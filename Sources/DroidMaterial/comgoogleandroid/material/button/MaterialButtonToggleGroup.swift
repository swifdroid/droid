//
//  MaterialButtonToggleGroup.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid
import CDroidJNI

extension ComGoogleAndroidPackage.MaterialPackage.ButtonPackage {
    public class MaterialButtonToggleGroupClass: AndroidClassName {}
    
    public var MaterialButtonToggleGroup: MaterialButtonToggleGroupClass { .init(superClass: self, "MaterialButtonToggleGroup") }
}

class MaterialButtonToggleGroup: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.button.MaterialButtonToggleGroup], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
