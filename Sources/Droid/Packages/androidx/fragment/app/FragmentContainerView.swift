//
//  FragmentContainerView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.FragmentPackage.AppPackage {
    public class FragmentContainerViewClass: JClassName, @unchecked Sendable {}
    
    public var FragmentContainerView: FragmentContainerViewClass { .init(parent: self, name: "FragmentContainerView") }
}

/// FragmentContainerView is a customized Layout designed specifically for Fragments.
/// It extends FrameLayout, so it can reliably handle Fragment Transactions,
/// and it also has additional features to coordinate with fragment behavior.
///
/// [Learn more](https://developer.android.com/reference/androidx/fragment/app/FragmentContainerView)
open class FragmentContainerView: FrameLayout {
    /// The JNI class name
    public override class var className: JClassName { .androidx.fragment.app.FragmentContainerView }
    
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}