//
//  ChipGroup.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI

extension ComGoogleAndroidPackage.Material.ChipPackage {
    public class ChipGroupClass: AndroidClassName {}
    
    public var ChipGroup: ChipGroupClass { .init(superClass: self, "ChipGroup") }
}

class ChipGroup: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.comGoogleAndroid.material.chip.ChipGroup])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
