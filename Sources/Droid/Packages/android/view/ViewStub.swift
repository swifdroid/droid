//
//  ViewStub.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.ViewPackage {
    public class ViewStubClass: JClassName, @unchecked Sendable {}
    public var ViewStub: ViewStubClass { .init(parent: self, name: "ViewStub") }
}

public class ViewStub: View {
    /// The JNI class name
    public override class var className: JClassName { .android.view.ViewStub }
}
