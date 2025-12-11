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
extension AndroidPackage.ViewPackage.ViewGroupClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    public static let viewGroup: Self = .init(.android.view.ViewGroup.LayoutParams)
}

open class ViewGroup: View {
    /// The JNI class name
    open override class var className: JClassName { .android.view.ViewGroup }
}
