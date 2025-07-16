//
//  SurfaceView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import FoundationEssentials

extension AndroidPackage.ViewPackage {
    public class SurfaceViewClass: JClassName, @unchecked Sendable {}
    
    public var SurfaceView: SurfaceViewClass { .init(parent: self, name: "SurfaceView") }
}

public class SurfaceView: View, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { .android.view.SurfaceView }
}
