//
//  ViewGroup.swift
//  Droid
//
//  Created by Mihael Isaev on 14.01.2022.
//

extension AndroidPackage.ViewPackage {
    public class ViewGroupClass: JClassName, @unchecked Sendable {}
    
    public var ViewGroup: ViewGroupClass { .init(parent: self, name: "ViewGroup") }
}

open class ViewGroup: View, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { .android.view.ViewGroup }
}
