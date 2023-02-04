//
//  SurfaceView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.ViewPackage {
    public class SurfaceViewClass: AndroidClassName {}
    
    public var SurfaceView: SurfaceViewClass { .init(superClass: self, "SurfaceView") }
}

class SurfaceView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.view.SurfaceView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
