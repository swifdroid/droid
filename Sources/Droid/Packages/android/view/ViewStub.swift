//
//  ViewStub.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import FoundationEssentials

extension AndroidPackage.ViewPackage {
    public class ViewStubClass: JClassName, @unchecked Sendable {}
    
    public var ViewStub: ViewStubClass { .init(parent: self, name: "ViewStub") }
}

public class ViewStub: View, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { .android.view.ViewStub }
}
