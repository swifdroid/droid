//
//  TextureView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.ViewPackage {
    public class TextureViewClass: JClassName, @unchecked Sendable {}
    public var TextureView: TextureViewClass { .init(parent: self, name: "TextureView") }
}

public class TextureView: View {
    /// The JNI class name
    public override class var className: JClassName { .android.view.TextureView }
}
