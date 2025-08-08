//
//  AppBarLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage {
    public class AppBarLayoutClass: JClassName, @unchecked Sendable {}
    public var AppBarLayout: AppBarLayoutClass { .init(parent: self, name: "AppBarLayout") }
}
extension ComGoogleAndroidPackage.MaterialPackage.AppBarPackage.AppBarLayoutClass {
    public class LayoutParamsClass: JClassName, @unchecked Sendable {}
    public var LayoutParams: LayoutParamsClass { .init(parent: self, name: "LayoutParams", isInnerClass: true) }
}
extension LayoutParams.Class {
    static let materialAppBarLayout: Self = .init(.comGoogleAndroid.material.appbar.AppBarLayout.LayoutParams)
}

open class AppBarLayout: ViewGroup, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .comGoogleAndroid.material.appbar.AppBarLayout }
    open override class var layoutParamsClass: LayoutParams.Class { .materialAppBarLayout }
    open override class var gradleDependencies: [String] { [
        #"implementation("com.google.android.material:material:1.12.0")"#
    ] }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
