//
//  SurfaceView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.ViewPackage {
    public class SurfaceViewClass: JClassName, @unchecked Sendable {}
    public var SurfaceView: SurfaceViewClass { .init(parent: self, name: "SurfaceView") }
}

public class SurfaceView: View {
    /// The JNI class name
    public override class var className: JClassName { .android.view.SurfaceView }
}
